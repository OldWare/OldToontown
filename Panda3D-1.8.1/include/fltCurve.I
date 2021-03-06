// Filename: fltCurve.I
// Created by:  drose (28Feb01)
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


////////////////////////////////////////////////////////////////////
//     Function: FltCurve::get_num_control_points
//       Access: Public
//  Description: Returns the number of control points assigned to the
//               curve.
////////////////////////////////////////////////////////////////////
INLINE int FltCurve::
get_num_control_points() const {
  return _control_points.size();
}

////////////////////////////////////////////////////////////////////
//     Function: FltCurve::get_control_point
//       Access: Public
//  Description: Returns the nth control point assigned to the curve.
////////////////////////////////////////////////////////////////////
INLINE const LPoint3d &FltCurve::
get_control_point(int n) const {
#ifndef NDEBUG
  static LPoint3d bogus(0.0, 0.0, 0.0);
  nassertr(n >= 0 && n < (int)_control_points.size(), bogus);
#endif
  return _control_points[n];
}
