set -x
set -e
BUILD_DIR=$PWD

if [ ! -e vendor/lib/libzbar.so ]; then
  zbar_url="https://sourceforge.net/projects/zbar/files/zbar/0.10/zbar-0.10.tar.bz2/download"
  curl -L $zbar_url -s -o - | tar jxf - -C $BUILD_DIR

  cd $BUILD_DIR/zbar-0.10/

  patch -p1 <<EOF
  diff --git a/zbar/jpeg.c b/zbar/jpeg.c
  index fb566f4..d1c1fb2 100644
  --- a/zbar/jpeg.c
  +++ b/zbar/jpeg.c
  @@ -79,8 +79,15 @@ int fill_input_buffer (j_decompress_ptr cinfo)
   void skip_input_data (j_decompress_ptr cinfo,
                         long num_bytes)
   {
  -    cinfo->src->next_input_byte = NULL;
  -    cinfo->src->bytes_in_buffer = 0;
  +    if (num_bytes > 0) {
  +        if (num_bytes < cinfo->src->bytes_in_buffer) {
  +            cinfo->src->next_input_byte += num_bytes;
  +            cinfo->src->bytes_in_buffer -= num_bytes;
  +        }
  +        else {
  +            fill_input_buffer(cinfo);
  +        }
  +    }
   }

   void term_source (j_decompress_ptr cinfo)
EOF

  CFLAGS="" ./configure --disable-video --without-gtk --without-qt --prefix=$BUILD_DIR/vendor

  make
  make install

  rm -r $BUILD_DIR/zbar-0.10
fi
