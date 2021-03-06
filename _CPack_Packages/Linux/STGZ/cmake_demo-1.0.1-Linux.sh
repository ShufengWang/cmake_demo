#!/bin/sh

# Display usage
cpack_usage()
{
  cat <<EOF
Usage: $0 [options]
Options: [defaults in brackets after descriptions]
  --help            print this message
  --prefix=dir      directory in which to install
  --include-subdir  include the cmake_demo-1.0.1-Linux subdirectory
  --exclude-subdir  exclude the cmake_demo-1.0.1-Linux subdirectory
EOF
  exit 1
}

cpack_echo_exit()
{
  echo $1
  exit 1
}

# Display version
cpack_version()
{
  echo "cmake_demo Installer Version: 1.0.1, Copyright (c) Humanity"
}

# Helper function to fix windows paths.
cpack_fix_slashes ()
{
  echo "$1" | sed 's/\\/\//g'
}

interactive=TRUE
cpack_skip_license=FALSE
cpack_include_subdir=""
for a in "$@"; do
  if echo $a | grep "^--prefix=" > /dev/null 2> /dev/null; then
    cpack_prefix_dir=`echo $a | sed "s/^--prefix=//"`
    cpack_prefix_dir=`cpack_fix_slashes "${cpack_prefix_dir}"`
  fi
  if echo $a | grep "^--help" > /dev/null 2> /dev/null; then
    cpack_usage 
  fi
  if echo $a | grep "^--version" > /dev/null 2> /dev/null; then
    cpack_version 
    exit 2
  fi
  if echo $a | grep "^--include-subdir" > /dev/null 2> /dev/null; then
    cpack_include_subdir=TRUE
  fi
  if echo $a | grep "^--exclude-subdir" > /dev/null 2> /dev/null; then
    cpack_include_subdir=FALSE
  fi
  if echo $a | grep "^--skip-license" > /dev/null 2> /dev/null; then
    cpack_skip_license=TRUE
  fi
done

if [ "x${cpack_include_subdir}x" != "xx" -o "x${cpack_skip_license}x" = "xTRUEx" ]
then
  interactive=FALSE
fi

cpack_version
echo "This is a self-extracting archive."
toplevel="`pwd`"
if [ "x${cpack_prefix_dir}x" != "xx" ]
then
  toplevel="${cpack_prefix_dir}"
fi

echo "The archive will be extracted to: ${toplevel}"

if [ "x${interactive}x" = "xTRUEx" ]
then
  echo ""
  echo "If you want to stop extracting, please press <ctrl-C>."

  if [ "x${cpack_skip_license}x" != "xTRUEx" ]
  then
    more << '____cpack__here_doc____'
demo installer version: 1.0.1

____cpack__here_doc____
    echo
    echo "Do you accept the license? [yN]: "
    read line leftover
    case ${line} in
      y* | Y*)
        cpack_license_accepted=TRUE;;
      *)
        echo "License not accepted. Exiting ..."
        exit 1;;
    esac
  fi

  if [ "x${cpack_include_subdir}x" = "xx" ]
  then
    echo "By default the cmake_demo will be installed in:"
    echo "  \"${toplevel}/cmake_demo-1.0.1-Linux\""
    echo "Do you want to include the subdirectory cmake_demo-1.0.1-Linux?"
    echo "Saying no will install in: \"${toplevel}\" [Yn]: "
    read line leftover
    cpack_include_subdir=TRUE
    case ${line} in
      n* | N*)
        cpack_include_subdir=FALSE
    esac
  fi
fi

if [ "x${cpack_include_subdir}x" = "xTRUEx" ]
then
  toplevel="${toplevel}/cmake_demo-1.0.1-Linux"
  mkdir -p "${toplevel}"
fi
echo
echo "Using target directory: ${toplevel}"
echo "Extracting, please wait..."
echo ""

# take the archive portion of this file and pipe it to tar
# the NUMERIC parameter in this command should be one more
# than the number of lines in this header file
# there are tails which don't understand the "-n" argument, e.g. on SunOS
# OTOH there are tails which complain when not using the "-n" argument (e.g. GNU)
# so at first try to tail some file to see if tail fails if used with "-n"
# if so, don't use "-n"
use_new_tail_syntax="-n"
tail $use_new_tail_syntax +1 "$0" > /dev/null 2> /dev/null || use_new_tail_syntax=""

tail $use_new_tail_syntax +143 "$0" | gunzip | (cd "${toplevel}" && tar xf -) || cpack_echo_exit "Problem unpacking the cmake_demo-1.0.1-Linux"

echo "Unpacking finished successfully"

exit 0
#-----------------------------------------------------------
#      Start of TAR.GZ file
#-----------------------------------------------------------;

� ]��X �}	|T���{�d&!3�@���oI&���,���@��D��7ɘY�,!q��K���֥�U��E�Z[ѺP��T�+X�h[�k��Ϲ˛��̠������~<e��{��{��:��`�3ce�[y***j�n'�����<5�ՕNWUE�k����U�pU����ߎ8�'�{� �/xr���Ӻ8����3v�'�힗S��>.w�,���,��YA �_����)�� ���?i������%q��y�e��T�.TW�8WU�Vp�Z��H,
�1MMV��:��'�
+���ߴ�CGӖ��7]�p�i��=�=�?O�OӖ�H��}�-�c'�o�z屦-��d^[.�bK��拿�.���� ���$�]J�$�f~I�`U��\�ϩ��������+;�x��.�-sϨL��k��]V�.��Bᄼ���6A�w�#r-֭�}�@��3�W�mY]@�ps�E�7,&�?�������1|��J�BYl �tB�Ұ�Ǣr�S���B���e��@#4A��p .y�QπP捄Br�Ñ�\�x��й�=�R��QOHNc;����������X������ϔ���lncl,���Y8�����9�:G��3������i�tp�_����i�w0B��O���o�r=����T�-a2�G�bV�t\ԅ�Bj��Y�5��-��_#ܦ�������>V�u,���R�/���C���������C�1��ɠ/?;C�����3�5�A:���`:�1cZI���lRF.j��)�X_P���\61�/X�P�G�U8<;<'\o5�����*�����?G��2��� ���\^^K���gd�����2�_��'%0Qi���JR �c	�[\�G<���@*�<a��atJxI�"��-+.h�,�N�YJ3"%���D�Ă�fo{���v{�R<�	����6@TuzbPt��=����Bjh�)�-m�lnwK��R�Kj�\�/���I8�H�uy{$khmlk��^�������v �j�u��0��"1	Hdw3�����'H�/��AwA9�"J���H�	���+h�vU���M �}1H��*zu{OT���e�ߜ��r��w�R�S�����AΨ�^-�-*z�7�]E_��߮�W���3���
^��?��?\ş����˩�Ww�:���u:8���tp����m<����ɡȷY,�fVWgX��\���U]]sj�����W���n�Ցt��]��S'��<�N/�%�Ь�S��4<�X���q��^����ZC�&�+R�g��9V�&��<�~������C��i�L��Fm>�geËu�:Mx�	vLW?����v�z�>�T�������C|h�&�1:�.��/��1��G�6V^&�8��<�퀛�5��oF0N��语�Q�.�E�*�LF�pB��X�d��12�M��[�^��|�-�������t̃#�0����l��cmVs���E���q��QG(��
te���3'����t����b����������_=�����>~�Ƌz��_h�ytr�k-��}h+x���η>z�7��̝}���n���R����r�O�g�g����L��������wg���@_���w���2�Wd�=}o9�2��K��#C��@_K�cnί����M�k��ݬ#�|�`��ҟg�6.v8�i��8���3����1��c����Dخ㳗ի¦-�J߮��;��^�2V��L>skg�V�5�d�|���*�p�g���u��R��Y�����*�5�V*�e��.� ~(�y�MC�S눮,�pP�K��Y�'��]�X\��=����e���2pǲ�`$,wx:qy����7�K��#H^���j&F�/��5H� X ���x��8���z�h,�uf|@�H]/~����hm��)�����,��cW�о]^���u	���� ,���X"$#�K۽7���e�$!��B�s�7�������^h_ ,%b�W����fP��}�3�8P�v�,�-��q}�TUV!ԯ^�`a��*��4/�$��4.U�U�U'{�B#���(�*4�h���D���F�+���br|i�80gL۔��@�e����w���m7PX|ʍV,�g
�(�P��$J�(�/�|i�Y�v���)����n1�[�ΙSW󙬂�W�*�z>X����Cu*�EoR�G��*�z�m�
��s[�����*�M�U�ջ�*�zw`�
>V�R�W����*�6\=�5m���t���aN���q�*|ƺO�<�կ ���W�7oL�0�{���C�=0�Lc�=@�Oc���^�ޅi4գ;H�aLc��N�?�46�ѭ$�CLcS�D���4����o�4N���#�0�Mv���/�46��:�� ӸG~������&;�$��0�Mu�Aҝ��&:*��L���c'0݆i�?�]5oy�ܦ-�6m~�XkG�s{qdmz�)'	���Ñρ�o��10���Kh��M3p\n�|�޴������v�6�����=�<�7f�v�P�?u܈��[�nz��M⁦��' �.��Ȍ��$��,����y�D>�0ـ����$�u�g��G� >Z�`�V;@?x`��!K��hB����z���7mIl�|����Ʀ��7]-<��w�!��A�	�#/|98�H�KA<�ǉ�|���m8����`����Z��]yP;����6�2ʱ�U`��ϑW�ݓ8�@\!��Tp��׮�Y���a�#�")��oO�b�MI����C*P	er 㫾L���)��@�, l9�箦-�8��rP)�`�8����
 ��� ���� ���P�-Gf��Y}�گ8�~��G� ��@_ObrN)������ډ���P���
�t턾	酡�~J�<h���5_�+}M^��������&7�3cM�eyc.�nt���.Xռ�+��������	��:�^;c'��-S�w���ԗF��G~�����9��-�l�l�,�C��}bӬ?'>@�z���,X����>����c���^���b�U0ID��	��	�!�tɳ���)G�3���V ܕ#t���Xae�H"ꌬ;�'�h���@Yr�rb#��㨀Nq:T�~������@����`9#AE�Б�@��s �Ax�{ ��/ ĵ�HP� ���L�,��ϯ�ܩ�q&�m������dvG��xIސ��M���ӧV�?MT�F��#.��j>�o�?���Eu�̈́��F�âr����2�!����ǀOw��/¿À�t��C���g�]���2s��_�e��q����Zm��q���^|������`�|���^qEV��v�e��.h�]`�X`����\h/��v+i����:�?|�G�%�����}�QxC41��b�o1��2
w��m�#�Gf�?k';��G���Sϩ��s�9��zN=��o�8�yE�Oؾ�1�~��v#���z�E�?��{[�܄����|o����{R��������O�;	���$�͢i���d�i����&�Ct�o���<���9-�u��|�p8{s�4�:��r�;|ϐ��"R�ٔ~����X�2���z�9��id����~���
���{X�(���u�?ca��"Ndau�ɟ��;.�h����Gw�t�V���[�Vq'أ�Ah����h�,�TQQ��=h��N\FN C3~�)M�Q�� M�c ����v���bӹ` �w�ƍ�� �'�š�*&*́a�I���$t%��$��g��FI4�σNe4�D����E��/@w0Z�r��u��1O�X�n��(W����/B�$7�8 1T���f'�?c�x`6����⧠�K͗a�����m��7X���RH\inE�{��V�:У�LDn3wa��$��Ø� ���	L�Hb��"LT�x�s���&��5��A�F<�yF0xAS6E���)�ș��n͂�M�E�a!-�;��M&s!Ʊ$���bwY&���p���Y��0��f�����A���~,z��1YV��e�&�jD9�c9'J��e�Fa+����"��B��l�Dr�W�
���M�@8.�{˹xBk����(�uNA�Cn�N��C����0*>�Zw;��Z�>��R�u.\��[/ ��%������Ip�$��}��'��$ض��]H���A�۟#�����$�^2���I��V�����B��>N���"���`G��I��� ������I������H�ˁ�켞�=@�]�!���`��I<QI�=kH��E$x���G�g��Y�d���Z�j5	��'��H��I��~��=��8��ƒ�@ìV���f��'a������^a�}\�>�6� ��36�aF?��.�����M�|�A.6~J�l�����ϲ�@� �-CR��������ly\�,����>�} �6\4q�A���_�k�6�P8�9�P�N��%�g>�p �eVg�����0;Gl�t \�4�u%�vy�]<�Fi�JGC40T|���<�А�PB�m��"� ���w���h�fH�\�����fE���d;Ś��QY,#�]*G�B�x�n�8u�,~:��)�@|F�.�C�T����F.�`�F#��<��l��A�=�/PШ��Bq�;�4r%��8�n�D�w_��q����?�|�Q ����@�1�E����EB�؃ ^�x����	y ���n���а��øC��0.Bn�-{��QD�x�Pq:���"�B"�m�R}�O@I�Q�* ��7�g�X�L�F����Qji��,^K�E�#�E���io�l��O�2�/Eq��=�|ƍ�!�����B��n�K��/��V�[M���m{����53�~4¸�H:qD�(��&���D�:����,�I6���+��9�����mϤ�^�q��?�$�	�/��W�7�"��(�)?�<��\ �E �&�x��(��wx{��R�K�C#? ��8��Tr�6��렭�E �u%��ߣ��}�L��K%��+)A5����Qc�w�Ch�tC�}�=����j6��'�о[����s��i��6��~��qa��1\UL�[5�i5�i�h�E<o@�ǀh/S��EOž�w{���0�Hۦ�h%������q4�J�^��5P`1`F'�w�UՈ˥���Q�S�Q|�X�V���aӾD��V�`5���Q�>��q���b�ūA�7�^-M�p�-h=g�3M�� |)�X���l;K�ϣ6�'��T�#�f�&m��~;:(ޡEY�p��z�Pie:�pȶ��KnS�D�K	����}G|�Q��#?���`27*�m���׋��xX�+?��g��h�#�+�A�*�d4�>����"4�W�2��fh��\n-I�S��о_|W�9�PF|�OŇ�R�P�{�/Dq%����U ���ؓ�+(^
�c�'� �AA9��/Żrq]�F�d�DO����P"uI�����)��T�*�-�
��X�%6��.U��G-�ĳ��ϩ��:���4C+�H)n�U6M�)�T�5VF�#�?����Tζ3�� ��BC����赆kʹϊ�'����B����9v�0�}�/y�zY,�@��yn���P3��n�r%�k4��2Cm,e�������5\ ��ǈ�P�$s��v��W��n@�,���`ec�������~�k��"�"�À:�D�l����X1Cp��SЛ1�놎|��I
��Ї}�!'�s ��1�P"�'�w`�=@�	�+��Z�ae\���eX�e�K��� ��6{��`öq��1�^���ST�gӌ�v���w �~�rw9�Q_�:n��'p��P�OF���
AiN��F�JO\��3F��@�j����Q�^�i���������ff�� �V��3��]F���;����<j��F�*��qh;�>е}�X4����y��,B�R���	x��F�z(���^�k��g�����O�2�m��V�0+7r�n���iL˂�Б�	0�����|M=ݸJ��7��y�誉$�S=W�
-����!,~F��C�T���6�m�C��$4��F1���nh�j� Ǯ�L����N�����E(_6��X��Բ��&�2�����
����Y�]�56�e�/�fQ)��062곁�'��N2��[�e@t��P_�Y��#~(��Q%���m晼���?��e����B����W��Hi�W�y%�f2�k54�p'̪l�5����R+C�P��<w$�����j�1����0>���&��9HQ��b�� ̐�Q3�4�Q�r*�O���IC֗������k^��>�u@ySj}�f-.bY��2da��\�7��oi��5�e�=�e�AI��R�$'�4K8밉e��5i�$�4�@V���? �6M�Qm�
rS����ɒ�-O�,�~��|�� PZt������3�0_����'3��텬�l	�4\͐���m8E�� [���!q�n���U9l���n·��2�����۳�@| ~Sd,"��',V�;�L�2�W �s\y88����П ��$z!��%��bсݥXA����}9�P�8Z5}��ԶK��Q�ʐB��iF�`��� �[Rٲ�?7����=
�I�
�赬v0@t$]�Hh�6�F2B즨$S��K,-F^���J�؎6��k���K�Z���->���n(I#(�ˍ�DF�S ړQP��I�#x���H:A	�˖���D��䗦t
�4Y޵3©@4�4��Hh�g<��Dݥ�%lOX����@yC*5#̷&̼�@�+�������e\P<�8�NP$��?.e�_`�Gd���g��{�T���J��J�'G���wDA��>ֹ�96Fx]3"��Hh?ϸ���@�+������(��� r8����F���x��(wdA��v�u	8���=M �VUE���!��,�� .��F�kDi�7k�M��Ie�����Q`�ہrOj�$�G���,�A�sx�Z	�f�q�pF���Ge�i�Կ3^9�QO����T�<܀�F���>&~1���F(��(�\#R�'��P���a�ț�љ��?�Ux�VĽ�� b��U��_�d���:j�pJW��p�3��s��k��"�d���m2�F��6YkG�M���1����&ȱ�&Ȃ��b�����ڻ�,ק"�T�1��Zjk�ٴ�_�yO�������^���E��"d��?��W��(�7K9��fKK��M;��%xD];�4��Y��L'�|k4e�����P4�E�����rk�{��
��b�U�U 6�p�=ى���XJ:����~�UP�c����H�c�Ѩ1X��9��4�S9�#�M�������[�3Ơ[��r��d��BA�y6��BS���r��ȧ)�w�q�h�1o t�(�)���7.8F�T�<	��KS��Ɲ���`���1�%u	he�t�4Ս�p�����F�V����/�&�j�t��Kq�bɺy� ���1�n��|�ZR�c0�BV1q�$0G���"������D+-�;�?���f�rϡ)Ӽ˰vM	s_C�FD���@Xp\,�@�5���_�:6Q�c��\ �^�A��������6-v�����r�瑠��#��<@��H��Yf�JR;�0t�$�x*0�I໌�m$�?H��gI��&	�Hp^��	"-$�=��H{��7H��	�+1��#��l�I��-$��'���$�|=	�x���C�+_�ēu���+�����s����!����C����x#�#������~}��rԀ���<���J�J�eC �E!��S� �2�W@P�X��s��b
�z'h�b3b�ݡ*�Q�~��e��^�L���,m���B.���PO˅���hY> 2��8���,���t诖~r?�u0U�I��!��T,!B���"t���� r��$��2��<�e�a����"������DD���Vfxk�	�:�QB�hT�9Dxg��&l�*V��m���m��*5�P	�Fd�W�NS���KԼ�d���n&A��PJ���[�PՏB��'��S�cD+Q�'�[	��0<X���x-�'X��
o^�Q㭓(Qz�䅨���AcRݎb�]*2O���9�LP%4@�؋��u�{2�����@m��yL��~	�=�3��z{B��¾A�Q�Y	�������C�渡�\�q��	h��-�����
��x�iW��7�+�&��x��=�s-ƋMG�S\��9����1�4= cB���'	�dS(��&��
�〰�!z�K,���߉u�+-IM��	�oø`�9�f���)z��-���4���,A���I�iILݟ0C����HH���Z��0��<-.�2�1!�jW�,����{^L &��3�L����HQ*"��4���E�UD���p�^.�j�-��=���"޿8����Ghw�`U��O�V�0�[d�����B=�bY/�U]?l��Ld_���%8x,'��t�Ih�m�M�ǒ�A�#g�� /<�Ht���$���0U��_��L|]ɥ�8,� �)��W����c�h3/B��1@h�6s� v�9"�irӺ4��k�xj��8�%��Prjh�t��2�p��h�M8�.�=a�bR8�ގy�^�|�Zq�k�#[;�>I�䭙����U�B�d��9_½
=C4L�]F-z��J�J��E���C{����O��(��"�[���)
��m���H�tX!9@H&�W)��>�q�з(2lG��FA�'"]�c<H�)�w)4��
n<�+<�*P3��W�� /Nhv@�(�$!~�/��'4{a�Sxy{.�"A�#��i�%RG/��	yxSɸ.�h&^ϙ�0Xw��r"^�.:�D��������ԧ���X�JR�y	8����q���ڙ�UU��"�̼���Y��?�v&��yriH���1�Ü�
�'�2<qr��/�N8��O's?}���̠���n�k������a��w�,��' ���Bq�ϣ������{i�,���Y�U�b�Յ��l���~0��3�^a���>��/���eV�p�%*D��	C��:�bh�u��x�͔mQ<�l��>���g���{���:z��w`�ō���g t�bz�يy���g�T)n&ןM�c�%����E�/�K��g�B�kqن6��)^���jz��1~��v�i�x�i?����������w��C��Wa|�	���x-�W�(ù?�t+��`|��i����Y�7����5��ȧ�g�*�O���G>��/��/�����tE@v[�����ƫ�P�xsа|�d�0l �lFc1���|�e$zF�R'�	�4�[���Ȗ�k�+v�eVt���[0ˬx�0��+^��(��M�7p��_�/#�\�ixy�Hr�B�R���`I#�0�@Y#vu�#n��m���x��e&�(�*ThD)F�'nR0�c@̛��(UT���g��	���0���Yd ��p�}`
#��v��	b�,�;�V�`��%������=��ؒ��xG�d�;�waT0��}8?���V�3xu�̹P���x�\��[��"7B?/gP�YP�)����f7 � ��oǷ�|�%ܦ���~g�Cր&�o��<}V�6@�7}��7�����ad�p,	}jcMq1h�@���`
��q�N'��b)��#pJ���U'^�&�Y���/»�tj�H�e-"�o��g��(T�!E�݊3��E�8R�����@�GjQ45b�|�ޓQ%�7�&Phí��R��k���w��_[n.7�f3�<�4��,-I�pd���ʹ�����_)��Q�l��ZR�f�ݦV2�|D��M@�S�KG��#��*���H�"n}�$�K���ZD�(�(#���D;�����8�
�$^������q'NH�3�1�u��e,��,Ӫ� ��3ް}#8���3�;���7��w܌� �q����8ݞLu�����Z�����?�Y�&�m����sv���Ml����r���Ƶ?��K�Tuk_��e��gg�Ә��Û6���g��n<{D7�\ȳQZ���t�	b�8�>l��>/�8`�7	F��!�iƿ�&�C�`R��ɦ�j���w$i�ɬ�!��y_S�@���S؎�r��I�Cl�BsE�yBmc��a�x��q���M�Ɓ`$�h�r6C�F���L�f��b�A�e�����`�"3a8�`��<����X� �I`i���3 8w=��R��Q#�^J��:&�$�2��G��DI��f�+�)eF�q�� �O
A	'$�l~	�ƿZSʞ_��I�2�j���5AE���'NUW���A��S��0C� ���e�'��:�Ъ���.m1I�J��u�*u�$ح�CQ]JDC�1@�i�46,��������F@k5[��NW�2���$8�d�BS��oP��� ��u)�0L/p���2�{�d}Rn�xs@hH6	%lL�.��&u�����jU&�iEE.M�p𳕞������RV�6x+�X�"�˷�{ Ю�^]�-	�ìT��WÀ�j���,��%����f�nb�K�D�kܠ�}6F���aQ�ײ(|.�B�H,����F�C�Gq@�����׸�-ɾ���,�����ސ�G������hy �&|r�wڴrwY�H�@gy��[�_[#ո�ː��	$�R�x�w�1-&�GfR��O#�E���D�W��l3i���2J0��� u�+=��j��HY7�3�A�E�t&���@��������m���K��D�Q@A����H��$��7�z�2�z��G����b���*$�Q L���(	�(+k�7>�K�{I0$@��x $Sy��zI]<�T8��P�"�*�(�Tl��@
�<@�dZ��h���NZ,)U7���tӿk�6�9��&��<øa����I�2LJ��֟�O"�2Yք*E~E�k�?����C�hf8������!�q�Vp�gYU��
�D�i�
U|ik�'t��!��7({�r4JI��(h�!�����Lo$�x���^�N^�\ Kq�ifT�z�r��Y�&*y��]3%)��<A)��ͭ��XCC{����Bj)H����6���H�kh�~�v��#�� ��K/�'�/U
���	& ��0geզR6�������"�q�K�΁pӌ�ʏ��������*Z���Ͳ}�������=[Շx�+K��yBJ�	f*���w�
%5]��T��@C������=��v��6D퐼���'ӗ�.��{R���7�f������&���8ؤ�)�F��?��77�˒�w�K�j���?��I!�o UŶNʻ>
,�O���U�q:`J�#{n�W<��~b�*�	GІ��=P �@^=���MD�Rl �	�Ԁ��F]u�N����Yh��}״�R�n�}��qg�&b� ��4pM�bB�x�Ԁ�: o,R�Pg4Y���'n@i�����?��J�@k�.9���k��L� �	��b�a+��q��MB�&B�/��$_f�'ww{�5��Wg�C�>���u
��Q��(�S�j�	~c2m����A����mtE=���е1O�L��N/�����%t�hj�Fu���2z#�n��$b�]T�*�s�I��/zaHP���q��t*=`4�}'�7B�z���f����P�ZQ}8���'�#G��i �^X�Ƥި�}��g#��h�Pv8F��?�c���V玕��b�%�^|����1�v�@�1)������a� ��>��t��ZAZ�Kݲ��^�+�M��O�E�H�҆�a7��Tʬ&N����擫�p��;l�?��  ���pz$}f.�е�/N�H�h4���0N%d��`�Xg�/��!�ڥ�H$�f<�jO�+gz|>��1ޯ�Sb�1	��y�P/�+~@@׊o@N�����5�"�JD����¤���H$�	�v{0A��ߎ�5h2.i碬'0����T�mmpC�$�݊[8�/L*�c�ZT199APj5{��>{ ��5�n;L�k��=�xSh�.'�Q���΅N>�`G��2J&�a�]�^h�t��H"�	�@���D�گ�r�cr\��eC����Ai>�UUJ� aD�~���`�CV�|�僄��]�ВPiJ�mL�1�Z��8���1�'��#���������A�1l�x$����=A��!�g enO� ���x:O�q����Q�9μ��,��Q!H&\���W�rf2�E�T8����̇���W��T�� �̏�$EU�ܫ����M07ǲ�$�qftԻ���]�I�0sO��,�P8	�A��%�ZS6�N)�2G߉�?���}��R�
º��+uH�^�z0�"0���S-�z�E�P�
^�Z�#Hd�\y��K�\�@kK�=�.�'ִA���+����e������m9�K5��~�Ξ~�+H�0~c������!�N��H��oДlE�j=�Z���+s:AZ�v,uC�TO�]�5��h���I�����/H���{P�ZH��0ư,��ґ�;u�tNC����!�G\"�4�MY��0��z8����R/S2�06���5�*��� 2'뎬G)Io�[T�U���M�atᾔ��|�9ȹ��b�l��D���s,�ӓo#[]�vw�4�I�@Oִ�I*78�����(�Ӷv��Z�� ��X�]���S,\��m��w���L�4��Dk�	���K����K��%��Ͱ�<]v~m1C�[G6�`�י�W�
�?����/6a3���Ɍ�V�$�t��^���`4���8�$Z�6$��{�i@5ѭv���2�Xސ�I��$,?��G?�^!:ӢR� _�����sѠ�U4pӠ��>\0�u�:e��Ɗ&���^>�JV	�]
b��Ln�
`�Q0h�h��=��4�Z�T){>t��ɚ�Я�4S���D\�0�S��e�R�mtJ�j���|��R�����It���ڣ�D�^�7�c����&���k����i�z�lj���ϕ2�ju�ma��zOoC_(�՝ֱ��u~��r��+ɮ�Q;��;N�i�@=T��l=0�N���������ƨh��L4C:3	�����h�J�|=λCH@MA#u�E�E�2TB�Jڙ)��lqB�)��]J�Z��gNl���vd�q�q��!��NN������}�U��e�Ǆ6���Y�jvI�+Q�q�1$[O�%�#񵚙D��|>_!𱒪�i�O��[�٫�.���-' a��`��;���@4Ά �D59�YJgP�r�~�.��@XOƠ��>O�W��}�񴕟!��i�[R����/ʬ/�g�2��O}Ҍ�tт�
|_]�m�
��&t��df�
�؞��{g���p��͹��<�Ӟ���E�1IHP�F�������Ȫ,�+��Ǐ
;�M��v��ayn��~I��\��b�.����霱��9�����F�W�����ݤ�0�2�A,Z��CF��.����e��M�r%��.|d��L��P/�9��c8�e�6W���*��b���F�0��	����ɦm�|�̴�&�'����@�^�,����*�w�"��).��(LQ=A�����Vk�,Qz�@�1sr�]��S���闋t .Q9Xé�,i�䇺P�����;�џ��f?/���`z�7�<�������U�j7Cۭ�0=���"���>h�꩏j�M�O6���P���h8"�����ӻ+�(&l���
`��L���@w�5�fTv�	}�Y�zKw����U�f�����kU�CeM�M��kFV����A��4ƹ�KJY�����QVȸ}��3�*��Q8����Г�xP���G�TU*�v�I����P�� )c�Z@m���˔!��(����z3����䃬���`"֍k z*�����Ǡ�#X��� ����N�PC( ��Ҧ�`�%�IgL���ō;�d�����9B�Ұ�ǈ�
ePC�l���X6MAYex��7#�H��/�����	��~�O�� ��$d��`��V*��\��|��,!��L��#�,u���0�z%��+��j��0э¼�����Q"�V��/'?�\ZFg,&��!��� �'d��S��d �(��NX��T0 Μű���g���|��P�B���ui�;U�*��� N�I�v���Y�8��������>����{%�{��38�~�U�>�����Ϥ�}����zQ��Wd�@�!�����eH��C�^���A����#���,��oЅ=��	O��`�{���F!��T�<?��J�����^�����������{.�?7M����=�=+�����ɂ���[t�+X�
�ߩS�Cެ��j�c!M/���&���������>����˿]����,�v��SG�o��t�MC�XHӾ�(�Q]�n������N������g<iH�u�z�E��������+:4���u���߆y���{F�G��ק?`2)�#�������EH�-�g��,�1VažY��踮|�=��cN^>���Ͼ�����ȟ%j�og��;�r�����jU��ߝ����ܩ˟�ʯ��y�i:���X�b�M��˯竧��!����2���Wg�?k%������>C���0>F-\O�"��F�K������Ct3�"�sx��
ԗ�����j3����3����P��i���;�cj>����<E7*�-ܤ�+�p�2_�³�y�nI�}1#h�@Zx�2k�9�8��Q�O-<W�p�2�i�ve����Iw(����'Z�Pe��)�_/P��^���xQ������~S/Q��^��9-|D
����h�>:|L�3���$|2���\���{���M:{(c�:����L¿T8��"��W?���㵌�N"n#����3C���r_֕�����A��m�0�O���ι�Z$���W2��ϡ-��p�H�oj3�K&��u��ӷ����FB�j��%�o���>�R�a)�������
���q.�ڿ��CSj$� p���鍏99
���|C�\g���I�{���2�7d�o� ��������k>���|�����������t�q��H�.�g�s7)7���6�vq2ydF�"�_�bo3�w��×��˿�D���/g��D�\��i�_��:�z�D�������3x��O������;��Ǚ��9���_PG�i�}o4�'��2<�[R�&�4�wH����rW ��R<DOrcB�$�"RW0��	J�x$#g���㲯�f�̪�DRrGL����@w�|�Ph ��RRr#��*'�k��-����n��>���9���,�������%�qz�*+R��(�@�E�dA�/H�m�5H�IS3��,+�:��[��cY�B�:-����iPm�3�Eg-_���^��D�$���4/��*�*˪!k0�镼�i�g���L�$��%}Rk���'�&���]ˏY�x�P�j�c��^-U��y!�jW'nEC.<�g��{��m ��GW��r�;�>�WP'Zk=?�	ƚS��� V��;�fo���غԫ/`�뎰��EiE2��^I�<\P
�,�c�o��U.� 5~�3SX�JzSkI���*�_Tv&�m\gs�[�zw��Y�i*����y���S��H0�����iO���	9���B�`:�O"t���)+��(l:����z�h,��*�� �`a��*�T�we���!����
�:��o�Q�n�����TTTԸ�N]3�+�!}*]NWUE�����vU:+\U��
���S�V��5������*N%�?��F�0.������Drʧ:�%�xD״`U������9�<g�[�� ��hni��)/g�]N<5R(p�VA�j^�\Z�`Ɋ6�+�y9 +r�Z�SϷ����^7�<_��]5����k*\����+k�]�����3��s�Ǽ�$�^����A��[��%^�=='�/�9�p&S:gl��i�.�\K��@���Ƨ�Sϩ��s������p$ �  