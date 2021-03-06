/*
  This file is part of LilyPond, the GNU music typesetter.

  Copyright (C) 1997--2015 Han-Wen Nienhuys <hanwen@xs4all.nl>

  LilyPond is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  LilyPond is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with LilyPond.  If not, see <http://www.gnu.org/licenses/>.
*/

#include "simultaneous-music-iterator.hh"
#include "music.hh"
#include "context.hh"
#include "warn.hh"
#include "context-def.hh"

Simultaneous_music_iterator::Simultaneous_music_iterator ()
{
  create_separate_contexts_ = false;
  children_list_ = SCM_EOL;
}

void
Simultaneous_music_iterator::derived_mark () const
{
  scm_gc_mark (children_list_);
}

void
Simultaneous_music_iterator::derived_substitute (Context *f, Context *t)
{
  for (SCM s = children_list_; scm_is_pair (s); s = scm_cdr (s))
    Music_iterator::unsmob (scm_car (s))->substitute_outlet (f, t);
}

void
Simultaneous_music_iterator::construct_children ()
{
  int j = 0;

  SCM i = get_music ()->get_property ("elements");

  children_list_ = SCM_EOL;
  SCM *tail = &children_list_;
  for (; scm_is_pair (i); i = scm_cdr (i), j++)
    {
      Music *mus = Music::unsmob (scm_car (i));

      SCM scm_iter = get_static_get_iterator (mus);
      Music_iterator *mi = Music_iterator::unsmob (scm_iter);

      /* if create_separate_contexts_ is set, create a new context with the
         number number as name */

      SCM name = ly_symbol2scm (get_outlet ()->context_name ().c_str ());
      Context *c = (j && create_separate_contexts_)
                   ? get_outlet ()->find_create_context (name, ::to_string (j), SCM_EOL)
                   : get_outlet ();

      if (!c)
        c = get_outlet ();

      mi->init_context (mus, c);
      mi->construct_children ();

      if (mi->ok ())
        {
          *tail = scm_cons (scm_iter, *tail);
          tail = SCM_CDRLOC (*tail);
        }
      else
        mi->quit ();
    }
}

// If there are non-run-always iterators and all of them die, take the
// rest of them along.
void
Simultaneous_music_iterator::process (Moment until)
{
  bool had_good = false;
  bool had_bad = false;
  SCM *proc = &children_list_;
  while (scm_is_pair (*proc))
    {
      Music_iterator *i = Music_iterator::unsmob (scm_car (*proc));
      bool run_always = i->run_always ();
      if (run_always || i->pending_moment () == until)
        i->process (until);
      if (!i->ok ())
        {
          if (!run_always)
            had_bad = true;
          i->quit ();
          *proc = scm_cdr (*proc);
        }
      else
        {
          if (!run_always)
            had_good = true;
          proc = SCM_CDRLOC (*proc);
        }
    }
  // If there were non-run-always iterators and all of them died, take
  // the rest of the run-always iterators along with them.  They have
  // likely lost their reference iterators.  Basing this on the actual
  // music contexts is not reliable since something like
  // \new Voice = blah {
  //    << \context Voice = blah { c4 d }
  //       \addlyrics { oh no }
  //    >> e f
  // }
  // cannot wait for the death of context blah before ending the
  // simultaneous iterator.
  if (had_bad && !had_good)
    {
      for (SCM p = children_list_; scm_is_pair (p); p = scm_cdr (p))
        Music_iterator::unsmob (scm_car (p))->quit ();
      children_list_ = SCM_EOL;
    }
}

Moment
Simultaneous_music_iterator::pending_moment () const
{
  Moment next;
  next.set_infinite (1);

  for (SCM s = children_list_; scm_is_pair (s); s = scm_cdr (s))
    {
      Music_iterator *it = Music_iterator::unsmob (scm_car (s));
      next = min (next, it->pending_moment ());
    }

  return next;
}

bool
Simultaneous_music_iterator::ok () const
{
  bool run_always_ok = false;
  for (SCM s = children_list_; scm_is_pair (s); s = scm_cdr (s))
    {
      Music_iterator *it = Music_iterator::unsmob (scm_car (s));
      if (!it->run_always ())
        return true;
      else
        run_always_ok = run_always_ok || it->ok ();
    }
  return run_always_ok;
}

bool
Simultaneous_music_iterator::run_always () const
{
  for (SCM s = children_list_; scm_is_pair (s); s = scm_cdr (s))
    {
      Music_iterator *it = Music_iterator::unsmob (scm_car (s));
      if (it->run_always ())
        return true;
    }
  return false;
}

void
Simultaneous_music_iterator::do_quit ()
{
  for (SCM s = children_list_; scm_is_pair (s); s = scm_cdr (s))
    Music_iterator::unsmob (scm_car (s))->quit ();
}

IMPLEMENT_CTOR_CALLBACK (Simultaneous_music_iterator);
