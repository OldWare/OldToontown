// Filename: textureContext.I
// Created by:  drose (07Oct99)
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
//     Function: TextureContext::Constructor
//       Access: Public
//  Description:
////////////////////////////////////////////////////////////////////
INLINE TextureContext::
TextureContext(PreparedGraphicsObjects *pgo, Texture *tex, int view) :
  BufferContext(&pgo->_texture_residency),
  AdaptiveLruPage(0),
  _texture(tex),
  _view(view)
{
}

////////////////////////////////////////////////////////////////////
//     Function: TextureContext::get_texture
//       Access: Public
//  Description: Returns the pointer to the associated Texture
//               object.
////////////////////////////////////////////////////////////////////
INLINE Texture *TextureContext::
get_texture() const {
  return _texture;
}

////////////////////////////////////////////////////////////////////
//     Function: TextureContext::get_view
//       Access: Public
//  Description: Returns the specific view of a multiview texture this
//               context represents.  In the usual case, with a
//               non-multiview texture, this will be 0.
////////////////////////////////////////////////////////////////////
INLINE int TextureContext::
get_view() const {
  return _view;
}


////////////////////////////////////////////////////////////////////
//     Function: TextureContext::was_modified
//       Access: Public
//  Description: Returns true if the texture properties or image have
//               been modified since the last time mark_loaded() was
//               called.
////////////////////////////////////////////////////////////////////
INLINE bool TextureContext::
was_modified() const {
  return was_properties_modified() || was_image_modified();
}

////////////////////////////////////////////////////////////////////
//     Function: TextureContext::was_properties_modified
//       Access: Public
//  Description: Returns true if the texture properties (unrelated to
//               the image) have been modified since the last time
//               mark_loaded() was called.
////////////////////////////////////////////////////////////////////
INLINE bool TextureContext::
was_properties_modified() const {
  return _properties_modified != _texture->get_properties_modified();
}

////////////////////////////////////////////////////////////////////
//     Function: TextureContext::was_image_modified
//       Access: Public
//  Description: Returns true if the texture image has been modified
//               since the last time mark_loaded() was called.
////////////////////////////////////////////////////////////////////
INLINE bool TextureContext::
was_image_modified() const {
  return _image_modified != _texture->get_image_modified();
}

////////////////////////////////////////////////////////////////////
//     Function: TextureContext::was_simple_image_modified
//       Access: Public
//  Description: Returns true if the texture's "simple" image has been
//               modified since the last time mark_simple_loaded() was
//               called.
////////////////////////////////////////////////////////////////////
INLINE bool TextureContext::
was_simple_image_modified() const {
  return _simple_image_modified != _texture->get_simple_image_modified();
}

////////////////////////////////////////////////////////////////////
//     Function: TextureContext::update_data_size_bytes
//       Access: Public
//  Description: Should be called (usually by a derived class) when
//               the on-card size of this object has changed.
////////////////////////////////////////////////////////////////////
INLINE void TextureContext::
update_data_size_bytes(size_t new_data_size_bytes) {
  BufferContext::update_data_size_bytes(new_data_size_bytes);
  AdaptiveLruPage::set_lru_size(new_data_size_bytes);
}

////////////////////////////////////////////////////////////////////
//     Function: TextureContext::mark_loaded
//       Access: Public
//  Description: Should be called after the texture has been loaded
//               into graphics memory, this updates the internal flags
//               for changed_size() and modified().
////////////////////////////////////////////////////////////////////
INLINE void TextureContext::
mark_loaded() {
  //  _data_size_bytes = _data->get_texture_size_bytes();
  _properties_modified = _texture->get_properties_modified();
  _image_modified = _texture->get_image_modified();
  update_modified(max(_properties_modified, _image_modified));

  // Assume the texture is now resident.
  set_resident(true);
}

////////////////////////////////////////////////////////////////////
//     Function: TextureContext::mark_simple_loaded
//       Access: Public
//  Description: Should be called after the texture's "simple" image
//               has been loaded into graphics memory.
////////////////////////////////////////////////////////////////////
INLINE void TextureContext::
mark_simple_loaded() {
  _properties_modified = _texture->get_properties_modified();
  _simple_image_modified = _texture->get_simple_image_modified();
  update_modified(max(_properties_modified, _simple_image_modified));

  // The texture's not exactly resident now, but some part of it is.
  set_resident(true);
}

////////////////////////////////////////////////////////////////////
//     Function: TextureContext::mark_unloaded
//       Access: Public
//  Description: Should be called after the texture has been forced
//               out of texture memory.
////////////////////////////////////////////////////////////////////
INLINE void TextureContext::
mark_unloaded() {
  _properties_modified = UpdateSeq::old();
  _image_modified = UpdateSeq::old();
  _simple_image_modified = UpdateSeq::old();
  update_modified(UpdateSeq::old());

  set_resident(false);
}

////////////////////////////////////////////////////////////////////
//     Function: TextureContext::mark_needs_reload
//       Access: Public
//  Description: Should be called to indicate the texture should be
//               reloaded at the nearest opportunity.
////////////////////////////////////////////////////////////////////
INLINE void TextureContext::
mark_needs_reload() {
  _image_modified = UpdateSeq::old();
}
