// Filename: ringEmitter.h
// Created by:  charles (22Jun00)
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

#ifndef ARCEMITTER_H
#define ARCEMITTER_H

#include "ringEmitter.h"

////////////////////////////////////////////////////////////////////
//       Class : ArcEmitter
// Description : Describes a planar ring region in which
//               particles are generated.
////////////////////////////////////////////////////////////////////
class EXPCL_PANDAPHYSICS ArcEmitter : public RingEmitter {
PUBLISHED:
  ArcEmitter();
  ArcEmitter(const ArcEmitter &copy);
  virtual ~ArcEmitter();

  virtual BaseParticleEmitter *make_copy();

  INLINE void set_start_angle(PN_stdfloat angle);
  INLINE void set_end_angle(PN_stdfloat angle);
  INLINE void set_arc(PN_stdfloat startAngle, PN_stdfloat endAngle);

  INLINE PN_stdfloat get_start_angle();
  INLINE PN_stdfloat get_end_angle();

  virtual void output(ostream &out) const;
  virtual void write(ostream &out, int indent=0) const;

private:
  // our emitter limits
  PN_stdfloat _start_theta;
  PN_stdfloat _end_theta;
  ///////////////////////////////

  virtual void assign_initial_position(LPoint3& pos);
};

#include "arcEmitter.I"

#endif // ARCEMITTER_H
