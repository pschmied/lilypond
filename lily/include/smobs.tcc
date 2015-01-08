/* -*- C++ -*-
  This file is part of LilyPond, the GNU music typesetter.

  Copyright (C) 2005--2015 Han-Wen Nienhuys <hanwen@xs4all.nl>

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

#ifndef SMOBS_TCC
#define SMOBS_TCC

// Contains generic template definitions.  With GCC, it is just
// included from smobs.hh, but other template expansion systems might
// make it feasible to compile this only a single time.

#include "lily-guile-macros.hh"
#include "smobs.hh"
#include <typeinfo>

template <class Super>
SCM
Smob_base<Super>::mark_trampoline (SCM arg)
{
  return (Super::unsmob (arg))->mark_smob ();
}

template <class Super>
int
Smob_base<Super>::print_trampoline (SCM arg, SCM port, scm_print_state *p)
{
  return (Super::unsmob (arg))->print_smob (port, p);
}

template <class Super>
SCM
Smob_base<Super>::register_ptr (Super *p)
{
  // Don't use SCM_RETURN_NEWSMOB since that would require us to
  // first register the memory and then create the smob.  That would
  // announce the memory as being GC-controlled before even
  // allocating the controlling smob.
  SCM s = SCM_UNDEFINED;
  SCM_NEWSMOB (s, smob_tag (), p);
  scm_gc_register_collectable_memory (p, sizeof (*p), smob_name_.c_str ());
  return s;
}

// Defaults, should not actually get called
template <class Super>
SCM
Smob_base<Super>::mark_smob ()
{
  return SCM_UNSPECIFIED;
}

template <class Super>
size_t
Smob_base<Super>::free_smob (SCM)
{
  return 0;
}

template <class Super>
SCM
Smob_base<Super>::equal_p (SCM, SCM)
{
  return SCM_BOOL_F;
}

// Default, will often get called

template <class Super>
int
Smob_base<Super>::print_smob (SCM p, scm_print_state *)
{
  scm_puts ("#<", p);
  scm_puts (smob_name_.c_str (), p);
  scm_puts (">", p);
  return 1;
}

template <class Super>
Super *
Smob_base<Super>::unregister_ptr (SCM obj)
{
  Super *p = Super::unchecked_unsmob (obj);
  scm_gc_unregister_collectable_memory (p, sizeof (*p), smob_name_.c_str ());
  return p;
}

template <class Super>
scm_t_bits Smob_base<Super>::smob_tag_ = 0;

template <class Super>
Scm_init Smob_base<Super>::scm_init_ = init;

template <class Super>
string Smob_base<Super>::smob_name_;

template <class Super>
void Smob_base<Super>::init ()
{
  smob_name_ = typeid (Super).name ();
  // Primitive demangling, suitable for GCC, should be harmless
  // elsewhere.  The worst that can happen is that we get material
  // unsuitable for Texinfo documentation.  If that proves to be an
  // issue, we need some smarter strategy.
  smob_name_ = smob_name_.substr (smob_name_.find_first_not_of ("0123456789"));
  assert(!smob_tag_);
  smob_tag_ = scm_make_smob_type (smob_name_.c_str (), 0);
  // The following have trivial private default definitions not
  // referring to any aspect of the Super class apart from its name.
  // They should be overridden (or rather masked) at Super level: that
  // way they can refer to Super-private data.
  // While that's not a consideration for type_p_name_, it's easier
  // doing it like the rest.

  if (&Super::free_smob != &Smob_base<Super>::free_smob)
    scm_set_smob_free (smob_tag_, Super::free_smob);
  // Old GCC versions get their type lattice for pointers-to-members
  // tangled up to a degree where we need to typecast _both_ covariant
  // types in order to be able to compare them.  The other comparisons
  // are for static member functions and thus are ordinary function
  // pointers which work without those contortions.
  if (static_cast<SCM (Super::*)()>(&Super::mark_smob) !=
      static_cast<SCM (Super::*)()>(&Smob_base<Super>::mark_smob))
    scm_set_smob_mark (smob_tag_, Super::mark_trampoline);
  scm_set_smob_print (smob_tag_, Super::print_trampoline);
  if (&Super::equal_p != &Smob_base<Super>::equal_p)
    scm_set_smob_equalp (smob_tag_, Super::equal_p);
  if (Super::type_p_name_ != 0)
    {
      SCM subr = scm_c_define_gsubr (Super::type_p_name_, 1, 0, 0,
                                     (scm_t_subr) smob_p);
      string fundoc = string("Is @var{x} a @code{") + smob_name_
        + "} object?";
      ly_add_function_documentation (subr, Super::type_p_name_, "(SCM x)",
                                     fundoc);
      scm_c_export (Super::type_p_name_, NULL);
    }
  ly_add_type_predicate ((void *) is_smob, smob_name_.c_str ());
  if (Super::smob_proc_signature_ >= 0)
    scm_set_smob_apply (smob_tag_,
                        (scm_t_subr)Super::smob_proc,
                        Super::smob_proc_signature_ >> 8,
                        (Super::smob_proc_signature_ >> 4)&0xf,
                        Super::smob_proc_signature_ & 0xf);
}
#endif
