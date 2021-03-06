// Filename: atomicAdjustPosixImpl.I
// Created by:  drose (10Feb06)
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
//     Function: AtomicAdjustPosixImpl::inc
//       Access: Public, Static
//  Description: Atomically increments the indicated variable.
////////////////////////////////////////////////////////////////////
INLINE void AtomicAdjustPosixImpl::
inc(TVOLATILE AtomicAdjustPosixImpl::Integer &var) {
  pthread_mutex_lock(&_mutex);
  ++var;
  pthread_mutex_unlock(&_mutex);
}

////////////////////////////////////////////////////////////////////
//     Function: AtomicAdjustPosixImpl::dec
//       Access: Public, Static
//  Description: Atomically decrements the indicated variable and
//               returns true if the new value is nonzero, false if it
//               is zero.
////////////////////////////////////////////////////////////////////
INLINE bool AtomicAdjustPosixImpl::
dec(TVOLATILE AtomicAdjustPosixImpl::Integer &var) {
  pthread_mutex_lock(&_mutex);
  Integer result = --var;
  pthread_mutex_unlock(&_mutex);
  return (result != 0);
}

////////////////////////////////////////////////////////////////////
//     Function: AtomicAdjustPosixImpl::add
//       Access: Public, Static
//  Description: Atomically computes var += delta.  It is legal for
//               delta to be negative.
////////////////////////////////////////////////////////////////////
INLINE void AtomicAdjustPosixImpl::
add(TVOLATILE AtomicAdjustPosixImpl::Integer &var, 
    AtomicAdjustPosixImpl::Integer delta) {
  pthread_mutex_lock(&_mutex);
  var += delta;
  pthread_mutex_unlock(&_mutex);
}

////////////////////////////////////////////////////////////////////
//     Function: AtomicAdjustPosixImpl::set
//       Access: Public, Static
//  Description: Atomically changes the indicated variable and
//               returns the original value.
////////////////////////////////////////////////////////////////////
INLINE AtomicAdjustPosixImpl::Integer AtomicAdjustPosixImpl::
set(TVOLATILE AtomicAdjustPosixImpl::Integer &var, 
    AtomicAdjustPosixImpl::Integer new_value) {
  pthread_mutex_lock(&_mutex);
  Integer orig_value = var;
  var = new_value;
  pthread_mutex_unlock(&_mutex);
  return orig_value;
}

////////////////////////////////////////////////////////////////////
//     Function: AtomicAdjustPosixImpl::get
//       Access: Public, Static
//  Description: Atomically retrieves the snapshot value of the
//               indicated variable.  This is the only guaranteed safe
//               way to retrieve the value that other threads might be
//               asynchronously setting, incrementing, or decrementing
//               (via other AtomicAjust methods).
////////////////////////////////////////////////////////////////////
INLINE AtomicAdjustPosixImpl::Integer AtomicAdjustPosixImpl::
get(const TVOLATILE AtomicAdjustPosixImpl::Integer &var) {
  pthread_mutex_lock(&_mutex);
  Integer orig_value = var;
  pthread_mutex_unlock(&_mutex);
  return orig_value;
}

////////////////////////////////////////////////////////////////////
//     Function: AtomicAdjustPosixImpl::set_ptr
//       Access: Public, Static
//  Description: Atomically changes the indicated variable and
//               returns the original value.
////////////////////////////////////////////////////////////////////
INLINE AtomicAdjustPosixImpl::Pointer AtomicAdjustPosixImpl::
set_ptr(TVOLATILE AtomicAdjustPosixImpl::Pointer &var, 
        AtomicAdjustPosixImpl::Pointer new_value) {
  pthread_mutex_lock(&_mutex);
  Pointer orig_value = var;
  var = new_value;
  pthread_mutex_unlock(&_mutex);
  return orig_value;
}

////////////////////////////////////////////////////////////////////
//     Function: AtomicAdjustPosixImpl::get_ptr
//       Access: Public, Static
//  Description: Atomically retrieves the snapshot value of the
//               indicated variable.  This is the only guaranteed safe
//               way to retrieve the value that other threads might be
//               asynchronously setting, incrementing, or decrementing
//               (via other AtomicAjust methods).
////////////////////////////////////////////////////////////////////
INLINE AtomicAdjustPosixImpl::Pointer AtomicAdjustPosixImpl::
get_ptr(const TVOLATILE AtomicAdjustPosixImpl::Pointer &var) {
  pthread_mutex_lock(&_mutex);
  Pointer orig_value = var;
  pthread_mutex_unlock(&_mutex);
  return orig_value;
}

////////////////////////////////////////////////////////////////////
//     Function: AtomicAdjustPosixImpl::compare_and_exchange
//       Access: Public, Static
//  Description: Atomic compare and exchange.  
//
//               If mem is equal to old_value, store new_value in mem.
//               In either case, return the original value of mem.
//               The caller can test for success by comparing
//               return_value == old_value.
//
//               The atomic function expressed in pseudo-code:
//
//                 orig_value = mem;
//                 if (mem == old_value) {
//                   mem = new_value;
//                 }
//                 return orig_value;
//
////////////////////////////////////////////////////////////////////
INLINE AtomicAdjustPosixImpl::Integer AtomicAdjustPosixImpl::
compare_and_exchange(TVOLATILE AtomicAdjustPosixImpl::Integer &mem, 
                     AtomicAdjustPosixImpl::Integer old_value,
                     AtomicAdjustPosixImpl::Integer new_value) {
  pthread_mutex_lock(&_mutex);
  Integer orig_value = mem;
  if (mem == old_value) {
    mem = new_value;
  }
  pthread_mutex_unlock(&_mutex);
  return orig_value;
}

////////////////////////////////////////////////////////////////////
//     Function: AtomicAdjustPosixImpl::compare_and_exchange_ptr
//       Access: Public, Static
//  Description: Atomic compare and exchange.  
//
//               As above, but works on pointers instead of integers.
////////////////////////////////////////////////////////////////////
INLINE AtomicAdjustPosixImpl::Pointer AtomicAdjustPosixImpl::
compare_and_exchange_ptr(TVOLATILE AtomicAdjustPosixImpl::Pointer &mem, 
                         AtomicAdjustPosixImpl::Pointer old_value,
                         AtomicAdjustPosixImpl::Pointer new_value) {
  pthread_mutex_lock(&_mutex);
  Pointer orig_value = mem;
  if (mem == old_value) {
    mem = new_value;
  }
  pthread_mutex_unlock(&_mutex);
  return orig_value;
}
