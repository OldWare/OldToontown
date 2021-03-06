// Filename: fltPackedColor.h
// Created by:  drose (25Aug00)
//
////////////////////////////////////////////////////////////////////
//
// PANDA 3D SOFTWARE
// Copyright (c) Carnegie Mellon University.  All rights reserved.
//
// All use of this software is subject to the terms of the revised BSD
// license.  You should have received a copy of this license along
// with this source code in a file named "LICENSE."
//
////////////////////////////////////////////////////////////////////

#ifndef FLTPACKEDCOLOR_H
#define FLTPACKEDCOLOR_H

#include "pandatoolbase.h"

#include "luse.h"
#include <math.h>

class FltRecordReader;
class FltRecordWriter;

////////////////////////////////////////////////////////////////////
//       Class : FltPackedColor
// Description : A packed color record, A, B, G, R.  This appears, for
//               instance, within a face bead.
////////////////////////////////////////////////////////////////////
class FltPackedColor {
public:
  INLINE FltPackedColor();

  INLINE LColor get_color() const;
  INLINE LRGBColor get_rgb() const;
  INLINE void set_color(const LColor &color);
  INLINE void set_rgb(const LRGBColor &rgb);

  void output(ostream &out) const;
  bool extract_record(FltRecordReader &reader);
  bool build_record(FltRecordWriter &writer) const;

public:
  int _a;
  int _b;
  int _g;
  int _r;
};

INLINE ostream &operator << (ostream &out, const FltPackedColor &color);

#include "fltPackedColor.I"

#endif



