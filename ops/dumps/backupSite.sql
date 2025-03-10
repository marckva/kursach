PGDMP      "                }            postgres    17.2    17.1 B    >           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            ?           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            @           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            A           1262    5    postgres    DATABASE     |   CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Russian_Russia.1251';
    DROP DATABASE postgres;
                     postgres    false            B           0    0    DATABASE postgres    COMMENT     N   COMMENT ON DATABASE postgres IS 'default administrative connection database';
                        postgres    false    4929                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
                     pg_database_owner    false            C           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                        pg_database_owner    false    4            �            1259    16437    basket    TABLE     �   CREATE TABLE public.basket (
    basketid bigint NOT NULL,
    quantity integer NOT NULL,
    clientid bigint NOT NULL,
    productid bigint NOT NULL
);
    DROP TABLE public.basket;
       public         heap r       postgres    false    4            �            1259    16434    basket_basketid_seq    SEQUENCE     |   CREATE SEQUENCE public.basket_basketid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.basket_basketid_seq;
       public               postgres    false    225    4            D           0    0    basket_basketid_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.basket_basketid_seq OWNED BY public.basket.basketid;
          public               postgres    false    222            �            1259    16435    basket_clientid_seq    SEQUENCE     |   CREATE SEQUENCE public.basket_clientid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.basket_clientid_seq;
       public               postgres    false    225    4            E           0    0    basket_clientid_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.basket_clientid_seq OWNED BY public.basket.clientid;
          public               postgres    false    223            �            1259    16436    basket_productid_seq    SEQUENCE     }   CREATE SEQUENCE public.basket_productid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.basket_productid_seq;
       public               postgres    false    4    225            F           0    0    basket_productid_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.basket_productid_seq OWNED BY public.basket.productid;
          public               postgres    false    224            �            1259    16425    client    TABLE       CREATE TABLE public.client (
    clientid bigint NOT NULL,
    surname character varying,
    name character varying NOT NULL,
    patronymic character varying,
    address character varying,
    phone character varying,
    email character varying,
    userid bigint NOT NULL
);
    DROP TABLE public.client;
       public         heap r       postgres    false    4            �            1259    16423    client_clientid_seq    SEQUENCE     |   CREATE SEQUENCE public.client_clientid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.client_clientid_seq;
       public               postgres    false    221    4            G           0    0    client_clientid_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.client_clientid_seq OWNED BY public.client.clientid;
          public               postgres    false    219            �            1259    16424    client_userid_seq    SEQUENCE     z   CREATE SEQUENCE public.client_userid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.client_userid_seq;
       public               postgres    false    4    221            H           0    0    client_userid_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.client_userid_seq OWNED BY public.client.userid;
          public               postgres    false    220            �            1259    16450    order    TABLE     �   CREATE TABLE public."order" (
    orderid bigint NOT NULL,
    address character varying,
    phone character varying,
    email character varying,
    cost numeric NOT NULL,
    clientid bigint NOT NULL,
    status character varying NOT NULL
);
    DROP TABLE public."order";
       public         heap r       postgres    false    4            �            1259    24702    order_orderid_seq    SEQUENCE     z   CREATE SEQUENCE public.order_orderid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.order_orderid_seq;
       public               postgres    false    226    4            I           0    0    order_orderid_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.order_orderid_seq OWNED BY public."order".orderid;
          public               postgres    false    230            �            1259    16415    product    TABLE     �   CREATE TABLE public.product (
    productid bigint NOT NULL,
    productname character varying NOT NULL,
    description character varying,
    quantity integer NOT NULL,
    price numeric NOT NULL,
    photo character varying
);
    DROP TABLE public.product;
       public         heap r       postgres    false    4            �            1259    16414    product_productid_seq    SEQUENCE     ~   CREATE SEQUENCE public.product_productid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.product_productid_seq;
       public               postgres    false    218    4            J           0    0    product_productid_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.product_productid_seq OWNED BY public.product.productid;
          public               postgres    false    217            �            1259    16457    productorder    TABLE     �   CREATE TABLE public.productorder (
    quantity integer NOT NULL,
    orderid bigint NOT NULL,
    productid bigint NOT NULL
);
     DROP TABLE public.productorder;
       public         heap r       postgres    false    4            �            1259    24687    user    TABLE     �   CREATE TABLE public."user" (
    id bigint NOT NULL,
    username character varying NOT NULL,
    password character varying NOT NULL
);
    DROP TABLE public."user";
       public         heap r       postgres    false    4            �            1259    24700    user_id_seq    SEQUENCE     t   CREATE SEQUENCE public.user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.user_id_seq;
       public               postgres    false    228    4            K           0    0    user_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.user_id_seq OWNED BY public."user".id;
          public               postgres    false    229            �           2604    16440    basket basketid    DEFAULT     r   ALTER TABLE ONLY public.basket ALTER COLUMN basketid SET DEFAULT nextval('public.basket_basketid_seq'::regclass);
 >   ALTER TABLE public.basket ALTER COLUMN basketid DROP DEFAULT;
       public               postgres    false    225    222    225            �           2604    16441    basket clientid    DEFAULT     r   ALTER TABLE ONLY public.basket ALTER COLUMN clientid SET DEFAULT nextval('public.basket_clientid_seq'::regclass);
 >   ALTER TABLE public.basket ALTER COLUMN clientid DROP DEFAULT;
       public               postgres    false    225    223    225            �           2604    16442    basket productid    DEFAULT     t   ALTER TABLE ONLY public.basket ALTER COLUMN productid SET DEFAULT nextval('public.basket_productid_seq'::regclass);
 ?   ALTER TABLE public.basket ALTER COLUMN productid DROP DEFAULT;
       public               postgres    false    224    225    225            �           2604    16428    client clientid    DEFAULT     r   ALTER TABLE ONLY public.client ALTER COLUMN clientid SET DEFAULT nextval('public.client_clientid_seq'::regclass);
 >   ALTER TABLE public.client ALTER COLUMN clientid DROP DEFAULT;
       public               postgres    false    221    219    221            �           2604    16429    client userid    DEFAULT     n   ALTER TABLE ONLY public.client ALTER COLUMN userid SET DEFAULT nextval('public.client_userid_seq'::regclass);
 <   ALTER TABLE public.client ALTER COLUMN userid DROP DEFAULT;
       public               postgres    false    220    221    221            �           2604    24703    order orderid    DEFAULT     p   ALTER TABLE ONLY public."order" ALTER COLUMN orderid SET DEFAULT nextval('public.order_orderid_seq'::regclass);
 >   ALTER TABLE public."order" ALTER COLUMN orderid DROP DEFAULT;
       public               postgres    false    230    226            �           2604    16418    product productid    DEFAULT     v   ALTER TABLE ONLY public.product ALTER COLUMN productid SET DEFAULT nextval('public.product_productid_seq'::regclass);
 @   ALTER TABLE public.product ALTER COLUMN productid DROP DEFAULT;
       public               postgres    false    218    217    218            �           2604    24701    user id    DEFAULT     d   ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);
 8   ALTER TABLE public."user" ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    229    228            6          0    16437    basket 
   TABLE DATA           I   COPY public.basket (basketid, quantity, clientid, productid) FROM stdin;
    public               postgres    false    225   �I       2          0    16425    client 
   TABLE DATA           d   COPY public.client (clientid, surname, name, patronymic, address, phone, email, userid) FROM stdin;
    public               postgres    false    221   �I       7          0    16450    order 
   TABLE DATA           Y   COPY public."order" (orderid, address, phone, email, cost, clientid, status) FROM stdin;
    public               postgres    false    226   9J       /          0    16415    product 
   TABLE DATA           ^   COPY public.product (productid, productname, description, quantity, price, photo) FROM stdin;
    public               postgres    false    218   �J       8          0    16457    productorder 
   TABLE DATA           D   COPY public.productorder (quantity, orderid, productid) FROM stdin;
    public               postgres    false    227   �K       9          0    24687    user 
   TABLE DATA           8   COPY public."user" (id, username, password) FROM stdin;
    public               postgres    false    228   �K       L           0    0    basket_basketid_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.basket_basketid_seq', 15, true);
          public               postgres    false    222            M           0    0    basket_clientid_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.basket_clientid_seq', 1, false);
          public               postgres    false    223            N           0    0    basket_productid_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.basket_productid_seq', 1, false);
          public               postgres    false    224            O           0    0    client_clientid_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.client_clientid_seq', 4, true);
          public               postgres    false    219            P           0    0    client_userid_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.client_userid_seq', 1, false);
          public               postgres    false    220            Q           0    0    order_orderid_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.order_orderid_seq', 1, true);
          public               postgres    false    230            R           0    0    product_productid_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.product_productid_seq', 6, true);
          public               postgres    false    217            S           0    0    user_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('public.user_id_seq', 2, true);
          public               postgres    false    229            �           2606    16444    basket basket_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.basket
    ADD CONSTRAINT basket_pkey PRIMARY KEY (basketid);
 <   ALTER TABLE ONLY public.basket DROP CONSTRAINT basket_pkey;
       public                 postgres    false    225            �           2606    16433    client client_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.client
    ADD CONSTRAINT client_pkey PRIMARY KEY (clientid);
 <   ALTER TABLE ONLY public.client DROP CONSTRAINT client_pkey;
       public                 postgres    false    221            �           2606    16456    order order_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY public."order"
    ADD CONSTRAINT order_pkey PRIMARY KEY (orderid);
 <   ALTER TABLE ONLY public."order" DROP CONSTRAINT order_pkey;
       public                 postgres    false    226            �           2606    16422    product product_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (productid);
 >   ALTER TABLE ONLY public.product DROP CONSTRAINT product_pkey;
       public                 postgres    false    218            �           2606    24693    user user_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public."user" DROP CONSTRAINT user_pkey;
       public                 postgres    false    228            �           1259    24671    fki_clientidOrd_fkey    INDEX     N   CREATE INDEX "fki_clientidOrd_fkey" ON public."order" USING btree (clientid);
 *   DROP INDEX public."fki_clientidOrd_fkey";
       public                 postgres    false    226            �           1259    24677    fki_orderidInf_fkey    INDEX     Q   CREATE INDEX "fki_orderidInf_fkey" ON public.productorder USING btree (orderid);
 )   DROP INDEX public."fki_orderidInf_fkey";
       public                 postgres    false    227            �           1259    24683    fki_productidInf_fkey    INDEX     U   CREATE INDEX "fki_productidInf_fkey" ON public.productorder USING btree (productid);
 +   DROP INDEX public."fki_productidInf_fkey";
       public                 postgres    false    227            �           1259    24699    fki_userid_fkey    INDEX     D   CREATE INDEX fki_userid_fkey ON public.client USING btree (userid);
 #   DROP INDEX public.fki_userid_fkey;
       public                 postgres    false    221            �           2606    24656    basket clientidB_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.basket
    ADD CONSTRAINT "clientidB_fkey" FOREIGN KEY (clientid) REFERENCES public.client(clientid) ON UPDATE CASCADE ON DELETE CASCADE;
 A   ALTER TABLE ONLY public.basket DROP CONSTRAINT "clientidB_fkey";
       public               postgres    false    225    4748    221            �           2606    24666    order clientidOrd_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."order"
    ADD CONSTRAINT "clientidOrd_fkey" FOREIGN KEY (clientid) REFERENCES public.client(clientid);
 D   ALTER TABLE ONLY public."order" DROP CONSTRAINT "clientidOrd_fkey";
       public               postgres    false    226    4748    221            �           2606    24672    productorder orderidInf_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.productorder
    ADD CONSTRAINT "orderidInf_fkey" FOREIGN KEY (orderid) REFERENCES public."order"(orderid);
 H   ALTER TABLE ONLY public.productorder DROP CONSTRAINT "orderidInf_fkey";
       public               postgres    false    227    4754    226            �           2606    24661    basket productidB_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.basket
    ADD CONSTRAINT "productidB_fkey" FOREIGN KEY (productid) REFERENCES public.product(productid) ON UPDATE CASCADE ON DELETE CASCADE;
 B   ALTER TABLE ONLY public.basket DROP CONSTRAINT "productidB_fkey";
       public               postgres    false    218    4746    225            �           2606    24678    productorder productidInf_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.productorder
    ADD CONSTRAINT "productidInf_fkey" FOREIGN KEY (productid) REFERENCES public.product(productid);
 J   ALTER TABLE ONLY public.productorder DROP CONSTRAINT "productidInf_fkey";
       public               postgres    false    227    218    4746            �           2606    24694    client userid_fkey    FK CONSTRAINT     q   ALTER TABLE ONLY public.client
    ADD CONSTRAINT userid_fkey FOREIGN KEY (userid) REFERENCES public."user"(id);
 <   ALTER TABLE ONLY public.client DROP CONSTRAINT userid_fkey;
       public               postgres    false    228    221    4758            6      x������ � �      2   �   x�3ἰ����/�\�xaǅ��]��ya�@�]��Nd�{/l�� Rua��v��A��~��&��.6M�{a��6����斦f��FƜ9��z%�9I�U�ezF���9zE���\1z\\\ ��P-      7   w   x�l ��1	проспект Кузнецова	+795865923	DogVorobei@gmail.com	35450.00	4	В обработке
\.


u4w      /   �   x�e�An�@Eד�8�U�iؘ`�Q�h<����� $*\�܈	�vQK������=�YoY'��E�Ͻ��dj�Y�*��H�h�E�Í,��n�u>�hi*=w����ֻ�=�c�i�GS7�h91 ��@a�3> o�u�s|�����o��S��y�=��|�����\���$�I���,��~�kj      8      x�3�4�4�2�f\1z\\\ T      9   �   x�e�KJCA��q�:2��GwWeAPTЁ���*4J�z����>��qs����yG؛�dۃ�����x��>nt[:�
��X&�G`���[B7A�
8�&����־����@�9U��+uDvE��SAVw2��آxonn�������+���>���a�z:zA�B
i�gh�*(KZ�cZd呺�TƚUzT��F�2Z+�t��L��<�W-E�U��ѳ�Kr.�˲�"�_&     