// Filename: geomVertexReader.I
// Created by:  drose (25Mar05)
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
//     Function: GeomVertexReader::Default Constructor
//       Access: Published
//  Description: Constructs an invalid GeomVertexReader.  You must use
//               the assignment operator to assign a valid
//               GeomVertexReader to this object before you can use
//               it.
////////////////////////////////////////////////////////////////////
INLINE GeomVertexReader::
GeomVertexReader(Thread *current_thread) :
  _vertex_data(NULL),
  _current_thread(current_thread)
{
  initialize();
}

////////////////////////////////////////////////////////////////////
//     Function: GeomVertexReader::Constructor
//       Access: Published
//  Description: Constructs a new reader to process the vertices of
//               the indicated data object.
////////////////////////////////////////////////////////////////////
INLINE GeomVertexReader::
GeomVertexReader(const GeomVertexData *vertex_data,
                 Thread *current_thread) :
  _vertex_data(vertex_data),
  _current_thread(current_thread)
{
  initialize();
}

////////////////////////////////////////////////////////////////////
//     Function: GeomVertexReader::Constructor
//       Access: Published
//  Description: Constructs a new reader to process the vertices of
//               the indicated data object.  This flavor creates the
//               reader specifically to process the named data type.
////////////////////////////////////////////////////////////////////
INLINE GeomVertexReader::
GeomVertexReader(const GeomVertexData *vertex_data, const string &name,
                 Thread *current_thread) :
  _vertex_data(vertex_data),
  _current_thread(current_thread)
{
  initialize();
  set_column(name);
}

////////////////////////////////////////////////////////////////////
//     Function: GeomVertexReader::Constructor
//       Access: Published
//  Description: Constructs a new reader to process the vertices of
//               the indicated data object.  This flavor creates the
//               reader specifically to process the named data type.
////////////////////////////////////////////////////////////////////
INLINE GeomVertexReader::
GeomVertexReader(const GeomVertexData *vertex_data, 
                 const InternalName *name,
                 Thread *current_thread) :
  _vertex_data(vertex_data),
  _current_thread(current_thread)
{
  initialize();
  set_column(name);
}

////////////////////////////////////////////////////////////////////
//     Function: GeomVertexReader::Constructor
//       Access: Published
//  Description: Constructs a new reader to process the vertices of
//               the indicated array only.
////////////////////////////////////////////////////////////////////
INLINE GeomVertexReader::
GeomVertexReader(const GeomVertexArrayData *array_data,
                 Thread *current_thread) :
  _array_data(array_data),
  _current_thread(current_thread)
{
  initialize();
}

////////////////////////////////////////////////////////////////////
//     Function: GeomVertexReader::Constructor
//       Access: Published
//  Description: Constructs a new reader to process the vertices of
//               the indicated array only.
////////////////////////////////////////////////////////////////////
INLINE GeomVertexReader::
GeomVertexReader(const GeomVertexArrayData *array_data, int column,
                 Thread *current_thread) :
  _array_data(array_data),
  _current_thread(current_thread)
{
  initialize();
  set_column(column);
}

////////////////////////////////////////////////////////////////////
//     Function: GeomVertexReader::Constructor
//       Access: Public
//  Description: Constructs a new reader to process the vertices of
//               the indicated data object.  This flavor creates the
//               reader specifically to process the named data type.
////////////////////////////////////////////////////////////////////
INLINE GeomVertexReader::
GeomVertexReader(const GeomVertexDataPipelineReader *data_reader,
                 const InternalName *name, bool force) :
  _vertex_data(data_reader->get_object()),
  _current_thread(data_reader->get_current_thread())
{
  initialize();
  _force = force;
  const GeomVertexFormat *format = data_reader->get_format();
  set_vertex_column(format->get_array_with(name),
                    format->get_column(name),
                    data_reader);
}

////////////////////////////////////////////////////////////////////
//     Function: GeomVertexReader::Copy Constructor
//       Access: Published
//  Description: 
////////////////////////////////////////////////////////////////////
INLINE GeomVertexReader::
GeomVertexReader(const GeomVertexReader &copy) :
  _vertex_data(copy._vertex_data),
  _array(copy._array),
  _array_data(copy._array_data),
  _current_thread(copy._current_thread),
  _packer(copy._packer),
  _stride(copy._stride),
  _handle(copy._handle),
  _pointer_begin(copy._pointer_begin),
  _pointer_end(copy._pointer_end),
  _pointer(copy._pointer),
  _start_row(copy._start_row),
  _force(copy._force)
{
}

////////////////////////////////////////////////////////////////////
//     Function: GeomVertexReader::Copy Assignment Operator
//       Access: Published
//  Description: 
////////////////////////////////////////////////////////////////////
INLINE void GeomVertexReader::
operator = (const GeomVertexReader &copy) {
  _vertex_data = copy._vertex_data;
  _array = copy._array;
  _array_data = copy._array_data;
  _current_thread = copy._current_thread;
  _packer = copy._packer;
  _stride = copy._stride;
  _handle = copy._handle;
  _pointer_begin = copy._pointer_begin;
  _pointer_end = copy._pointer_end;
  _pointer = copy._pointer;
  _start_row = copy._start_row;
  _force = copy._force;
}

////////////////////////////////////////////////////////////////////
//     Function: GeomVertexReader::Destructor
//       Access: Published
//  Description: 
////////////////////////////////////////////////////////////////////
INLINE GeomVertexReader::
~GeomVertexReader() {
}

////////////////////////////////////////////////////////////////////
//     Function: GeomVertexReader::get_vertex_data
//       Access: Published
//  Description: Returns the vertex data object that the
//               reader is processing.  This may return NULL if the
//               reader was constructed with just an array pointer.
////////////////////////////////////////////////////////////////////
INLINE const GeomVertexData *GeomVertexReader::
get_vertex_data() const {
  return _vertex_data;
}

////////////////////////////////////////////////////////////////////
//     Function: GeomVertexReader::get_array_data
//       Access: Published
//  Description: Returns the particular array object that the
//               reader is currently processing.
////////////////////////////////////////////////////////////////////
INLINE const GeomVertexArrayData *GeomVertexReader::
get_array_data() const {
  return _array_data;
}

////////////////////////////////////////////////////////////////////
//     Function: GeomVertexReader::get_array_handle
//       Access: Published
//  Description: Returns the read handle to the array object that the
//               read is currently processing.  This low-level call
//               should be used with caution.
////////////////////////////////////////////////////////////////////
INLINE const GeomVertexArrayDataHandle *GeomVertexReader::
get_array_handle() const {
  return _handle;
}

////////////////////////////////////////////////////////////////////
//     Function: GeomVertexReader::get_stride
//       Access: Published
//  Description: Returns the per-row stride (bytes between consecutive
//               rows) of the underlying vertex array.  This low-level
//               information is normally not needed to use the
//               GeomVertexReader directly.
////////////////////////////////////////////////////////////////////
INLINE size_t GeomVertexReader::
get_stride() const {
  return _stride;
}

////////////////////////////////////////////////////////////////////
//     Function: GeomVertexReader::get_current_thread
//       Access: Published
//  Description: Returns the Thread pointer of the currently-executing
//               thread, as passed to the constructor of this object.
////////////////////////////////////////////////////////////////////
INLINE Thread *GeomVertexReader::
get_current_thread() const {
  return _current_thread;
}

////////////////////////////////////////////////////////////////////
//     Function: GeomVertexReader::set_force
//       Access: Published
//  Description: Sets the value of the force flag.  When this is true
//               (the default), vertex data will be paged in from disk
//               if necessary.  When this is false, the GeomVertexData
//               will simply return a failure code when attempting to
//               read vertex data that is not resident (but will put
//               it on the queue to become resident later).
//
//               Normally, vertex data is always resident, so this
//               will not be an issue.  It is only possible for vertex
//               data to be nonresident if you have enabled vertex
//               paging via the GeomVertexArrayData and VertexDataPage
//               interfaces.
////////////////////////////////////////////////////////////////////
INLINE void GeomVertexReader::
set_force(bool force) {
  _force = force;
}

////////////////////////////////////////////////////////////////////
//     Function: GeomVertexReader::get_force
//       Access: Published
//  Description: Returns the value of the force flag.  See
//               set_force().
////////////////////////////////////////////////////////////////////
INLINE bool GeomVertexReader::
get_force() const {
  return _force;
}

////////////////////////////////////////////////////////////////////
//     Function: GeomVertexReader::set_column
//       Access: Published
//  Description: Sets up the reader to use the nth data type of the
//               GeomVertexFormat, numbering from 0.
//
//               This also resets the read row number to the start row
//               (the same value passed to a previous call to
//               set_row(), or 0 if set_row() was never called.)
//
//               The return value is true if the data type is valid,
//               false otherwise.
////////////////////////////////////////////////////////////////////
INLINE bool GeomVertexReader::
set_column(int column) {
  if (_vertex_data != (const GeomVertexData *)NULL) {
    GeomVertexDataPipelineReader reader(_vertex_data, _current_thread);
    reader.check_array_readers();
    const GeomVertexFormat *format = reader.get_format();
    return set_vertex_column(format->get_array_with(column),
                             format->get_column(column),
                             &reader);
  }
  if (_array_data != (const GeomVertexArrayData *)NULL) {
    return set_array_column(_array_data->get_array_format()->get_column(column));
  }
  return false;
}

////////////////////////////////////////////////////////////////////
//     Function: GeomVertexReader::set_column
//       Access: Published
//  Description: Sets up the reader to use the data type with the
//               indicated name.
//
//               This also resets the read row number to the start row
//               (the same value passed to a previous call to
//               set_row(), or 0 if set_row() was never called.)
//
//               The return value is true if the data type is valid,
//               false otherwise.
////////////////////////////////////////////////////////////////////
INLINE bool GeomVertexReader::
set_column(const string &name) {
  return set_column(InternalName::make(name));
}

////////////////////////////////////////////////////////////////////
//     Function: GeomVertexReader::set_column
//       Access: Published
//  Description: Sets up the reader to use the data type with the
//               indicated name.
//
//               This also resets the read row number to the start row
//               (the same value passed to a previous call to
//               set_row(), or 0 if set_row() was never called.)
//
//               The return value is true if the data type is valid,
//               false otherwise.
////////////////////////////////////////////////////////////////////
INLINE bool GeomVertexReader::
set_column(const InternalName *name) {
  if (_vertex_data != (const GeomVertexData *)NULL) {
    GeomVertexDataPipelineReader reader(_vertex_data, _current_thread);
    reader.check_array_readers();
    const GeomVertexFormat *format = reader.get_format();
    return set_vertex_column(format->get_array_with(name),
                             format->get_column(name),
                             &reader);
  }
  if (_array_data != (const GeomVertexArrayData *)NULL) {
    return set_array_column(_array_data->get_array_format()->get_column(name));
  }

  return false;
}

////////////////////////////////////////////////////////////////////
//     Function: GeomVertexReader::clear
//       Access: Published
//  Description: Resets the GeomVertexReader to the initial state.
////////////////////////////////////////////////////////////////////
INLINE void GeomVertexReader::
clear() {
  (*this) = GeomVertexReader(_current_thread);
}

////////////////////////////////////////////////////////////////////
//     Function: GeomVertexReader::has_column
//       Access: Published
//  Description: Returns true if a valid data type has been
//               successfully set, or false if the data type does not
//               exist (or if get_force() is false and the vertex data
//               is nonresident).
////////////////////////////////////////////////////////////////////
INLINE bool GeomVertexReader::
has_column() const {
  return (_packer != (GeomVertexColumn::Packer *)NULL);
}

////////////////////////////////////////////////////////////////////
//     Function: GeomVertexReader::get_array
//       Access: Published
//  Description: Returns the array index containing the data type that
//               the reader is working on.
////////////////////////////////////////////////////////////////////
INLINE int GeomVertexReader::
get_array() const {
  return _array;
}

////////////////////////////////////////////////////////////////////
//     Function: GeomVertexReader::get_column
//       Access: Published
//  Description: Returns the description of the data type that the
//               reader is working on.
////////////////////////////////////////////////////////////////////
INLINE const GeomVertexColumn *GeomVertexReader::
get_column() const {
  if (_packer != (GeomVertexColumn::Packer *)NULL) {
    return _packer->_column;
  }
  return NULL;
}

////////////////////////////////////////////////////////////////////
//     Function: GeomVertexReader::set_row_unsafe
//       Access: Published
//  Description: Sets the start row to the indicated value, without
//               internal checks.  This is the same as set_row(), but
//               it does not check for the possibility that the array
//               has been reallocated internally for some reason; use
//               only when you are confident that the array is
//               unchanged and you really need every bit of available
//               performance.
////////////////////////////////////////////////////////////////////
INLINE void GeomVertexReader::
set_row_unsafe(int row) {
  _start_row = row;
  if (has_column()) {
    quick_set_pointer(_start_row);
  }
}

////////////////////////////////////////////////////////////////////
//     Function: GeomVertexReader::set_row
//       Access: Published
//  Description: Sets the start row to the indicated value.  The
//               reader will begin reading from the indicated row;
//               each subsequent get_data*() call will return the data
//               from the subsequent row.  If set_column() is called,
//               the reader will return to this row.
////////////////////////////////////////////////////////////////////
INLINE void GeomVertexReader::
set_row(int row) {
  _start_row = row;
  if (has_column()) {
    bool result = set_pointer(_start_row);
    nassertv(result);
  }
}

////////////////////////////////////////////////////////////////////
//     Function: GeomVertexReader::get_start_row
//       Access: Published
//  Description: Returns the row index at which the reader started.
//               It will return to this row if you reset the current
//               column.
////////////////////////////////////////////////////////////////////
INLINE int GeomVertexReader::
get_start_row() const {
  return _start_row;
}

////////////////////////////////////////////////////////////////////
//     Function: GeomVertexReader::get_read_row
//       Access: Published
//  Description: Returns the row index from which the data will be
//               retrieved by the next call to get_data*().
////////////////////////////////////////////////////////////////////
INLINE int GeomVertexReader::
get_read_row() const {
  return (int)(_pointer - _pointer_begin) / _stride;
}

////////////////////////////////////////////////////////////////////
//     Function: GeomVertexReader::is_at_end
//       Access: Published
//  Description: Returns true if the reader is currently at the end of
//               the list of vertices, false otherwise.  If this is
//               true, another call to get_data*() will result in a
//               crash.
////////////////////////////////////////////////////////////////////
INLINE bool GeomVertexReader::
is_at_end() const {
  return _pointer >= _pointer_end;
}

////////////////////////////////////////////////////////////////////
//     Function: GeomVertexReader::get_data1f
//       Access: Published
//  Description: Returns the data associated with the read row,
//               expressed as a 1-component value, and advances the
//               read row.
////////////////////////////////////////////////////////////////////
INLINE float GeomVertexReader::
get_data1f() {
  nassertr(has_column(), 0.0f);
  return _packer->get_data1f(inc_pointer());
}

////////////////////////////////////////////////////////////////////
//     Function: GeomVertexReader::get_data2f
//       Access: Published
//  Description: Returns the data associated with the read row,
//               expressed as a 2-component value, and advances the
//               read row.
////////////////////////////////////////////////////////////////////
INLINE const LVecBase2f &GeomVertexReader::
get_data2f() {
  nassertr(has_column(), LVecBase2f::zero());
  return _packer->get_data2f(inc_pointer());
}

////////////////////////////////////////////////////////////////////
//     Function: GeomVertexReader::get_data3f
//       Access: Published
//  Description: Returns the data associated with the read row,
//               expressed as a 3-component value, and advances the
//               read row.
////////////////////////////////////////////////////////////////////
INLINE const LVecBase3f &GeomVertexReader::
get_data3f() {
  nassertr(has_column(), LVecBase3f::zero());
  return _packer->get_data3f(inc_pointer());
}

////////////////////////////////////////////////////////////////////
//     Function: GeomVertexReader::get_data4f
//       Access: Published
//  Description: Returns the data associated with the read row,
//               expressed as a 4-component value, and advances the
//               read row.
////////////////////////////////////////////////////////////////////
INLINE const LVecBase4f &GeomVertexReader::
get_data4f() {
  nassertr(has_column(), LVecBase4f::zero());
  return _packer->get_data4f(inc_pointer());
}

////////////////////////////////////////////////////////////////////
//     Function: GeomVertexReader::get_data1d
//       Access: Published
//  Description: Returns the data associated with the read row,
//               expressed as a 1-component value, and advances the
//               read row.
////////////////////////////////////////////////////////////////////
INLINE double GeomVertexReader::
get_data1d() {
  nassertr(has_column(), 0.0f);
  return _packer->get_data1d(inc_pointer());
}

////////////////////////////////////////////////////////////////////
//     Function: GeomVertexReader::get_data2d
//       Access: Published
//  Description: Returns the data associated with the read row,
//               expressed as a 2-component value, and advances the
//               read row.
////////////////////////////////////////////////////////////////////
INLINE const LVecBase2d &GeomVertexReader::
get_data2d() {
  nassertr(has_column(), LVecBase2d::zero());
  return _packer->get_data2d(inc_pointer());
}

////////////////////////////////////////////////////////////////////
//     Function: GeomVertexReader::get_data3d
//       Access: Published
//  Description: Returns the data associated with the read row,
//               expressed as a 3-component value, and advances the
//               read row.
////////////////////////////////////////////////////////////////////
INLINE const LVecBase3d &GeomVertexReader::
get_data3d() {
  nassertr(has_column(), LVecBase3d::zero());
  return _packer->get_data3d(inc_pointer());
}

////////////////////////////////////////////////////////////////////
//     Function: GeomVertexReader::get_data4d
//       Access: Published
//  Description: Returns the data associated with the read row,
//               expressed as a 4-component value, and advances the
//               read row.
////////////////////////////////////////////////////////////////////
INLINE const LVecBase4d &GeomVertexReader::
get_data4d() {
  nassertr(has_column(), LVecBase4d::zero());
  return _packer->get_data4d(inc_pointer());
}

////////////////////////////////////////////////////////////////////
//     Function: GeomVertexReader::get_data1
//       Access: Published
//  Description: Returns the data associated with the read row,
//               expressed as a 1-component value, and advances the
//               read row.
////////////////////////////////////////////////////////////////////
INLINE PN_stdfloat GeomVertexReader::
get_data1() {
#ifndef STDFLOAT_DOUBLE
  return get_data1f();
#else
  return get_data1d();
#endif
}

////////////////////////////////////////////////////////////////////
//     Function: GeomVertexReader::get_data2
//       Access: Published
//  Description: Returns the data associated with the read row,
//               expressed as a 2-component value, and advances the
//               read row.
////////////////////////////////////////////////////////////////////
INLINE const LVecBase2 &GeomVertexReader::
get_data2() {
#ifndef STDFLOAT_DOUBLE
  return get_data2f();
#else
  return get_data2d();
#endif
}

////////////////////////////////////////////////////////////////////
//     Function: GeomVertexReader::get_data3
//       Access: Published
//  Description: Returns the data associated with the read row,
//               expressed as a 3-component value, and advances the
//               read row.
////////////////////////////////////////////////////////////////////
INLINE const LVecBase3 &GeomVertexReader::
get_data3() {
#ifndef STDFLOAT_DOUBLE
  return get_data3f();
#else
  return get_data3d();
#endif
}

////////////////////////////////////////////////////////////////////
//     Function: GeomVertexReader::get_data4
//       Access: Published
//  Description: Returns the data associated with the read row,
//               expressed as a 4-component value, and advances the
//               read row.
////////////////////////////////////////////////////////////////////
INLINE const LVecBase4 &GeomVertexReader::
get_data4() {
#ifndef STDFLOAT_DOUBLE
  return get_data4f();
#else
  return get_data4d();
#endif
}

////////////////////////////////////////////////////////////////////
//     Function: GeomVertexReader::get_data1i
//       Access: Published
//  Description: Returns the data associated with the read row,
//               expressed as a 1-component value, and advances the
//               read row.
////////////////////////////////////////////////////////////////////
INLINE int GeomVertexReader::
get_data1i() {
  nassertr(has_column(), 0);
  return _packer->get_data1i(inc_pointer());
}

////////////////////////////////////////////////////////////////////
//     Function: GeomVertexReader::get_data2i
//       Access: Published
//  Description: Returns the data associated with the read row,
//               expressed as a 2-component value, and advances the
//               read row.
////////////////////////////////////////////////////////////////////
INLINE const int *GeomVertexReader::
get_data2i() {
  nassertr(has_column(), 0);
  return _packer->get_data2i(inc_pointer());
}

////////////////////////////////////////////////////////////////////
//     Function: GeomVertexReader::get_data3i
//       Access: Published
//  Description: Returns the data associated with the read row,
//               expressed as a 3-component value, and advances the
//               read row.
////////////////////////////////////////////////////////////////////
INLINE const int *GeomVertexReader::
get_data3i() {
  nassertr(has_column(), 0);
  return _packer->get_data3i(inc_pointer());
}

////////////////////////////////////////////////////////////////////
//     Function: GeomVertexReader::get_data4i
//       Access: Published
//  Description: Returns the data associated with the read row,
//               expressed as a 4-component value, and advances the
//               read row.
////////////////////////////////////////////////////////////////////
INLINE const int *GeomVertexReader::
get_data4i() {
  nassertr(has_column(), 0);
  return _packer->get_data4i(inc_pointer());
}

////////////////////////////////////////////////////////////////////
//     Function: GeomVertexReader::get_packer
//       Access: Protected
//  Description: Returns the reader's Packer object.
////////////////////////////////////////////////////////////////////
INLINE GeomVertexColumn::Packer *GeomVertexReader::
get_packer() const {
  return _packer;
}

////////////////////////////////////////////////////////////////////
//     Function: GeomVertexReader::set_pointer
//       Access: Private
//  Description: Sets up the array pointers freshly from the source
//               object (in case they have been reallocated recently),
//               and sets the internal pointer to the indicated row.
//
//               Returns true if successful, or false if the vertex
//               data is not resident.  If it returns false, the
//               reader's internal column spec is cleared.  It is only
//               possible to return false if get_force() is false.
////////////////////////////////////////////////////////////////////
INLINE bool GeomVertexReader::
set_pointer(int row) {
  _pointer_begin = _handle->get_read_pointer(_force);
  if (_pointer_begin == NULL && _handle->get_data_size_bytes() != 0) {
    // Vertex data is not resident.
    set_column(0, NULL);
    return false;
  }

  // Vertex data is resident, or just empty.
  _pointer_end = _pointer_begin + _handle->get_data_size_bytes();
  quick_set_pointer(row);
  return true;
}

////////////////////////////////////////////////////////////////////
//     Function: GeomVertexReader::quick_set_pointer
//       Access: Private
//  Description: Sets up the internal pointer to the indicated row,
//               without first verifying that arrays haven't been
//               reallocated.
////////////////////////////////////////////////////////////////////
INLINE void GeomVertexReader::
quick_set_pointer(int row) {
  nassertv(has_column() && (_pointer_begin != NULL || row == 0));

#if defined(_DEBUG)
  // Make sure we still have the same pointer as stored in the array.
  nassertv(_pointer_begin == _handle->get_read_pointer(true));
#endif

  _pointer = _pointer_begin + _packer->_column->get_start() + _stride * row;

#if defined(_DEBUG)
  // We have to allow the pointer to exceed the end by up to one row's
  // width.  This wouldn't be legal on a plain GeomVertexReader, but
  // it *is* legal for a GeomVertexRewriter.
  nassertv(_pointer_begin == _pointer_end || (_pointer - _packer->_column->get_start())  <= _pointer_end);
#endif
}

////////////////////////////////////////////////////////////////////
//     Function: GeomVertexReader::inc_pointer
//       Access: Private
//  Description: Increments to the next row, and returns the data
//               pointer as it was before incrementing.
////////////////////////////////////////////////////////////////////
INLINE const unsigned char *GeomVertexReader::
inc_pointer() {
#if defined(_DEBUG)
  nassertr(_pointer < _pointer_end, empty_buffer);
  // Make sure we still have the same pointer as stored in the array.
  nassertr(_pointer_begin == _handle->get_read_pointer(true), empty_buffer);
  nassertr(_pointer < _pointer_begin + _handle->get_data_size_bytes(), empty_buffer);
#endif

  const unsigned char *orig_pointer = _pointer;
  _pointer += _stride;
  return orig_pointer;
}
