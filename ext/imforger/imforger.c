/* sprintf include */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* for access() */
#include <unistd.h>
/* include Imlib2 stuff */
#include <Imlib2.h>
/* ruby */
#include <ruby.h>

static VALUE imforger_save_file(VALUE self, VALUE outputString)
{
  VALUE r_input_image;
  VALUE r_output_image;
  VALUE r_options;
  VALUE r_width;
  VALUE r_height;
  VALUE r_maxwidth;
  VALUE r_maxheight;

  char *imagePath1;
  char *imagePath2;

  int width;
  int height;
  float scale;

  /* image handles */
  Imlib_Image image1;
  Imlib_Image image2;

  r_input_image  = rb_iv_get(self, "@input_image");
  r_output_image = rb_iv_set(self, "@output_image", outputString);
  r_options      = rb_iv_get(self, "@options");

  imagePath1 = StringValuePtr(r_input_image);
  imagePath2 = StringValuePtr(r_output_image);

  /* check that the file exists and can be read */
  /* TODO: raise a real error */
  if(access(imagePath1, R_OK) == -1){
    return rb_str_new2(strcat(imagePath1, ": File cannot be found."));
  }

  /* load the image1 */
  image1 = imlib_load_image(imagePath1);
  /* if the load was successful */
  if (image1)
  {
    char *tmp;
    /* set the image1 we loaded as the current context image1 to work on */
    imlib_context_set_image(image1);

    /* if the width and height were set, use that; otherwise use the
     * current dimensions */
    r_width  = rb_hash_aref(r_options, rb_str_new2("width"));
    r_height = rb_hash_aref(r_options, rb_str_new2("height"));
    if(r_width == Qnil){
      width = imlib_image_get_width();
    } else {
      width = NUM2INT(r_width);
    }
    if(r_height == Qnil){
      height = imlib_image_get_height();
    } else {
      height = NUM2INT(r_height);
    }

    /* going for maximum height */
    r_maxwidth  = rb_hash_aref(r_options, rb_str_new2("maxwidth"));
    r_maxheight = rb_hash_aref(r_options, rb_str_new2("maxheight"));
    if(r_maxwidth != Qnil){
      if(width > NUM2INT(r_maxwidth)){
        scale  = NUM2INT(r_maxwidth) / (float)width;
        width  = NUM2INT(r_maxwidth);
        height = (int)(scale * height);
      }
    }
    if(r_maxheight != Qnil){
      if(height > NUM2INT(r_maxheight)){
        scale  = NUM2INT(r_maxheight) / (float)height;
        height = NUM2INT(r_maxheight);
        width  = (int)(scale * width);
      }
    }

    /* set the image1 format 
     * to be the format of the extension of our last */
    /* argument - i.e. .png = png, .tif = tiff etc. */
    tmp = strrchr(imagePath2, '.');
      if(tmp)
        imlib_context_set_anti_alias(1);
        image2 = imlib_create_cropped_scaled_image(0,0,imlib_image_get_width(),imlib_image_get_height(),width,height);
        imlib_context_set_image(image2);
        imlib_image_set_format(tmp + 1);
      /* save the image1 */
      imlib_save_image(imagePath2);
    }
  return Qtrue;
}

VALUE cImforger;

void Init_imforger() {
  cImforger = rb_define_class("Imforger", rb_cObject);
  rb_define_private_method(cImforger, "save_file", imforger_save_file, 1);
}
