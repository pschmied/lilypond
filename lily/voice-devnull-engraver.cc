/*
  voice-devnull-engraver.cc -- implement Voice_devnull_engraver

  source file of the GNU LilyPond music typesetter
  
  (c) 2000--2001 Jan Nieuwenhuizen <janneke@gnu.org>
*/

#include "engraver.hh"
#include "item.hh"
#include "musical-request.hh"
#include "translator-group.hh"

class Voice_devnull_engraver : public Engraver
{
public:
  VIRTUAL_COPY_CONS (Translator);
  
protected:
  virtual bool try_music (Music *m);
  virtual void acknowledge_grob (Grob_info);
};

ADD_THIS_TRANSLATOR (Voice_devnull_engraver);

static char const *eat_spanners[] = {
  "beam-interface",
  "slur",
  "tie",
  "dynamic-interface",
  "crescendo-interface",
  0
};

bool
Voice_devnull_engraver::try_music (Music *m)
{
  SCM s = get_property ("devNullVoice");
#if 0
  /* No need */
  if (gh_equal_p (s, ly_symbol2scm ("never")))
    return;
#endif

  if (gh_equal_p (s, ly_symbol2scm ("allways"))
      || (s == SCM_EOL
	  && daddy_trans_l_->id_str_.left_str (3) == "two"
	  && (to_boolean (get_property ("unison"))
	      || to_boolean (get_property ("unisilence")))))
    {
      for (char const **p = eat_spanners; *p; p++)
	{
	  if (Span_req *s = dynamic_cast <Span_req *> (m))
	    {
	      if (scm_equal_p (s->get_mus_property ("span-type"),
			       ly_str02scm ( *p)) == SCM_BOOL_T)
		{
		  return true;
		}
	    }
	}
    }
  return false;
}
  
static char const *junk_interfaces[] = {
#if 1
  "beam-interface",
#endif
  "script-interface",
  "slur-interface",
  "tie-interface",
  "text-interface",
  "text-item-interface",
  "text-script-interface",
  "dynamic-interface",
  "hairpin-interface",
  "text-spanner-interface",
  0
};

void
Voice_devnull_engraver::acknowledge_grob (Grob_info i)
{
  SCM s = get_property ("devNullVoice");
#if 0
  /* No need */
  if (s == ly_symbol2scm ("never"))
    return;
#endif

  if (s == ly_symbol2scm ("allways")
      || (s == SCM_EOL
	  && daddy_trans_l_->id_str_.left_str (3) == "two"
	  && (to_boolean (get_property ("unison"))
	      || to_boolean (get_property ("unisilence")))))
    for (char const **p = junk_interfaces; *p; p++)
      if (i.elem_l_->has_interface (ly_symbol2scm (*p)))
	{
	  i.elem_l_->suicide ();
	  return;
	}
}
 
