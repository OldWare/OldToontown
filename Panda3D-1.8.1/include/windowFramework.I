// Filename: windowFramework.I
// Created by:  drose (02Apr02)
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
//     Function: WindowFramework::get_panda_framework
//       Access: Public
//  Description: Returns a pointer to the associated PandaFramework
//               object.
////////////////////////////////////////////////////////////////////
INLINE PandaFramework *WindowFramework::
get_panda_framework() const {
  return _panda_framework;
}

////////////////////////////////////////////////////////////////////
//     Function: WindowFramework::get_graphics_window
//       Access: Public
//  Description: Returns a pointer to the underlying GraphicsWindow
//               object, if it is in fact a window; or NULL if it is
//               not.
////////////////////////////////////////////////////////////////////
INLINE GraphicsWindow *WindowFramework::
get_graphics_window() const {
  if (_window != (GraphicsOutput *)NULL && 
      _window->is_of_type(GraphicsWindow::get_class_type())) {
    return DCAST(GraphicsWindow, _window);
  }
  return NULL;
}

////////////////////////////////////////////////////////////////////
//     Function: WindowFramework::get_graphics_output
//       Access: Public
//  Description: Returns a pointer to the underlying GraphicsOutput
//               object
////////////////////////////////////////////////////////////////////
INLINE GraphicsOutput *WindowFramework::
get_graphics_output() const {
  return _window;
}

////////////////////////////////////////////////////////////////////
//     Function: WindowFramework::get_num_cameras
//       Access: Public
//  Description: Returns the number of 3-d cameras associated with the
//               window.  A window usually has only one camera, but it
//               may have multiple cameras if there are multiple
//               display regions within the window.
////////////////////////////////////////////////////////////////////
INLINE int WindowFramework::
get_num_cameras() const {
  return _cameras.size();
}

////////////////////////////////////////////////////////////////////
//     Function: WindowFramework::get_camera
//       Access: Public
//  Description: Returns the nth camera associated with the window.
////////////////////////////////////////////////////////////////////
INLINE Camera *WindowFramework::
get_camera(int n) const {
  nassertr(n >= 0 && n < (int)_cameras.size(), NULL);
  return _cameras[n];
}

////////////////////////////////////////////////////////////////////
//     Function: WindowFramework::get_display_region_2d
//       Access: Public
//  Description: Returns the default DisplayRegion created for the 2-d
//               scene (render2d).
////////////////////////////////////////////////////////////////////
INLINE DisplayRegion *WindowFramework::
get_display_region_2d() const {
  return _display_region_2d;
}

////////////////////////////////////////////////////////////////////
//     Function: WindowFramework::get_display_region_3d
//       Access: Public
//  Description: Returns the default DisplayRegion created for the 3-d
//               scene (render).
////////////////////////////////////////////////////////////////////
INLINE DisplayRegion *WindowFramework::
get_display_region_3d() const {
  return _display_region_3d;
}

////////////////////////////////////////////////////////////////////
//     Function: WindowFramework::get_anim_controls
//       Access: Public
//  Description: Returns the current state of the anim_controls flag.
////////////////////////////////////////////////////////////////////
INLINE bool WindowFramework::
get_anim_controls() const {
  return _anim_controls_enabled;
}

////////////////////////////////////////////////////////////////////
//     Function: WindowFramework::get_wireframe
//       Access: Public
//  Description: Returns the current state of the wireframe flag.
////////////////////////////////////////////////////////////////////
INLINE bool WindowFramework::
get_wireframe() const {
  return _wireframe_enabled;
}

////////////////////////////////////////////////////////////////////
//     Function: WindowFramework::get_texture
//       Access: Public
//  Description: Returns the current state of the texture flag.
////////////////////////////////////////////////////////////////////
INLINE bool WindowFramework::
get_texture() const {
  return _texture_enabled;
}

////////////////////////////////////////////////////////////////////
//     Function: WindowFramework::get_two_sided
//       Access: Public
//  Description: Returns the current state of the two_sided flag.
////////////////////////////////////////////////////////////////////
INLINE bool WindowFramework::
get_two_sided() const {
  return _two_sided_enabled;
}

////////////////////////////////////////////////////////////////////
//     Function: WindowFramework::get_one_sided_reverse
//       Access: Public
//  Description: Returns the current state of the one_sided_reverse flag.
////////////////////////////////////////////////////////////////////
INLINE bool WindowFramework::
get_one_sided_reverse() const {
  return _one_sided_reverse_enabled;
}

////////////////////////////////////////////////////////////////////
//     Function: WindowFramework::get_lighting
//       Access: Public
//  Description: Returns the current state of the lighting flag.
////////////////////////////////////////////////////////////////////
INLINE bool WindowFramework::
get_lighting() const {
  return _lighting_enabled;
}

////////////////////////////////////////////////////////////////////
//     Function: WindowFramework::get_perpixel
//       Access: Public
//  Description: Returns the current state of the perpixel flag.
////////////////////////////////////////////////////////////////////
INLINE bool WindowFramework::
get_perpixel() const {
  return _perpixel_enabled;
}

////////////////////////////////////////////////////////////////////
//     Function: WindowFramework::get_background_type
//       Access: Public
//  Description: Returns the current background type setting.
////////////////////////////////////////////////////////////////////
INLINE WindowFramework::BackgroundType WindowFramework::
get_background_type() const {
  return _background_type;
}
