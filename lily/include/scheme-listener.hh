/*
  This file is part of LilyPond, the GNU music typesetter.

  Copyright (C) 2006--2015 Erik Sandberg  <mandolaerik@gmail.com>

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

#ifndef SCHEME_LISTENER_HH
#define SCHEME_LISTENER_HH

#include "listener.hh"

/*
 Scheme_listener is only used internally by scheme-listener-scheme.cc
*/

class Scheme_listener : public Smob<Scheme_listener>
{
public:
  int print_smob (SCM, scm_print_state *);
  SCM mark_smob ();
  virtual ~Scheme_listener ();
  Scheme_listener (SCM callback);
  DECLARE_LISTENER (call);
private:
  SCM callback_;
};

#endif /* SCHEME_LISTENER_HH */
