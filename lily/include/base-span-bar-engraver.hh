/*
  base-span-bar-engraver.hh -- declare Span_bar_engraver

  source file of the GNU LilyPond music typesetter

  (c)  1997--1999 Han-Wen Nienhuys <hanwen@cs.uu.nl>
*/


#ifndef SPAN_BAR_GRAV_HH
#define SPAN_BAR_GRAV_HH

#include "engraver.hh"
class Axis_align_spanner;
/** 

  Make bars that span multiple "staffs". Catch bars, and span a
  Span_bar over them if we find more than 2 bars.  Vertical alignment
  of staffs changes the appearance of spanbars.  It is up to the
  aligner (Vertical_align_engraver, in this case, to add extra
  dependencies to the spanbars.

  */
class Base_span_bar_engraver : public Engraver
{
  Span_bar * spanbar_p_;
  Array<Bar*> bar_l_arr_;

public:
  VIRTUAL_COPY_CONS(Translator);
  
    
  Base_span_bar_engraver();
protected:
  /**
    Do we use break priorities?  If true, use break_priority_i_ as
    horizontal alignment priority, otherwise, hang the spanbar on the
    acknowledged bar.  */
  bool use_priority_b_;
  
  virtual void acknowledge_element (Score_element_info);
  virtual void do_pre_move_processing();
  virtual Span_bar* get_span_bar_p() const;
};

#endif // SPAN_BAR_GRAV_HH
