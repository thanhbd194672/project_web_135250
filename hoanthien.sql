PGDMP                         {            postgres    15.1    15.1 '    (           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            )           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            *           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            +           1262    5    postgres    DATABASE     �   CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1258';
    DROP DATABASE postgres;
                postgres    false            ,           0    0    DATABASE postgres    COMMENT     N   COMMENT ON DATABASE postgres IS 'default administrative connection database';
                   postgres    false    3371                        3079    16384 	   adminpack 	   EXTENSION     A   CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;
    DROP EXTENSION adminpack;
                   false            -           0    0    EXTENSION adminpack    COMMENT     M   COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';
                        false    2            �            1255    16929    countreview()    FUNCTION     8  CREATE FUNCTION public.countreview() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
	--raise notice 'after trigger duoc kich hoat';
	-- xu ly
	update stalls set like_stall = (select count(id) from comment where id_stall = new.id_stall) where stalls.id = new.id_stall;
	--return new;
	return null;
end;
$$;
 $   DROP FUNCTION public.countreview();
       public          postgres    false            �            1255    16930    find_comment_stall(integer)    FUNCTION     �   CREATE FUNCTION public.find_comment_stall(integer) RETURNS integer[]
    LANGUAGE plpgsql
    AS $_$
	
DECLARE 
	list integer[];
BEGIN
	list:= 
	ARRAY(
	SELECT comment.id
	FROM comment
	where comment.id_stalls = $1
	);
	RETURN list;
END;
$_$;
 2   DROP FUNCTION public.find_comment_stall(integer);
       public          postgres    false            �            1255    16931    find_dish(integer)    FUNCTION     �   CREATE FUNCTION public.find_dish(integer) RETURNS integer[]
    LANGUAGE plpgsql
    AS $_$
	
DECLARE 
	list integer[];
BEGIN
	list:= 
	ARRAY(
	SELECT dishes.id
	FROM dishes 
	where dishes.id_stall = $1
	);
	RETURN list;
END;
$_$;
 )   DROP FUNCTION public.find_dish(integer);
       public          postgres    false            �            1255    16932    find_stall_known_dish(integer)    FUNCTION     �   CREATE FUNCTION public.find_stall_known_dish(integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE 
	id_stall integer;
BEGIN
	id_stall:= 
	
	(SELECT dishes.id_stall
	FROM dishes
	where dishes.id = $1);
	
	RETURN id_stall;
END;
$_$;
 5   DROP FUNCTION public.find_stall_known_dish(integer);
       public          postgres    false            �            1255    16933    update_number_students()    FUNCTION     �   CREATE FUNCTION public.update_number_students() RETURNS void
    LANGUAGE plpgsql
    AS $$
begin
     update clazz set number_students = number_of_student(clazz.clazz_id);
	 return;
end;
$$;
 /   DROP FUNCTION public.update_number_students();
       public          postgres    false            �            1255    16934    update_star()    FUNCTION     �  CREATE FUNCTION public.update_star() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	declare sum_star float;
	declare count_comment int;
	declare avg_star float;
BEGIN
	sum_star = sum(star) from comment where  id_stall = new.id_stall ;
	count_comment = count(star)from comment where id_stall = new.id_stall;
	avg_star = (sum_star )/(count_comment);
	
    UPDATE stalls  SET rating = avg_star
	WHERE   stalls.id = new.id_stall;
	RETURN new;
END;
$$;
 $   DROP FUNCTION public.update_star();
       public          postgres    false            �            1259    16935    t3_seq    SEQUENCE     n   CREATE SEQUENCE public.t3_seq
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;
    DROP SEQUENCE public.t3_seq;
       public          postgres    false            �            1259    16936    comment    TABLE     	  CREATE TABLE public.comment (
    id integer DEFAULT nextval('public.t3_seq'::regclass) NOT NULL,
    username character varying,
    id_stall integer,
    content character varying,
    star integer,
    "time" timestamp without time zone,
    like_cmt integer
);
    DROP TABLE public.comment;
       public         heap    postgres    false    215            �            1259    16942    t2_seq    SEQUENCE     n   CREATE SEQUENCE public.t2_seq
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;
    DROP SEQUENCE public.t2_seq;
       public          postgres    false            �            1259    16943    dishes    TABLE        CREATE TABLE public.dishes (
    id integer DEFAULT nextval('public.t2_seq'::regclass) NOT NULL,
    id_stall integer,
    name character varying,
    type character varying,
    sale_off integer,
    price double precision,
    image character varying
);
    DROP TABLE public.dishes;
       public         heap    postgres    false    217            �            1259    16949    feedback    TABLE     �   CREATE TABLE public.feedback (
    username character varying,
    name character varying,
    avatar character varying,
    comment character varying,
    star character varying
);
    DROP TABLE public.feedback;
       public         heap    postgres    false            �            1259    16954    t1_seq    SEQUENCE     n   CREATE SEQUENCE public.t1_seq
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;
    DROP SEQUENCE public.t1_seq;
       public          postgres    false            �            1259    16955    stalls    TABLE     {  CREATE TABLE public.stalls (
    id integer DEFAULT nextval('public.t1_seq'::regclass) NOT NULL,
    address character varying[],
    type character varying,
    time_o time without time zone,
    time_c time without time zone,
    rating double precision,
    telephone_num character varying[],
    like_stall integer,
    name character varying,
    image character varying
);
    DROP TABLE public.stalls;
       public         heap    postgres    false    220            �            1259    16961    users    TABLE       CREATE TABLE public.users (
    username character varying NOT NULL,
    password character varying,
    name character varying,
    address character varying,
    telephone_num character varying,
    favorite_list integer[],
    follow_stall integer[],
    avatar character varying
);
    DROP TABLE public.users;
       public         heap    postgres    false                      0    16936    comment 
   TABLE DATA           Z   COPY public.comment (id, username, id_stall, content, star, "time", like_cmt) FROM stdin;
    public          postgres    false    216   %0       !          0    16943    dishes 
   TABLE DATA           R   COPY public.dishes (id, id_stall, name, type, sale_off, price, image) FROM stdin;
    public          postgres    false    218   �1       "          0    16949    feedback 
   TABLE DATA           I   COPY public.feedback (username, name, avatar, comment, star) FROM stdin;
    public          postgres    false    219   S:       $          0    16955    stalls 
   TABLE DATA           s   COPY public.stalls (id, address, type, time_o, time_c, rating, telephone_num, like_stall, name, image) FROM stdin;
    public          postgres    false    221   �;       %          0    16961    users 
   TABLE DATA           v   COPY public.users (username, password, name, address, telephone_num, favorite_list, follow_stall, avatar) FROM stdin;
    public          postgres    false    222    A       .           0    0    t1_seq    SEQUENCE SET     5   SELECT pg_catalog.setval('public.t1_seq', 15, true);
          public          postgres    false    220            /           0    0    t2_seq    SEQUENCE SET     5   SELECT pg_catalog.setval('public.t2_seq', 89, true);
          public          postgres    false    217            0           0    0    t3_seq    SEQUENCE SET     5   SELECT pg_catalog.setval('public.t3_seq', 60, true);
          public          postgres    false    215            �           2606    16967    comment comment_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.comment DROP CONSTRAINT comment_pkey;
       public            postgres    false    216            �           2606    16969    dishes dish_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.dishes
    ADD CONSTRAINT dish_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.dishes DROP CONSTRAINT dish_pkey;
       public            postgres    false    218            �           2606    16971    stalls stall_pkey 
   CONSTRAINT     O   ALTER TABLE ONLY public.stalls
    ADD CONSTRAINT stall_pkey PRIMARY KEY (id);
 ;   ALTER TABLE ONLY public.stalls DROP CONSTRAINT stall_pkey;
       public            postgres    false    221            �           2606    16973    users unique_telephone_num 
   CONSTRAINT     ^   ALTER TABLE ONLY public.users
    ADD CONSTRAINT unique_telephone_num UNIQUE (telephone_num);
 D   ALTER TABLE ONLY public.users DROP CONSTRAINT unique_telephone_num;
       public            postgres    false    222            �           2606    16975    users user_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT user_pkey PRIMARY KEY (username);
 9   ALTER TABLE ONLY public.users DROP CONSTRAINT user_pkey;
       public            postgres    false    222            �           2620    16976 !   comment count_review_after_insert    TRIGGER     |   CREATE TRIGGER count_review_after_insert AFTER INSERT ON public.comment FOR EACH ROW EXECUTE FUNCTION public.countreview();
 :   DROP TRIGGER count_review_after_insert ON public.comment;
       public          postgres    false    216    223            �           2620    16977    comment update_star_comment    TRIGGER     v   CREATE TRIGGER update_star_comment AFTER INSERT ON public.comment FOR EACH ROW EXECUTE FUNCTION public.update_star();
 4   DROP TRIGGER update_star_comment ON public.comment;
       public          postgres    false    228    216            �           2606    16978    comment comment_id_stall_fkey    FK CONSTRAINT     ~   ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_id_stall_fkey FOREIGN KEY (id_stall) REFERENCES public.stalls(id);
 G   ALTER TABLE ONLY public.comment DROP CONSTRAINT comment_id_stall_fkey;
       public          postgres    false    216    221    3206            �           2606    16983    comment comment_username_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_username_fkey FOREIGN KEY (username) REFERENCES public.users(username);
 G   ALTER TABLE ONLY public.comment DROP CONSTRAINT comment_username_fkey;
       public          postgres    false    222    3210    216            �           2606    16988    dishes dish_id_stall_fkey    FK CONSTRAINT     z   ALTER TABLE ONLY public.dishes
    ADD CONSTRAINT dish_id_stall_fkey FOREIGN KEY (id_stall) REFERENCES public.stalls(id);
 C   ALTER TABLE ONLY public.dishes DROP CONSTRAINT dish_id_stall_fkey;
       public          postgres    false    218    221    3206               \  x���AN�0E��)�h5��񊃰�R)h�Z.��G��.@H �*Y��o¤�M�ƫy��ɲȤgI]�Fq�1Ŧ�h:g�
9D1�0�~��3�6��}��^m��	>�T��"h�ݒF+�xH�a{\��~3`�ܸ !	��(��,ꍁ��V����V�©��R{�<��<hf�|�Ni�ZIMˉ��&���M%p�5N0���$��#5~���t�5o�n˅-w,�Z�M]]�X�l�P�`�9'Q~C���\���I N�'��$�s7��'�H��H�-7��DMQ��_M8\7�.wwQ6M�L��{id�('����m��$����#��_���      !   �  x����o�����_1�mV")R�5.� I���(�P@Q�8���JCC�[������X�,��	6m�P�@����~�����(�810�3�y?ǲ��e~ɞ�9{�`'��[��ۿ���>OgV�r�~�o����Z�U�W2�s>�S����{n�$ߨ�a|(�
Ѐ@b���د��\�4�bܾ��N�euz���Z�U�U"�X����d��R�I}Bg�g�O��}���7�n6����������oo�ۿ�3�+J���p�I�S��v�hg�c�Q�U-���r����������=?8;�ӛ>^q1�i)<��cR�!0��޼���6&�blϽc��qq�	ْ�_q~����M����W��oRv^\�G�g��9IP�l����,����l%���c�m�"�ȴ.��q��� �y��0�8���aX���FP�79i�����\h��oH��Kn6�������2��8��A���+8�ؾb			KΔ���Q�=W,��݃���_�9挏��y��Z�M�$þ�"F�E��O�������	O�D�!�9>8:�"8$����4J�5o����ϛg��E,Rv�<���v"�=��B�1�	�3�s�N��-N
O�>�60�#��9+��\F��>2���/H�R%'K��o\~�/X��Ί�UW#r��T=�c�<�a(��{y6:�AR�� B�0�D��L�S�T\\�]���zmd���t�8���U�!O4�m��*[:�M��Cm��^���(�Tm怂i_�)'"R���K���ܹ�Α2)�U/���Kh^�_��=N���0��Xq]ߙ����:����s��׈`<��;�u:�U�,��żrm`y�	�����L2[����]!�zg�A� �w�.t@��c��<�~�Y YQ��,�~<�jlPlP"����&��D�ܼC�x��Q<a3���|���	G�kǻ��{lM���p�-��(� 5�%�z�;zh>�u�4\8j�b������Eq����Y0�q��Lg�;�|d:Uf����C�� �l�>�����G�7�D7��b�'����:�< :|.���{�&g�IĚ�dH�Ȑ�z�-0�9-B�n ��6�QCc�L��ھyou��VU�u ^p�? Vs� }�����6I�,�Fy�%{�`�W�a`��kv��ZB0�je�y]�+Y�Ԃ.��U(�ڻ�n�]��n#�a�,J�:M���*�)-;hdC)�D�QY}L{;�k�m�\�+�j��VP	�B��B�,����a}Л�ٱ^D4gx͓��#pzѸ��Ѹ�ƒ��\��(����jh�X��QH�`��V�hN��DH�����2꩛0�~Lo_�F�XClk��o`��c�J��lI�v3�����1V��R
Sl�y�zQ�N��I���X�I5wx.�d2����Ye2Mo��kQIvLlB��)����|�[Wm/�\0Ul�"ؚ9f��z��]�����<�jVgv��F��1��J����L�8$�K�ߌ�M����?���dߍu�s��8��q�������}5!}���[b�:�K��Qt(eM��F��"Z�:��i�l�/�����Je�H8��$��T�<��I�D�tc�o�������ubt0�؂g|���wp�n����r[�x�*v/��~뻄�CƖ
��62�6�����(�T�/��'��'ǋX&բ듛�G"Y�E{k	�Z�'�Sy6�gg��������W�	e��v%iy�i&`h����X�4�, �}��ϫ�6��9�8=�%O�6�f��Gl�j�&�9 3���O��F9�2{I�n��ߎ�U-E��U�����ȋ�ƽȎ4���H�yN�׸O��G�]:pZ�Sw>��DR��!��$j�j��P��Xv�/e~�u�K��oo���of.��H����8a�>���6�`��:�������:Ý:k�|�ItZ#��&��͆M��?�1�A��o�k�pdR�E��n�x{�ϖ�:k�~�"Qr�[YN��xa�nv�c���F	S85���������O[�1�2@5�_��#x=s�kב�7��j�3�H�u8ky�S�!
E�F�D;ŏa�%���`HH]ڔ���)��v�hAG�)}�W�@�SA�IU�Ш��ߥ���Є��"�z������6#h��������>�w������7      "   ~  x�Ւ�N�0���)�q�:�bGl,����&��O���'�#T&$���=�&�)H ��|����}d~�	(J�)�	z�P�xu �`���:�����;�����C��aޠ��$�(�w�T.���N)Bc�D�(�`Ah���a�O�b����Ǻ���N-�+ox�_�YݬТ]o����>���Y�>��oZI�-�P�e���$����8Jɲ{+T�sn8�eq�M��Qm�,��6u�B�v�k@ז<��Ԡ�Mu�+#�pGvHB���Q�v�����8y��ÚGt��Ӯ�˛{/�����4G�0��}2f1��)�Ɠ��#�$�v��Т����Q�Y|(=�G��ɍ���:��������S�      $   /  x��V]o�F}v~�U��������I�l�le�P	9c��cج)+�C[U}@H ���J	��CP
�X?��4��������&B�J�j��̜{��cݘo:�@�a9�]���r���z��Z,v�1��)Ɲ �|_<W�����d�1��3{���E��%�e�2�A�r��-:i�"�Ł���~$�K],锓g}�M�֊G5J,W�v�i���ee~�[v�3�Ɵ%E5��v�n��/����<G
��ěNŗ��M����0�����`��+�\
��@�W�v��U���AK`$�����:~���e��Ϣ�p�R0��2�5��Y0��cĻ�Zג�U<���f�j0>�H{���r6��!E�'�N���^��:_c�qyM�����~H�e�[p �����pdr��2�=��]ך	Α�緤lrp��혢`�*�"O.��������{8�|�y�#O4RZE$o�2ݬ1�g���s��IB2����M����2�EQ�u����*��q�ng���q� XT.&��S@6u`�f���5Z����c ӵr��h*��p!G�!h�v�����j��.�z~�o�ثY�7�%`7�~�p8��''<"��2�QE�p�Z�g!���	dߑ��Րk��^���H�g����A+ #��(H��F����$���������G6���N6������w��F ��H��(���b�R�̟2dl���1�pйr�JY�� �qT���6�Z�+t�wQ���%^i#&�A�u9�O��8�V����3���!��Z<�e֧�a�$=a]
6+�=��i�x8�����������������5��m�xMv��| ���B
���vU� ��S�'�u�X-�8�*�8�1�nu��5
�x���g�$���g�1�P<:�Z�:}W�r�c�Bz����^8�_�-.�^	�l`{E����j]OB���#��)?���v�M^�V���&��]\�K/�&UVM��l1AL�HcԹC�e�,�s_�k4��`+�2e#cOP��4f��w�u��aQI�k�[8ߖ���7�'��O�=�A���b�����9��L|�&#���F�bd��Q]3�h/#�j��*<x~���;�I:�b�F��&%�e}�a�+���q)�� 6�Vǽ�6��r����뜘��j�3{�k��bc�6���1�}���A����5HF�Ta�!J�櫍תhBoݙ��������i�T��DÖ�M�KzVo��A9��(T���o�e)!�i@=TYV������rM�Wsss���4U      %   g  x��T�n�@�}O����쟽(�!�
�9[�s�]c���Դ ����*)Ëܛ0�]��@`eɚ��7�|;3�4�<�@���p���V��XWTSEu�2�=�}�'&�+���M���v���ݽ���A2�ƃΛ��������SᏏ��/Ux������7<����H�
�KI��DĮЎ�G@#�
����M�wG��4O��/J��ٲ��-�ϛbl8�\p`b�ɣ[�}!�����=gb�������-����[���!�^1K�X���ϗc1\S ����f��VB҄S�'��<֡04�B@"��O����B/������L������ ��IE/@QJR*SJ����n�:�1��tu�wޮo��[�w�V��B��5��v{��Ӊ��c�\11�A�8�8��:�A�T05a(E��ت(=iV��Y�ENj��jt_��A�9�m���.'��ֵ��U��L��y����kߘժ1X%q��CE�JXg�z}�����>��d�u�D��I~�*E� %hsA^;�����yܭ����k�2&i&�_���2��J��f��s�v�b
ϲq)����x�f����|�     