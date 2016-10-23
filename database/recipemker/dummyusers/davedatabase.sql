--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.0
-- Dumped by pg_dump version 9.6.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: contains; Type: TABLE; Schema: public; Owner: dave
--

CREATE TABLE contains (
    id integer NOT NULL,
    recipe smallint NOT NULL,
    ingredient smallint NOT NULL,
    amount double precision NOT NULL,
    CONSTRAINT sane_amount CHECK ((amount >= (0)::double precision))
);


ALTER TABLE contains OWNER TO dave;

--
-- Name: contains_id_seq; Type: SEQUENCE; Schema: public; Owner: dave
--

CREATE SEQUENCE contains_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE contains_id_seq OWNER TO dave;

--
-- Name: contains_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dave
--

ALTER SEQUENCE contains_id_seq OWNED BY contains.id;


--
-- Name: ingredients; Type: TABLE; Schema: public; Owner: dave
--

CREATE TABLE ingredients (
    id integer NOT NULL,
    name text NOT NULL,
    calories double precision NOT NULL,
    sugar double precision NOT NULL,
    protein double precision NOT NULL,
    fat double precision NOT NULL,
    CONSTRAINT has_calories CHECK ((calories >= (0)::double precision)),
    CONSTRAINT has_fat CHECK ((sugar >= (0)::double precision)),
    CONSTRAINT has_protein CHECK ((sugar >= (0)::double precision)),
    CONSTRAINT has_sugar CHECK ((sugar >= (0)::double precision))
);


ALTER TABLE ingredients OWNER TO dave;

--
-- Name: ingredients_id_seq; Type: SEQUENCE; Schema: public; Owner: dave
--

CREATE SEQUENCE ingredients_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ingredients_id_seq OWNER TO dave;

--
-- Name: ingredients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dave
--

ALTER SEQUENCE ingredients_id_seq OWNED BY ingredients.id;


--
-- Name: mealplan; Type: TABLE; Schema: public; Owner: dave
--

CREATE TABLE mealplan (
    userid integer,
    recipeid integer,
    mealcode smallint,
    dateadded date NOT NULL,
    CONSTRAINT mealplan_valid_meal CHECK (((mealcode >= 1) AND (mealcode <= 3)))
);


ALTER TABLE mealplan OWNER TO dave;

--
-- Name: ratings; Type: TABLE; Schema: public; Owner: dave
--

CREATE TABLE ratings (
    id integer NOT NULL,
    userid smallint,
    recipe smallint,
    rating smallint,
    CONSTRAINT sane_rating CHECK (((rating >= 0) AND (rating <= 10)))
);


ALTER TABLE ratings OWNER TO dave;

--
-- Name: ratings_id_seq; Type: SEQUENCE; Schema: public; Owner: dave
--

CREATE SEQUENCE ratings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ratings_id_seq OWNER TO dave;

--
-- Name: ratings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dave
--

ALTER SEQUENCE ratings_id_seq OWNED BY ratings.id;


--
-- Name: recipes; Type: TABLE; Schema: public; Owner: dave
--

CREATE TABLE recipes (
    id integer NOT NULL,
    name text NOT NULL,
    author smallint,
    instruction_file text NOT NULL
);


ALTER TABLE recipes OWNER TO dave;

--
-- Name: recipes_id_seq; Type: SEQUENCE; Schema: public; Owner: dave
--

CREATE SEQUENCE recipes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE recipes_id_seq OWNER TO dave;

--
-- Name: recipes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dave
--

ALTER SEQUENCE recipes_id_seq OWNED BY recipes.id;


--
-- Name: userattr; Type: TABLE; Schema: public; Owner: dave
--

CREATE TABLE userattr (
    id integer NOT NULL,
    sex character(1),
    height smallint,
    weight smallint,
    age smallint,
    exercise smallint,
    userid smallint,
    CONSTRAINT sane_age CHECK (((age >= 0) AND (age <= 200))),
    CONSTRAINT sane_exercise CHECK (((exercise >= 1) AND (exercise <= 4))),
    CONSTRAINT sane_height CHECK (((height >= 0) AND (height <= 300))),
    CONSTRAINT sane_sex CHECK (((sex = 'M'::bpchar) OR (sex = 'F'::bpchar))),
    CONSTRAINT sane_weight CHECK (((weight >= 0) AND (weight <= 800)))
);


ALTER TABLE userattr OWNER TO dave;

--
-- Name: userattr_id_seq; Type: SEQUENCE; Schema: public; Owner: dave
--

CREATE SEQUENCE userattr_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE userattr_id_seq OWNER TO dave;

--
-- Name: userattr_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dave
--

ALTER SEQUENCE userattr_id_seq OWNED BY userattr.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: dave
--

CREATE TABLE users (
    id integer NOT NULL,
    name text NOT NULL,
    pwrd text NOT NULL,
    email text NOT NULL,
    attrid integer
);


ALTER TABLE users OWNER TO dave;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: dave
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_id_seq OWNER TO dave;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dave
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: contains id; Type: DEFAULT; Schema: public; Owner: dave
--

ALTER TABLE ONLY contains ALTER COLUMN id SET DEFAULT nextval('contains_id_seq'::regclass);


--
-- Name: ingredients id; Type: DEFAULT; Schema: public; Owner: dave
--

ALTER TABLE ONLY ingredients ALTER COLUMN id SET DEFAULT nextval('ingredients_id_seq'::regclass);


--
-- Name: ratings id; Type: DEFAULT; Schema: public; Owner: dave
--

ALTER TABLE ONLY ratings ALTER COLUMN id SET DEFAULT nextval('ratings_id_seq'::regclass);


--
-- Name: recipes id; Type: DEFAULT; Schema: public; Owner: dave
--

ALTER TABLE ONLY recipes ALTER COLUMN id SET DEFAULT nextval('recipes_id_seq'::regclass);


--
-- Name: userattr id; Type: DEFAULT; Schema: public; Owner: dave
--

ALTER TABLE ONLY userattr ALTER COLUMN id SET DEFAULT nextval('userattr_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: dave
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Data for Name: contains; Type: TABLE DATA; Schema: public; Owner: dave
--

COPY contains (id, recipe, ingredient, amount) FROM stdin;
149	8	210	10
150	8	1585	0.400000000000000022
151	8	2977	0.100000000000000006
152	8	2361	0.299999999999999989
153	8	2377	1.19999999999999996
154	8	1609	0.599999999999999978
155	8	3411	0.200000000000000011
156	8	3421	4
157	8	3297	3.5
158	8	528	1
159	8	1587	1.5
160	8	736	0.75
161	8	2412	0.100000000000000006
162	8	2977	0.100000000000000006
163	8	1502	0.599999999999999978
164	8	2165	0.5
165	13	1056	0.75
166	13	1609	1.19999999999999996
167	13	3543	0.299999999999999989
168	13	3051	0.299999999999999989
169	13	3093	0.149999999999999994
170	13	1618	0.100000000000000006
171	13	1666	0.400000000000000022
172	13	3088	0.149999999999999994
173	13	2365	1.5
174	13	1014	24
175	13	1502	1
176	13	1237	0.5
177	13	785	2
178	13	752	3
179	13	2944	3
180	13	2315	1.05000000000000004
181	13	3556	2
182	13	2514	1.19999999999999996
183	14	929	6
184	14	2877	0.800000000000000044
185	14	2361	0.149999999999999994
186	14	736	0.400000000000000022
187	14	3579	1.5
188	14	3297	1
189	14	1968	0.5
190	14	141	2
191	14	2310	0.299999999999999989
192	5	1088	0.299999999999999989
193	5	1267	0.200000000000000011
194	5	1577	0.0400000000000000008
195	5	1482	1.5
196	5	3317	2.95000000000000018
197	5	3542	0.149999999999999994
198	5	1070	0.5
199	5	862	2.5
200	5	1270	3.5
201	5	3317	0.200000000000000011
202	5	515	0.200000000000000011
203	5	2312	1.39999999999999991
204	5	3308	2.5
205	5	2932	1.25
206	5	497	1.25
207	15	2361	0.299999999999999989
208	15	935	7
209	15	2377	1.19999999999999996
210	15	1608	0.599999999999999978
211	15	2451	0.800000000000000044
212	15	1098	3
213	15	3297	2.5
214	15	2548	0.149999999999999994
215	15	53	1
216	15	3046	0.400000000000000022
223	3	2369	0.800000000000000044
224	3	1590	2.39999999999999991
225	3	1502	1.19999999999999996
226	3	3290	6
227	3	3046	0.25
228	3	3311	0.25
229	3	2361	0.349999999999999978
230	3	1528	4
231	3	1528	3
232	3	1052	3
249	11	1585	1.5
250	11	462	3.29999999999999982
251	11	2765	8
252	11	1571	18
253	2	3261	0.599999999999999978
254	2	102	1.10000000000000009
255	2	2562	0.5
256	2	3628	1.19999999999999996
257	2	1098	1
258	7	225	3
259	7	2361	0.170000000000000012
260	7	2277	2
261	7	3046	0.200000000000000011
262	7	3277	0.299999999999999989
263	9	2361	0.599999999999999978
264	9	2412	0.5
265	9	1608	0.599999999999999978
266	9	1968	1.5
267	9	2873	2
268	9	2873	4
269	9	3145	4
270	9	2765	5
271	9	736	0.800000000000000044
272	9	1270	0.5
273	9	2361	0.200000000000000011
280	10	2452	0.5
281	10	3625	1.39999999999999991
282	10	1014	16
283	10	2079	0.5
284	10	1076	0.200000000000000011
285	10	2971	6
286	10	1968	0.800000000000000044
287	6	2848	3.5
288	6	2369	0.5
289	6	316	8
290	6	2361	0.400000000000000022
291	6	2978	0.599999999999999978
292	6	3361	0.599999999999999978
293	6	3543	0.149999999999999994
294	6	2242	0.200000000000000011
295	12	3416	4
296	12	3317	0.0100000000000000002
297	12	2361	2.5
298	12	2765	7
299	12	580	0.5
300	12	1609	0.900000000000000022
301	12	2413	0.5
302	12	119	0.0500000000000000028
303	12	2991	15
304	12	2374	1.19999999999999996
305	12	3585	2.5
306	12	1968	0.5
307	4	2361	0.349999999999999978
308	4	2377	1.19999999999999996
309	4	1609	0.599999999999999978
310	4	2165	3.79999999999999982
311	4	1247	0.550000000000000044
312	4	1502	3
313	4	840	1.5
314	4	3399	2.5
315	4	3686	3
316	4	2877	2
317	16	1968	0.100000000000000006
318	16	1314	0.100000000000000006
319	16	1238	0.200000000000000011
320	16	3467	0.0599999999999999978
321	16	3313	0.119999999999999996
322	16	2364	0.280000000000000027
323	16	929	6
324	16	2329	1.5
325	16	3178	1
326	16	1609	0.5
327	16	1418	0.100000000000000006
328	16	2364	0.200000000000000011
329	16	3313	0.100000000000000006
330	16	3365	0.200000000000000011
331	16	2456	0.299999999999999989
332	16	1096	2.70000000000000018
\.


--
-- Name: contains_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dave
--

SELECT pg_catalog.setval('contains_id_seq', 332, true);


--
-- Data for Name: ingredients; Type: TABLE DATA; Schema: public; Owner: dave
--

COPY ingredients (id, name, calories, sugar, protein, fat) FROM stdin;
1	Almond, sugar-coated	2285	37.5	13.5999999999999996	37.5
2	Amino acid or creatine drink, prepared from dry powder with water or milk	147	2.70000000000000018	3.60000000000000009	1.10000000000000009
3	Amino acid or creatine powder	1666	0	98	0
4	Anchovy, canned	762	0	25.3999999999999986	8.90000000000000036
5	Apple, baked, no added fat	258	13.5999999999999996	0.299999999999999989	0
6	Apple, bonza, unpeeled, raw	244	11.5	0.299999999999999989	0.299999999999999989
7	Apple, canned or puree	239	11.9000000000000004	0.299999999999999989	0.200000000000000011
8	Apple, dried	1232	62.1000000000000014	1.30000000000000004	0.299999999999999989
9	Apple, fuji, unpeeled, raw	245	12.0999999999999996	0.299999999999999989	0.299999999999999989
10	Apple, golden delicious, unpeeled, raw	202	10.5	0.299999999999999989	0
11	Apple, granny-smith, unpeeled, baked, no added fat	216	9.80000000000000071	0.400000000000000022	0.200000000000000011
12	Apple, granny-smith, unpeeled, raw	202	10.3000000000000007	0.299999999999999989	0
13	Apple, green skin, peeled, raw	225	11.8000000000000007	0.299999999999999989	0
14	Apple, green skin, unpeeled, raw	202	10.4000000000000004	0.299999999999999989	0
15	Apple, jonathon, unpeeled, raw	226	11.8000000000000007	0.299999999999999989	0
16	Apple, peeled, raw, not further defined	254	13	0.299999999999999989	0.200000000000000011
17	Apple, peeled, stewed, sugar sweetened, no added fat	307	17.3000000000000007	0.200000000000000011	0.100000000000000006
18	Apple, pink lady, unpeeled, raw	247	11.9000000000000004	0.299999999999999989	0.400000000000000022
19	Apple, raw, not further defined	239	11.9000000000000004	0.299999999999999989	0.200000000000000011
20	Apple, red delicious, unpeeled, raw	248	13	0.299999999999999989	0
21	Apple, red skin, peeled, raw	259	13.1999999999999993	0.299999999999999989	0.200000000000000011
22	Apple, red skin, unpeeled, raw	243	12	0.299999999999999989	0.200000000000000011
23	Apple, royal gala, unpeeled, raw	222	11.0999999999999996	0.400000000000000022	0
24	Apple, toffee coated	377	18.6000000000000014	0.299999999999999989	0
25	Apple, unpeeled, raw, not further defined	237	11.8000000000000007	0.299999999999999989	0.200000000000000011
26	Apple, unpeeled, stewed, sugar added, no fat added	296	16.3999999999999986	0.200000000000000011	0.100000000000000006
27	Apricot, canned in intense sweetened liquid	110	4.29999999999999982	0.5	0
28	Apricot, canned in intense sweetened liquid, drained	118	3.89999999999999991	0.800000000000000044	0
29	Apricot, canned in intense sweetened liquid, liquid only	102	4.70000000000000018	0.200000000000000011	0
30	Apricot, canned in light syrup	209	9.69999999999999929	0.699999999999999956	0
31	Apricot, canned in light syrup, drained	214	9	1	0
32	Apricot, canned in light syrup, syrup only	204	10.5	0.299999999999999989	0
33	Apricot, canned in pear juice	192	8.19999999999999929	0.800000000000000044	0
34	Apricot, canned in pear juice, drained	196	7.79999999999999982	1	0
35	Apricot, canned in pear juice, juice only	187	8.69999999999999929	0.5	0
36	Apricot, canned in syrup	255	12.9000000000000004	0.699999999999999956	0
37	Apricot, canned in syrup, drained	258	12.3000000000000007	0.900000000000000022	0
38	Apricot, canned in syrup, syrup only	251	13.6999999999999993	0.400000000000000022	0
39	Apricot, dried	886	40.5	4.29999999999999982	0.200000000000000011
40	Apricot, raw	171	6.59999999999999964	0.800000000000000044	0.100000000000000006
41	Apricot, stewed, sugar sweetened, no added fat	347	17.8999999999999986	0.800000000000000044	0.100000000000000006
42	Artichoke, globe, boiled, microwaved or steamed, drained	170	1.10000000000000009	3.29999999999999982	0.200000000000000011
43	Artichoke, globe, boiled, microwaved or steamed, drained, added fat not further defined	358	1	3.20000000000000018	5.5
44	Artichoke, globe, raw	145	0.900000000000000022	2.79999999999999982	0.200000000000000011
45	Artichoke heart, canned in brine, drained	104	1.10000000000000009	1.89999999999999991	0.299999999999999989
46	Artichoke, jerusalem, peeled, boiled, microwaved or steamed, drained	263	2.89999999999999991	2.29999999999999982	0.100000000000000006
47	Artichoke, jerusalem, peeled, raw	245	2.70000000000000018	2.10000000000000009	0.100000000000000006
48	Asparagus, canned in brine, drained or undrained	101	1.5	1.89999999999999991	0.100000000000000006
49	Asparagus, green, fresh or frozen, baked, roasted, stir-fried or fried, grilled or BBQd, fat not further defined	324	1.60000000000000009	2.89999999999999991	6.09999999999999964
50	Asparagus, green, fresh or frozen, baked, roasted, stir-fried or fried, grilled or BBQd, no added fat	107	1.69999999999999996	3	0.100000000000000006
51	Asparagus, green, fresh or frozen, boiled, microwaved or steamed, drained	104	1.60000000000000009	2.89999999999999991	0.100000000000000006
52	Asparagus, green, fresh or frozen, boiled, microwaved or steamed, drained, added fat not further defined	295	1.60000000000000009	2.79999999999999982	5.40000000000000036
53	Asparagus, green, raw	88	1.39999999999999991	2.5	0.100000000000000006
54	Avocado, cooked, with or without fat	912	0.400000000000000022	1.89999999999999991	22.8000000000000007
55	Avocado, raw	867	0.400000000000000022	1.80000000000000004	21.6000000000000014
56	Babaco, peeled, raw	89	3.10000000000000009	1.30000000000000004	0.100000000000000006
57	Babyccino, from cows milk	248	6.29999999999999982	3.5	2.29999999999999982
58	Babyccino, from soy milk	229	3.20000000000000018	3.29999999999999982	1.89999999999999991
59	Bacon, 97% fat free, baked, roasted, fried, grilled or BBQd, with or without added fat	543	1.10000000000000009	24.6999999999999993	2.70000000000000018
60	Bacon, 97% fat free, raw	407	0.800000000000000044	18.5	2
61	Bacon, breakfast rasher, baked, roasted or fried, no added fat	646	1.80000000000000004	21.8999999999999986	5.79999999999999982
62	Bacon, breakfast rasher, grilled or BBQd, no added fat	591	1.80000000000000004	22.1999999999999993	4.5
63	Bacon, breakfast rasher, raw	403	0.699999999999999956	14.5999999999999996	3.39999999999999991
64	Bacon, middle rasher, fat only, grilled or BBQd	2747	0.400000000000000022	14.5	67.4000000000000057
65	Bacon, middle rasher or shortcut, fully-trimmed, baked, roasted, fried, grilled or BBQd, butter, dairy blend or margarine spread	827	0.5	27.8999999999999986	9.30000000000000071
66	Bacon, middle rasher or shortcut, fully-trimmed, baked, roasted, fried, grilled or BBQd, fat not further defined	845	0.5	27.8999999999999986	9.80000000000000071
67	Bacon, middle rasher or shortcut, fully-trimmed, baked, roasted, fried, grilled or BBQd, olive oil	846	0.5	27.8000000000000007	9.90000000000000036
68	Bacon, middle rasher or shortcut, fully-trimmed, baked, roasted, fried, stir-fried, grilled or BBQd, canola oil	846	0.5	27.8000000000000007	9.90000000000000036
69	Bacon, middle rasher or shortcut, fully-trimmed, baked, roasted, fried, stir-fried, grilled or BBQd, other oil	846	0.5	27.8000000000000007	9.90000000000000036
70	Bacon, middle rasher or shortcut, fully-trimmed, baked, roasted, grilled or BBQd, no added fat	998	0.900000000000000022	33.2000000000000028	11.3000000000000007
201	Beef, corned, with cereal, canned	837	0	14.5	13.3000000000000007
71	Bacon, middle rasher or shortcut, fully-trimmed, fried or stir-fried, no added fat	953	1	31.3999999999999986	10.9000000000000004
72	Bacon, middle rasher or shortcut, fully-trimmed, raw	572	0.400000000000000022	21.3000000000000007	5.5
73	Bacon, middle rasher, semi-trimmed, baked, roasted, fried, grilled or BBQd, butter, dairy blend & margarine	1362	0.400000000000000022	23.6000000000000014	25.8000000000000007
74	Bacon, middle rasher, semi-trimmed, baked, roasted, fried, grilled or BBQd, canola oil	1382	0.400000000000000022	23.6000000000000014	26.3000000000000007
75	Bacon, middle rasher, semi-trimmed, baked, roasted, fried, grilled or BBQd, fat not further defined	1380	0.400000000000000022	23.6000000000000014	26.3000000000000007
76	Bacon, middle rasher, semi-trimmed, baked, roasted, fried, grilled or BBQd, olive oil	1382	0.400000000000000022	23.6000000000000014	26.3000000000000007
77	Bacon, middle rasher, semi-trimmed, baked, roasted, fried, stir-fried, grilled or BBQd, other oil	1382	0.400000000000000022	23.6000000000000014	26.3000000000000007
78	Bacon, middle rasher, semi-trimmed, baked, roasted, grilled or BBQd, no added fat	1103	0.900000000000000022	32.1000000000000014	14.6999999999999993
79	Bacon, middle rasher, semi-trimmed, boiled, casseroled, microwaved, poached, steamed or stewed, no added fat	1310	0.400000000000000022	24.1000000000000014	24.1999999999999993
80	Bacon, middle rasher, semi-trimmed, fried or stir-fried, no added fat	1351	0.900000000000000022	26.8000000000000007	23.8000000000000007
81	Bacon, middle rasher, semi-trimmed, raw	982	0.299999999999999989	18	18.1000000000000014
82	Bacon, middle rasher, untrimmed, baked, roasted, fried, grilled or BBQd, fat not further defined	1809	0.299999999999999989	20.1999999999999993	39.5
83	Bacon, middle rasher, untrimmed, baked, roasted, fried, grilled or BBQd, no added fat	1747	0.299999999999999989	20.6000000000000014	37.6000000000000014
84	Bacon, middle rasher, untrimmed, boiled, casseroled, microwaved, poached, steamed or stewed, no added fat	1747	0.299999999999999989	20.6000000000000014	37.6000000000000014
85	Bacon, middle rasher, untrimmed, raw	1310	0.299999999999999989	15.4000000000000004	28.1999999999999993
86	Bacon, raw, used in baked products, not further defined	1091	0.299999999999999989	16.3000000000000007	21.8000000000000007
87	Bagel, from white flour, commercial	1094	6.20000000000000018	9.5	1.39999999999999991
88	Bagel, from white flour, commercial, toasted	1243	7	10.8000000000000007	1.60000000000000009
89	Bagel, fruit, commercial	1007	6.70000000000000018	8.59999999999999964	1.30000000000000004
90	Bagel, fruit, commercial, toasted	1144	7.59999999999999964	9.80000000000000071	1.39999999999999991
91	Baked beans, all flavours (except tomato sauce), reduced salt	375	3.39999999999999991	4.90000000000000036	0.299999999999999989
92	Baked beans, canned in BBQ sauce, regular	355	2.10000000000000009	4.90000000000000036	0.299999999999999989
93	Baked beans, canned in tomato & cheese sauce, regular	383	3.60000000000000009	4.90000000000000036	0.599999999999999978
94	Baked beans, canned in tomato sauce, reduced salt	375	3.39999999999999991	4.90000000000000036	0.299999999999999989
95	Baked beans, canned in tomato sauce, regular	355	2.10000000000000009	4.90000000000000036	0.299999999999999989
96	Baked beans, canned in tomato sauce, with sausages, regular	433	1.89999999999999991	5.79999999999999982	2.89999999999999991
97	Baked beans, canned, not further defined	363	2.29999999999999982	4.90000000000000036	0.5
98	Baking powder, dry powder	360	0	0	0.100000000000000006
99	Baking soda (bicarbonate), dry powder	0	0	0	0
100	Bamboo shoot, canned in water, heated, drained	57	0.800000000000000044	0.800000000000000044	0
101	Bamboo shoot, fresh, cooked, with or without fat	57	0.800000000000000044	0.800000000000000044	0
102	Banana, cavendish, peeled, raw	385	12.8000000000000007	1.39999999999999991	0.299999999999999989
103	Banana chip	2171	35.2999999999999972	2.29999999999999982	33.6000000000000014
104	Banana, cooked	516	13.4000000000000004	1.39999999999999991	3.29999999999999982
105	Banana, lady finger or sugar, peeled, raw	474	18.1999999999999993	1.5	0.100000000000000006
106	BarleyMax, dry, uncooked	1385	5	18.1000000000000014	7.79999999999999982
107	Barley, pearl, cooked in water, no added fat or salt	416	0	2.89999999999999991	0.900000000000000022
108	Barley, pearl, uncooked	1358	0.699999999999999956	8	2.39999999999999991
109	Barramundi, baked, roasted, grilled, BBQd, fried or deep fried, butter, dairy blend or margarine	704	0	25.3000000000000007	7.40000000000000036
110	Barramundi, baked, roasted, grilled, BBQd, fried or deep fried, canola oil	755	0	25.1999999999999993	8.80000000000000071
111	Barramundi, baked, roasted, grilled, BBQd, fried or deep fried, fat not further defined	750	0	25.3000000000000007	8.69999999999999929
112	Barramundi, baked, roasted, grilled, BBQd, fried or deep fried, olive oil	755	0	25.1999999999999993	8.80000000000000071
113	Barramundi, baked, roasted, grilled, BBQd, fried or deep fried, other oil	755	0	25.1999999999999993	8.80000000000000071
114	Barramundi, baked, roasted, grilled, BBQd or fried, no added fat	528	0	26.6000000000000014	2.10000000000000009
115	Barramundi, boiled, microwaved, steamed or poached, no added fat	459	0	23.1000000000000014	1.80000000000000004
116	Barramundi, coated, baked, roasted, fried, deep fried, grilled or BBQd, fat not further defined	821	0.400000000000000022	20.8000000000000007	9.5
117	Barramundi, coated, takeaway outlet, deep fried	1059	0.200000000000000011	15.8000000000000007	16.8999999999999986
118	Barramundi, raw	385	0	19.3999999999999986	1.5
119	Basil, dried	1079	0	18.1999999999999993	5.5
120	Basil, green, raw	119	0	2	0.599999999999999978
121	Bassa (basa), baked, roasted, grilled, BBQd, fried or deep fried, fat not further defined	681	0	20.3999999999999986	9
122	Bassa (basa), baked, roasted, grilled, BBQd or fried, no added fat	455	0	21.5	2.39999999999999991
123	Bassa (basa), boiled, microwaved, steamed or poached, with or without added fat	415	0	18.6000000000000014	2.70000000000000018
124	Bassa (basa), coated, baked, roasted, fried, deep fried, grilled or BBQd, fat not further defined	767	0.400000000000000022	17	9.80000000000000071
125	Bassa (basa), raw	332	0	15.6999999999999993	1.80000000000000004
126	Batter for coating food, commercial, uncooked	487	0	3.5	0.400000000000000022
127	Batter for coating food, homemade, uncooked	541	1.69999999999999996	5.40000000000000036	2.10000000000000009
128	Bean, black, dried, boiled, microwaved or steamed, drained	464	4.70000000000000018	8.19999999999999929	0.699999999999999956
129	Bean, broad, canned, drained	250	0.699999999999999956	7.29999999999999982	0.5
130	Bean, broad, fresh or frozen, boiled, microwaved or steamed, drained	252	0.800000000000000044	7.40000000000000036	0.5
131	Bean, broad, fresh or frozen, raw	235	0.699999999999999956	6.90000000000000036	0.5
132	Bean, butter, fresh, boiled, microwaved or steamed, drained	112	1.89999999999999991	2.5	0.200000000000000011
133	Bean, butter, fresh, raw	104	1.80000000000000004	2.29999999999999982	0.200000000000000011
134	Bean, cannellini, canned, drained	404	2.10000000000000009	6.20000000000000018	0.599999999999999978
135	Bean, green, canned, cooked, no added fat	102	1.30000000000000004	1.39999999999999991	0.200000000000000011
136	Bean, green, cooked, not further defined	96	1.5	1.39999999999999991	0.200000000000000011
137	Bean, green, fresh, boiled, microwaved or steamed, drained	89	1.69999999999999996	1.5	0.200000000000000011
138	Bean, green, fresh or frozen, baked, roasted, fried, stir-fried, grilled or BBQd, fat not further defined	339	1.30000000000000004	2.5	6
139	Bean, green, fresh or frozen, baked, roasted, fried, stir-fried, grilled or BBQd, no added fat	132	1.39999999999999991	2.60000000000000009	0.200000000000000011
140	Bean, green, fresh or frozen, boiled, microwaved or steamed, added fat not further defined	288	1.19999999999999996	2.20000000000000018	4.90000000000000036
141	Bean, green, fresh or frozen, raw	112	1.19999999999999996	2.20000000000000018	0.200000000000000011
142	Bean, green, frozen, boiled, microwaved or steamed, drained	102	1.30000000000000004	1.39999999999999991	0.200000000000000011
143	Bean, haricot, dried	1220	3.5	21.8999999999999986	2.20000000000000018
144	Bean, haricot, dried, boiled, microwaved or steamed, drained	464	4.70000000000000018	8.19999999999999929	0.699999999999999956
145	Bean, lima, dried	1299	3.70000000000000018	21.3999999999999986	1.69999999999999996
146	Bean, lima, dried, boiled, microwaved or steamed, drained	355	0.599999999999999978	6.40000000000000036	0.299999999999999989
147	Bean, lupin, canned, drained	472	0.699999999999999956	13.9000000000000004	2.39999999999999991
148	Bean, lupin, raw	1389	2	41	7
149	Bean, mixed, canned, drained	426	2.5	6.40000000000000036	0.400000000000000022
150	Bean paste	805	32.2000000000000028	6.09999999999999964	0.400000000000000022
151	Bean, red, fresh, boiled, drained	604	1.30000000000000004	13.8000000000000007	0.400000000000000022
152	Bean, red, fresh, raw	561	1.19999999999999996	12.8000000000000007	0.400000000000000022
153	Bean, red, kidney, canned, drained	441	2.39999999999999991	6.59999999999999964	0.599999999999999978
154	Bean, red kidney, dried	1251	3.39999999999999991	22.5	1.80000000000000004
155	Bean, red kidney, dried, boiled, microwaved or steamed, drained	382	0.599999999999999978	7.90000000000000036	0.5
156	Bean, refried, canned	363	0.200000000000000011	5.5	1.30000000000000004
157	Bean, soya, canned, drained	438	1.89999999999999991	8.59999999999999964	5.5
158	Bean, soya, dried	1681	6.70000000000000018	31.3000000000000007	20.1999999999999993
159	Bean, soya, dried, boiled, microwaved or steamed, drained	614	1.39999999999999991	13.5	7.70000000000000018
160	Beef, all cuts, separable fat, grilled or roasted without fat	2317	0	15.3000000000000007	55.6000000000000014
161	Beef, all cuts, separable fat, raw	2478	0	12.0999999999999996	61.3999999999999986
162	Beef, BBQ/grill/fry cuts, fully-trimmed, BBQd, grilled or fried, no added fat	724	0	31.1000000000000014	5.29999999999999982
163	Beef, BBQ/grill/fry cuts, fully-trimmed, raw	546	0	22.3999999999999986	4.5
164	Beef, BBQ/grill/fry cuts, semi-trimmed, BBQd, grilled or fried, no added fat	804	0	30.3000000000000007	7.79999999999999982
165	Beef, BBQ/grill/fry cuts, semi-trimmed, raw	632	0	21.8999999999999986	7
166	Beef, blade steak, fully-trimmed, baked, roasted, fried, grilled or BBQd, fat not further defined	728	0	26.1999999999999993	7.70000000000000018
167	Beef, blade steak, fully-trimmed, baked, roasted, fried, grilled or BBQd, no added fat	683	0	31.6000000000000014	4
168	Beef, blade steak, fully-trimmed, boiled, casseroled, microwaved, poached, steamed or stewed, fat not further defined	745	0	26.8000000000000007	7.79999999999999982
169	Beef, blade steak, fully-trimmed, boiled, casseroled, microwaved, poached, steamed or stewed, no added fat	667	0	27.3999999999999986	5.5
170	Beef, blade steak, fully-trimmed, raw	534	0	21.8999999999999986	4.40000000000000036
171	Beef, blade steak, semi-trimmed, baked, roasted, fried, grilled or BBQd, fat not further defined	803	0	25.8000000000000007	9.90000000000000036
172	Beef, blade steak, semi-trimmed, baked, roasted, fried, grilled or BBQd, no added fat	740	0	31	5.79999999999999982
173	Beef, blade steak, semi-trimmed, raw	598	0	21.6000000000000014	6.20000000000000018
174	Beef, blade steak, separable fat, grilled or BBQd, no added fat	2317	0	15.3000000000000007	55.6000000000000014
175	Beef, blade steak, separable fat, raw	2478	0	12.0999999999999996	61.3999999999999986
176	Beef, blade steak, separable lean, grilled or BBQd, no added fat	650	0	31.8999999999999986	2.89999999999999991
177	Beef, blade steak, separable lean, raw	474	0	22.1999999999999993	2.60000000000000009
178	Beef, blade steak, untrimmed, baked, roasted, fried, grilled or BBQd, fat not further defined	934	0	25.1000000000000014	13.6999999999999993
179	Beef, blade steak, untrimmed, baked, roasted, fried, grilled or BBQd, no added fat	791	0	30.5	7.40000000000000036
180	Beef, blade steak, untrimmed, boiled, casseroled, microwaved, poached, steamed or stewed, with or without added fat	921	0	26	12.9000000000000004
181	Beef, blade steak, untrimmed, raw	707	0	21	9.5
182	Beef, casserole cuts, fully-trimmed, boiled, casseroled, microwaved, poached, steamed, or stewed, no added fat	654	0	25.1000000000000014	6.20000000000000018
183	Beef, casserole cuts, fully-trimmed, raw	548	0	21.6999999999999993	4.90000000000000036
184	Beef, casserole cuts, untrimmed, boiled, casseroled, microwaved, poached, steamed or stewed, with or without fat	883	0	26	11.9000000000000004
185	Beef, casserole cuts, untrimmed, raw	677	0	21	8.59999999999999964
186	Beef, chuck steak, fully-trimmed, baked, roasted, fried, stir-fried, grilled or BBQd, fat not further defined	870	0	26.6000000000000014	11.3000000000000007
187	Beef, chuck steak, fully-trimmed, baked, roasted, fried, stir-fried, grilled or BBQd, no added fat	798	0	27.1000000000000014	9.09999999999999964
188	Beef, chuck steak, fully-trimmed, boiled, casseroled, microwaved, poached, steamed, or stewed, with or without added fat	684	0	22	8.40000000000000036
189	Beef, chuck steak, fully-trimmed, raw	654	0	22.1999999999999993	7.5
190	Beef, chuck steak, separable fat, boiled, casseroled, microwaved, poached, steamed, or stewed, no added fat	2317	0	15.3000000000000007	55.6000000000000014
191	Beef, chuck steak, separable fat, raw	2478	0	12.0999999999999996	61.3999999999999986
192	Beef, chuck steak, separable lean, boiled, casseroled, microwaved, poached, steamed, or stewed, no added fat	953	0	33	10.5999999999999996
193	Beef, chuck steak, separable lean, raw	517	0	23	3.39999999999999991
194	Beef, chuck steak, untrimmed, boiled, casseroled, microwaved, poached, steamed, or stewed, with or without added fat	1114	0	30.8999999999999986	15.9000000000000004
195	Beef, chuck steak, untrimmed, raw	755	0	21.6999999999999993	10.5
196	Beef, corned, 50% trimmed, cooked	537	0.200000000000000011	17.8000000000000007	6.29999999999999982
197	Beef, corned, 75% trimmed, cooked	639	0.200000000000000011	17.1999999999999993	9.30000000000000071
198	Beef, corned, canned	957	0.299999999999999989	21.5	15.6999999999999993
199	Beef, corned, lean, cooked	425	0.200000000000000011	18.3999999999999986	3
200	Beef, corned, lean & fat, cooked	639	0.200000000000000011	17.1999999999999993	9.30000000000000071
202	Beef, diced, fully-trimmed, baked, roasted, fried or stir-fried, grilled or BBQd, fat not further defined	791	0	33.2000000000000028	6.09999999999999964
203	Beef, diced, fully-trimmed, baked, roasted, fried or stir-fried, grilled or BBQd, no added fat	653	0	32.1000000000000014	2.89999999999999991
204	Beef, diced, fully-trimmed, boiled, casseroled, microwaved, poached, steamed or stewed, fat not further defined	811	0	34	6.29999999999999982
205	Beef, diced, fully-trimmed, boiled, casseroled, microwaved, poached, steamed or stewed, no added fat	734	0	34.7000000000000028	3.89999999999999991
206	Beef, diced, fully-trimmed, raw	588	0	27.8000000000000007	3.10000000000000009
207	Beef, diced, separable lean, fried or stir-fried, no added fat	653	0	32.1000000000000014	2.89999999999999991
208	Beef, diced, separable lean, raw	574	0	27.8999999999999986	2.70000000000000018
209	Beef, diced, untrimmed, baked, roasted, fried or stir-fried, grilled or BBQd, no added fat	678	0	31.8000000000000007	3.70000000000000018
210	Beef, diced, untrimmed, raw	614	0	27.6000000000000014	3.89999999999999991
211	Beef, extract, bonox	401	0	16.6000000000000014	0.200000000000000011
212	Beef, eye fillet, separable lean, baked, roasted, fried, grilled or BBQd, no added fat	746	0	31.8999999999999986	5.5
213	Beef, eye fillet, separable lean, raw	570	0	22.1999999999999993	5.20000000000000018
214	Beef, fillet steak, fully-trimmed, baked, roasted, fried, grilled or BBQd, butter, dairy blend or margarine	753	0	26.6000000000000014	8.19999999999999929
215	Beef, fillet steak, fully-trimmed, baked, roasted, fried, grilled or BBQd, canola oil	771	0	26.5	8.69999999999999929
216	Beef, fillet steak, fully-trimmed, baked, roasted, fried, grilled or BBQd, fat not further defined	815	0	26.3000000000000007	10
217	Beef, fillet steak, fully-trimmed, baked, roasted, fried, grilled or BBQd, no added fat	746	0	31.8999999999999986	5.5
218	Beef, fillet steak, fully-trimmed, baked, roasted, fried, grilled or BBQd, olive oil	817	0	26.3000000000000007	10
219	Beef, fillet steak, fully-trimmed, baked, roasted, fried, grilled or BBQd, other oil	817	0	26.3000000000000007	10
220	Beef, fillet steak, fully-trimmed, raw	608	0	22	6.29999999999999982
221	Beef, fillet steak, separable lean, grilled or BBQd, no added fat	746	0	31.8999999999999986	5.5
222	Beef, fillet steak, separable lean, raw	570	0	22.1999999999999993	5.20000000000000018
223	Beef, fillet steak, untrimmed, baked, roasted, fried, grilled or BBQd, fat not further defined	937	0	25.6000000000000014	13.5999999999999996
224	Beef, fillet steak, untrimmed, baked, roasted, fried, grilled or BBQd, no added fat	849	0	30.8000000000000007	8.80000000000000071
225	Beef, fillet steak, untrimmed, raw	710	0	21.5	9.30000000000000071
226	Beef, for use in kebabs, cooked	1544	0.299999999999999989	24.1999999999999993	25.8999999999999986
227	Beef, heart, raw	420	0	18.1999999999999993	3
228	Beef, heart, simmered or boiled, no added fat	627	0	31.1999999999999993	2.60000000000000009
229	Beef, kebab, marinated, baked, roasted, fried, grilled or BBQd, fat not further defined	843	3.79999999999999982	23.5	10
230	Beef, kidney, raw	369	0	18.1999999999999993	1.60000000000000009
231	Beef, kidney, simmered or boiled, no added fat	566	0	27.3999999999999986	2.70000000000000018
232	Beef, liver, raw	704	0	20	8.59999999999999964
233	Beef, liver, simmered or boiled, no added fat	922	0	26.1999999999999993	11.6999999999999993
234	Beef, loin (fillet, sirloin, scotch fillet, T-bone), separable fat, grilled or BBQd, no added fat	2317	0	15.3000000000000007	55.6000000000000014
235	Beef, loin (fillet, sirloin, scotch fillet, T-bone), separable fat, raw	2478	0	12.0999999999999996	61.3999999999999986
236	Beef, mince, >10% fat, baked, roasted, fried or stir-fried, grilled or BBQd, fat not further defined	1234	0	29.6999999999999993	19.6999999999999993
237	Beef, mince, >10% fat, baked, roasted, fried or stir-fried, grilled or BBQd, no added fat	1185	0	30.3000000000000007	18.1000000000000014
238	Beef, mince, >10% fat, raw	767	0	22.5	10.4000000000000004
239	Beef, mince, ~5-10% fat, baked, roasted, fried or stir-fried, grilled or BBQd, canola oil	1160	0	28.8999999999999986	18.1000000000000014
240	Beef, mince, ~5-10% fat, baked, roasted, fried or stir-fried, grilled or BBQd, fat not further defined	1159	0	28.8999999999999986	18
241	Beef, mince, ~5-10% fat, baked, roasted, fried or stir-fried, grilled or BBQd, no added fat	1108	0	29.5	16.3999999999999986
242	Beef, mince, ~5-10% fat, baked, roasted, fried or stir-fried, grilled or BBQd, olive oil	1160	0	28.8999999999999986	18.1000000000000014
243	Beef, mince, ~5-10% fat, baked, roasted, fried or stir-fried, grilled or BBQd, other oil	1160	0	28.8999999999999986	18.1000000000000014
244	Beef, mince, ~5-10% fat, boiled, casseroled, microwaved, poached, steamed, or stewed, fat not further defined	961	0	27.3999999999999986	13.4000000000000004
245	Beef, mince, ~5-10% fat, boiled, casseroled, microwaved, poached, steamed, or stewed, no added fat	888	0	28	11.0999999999999996
246	Beef, mince, ~5-10% fat, raw	710	0	22.3999999999999986	8.90000000000000036
247	Beef, mince, <5% fat, baked, roasted, fried or stir-fried, grilled or BBQd, canola oil	906	0	31.6999999999999993	9.90000000000000036
248	Beef, mince, <5% fat, baked, roasted, fried or stir-fried, grilled or BBQd, fat not further defined	905	0	31.6999999999999993	9.90000000000000036
249	Beef, mince, <5% fat, baked, roasted, fried or stir-fried, grilled or BBQd, no added fat	849	0	32.2999999999999972	8.09999999999999964
250	Beef, mince, <5% fat, baked, roasted, fried or stir-fried, grilled or BBQd, olive oil	906	0	31.6999999999999993	9.90000000000000036
251	Beef, mince, <5% fat, baked, roasted, fried or stir-fried, grilled or BBQd, other oil	906	0	31.6999999999999993	9.90000000000000036
252	Beef, mince, <5% fat, boiled, casseroled, microwaved, poached, steamed or stewed, fat not further defined	754	0	28.1000000000000014	7.5
253	Beef, mince, <5% fat, boiled, casseroled, microwaved, poached, steamed, or stewed, no added fat	676	0	28.6000000000000014	5.09999999999999964
254	Beef, mince, <5% fat, raw	541	0	22.8999999999999986	4.09999999999999964
255	Beef, mince, baked, roasted, fried or stir-fried, grilled or BBQd, fat not further defined	911	0	30	10.8000000000000007
256	Beef, mince, baked, roasted, fried or stir-fried, grilled or BBQd, no added fat	829	0	30.6999999999999993	8.30000000000000071
257	Beef, mince, boiled, casseroled, microwaved, steamed or stewed, with or without added fat	805	0	28.1000000000000014	8.80000000000000071
258	Beef, mince, raw, not further defined	614	0	22.6999999999999993	6.20000000000000018
259	Beef, rib, baked, roasted, fried, grilled or BBQd, with or without added fat	1214	0.800000000000000044	33.3999999999999986	16.8999999999999986
260	Beef, rib cutlet or roast, fully-trimmed, baked, roasted, fried, grilled or BBQd, fat not further defined	690	0	25.8999999999999986	6.79999999999999982
261	Beef, rib cutlet or roast, fully-trimmed, baked, roasted, fried, grilled or BBQd, no added fat	740	0	28.3000000000000007	7
262	Beef, rib cutlet or roast, semi-trimmed, boiled, casseroled, microwaved, poached, steamed, or stewed, with or without added fat	975	0	27.6999999999999993	13.5999999999999996
263	Beef, roasting cuts, fully-trimmed, baked or roasted, no added fat	664	0	31.8999999999999986	3.29999999999999982
264	Beef, roasting cuts, fully-trimmed, raw	503	0	21.6000000000000014	3.70000000000000018
265	Beef, roasting cuts, semi-trimmed, baked or roasted, no added fat	705	0	31.5	4.59999999999999964
266	Beef, roasting cuts, semi-trimmed, raw	560	0	21.3999999999999986	5.29999999999999982
267	Beef, roasting cuts, untrimmed, baked or roasted, no added fat	745	0	25.6999999999999993	8.30000000000000071
268	Beef, roasting cuts, untrimmed, raw	611	0	21.1000000000000014	6.79999999999999982
269	Beef, round medallion, separable lean, grilled or BBQd, no added fat	615	0	31.8000000000000007	2
270	Beef, round medallion, separable lean, raw	420	0	21	1.69999999999999996
271	Beef, round steak, fully-trimmed, baked, roasted, fried, grilled or BBQd, canola oil	636	0	24.8999999999999986	5.79999999999999982
272	Beef, round steak, fully-trimmed, baked, roasted, fried, grilled or BBQd, fat not further defined	635	0	24.8999999999999986	5.70000000000000018
273	Beef, round steak, fully-trimmed, baked, roasted, fried, grilled or BBQd, no added fat	632	0	31.6000000000000014	2.5
274	Beef, round steak, fully-trimmed, baked, roasted, fried, grilled or BBQd, olive oil	636	0	24.8999999999999986	5.79999999999999982
275	Beef, round steak, fully-trimmed, baked, roasted, fried, grilled or BBQd, other oil	636	0	24.8999999999999986	5.79999999999999982
276	Beef, round steak, fully-trimmed, boiled, casseroled, microwaved, poached, steamed or stewed, with or without added fat	611	0	25.8000000000000007	4.70000000000000018
277	Beef, round steak, fully-trimmed, raw	457	0	20.8000000000000007	2.79999999999999982
278	Beef, round steak, semi-trimmed, baked, roasted, fried, grilled or BBQd, no added fat	656	0	31.3999999999999986	3.29999999999999982
279	Beef, round steak, semi-trimmed, raw	525	0	20.5	4.70000000000000018
280	Beef, round steak, separable fat, grilled or BBQd, no added fat	2317	0	15.3000000000000007	55.6000000000000014
281	Beef, round steak, separable fat, raw	2478	0	12.0999999999999996	61.3999999999999986
282	Beef, round steak, separable lean, grilled or BBQd, no added fat	615	0	31.8000000000000007	2
283	Beef, round steak, separable lean, raw	420	0	21	1.69999999999999996
284	Beef, round steak, untrimmed, baked, roasted, fried, grilled or BBQd, fat not further defined	768	0	24.3000000000000007	9.59999999999999964
285	Beef, round steak, untrimmed, baked, roasted, fried, grilled or BBQd, no added fat	697	0	31	4.59999999999999964
286	Beef, round steak, untrimmed, raw	568	0	20.3999999999999986	6
287	Beef, rump medallion, separable lean, grilled or BBQd, no added fat	710	0	32	4.5
288	Beef, rump medallion, separable lean, raw	450	0	20.3999999999999986	2.79999999999999982
289	Beef, rump steak, fully-trimmed, baked, roasted, fried, grilled or BBQd, butter, dairy blend or margarine	683	0	24.1000000000000014	7.40000000000000036
290	Beef, rump steak, fully-trimmed, baked, roasted, fried, grilled or BBQd, canola oil	701	0	24.1000000000000014	7.90000000000000036
291	Beef, rump steak, fully-trimmed, baked, roasted, fried, grilled or BBQd, no added fat	742	0	31.6999999999999993	5.5
292	Beef, rump steak, fully-trimmed, baked, roasted, fried, grilled or BBQd, olive oil	701	0	24.1000000000000014	7.90000000000000036
293	Beef, rump steak, fully-trimmed, baked, roasted, fried, stir-fried, grilled or BBQd, fat not further defined	700	0	24.1000000000000014	7.79999999999999982
294	Beef, rump steak, fully-trimmed, baked, roasted, fried, stir-fried, grilled or BBQd, other oil	701	0	24.1000000000000014	7.90000000000000036
295	Beef, rump steak, fully-trimmed, boiled, casseroled, microwaved, poached, steamed or stewed, with or without added fat	678	0	24.8999999999999986	6.90000000000000036
296	Beef, rump steak, fully-trimmed, raw	511	0	20.1999999999999993	4.59999999999999964
297	Beef, rump steak, semi-trimmed, baked, roasted, fried, grilled or BBQd, butter, dairy blend or margarine	724	0	23.8999999999999986	8.59999999999999964
298	Beef, rump steak, semi-trimmed, baked, roasted, fried, grilled or BBQd, canola oil	742	0	23.8999999999999986	9.09999999999999964
299	Beef, rump steak, semi-trimmed, baked, roasted, fried, grilled or BBQd, fat not further defined	741	0	23.8999999999999986	9
300	Beef, rump steak, semi-trimmed, baked, roasted, fried, grilled or BBQd, no added fat	804	0	31	7.5
301	Beef, rump steak, semi-trimmed, baked, roasted, fried, grilled or BBQd, olive oil	742	0	23.8999999999999986	9.09999999999999964
302	Beef, rump steak, semi-trimmed, baked, roasted, fried, grilled or BBQd, other oil	742	0	23.8999999999999986	9.09999999999999964
303	Beef, rump steak, semi-trimmed, boiled, casseroled, microwaved, poached, steamed, or stewed, with or without added fat	721	0	24.8000000000000007	8.09999999999999964
304	Beef, rump steak, semi-trimmed, raw	546	0	20	5.59999999999999964
305	Beef, rump steak, separable fat, grilled or BBQd, no added fat	2317	0	15.3000000000000007	55.6000000000000014
306	Beef, rump steak, separable fat, raw	2478	0	12.0999999999999996	61.3999999999999986
307	Beef, rump steak, separable lean, grilled or BBQd, no added fat	710	0	32	4.5
308	Beef, rump steak, separable lean, raw	450	0	20.3999999999999986	2.79999999999999982
309	Beef, rump steak, untrimmed, baked, roasted, fried, grilled or BBQd, butter, dairy blend or margarine	1047	0	22.6000000000000014	17.8999999999999986
310	Beef, rump steak, untrimmed, baked, roasted, fried, grilled or BBQd, canola oil	1065	0	22.6000000000000014	18.3999999999999986
311	Beef, rump steak, untrimmed, baked, roasted, fried, grilled or BBQd, fat not further defined	1063	0	22.6000000000000014	18.3000000000000007
312	Beef, rump steak, untrimmed, baked, roasted, fried, grilled or BBQd, no added fat	910	0	29.8999999999999986	10.9000000000000004
313	Beef, rump steak, untrimmed, baked, roasted, fried, grilled or BBQd, olive oil	1065	0	22.6000000000000014	18.3999999999999986
314	Beef, rump steak, untrimmed, baked, roasted, fried, grilled or BBQd, other oil	1065	0	22.6000000000000014	18.3999999999999986
315	Beef, rump steak, untrimmed, boiled, casseroled, microwaved, poached, steamed or stewed, with or without added fat	1054	0	23.3999999999999986	17.6999999999999993
316	Beef, rump steak, untrimmed, raw	815	0	18.8999999999999986	13.3000000000000007
317	Beef, schnitzel, breadcrumb coating, baked, roasted, fried, grilled or BBQd, canola oil	1053	0.5	21.1000000000000014	12.3000000000000007
318	Beef, schnitzel, breadcrumb coating, baked, roasted, fried, grilled or BBQd, fat not further defined	1049	0.5	21.1000000000000014	12.1999999999999993
319	Beef, schnitzel, breadcrumb coating, baked, roasted, fried, grilled or BBQd, no added fat	859	0.599999999999999978	22.3000000000000007	6.09999999999999964
320	Beef, schnitzel, breadcrumb coating, baked, roasted, fried, grilled or BBQd, olive oil	1053	0.5	21.1000000000000014	12.3000000000000007
321	Beef, schnitzel, breadcrumb coating, baked, roasted, fried, grilled or BBQd, other oil	1053	0.5	21.1000000000000014	12.3000000000000007
322	Beef, scotch fillet, fully-trimmed, baked, roasted, fried, grilled or BBQd, butter, dairy blend or margarine	797	0	27.8000000000000007	8.80000000000000071
323	Beef, scotch fillet, fully-trimmed, baked, roasted, fried, grilled or BBQd, canola oil	815	0	27.6999999999999993	9.30000000000000071
324	Beef, scotch fillet, fully-trimmed, baked, roasted, fried, grilled or BBQd, fat not further defined	814	0	27.6999999999999993	9.19999999999999929
325	Beef, scotch fillet, fully-trimmed, baked, roasted, fried, grilled or BBQd, no added fat	756	0	31.3999999999999986	6
326	Beef, scotch fillet, fully-trimmed, baked, roasted, fried, grilled or BBQd, olive oil	815	0	27.6999999999999993	9.30000000000000071
327	Beef, scotch fillet, fully-trimmed, baked, roasted, fried, grilled or BBQd, other oil	815	0	27.6999999999999993	9.30000000000000071
328	Beef, scotch fillet, fully-trimmed, boiled, casseroled, microwaved, poached, steamed or stewed, with or without added fat	796	0	28.6999999999999993	8.30000000000000071
329	Beef, scotch fillet, fully-trimmed, raw	607	0	23.1999999999999993	5.70000000000000018
330	Beef, scotch fillet, semi-trimmed, baked, roasted, fried, grilled or BBQd, butter, dairy blend or margarine	970	0	26.6999999999999993	13.9000000000000004
331	Beef, scotch fillet, semi-trimmed, baked, roasted, fried, grilled or BBQd, canola oil	988	0	26.6999999999999993	14.4000000000000004
332	Beef, scotch fillet, semi-trimmed, baked, roasted, fried, grilled or BBQd, fat not further defined	987	0	26.6999999999999993	14.4000000000000004
333	Beef, scotch fillet, semi-trimmed, baked, roasted, fried, grilled or BBQd, no added fat	863	0	30.3000000000000007	9.40000000000000036
334	Beef, scotch fillet, semi-trimmed, baked, roasted, fried, grilled or BBQd, olive oil	988	0	26.6999999999999993	14.4000000000000004
335	Beef, scotch fillet, semi-trimmed, baked, roasted, fried, grilled or BBQd, other oil	988	0	26.6999999999999993	14.4000000000000004
336	Beef, scotch fillet, semi-trimmed, raw	751	0	22.3999999999999986	10
337	Beef, scotch fillet, separable lean, grilled or BBQd, no added fat	707	0	31.8999999999999986	4.5
338	Beef, scotch fillet, separable lean, raw	508	0	23.8000000000000007	2.79999999999999982
339	Beef, scotch fillet, untrimmed, baked, roasted, fried, grilled or BBQd, fat not further defined	1144	0	25.8000000000000007	19.1000000000000014
340	Beef, scotch fillet, untrimmed, baked, roasted, fried, grilled or BBQd, no added fat	953	0	29.3999999999999986	12.3000000000000007
341	Beef, scotch fillet, untrimmed, raw	883	0	21.6000000000000014	13.9000000000000004
342	Beef, silverside minute steak, separable lean, baked or roasted, no added fat	664	0	26.8999999999999986	5.59999999999999964
343	Beef, silverside minute steak, separable lean, raw	495	0	24.1000000000000014	2.29999999999999982
344	Beef, silverside roast, fully-trimmed, baked or roasted, no added fat	681	0	26.8000000000000007	6.09999999999999964
345	Beef, silverside roast, fully-trimmed, boiled, casseroled, microwaved, poached, steamed, or stewed, no added fat	656	0	29.8999999999999986	4
346	Beef, silverside roast, fully-trimmed, raw	525	0	23.8999999999999986	3.20000000000000018
347	Beef, silverside roast, semi-trimmed, baked or roasted, no added fat	704	0	26.6000000000000014	6.79999999999999982
348	Beef, silverside roast, semi-trimmed, boiled, casseroled, microwaved, poached, steamed, or stewed, no added fat	709	0	29.6000000000000014	5.59999999999999964
349	Beef, silverside roast, semi-trimmed, raw	568	0	23.6999999999999993	4.5
350	Beef, silverside roast, separable lean, baked or roasted, no added fat	664	0	26.8999999999999986	5.59999999999999964
351	Beef, silverside roast, separable lean, raw	495	0	24.1000000000000014	2.29999999999999982
352	Beef, silverside roast, untrimmed, baked or roasted, no added fat	797	0	26	9.59999999999999964
353	Beef, silverside roast, untrimmed, boiled, casseroled, microwaved, poached, steamed or stewed, no added fat	888	0	28.5	10.9000000000000004
354	Beef, silverside roast, untrimmed, raw	711	0	22.8000000000000007	8.69999999999999929
355	Beef, sirloin steak, fully-trimmed, baked, roasted, fried, grilled or BBQd, canola oil	712	0	28.5	6.09999999999999964
356	Beef, sirloin steak, fully-trimmed, baked, roasted, fried, grilled or BBQd, fat not further defined	710	0	28.5	6.09999999999999964
357	Beef, sirloin steak, fully-trimmed, baked, roasted, fried, grilled or BBQd, no added fat	676	0	30.3000000000000007	4.29999999999999982
358	Beef, sirloin steak, fully-trimmed, baked, roasted, fried, grilled or BBQd, olive oil	712	0	28.5	6.09999999999999964
359	Beef, sirloin steak, fully-trimmed, baked, roasted, fried, grilled or BBQd, other oil	712	0	28.5	6.09999999999999964
360	Beef, sirloin steak, fully-trimmed, boiled, casseroled, microwaved, poached, steamed or stewed, with or without added fat	689	0	29.5	5.09999999999999964
361	Beef, sirloin steak, fully-trimmed, raw	520	0	23.8999999999999986	3.10000000000000009
362	Beef, sirloin steak, semi-trimmed, baked, roasted, fried, grilled or BBQd, canola oil	807	0	27.8999999999999986	9
363	Beef, sirloin steak, semi-trimmed, baked, roasted, fried, grilled or BBQd, fat not further defined	805	0	27.8999999999999986	8.90000000000000036
364	Beef, sirloin steak, semi-trimmed, baked, roasted, fried, grilled or BBQd, no added fat	746	0	29.6999999999999993	6.5
365	Beef, sirloin steak, semi-trimmed, baked, roasted, fried, grilled or BBQd, olive oil	807	0	27.8999999999999986	9
366	Beef, sirloin steak, semi-trimmed, baked, roasted, fried, grilled or BBQd, other oil	807	0	27.8999999999999986	9
367	Beef, sirloin steak, semi-trimmed, raw	599	0	23.3999999999999986	5.5
368	Beef, sirloin steak, separable lean, grilled or BBQd, no added fat	659	0	30.5	3.79999999999999982
369	Beef, sirloin steak, separable lean, raw	480	0	24.1000000000000014	1.89999999999999991
370	Beef, sirloin steak, untrimmed, baked, roasted, fried, grilled or BBQd, fat not further defined	1200	0	25.6000000000000014	20.6999999999999993
371	Beef, sirloin steak, untrimmed, baked, roasted, fried, grilled or BBQd, no added fat	1007	0	27.3000000000000007	14.6999999999999993
372	Beef, sirloin steak, untrimmed, baked, roasted, fried, grilled or BBQd, olive oil	1201	0	25.6000000000000014	20.6999999999999993
373	Beef, sirloin steak, untrimmed, raw	930	0	21.3999999999999986	15.3000000000000007
374	Beef, steak, fully-trimmed, baked, roasted, fried, grilled or BBQd, canola oil	750	0	26.3999999999999986	8.09999999999999964
375	Beef, steak, fully-trimmed, baked, roasted, fried, grilled or BBQd, fat not further defined	749	0	26.3999999999999986	8.09999999999999964
376	Beef, steak, fully-trimmed, baked, roasted, fried, grilled or BBQd, no added fat	673	0	27	5.79999999999999982
377	Beef, steak, fully-trimmed, baked, roasted, fried, grilled or BBQd, olive oil	750	0	26.3999999999999986	8.09999999999999964
378	Beef, steak, fully-trimmed, baked, roasted, fried, grilled or BBQd, other oil	750	0	26.3999999999999986	8.09999999999999964
379	Beef, steak, fully-trimmed, boiled, casseroled, microwaved, poached, steamed or stewed, fat not further defined	767	0	27.1000000000000014	8.30000000000000071
380	Beef, steak, fully-trimmed, boiled, casseroled, microwaved, poached, steamed or stewed, no added fat	690	0	27.6999999999999993	5.90000000000000036
381	Beef, steak, fully-trimmed, coated, baked, roasted, fried, grilled or BBQd, fat not further defined	1064	0.699999999999999956	22.5	12.5
382	Beef, steak, fully-trimmed, coated, baked, roasted, fried, grilled or BBQd, no added fat	874	0.800000000000000044	23.8000000000000007	6.5
383	Beef, steak, fully-trimmed, raw	552	0	22.1000000000000014	4.79999999999999982
384	Beef, steak, semi-trimmed, baked, roasted, fried, grilled or BBQd, canola oil	839	0	25.8999999999999986	10.8000000000000007
385	Beef, steak, semi-trimmed, baked, roasted, fried, grilled or BBQd, fat not further defined	837	0	25.8999999999999986	10.6999999999999993
386	Beef, steak, semi-trimmed, baked, roasted, fried, grilled or BBQd, no added fat	764	0	26.5	8.5
387	Beef, steak, semi-trimmed, baked, roasted, fried, grilled or BBQd, olive oil	839	0	25.8999999999999986	10.8000000000000007
388	Beef, steak, semi-trimmed, baked, roasted, fried, grilled or BBQd, other oil	839	0	25.8999999999999986	10.8000000000000007
389	Beef, steak, semi-trimmed, boiled, casseroled, microwaved, poached, steamed or stewed, with or without added fat	820	0	26.8999999999999986	9.80000000000000071
390	Beef, steak, semi-trimmed, coated, baked, roasted, fried, grilled or BBQd, with or without added fat	1038	0.699999999999999956	22.6999999999999993	11.5
391	Beef, steak, semi-trimmed, raw	626	0	21.6999999999999993	7
392	Beef, steak, untrimmed	847	0	20.6000000000000014	13.5
393	Beef, steak, untrimmed, baked, roasted, fried, grilled or BBQd, fat not further defined	1101	0	24.6000000000000014	18.5
394	Beef, steak, untrimmed, baked, roasted, fried, grilled or BBQd, no added fat	1033	0	25.1000000000000014	16.3999999999999986
395	Beef, steak, untrimmed, baked, roasted, fried, grilled or BBQd, olive oil	1103	0	24.6000000000000014	18.5
396	Beef, steak, untrimmed, baked, roasted, fried, grilled or BBQd, other oil	1103	0	24.6000000000000014	18.5
397	Beef, steak, untrimmed, coated, baked, roasted, fried, grilled or BBQd, fat not further defined	1321	0.699999999999999956	21.1000000000000014	20.1000000000000014
398	Beef, stir-fry cuts, fully-trimmed, fried or stir-fried, no added fat	683	0	31.8999999999999986	3.79999999999999982
399	Beef, stir-fry cuts, fully-trimmed, raw	492	0	21.1000000000000014	3.60000000000000009
400	Beef, stir-fry cuts, semi-trimmed, fried or stir-fried, no added fat	726	0	31.5	5.20000000000000018
401	Beef, stir-fry cuts, semi-trimmed, raw	543	0	20.8000000000000007	5.09999999999999964
402	Beef, stir-fry strips, fully-trimmed, baked, roasted, fried, stir-fried, grilled or BBQd, canola oil	741	0	32.3999999999999986	5.09999999999999964
403	Beef, stir-fry strips, fully-trimmed, baked, roasted, fried, stir-fried, grilled or BBQd, fat not further defined	739	0	32.3999999999999986	5.09999999999999964
404	Beef, stir-fry strips, fully-trimmed, baked, roasted, fried, stir-fried, grilled or BBQd, no added fat	644	0	30.8999999999999986	3.20000000000000018
405	Beef, stir-fry strips, fully-trimmed, baked, roasted, fried, stir-fried, grilled or BBQd, olive oil	741	0	32.3999999999999986	5.09999999999999964
406	Beef, stir-fry strips, fully-trimmed, baked, roasted, fried, stir-fried, grilled or BBQd, other oil	741	0	32.3999999999999986	5.09999999999999964
407	Beef, stir-fry strips, fully-trimmed, boiled, casseroled, microwaved, poached, steamed or stewed, fat not further defined	758	0	33.2000000000000028	5.20000000000000018
408	Beef, stir-fry strips, fully-trimmed, boiled, casseroled, microwaved, poached, steamed or stewed, no added fat	680	0	33.8999999999999986	2.79999999999999982
409	Beef, stir-fry strips, fully-trimmed, raw	544	0	27.1000000000000014	2.20000000000000018
410	Beef, stir-fry strips or diced, separable fat, fried or stir-fried, no added fat	2317	0	15.3000000000000007	55.6000000000000014
411	Beef, stir-fry strips or diced, separable fat, raw	2478	0	12.0999999999999996	61.3999999999999986
412	Beef, stir-fry strips, separable lean, fried or stir-fried, no added fat	644	0	30.8999999999999986	3.20000000000000018
413	Beef, stir-fry strips, separable lean, raw	536	0	27.1999999999999993	2
414	Beef, stir-fry strips, untrimmed, baked, roasted, fried, stir-fried, grilled or BBQd, no added fat	657	0	30.8000000000000007	3.60000000000000009
415	Beef, stir-fry strips, untrimmed, raw	559	0	27	2.70000000000000018
416	Beef, tail, raw	1287	0	17.3999999999999986	26.8000000000000007
417	Beef, tail, simmered or boiled, no added fat	1453	0	21.6999999999999993	29.3000000000000007
418	Beef, T-bone steak, fully-trimmed, baked, roasted, fried, grilled or BBQd, fat not further defined	814	0	28.3000000000000007	9
419	Beef, T-bone steak, fully-trimmed, baked, roasted, fried, grilled or BBQd, no added fat	755	0	28.1999999999999993	7.40000000000000036
420	Beef, T-bone steak, fully-trimmed, raw	607	0	23.6999999999999993	5.5
421	Beef, T-bone steak, semi-trimmed, baked, roasted, fried, grilled or BBQd, butter, dairy blend or margarine	954	0	27.3000000000000007	13.1999999999999993
422	Beef, T-bone steak, semi-trimmed, baked, roasted, fried, grilled or BBQd, canola oil	973	0	27.3000000000000007	13.6999999999999993
423	Beef, T-bone steak, semi-trimmed, baked, roasted, fried, grilled or BBQd, fat not further defined	971	0	27.3000000000000007	13.6999999999999993
424	Beef, T-bone steak, semi-trimmed, baked, roasted, fried, grilled or BBQd, no added fat	837	0	27.5	10
425	Beef, T-bone steak, semi-trimmed, baked, roasted, fried, grilled or BBQd, olive oil	973	0	27.3000000000000007	13.6999999999999993
426	Beef, T-bone steak, semi-trimmed, baked, roasted, fried, grilled or BBQd, other oil	973	0	27.3000000000000007	13.6999999999999993
427	Beef, T-bone steak, semi-trimmed, raw	738	0	22.8000000000000007	9.5
428	Beef, T-bone steak, separable lean, grilled or BBQd, no added fat	637	0	29.1999999999999993	3.79999999999999982
429	Beef, T-bone steak, separable lean, raw	487	0	24.3999999999999986	2
430	Beef, T-bone steak, untrimmed, baked, roasted, fried, grilled or BBQd, fat not further defined	1270	0	25.5	22.6000000000000014
431	Beef, T-bone steak, untrimmed, baked, roasted, fried, grilled or BBQd, no added fat	984	0	26.3000000000000007	14.5
432	Beef, T-bone steak, untrimmed, raw	988	0	21.3000000000000007	16.8999999999999986
433	Beef, tongue, raw	833	0	17.1999999999999993	14.5999999999999996
434	Beef, tongue, simmered or boiled, no added fat	1289	0	21.1999999999999993	25.1000000000000014
435	Beef, topside or silverside, separable fat, raw	2478	0	12.0999999999999996	61.3999999999999986
436	Beef, topside roast, fully-trimmed, baked or roasted, no added fat	676	0	32.5	3.29999999999999982
437	Beef, topside roast, fully-trimmed, boiled, casseroled, microwaved, poached, steamed or stewed, no added fat	635	0	27.8000000000000007	4.40000000000000036
438	Beef, topside roast, fully-trimmed, raw	518	0	22.1999999999999993	3.79999999999999982
439	Beef, topside roast, semi-trimmed, baked or roasted, no added fat	719	0	32.1000000000000014	4.70000000000000018
440	Beef, topside roast, semi-trimmed, raw	558	0	22	5
441	Beef, topside roast, separable lean, baked or roasted, no added fat	660	0	32.7000000000000028	2.79999999999999982
442	Beef, topside roast, separable lean, raw	490	0	22.3000000000000007	3
443	Beef, topside roast, untrimmed, baked or roasted, no added fat	793	0	31.3000000000000007	7.09999999999999964
444	Beef, topside roast, untrimmed, breadcrumb coating, baked or roasted, no added fat	1082	0.5	22.3999999999999986	12.5
445	Beef, topside roast, untrimmed, raw	558	0	22	5
446	Beef, topside/silverside, separable fat, baked or roasted, no added fat	2317	0	15.3000000000000007	55.6000000000000014
447	Beef, topside steak, fully-trimmed, baked, roasted, fried, grilled or BBQd, fat not further defined	696	0	26.5	6.59999999999999964
448	Beef, topside steak, fully-trimmed, baked, roasted, fried, grilled or BBQd, no added fat	676	0	32.5	3.29999999999999982
449	Beef, topside steak, fully-trimmed, boiled, casseroled, microwaved, poached, steamed or stewed, with or without added fat	674	0	27.5	5.59999999999999964
450	Beef, topside steak, fully-trimmed, raw	508	0	22.1999999999999993	3.5
451	Beef, topside steak, semi-trimmed, baked, roasted, fried, grilled or BBQd, no added fat	719	0	32.1000000000000014	4.70000000000000018
452	Beef, topside steak, semi-trimmed, raw	558	0	22	5
453	Beef, topside steak, separable lean, baked or roasted, no added fat	660	0	32.7000000000000028	2.79999999999999982
454	Beef, topside steak, separable lean, raw	490	0	22.3000000000000007	3
455	Beef, topside steak, untrimmed, baked, roasted, fried, grilled or BBQd, no added fat	793	0	31.3000000000000007	7.09999999999999964
456	Beef, topside steak, untrimmed, raw	564	0	21.8999999999999986	5.20000000000000018
457	Beef, tripe, raw	302	0	13.1999999999999993	2.10000000000000009
458	Beef, tripe, simmered or boiled, no added fat	348	0	14.4000000000000004	2.79999999999999982
459	Beer, flavoured (alcohol 4% v/v)	142	0.200000000000000011	0.299999999999999989	0
460	Beer, home-brewed, full strength	153	0.200000000000000011	0.5	0
461	Beer, home-brewed, reduced alcohol, mid-strength, or light beer	109	0.100000000000000006	0.5	0
462	Beer, lager or ale style (alcohol 4.6% v/v)	143	0.100000000000000006	0.299999999999999989	0
463	Beer, lager or ale style (alcohol 5% v/v & above)	151	0	0.400000000000000022	0
464	Beer, lager or ale style, mid strength (alcohol 3.5% v/v)	120	0.100000000000000006	0.299999999999999989	0
465	Beer, lager or ale style, reduced alcohol or light beer (alcohol 2.5% v/v)	103	0.100000000000000006	0.299999999999999989	0
466	Beer, not further defined	136	0.100000000000000006	0.299999999999999989	0
467	Beer, stout (alcohol 6% v/v)	223	0.100000000000000006	0.599999999999999978	0
468	Beetroot, canned, drained	199	8.90000000000000036	1.19999999999999996	0.100000000000000006
469	Beetroot, purple, peeled, fresh or frozen, boiled, microwaved or steamed, drained	217	9	2	0.100000000000000006
470	Beetroot, purple, peeled, fresh or frozen, raw	201	8.40000000000000036	1.89999999999999991	0.100000000000000006
471	Beetroot, purple, peeled or unpeeled, fresh or frozen, baked, roasted, fried, stir-fried, grilled or BBQd, no added fat	246	10.1999999999999993	2.29999999999999982	0.100000000000000006
472	Beetroot, purple, peeled or unpeeled, fresh or frozen, baked, roasted, stir-fried, grilled or BBQd, fat not further defined	455	9.69999999999999929	2.20000000000000018	6.09999999999999964
473	Beetroot, purple, peeled or unpeeled, fresh or frozen, steamed, added fat not further defined	386	8.59999999999999964	2	5
474	Beta-carotene	0	0	0	0
475	Beverage base, banana flavour (Nesquik brand)	1596	95	0	0
476	Beverage base, chocolate flavour, added vitamins A, B1, B2, B3, C, D & folate & Ca (Aktavite)	1503	62.8999999999999986	4.40000000000000036	1.89999999999999991
477	Beverage base, chocolate flavour, added vitamins A, B1, B2, C, D & folate, Ca & Fe (Milo)	1666	47.2999999999999972	12.6999999999999993	10.4000000000000004
478	Beverage base, chocolate flavour, added vitamins A & B3 & Fe	1600	46.1000000000000014	9.30000000000000071	2.89999999999999991
479	Beverage base, chocolate flavour, unfortified (Nesquik brand)	1632	82.2999999999999972	4.70000000000000018	3.39999999999999991
480	Beverage base, drinking chocolate, unfortified	1508	74.2999999999999972	5.59999999999999964	4.79999999999999982
481	Beverage base, malt chocolate flavour, added vitamins A, B1, B2, C, D & folate, Ca & Fe (Milo malt)	1681	47.2999999999999972	12.6999999999999993	9.59999999999999964
482	Beverage base, malted milk powder, added vitamins A, B1, B2, B3, B6, B12, biotin, C, D E & folate, Ca & Zn	1582	37	9.40000000000000036	3
483	Beverage base, malted milk powder, unfortified	1686	45.7000000000000028	11.6999999999999993	7.20000000000000018
484	Beverage base, soy, dry powder (not infant food)	1992	11.3000000000000007	21.8999999999999986	26.3000000000000007
485	Beverage base, strawberry flavour, from drinking straw, containing added sugar & intense sweetener, unfortified	1566	50.3999999999999986	0.200000000000000011	0
486	Beverage base, strawberry flavour, unfortified (Nesquik brand)	1594	99.2000000000000028	0	0
487	Biscuit filling, cream style, chocolate flavoured, commercial	2667	40.8999999999999986	2.20000000000000018	53.2999999999999972
488	Biscuit filling, cream style, vanilla flavoured, commercial	2640	43.1000000000000014	2	51.7999999999999972
489	Biscuit filling, icing style, vanilla flavoured, commercial	2288	61.1000000000000014	0.200000000000000011	35.2999999999999972
490	Bitters	1344	0.800000000000000044	0.100000000000000006	0.5
491	Blackberry, purchased frozen	211	7.5	1.39999999999999991	0.299999999999999989
492	Blackberry, raw	211	7.5	1.39999999999999991	0.299999999999999989
493	Blueberry, canned in syrup	302	17	0.400000000000000022	0
494	Blueberry, canned in syrup, drained	323	16.6000000000000014	0.800000000000000044	0.100000000000000006
495	Blueberry, canned in syrup, syrup only	285	17.3999999999999986	0.100000000000000006	0
496	Blueberry, purchased frozen	224	11.0999999999999996	0.599999999999999978	0.100000000000000006
497	Blueberry, raw	218	10.8000000000000007	0.599999999999999978	0.100000000000000006
498	Blue-eye trevalla, baked, roasted, grilled, BBQd, fried or deep fried, fat not further defined	732	0	24.6999999999999993	8.40000000000000036
499	Blue-eye trevalla, coated, takeaway outlet, deep fried	1049	0.200000000000000011	15.5	16.8000000000000007
500	Blue-eye trevalla, flesh, raw	371	0	19	1.30000000000000004
501	Blue grenadier (hoki), baked, roasted, fried, grilled or BBQd, no added fat	427	0.299999999999999989	22	1.30000000000000004
502	Blue grenadier (hoki), baked, roasted, grilled, BBQd, fried or deep fried, fat not further defined	656	0.400000000000000022	20.1999999999999993	8.30000000000000071
503	Blue grenadier (hoki), boiled, microwaved, steamed or poached, with or without added fat	392	0.299999999999999989	18.3999999999999986	2
504	Blue grenadier (hoki), coated, baked, roasted, grilled, BBQd, fried or deep fried, fat not further defined	747	0.699999999999999956	16.8999999999999986	9.19999999999999929
505	Blue grenadier (hoki), coated, packaged frozen, baked, roasted, fried, grilled or BBQd, with or without added fat	1025	1.39999999999999991	15.9000000000000004	11.8000000000000007
506	Blue grenadier (hoki), coated, takeaway outlet, deep fried	1006	0.400000000000000022	12.9000000000000004	16.6999999999999993
507	Blue grenadier (hoki), raw	313	0.299999999999999989	15.5	1.19999999999999996
508	Bok choy or choy sum, baked, roasted, fried, stir-fried, grilled or BBQd, fat not further defined	367	0.800000000000000044	3.39999999999999991	7.29999999999999982
509	Bok choy or choy sum, baked, roasted, fried, stir-fried, grilled or BBQd, no added fat	113	0.900000000000000022	3.60000000000000009	0.299999999999999989
510	Bok choy or choy sum, baked, roasted, fried, stir-fried, grilled or BBQd, olive oil	372	0.800000000000000044	3.39999999999999991	7.40000000000000036
511	Bok choy or choy sum, baked, roasted, fried, stir-fried, grilled or BBQd, other oil	372	0.800000000000000044	3.39999999999999991	7.40000000000000036
512	Bok choy or choy sum, boiled, casseroled microwaved, poached, steamed or stewed, added fat not further defined	252	0.599999999999999978	2.5	4.90000000000000036
513	Bok choy or choy sum, boiled, microwaved or steamed, drained	82	0.599999999999999978	2.60000000000000009	0.200000000000000011
514	Bok choy or choy sum, raw	79	0.599999999999999978	2.5	0.200000000000000011
515	Brandy	897	0.299999999999999989	0	0
516	Brandy, cooked	302	0.299999999999999989	0	0
517	Bread, banana, commercial	1391	25.1000000000000014	5.29999999999999982	14.1999999999999993
518	Bread, banana, commercial, toasted	1617	29.1999999999999993	6.09999999999999964	16.5
519	Bread, banana, homemade	1470	29.5	5.70000000000000018	11.9000000000000004
520	Bread, banana, homemade, toasted	1709	34.2000000000000028	6.70000000000000018	13.8000000000000007
521	Bread, chapatti, commercial	993	0.299999999999999989	7.09999999999999964	2.20000000000000018
522	Bread, commercial, fresh, not further defined	1015	2.5	10.1999999999999993	2.89999999999999991
523	Bread, commercial, toasted, not further defined	1194	2.89999999999999991	12	3.39999999999999991
524	Bread, corn	1069	3.89999999999999991	7.79999999999999982	4.90000000000000036
525	Bread, croutons, commercial or homemade	1600	3.60000000000000009	12.9000000000000004	9.5
526	Breadcrumbs for coating food, commercial, uncooked	1610	2.89999999999999991	8.90000000000000036	18.3999999999999986
527	Breadcrumbs for coating food, homemade, uncooked	1447	3.20000000000000018	11.3000000000000007	6.5
528	Breadcrumbs, white	1489	4.40000000000000036	12.4000000000000004	3.60000000000000009
529	Bread, damper, from white flour, commercial	1029	1.69999999999999996	6.40000000000000036	5.40000000000000036
530	Bread, damper, from white flour, commercial, toasted	1210	1.89999999999999991	7.59999999999999964	6.29999999999999982
531	Bread, damper, from white flour, homemade from basic ingredients	1084	2.89999999999999991	7.5	5.5
532	Bread, damper, from white flour, homemade from basic ingredients	999	1.60000000000000009	6.70000000000000018	4
533	Bread, damper, from white Jackaroo flour, added vitamins & minerals, homemade from basic ingredients	1124	2.60000000000000009	8	4.79999999999999982
534	Bread, damper, from wholemeal flour, commercial	1018	2.20000000000000018	6.40000000000000036	5.90000000000000036
535	Bread, damper, from wholemeal flour, commercial, toasted	1197	2.5	7.5	6.90000000000000036
536	Bread, damper, from wholemeal flour, homemade from basic ingredients	986	2.20000000000000018	6.59999999999999964	4.5
537	Bread, flat, injera	984	0	7.09999999999999964	0.800000000000000044
538	Bread, flat, not further defined, commercial	1176	4.29999999999999982	8.5	4.79999999999999982
539	Bread, flat, not further defined, commercial, toasted	1392	5.09999999999999964	10	5.70000000000000018
540	Bread, flat (pita or Lebanese), white, commercial	1102	3.10000000000000009	9.5	2.10000000000000009
541	Bread, flat (pita or Lebanese), white, commercial, toasted	1296	3.60000000000000009	11.1999999999999993	2.39999999999999991
542	Bread, flat (pita or Lebanese), wholemeal, commercial	1074	3.10000000000000009	8.59999999999999964	2
543	Bread, flat (pita or Lebanese), wholemeal, commercial, toasted	1279	3.70000000000000018	10.3000000000000007	2.39999999999999991
544	Bread, flat wrap, corn, commercial	1267	1.60000000000000009	4.79999999999999982	1.30000000000000004
545	Bread, flat wrap, corn, commercial, toasted	1407	1.80000000000000004	5.29999999999999982	1.39999999999999991
546	Bread, flat wrap or tortilla, mixed grain	1275	5.79999999999999982	8	8.40000000000000036
547	Bread, flat wrap or tortilla, mixed grain, toasted	1417	6.40000000000000036	8.80000000000000071	9.30000000000000071
548	Bread, flat wrap or tortilla, rice, commercial	1335	4.29999999999999982	7.09999999999999964	6.20000000000000018
549	Bread, flat wrap or tortilla, rye, commercial	1119	3	9.69999999999999929	2.10000000000000009
550	Bread, flat wrap or tortilla, rye, commercial, toasted	1243	3.29999999999999982	10.8000000000000007	2.29999999999999982
551	Bread, flat wrap or tortilla, wholemeal, commercial	1277	6	7.79999999999999982	8.30000000000000071
552	Bread, flat wrap or tortilla, wholemeal, commercial, toasted	1419	6.70000000000000018	8.69999999999999929	9.19999999999999929
553	Bread, flat wrap, white, commercial	1260	6	7.79999999999999982	8.30000000000000071
554	Bread, flat wrap, white, commercial, toasted	1400	6.70000000000000018	8.69999999999999929	9.19999999999999929
555	Bread, focaccia, plain, commercial	993	2.70000000000000018	9.59999999999999964	1.80000000000000004
556	Bread, focaccia, plain, commercial, toasted	1182	3.20000000000000018	11.4000000000000004	2.10000000000000009
557	Bread, fresh, not further defined	999	2.29999999999999982	8.5	2.70000000000000018
558	Bread, from rye flour, added grains, commercial	1007	1.60000000000000009	11.5	3.79999999999999982
559	Bread, from rye flour, added grains, commercial, toasted	1185	1.89999999999999991	13.5	4.5
560	Bread, from rye flour, dark, commercial	957	2.5	7.90000000000000036	2
561	Bread, from rye flour, dark, commercial, toasted	1126	2.89999999999999991	9.30000000000000071	2.39999999999999991
562	Bread, from rye flour, homemade from basic ingredients	1007	1.10000000000000009	7.70000000000000018	3.10000000000000009
563	Bread, from rye flour, homemade from basic ingredients, toasted	1184	1.30000000000000004	9.09999999999999964	3.70000000000000018
564	Bread, from rye flour, light, commercial	1057	2.20000000000000018	9	2.39999999999999991
565	Bread, from rye flour, light, commercial, toasted	1243	2.60000000000000009	10.5999999999999996	2.79999999999999982
566	Bread, from rye flour, organic, commercial	1057	2.20000000000000018	9	2.39999999999999991
567	Bread, from rye flour, organic, commercial, toasted	1243	2.60000000000000009	10.5999999999999996	2.79999999999999982
568	Bread, from rye flour, sour dough, commercial	980	2	9.19999999999999929	1.60000000000000009
569	Bread, from rye flour, sour dough, commercial, toasted	1153	2.39999999999999991	10.8000000000000007	1.89999999999999991
570	Bread, from spelt flour, commercial	1127	2.10000000000000009	12.1999999999999993	1.89999999999999991
571	Bread, from spelt flour, commercial, toasted	1342	2.60000000000000009	14.5999999999999996	2.29999999999999982
572	Bread, from wheat flour, commercial, added dried fruit	1151	15	8.30000000000000071	3.89999999999999991
573	Bread, from wheat flour, commercial, added dried fruit, toasted	1279	16.6999999999999993	9.19999999999999929	4.29999999999999982
574	Bread, from wheat flour, homemade from basic ingredients, added dried fruit	1136	14.8000000000000007	6.70000000000000018	3.60000000000000009
575	Bread, from wheat flour, homemade from basic ingredients, added dried fruit, toasted	1263	16.3999999999999986	7.5	4
576	Bread, from white flour, chia seeds, commercial	1059	2.5	10.0999999999999996	4.09999999999999964
577	Bread, from white flour, chia seeds, commercial, toasted	1246	2.89999999999999991	11.9000000000000004	4.79999999999999982
578	Bread, from white flour, ciabatta, commercial	1045	2.79999999999999982	10.0999999999999996	1.89999999999999991
579	Bread, from white flour, ciabatta, commercial, toasted	1244	3.39999999999999991	12	2.20000000000000018
580	Bread, from white flour, commercial	993	2.70000000000000018	9.59999999999999964	1.80000000000000004
581	Bread, from white flour, commercial, added calcium	993	2.70000000000000018	9.59999999999999964	1.80000000000000004
582	Bread, from white flour, commercial, added calcium, toasted	1154	3.10000000000000009	11.0999999999999996	2.10000000000000009
583	Bread, from white flour, commercial, added fibre	1010	2.5	9.40000000000000036	1.69999999999999996
584	Bread, from white flour, commercial, added fibre, toasted	1202	3	11.1999999999999993	2
585	Bread, from white flour, commercial, added fibre & vitamins B1, B3, B6 & E, Fe & Zn	963	2.39999999999999991	8.40000000000000036	1.80000000000000004
586	Bread, from white flour, commercial, added fibre & vitamins B1, B3, B6 & E, Fe & Zn, toasted	1133	2.79999999999999982	9.90000000000000036	2.10000000000000009
587	Bread, from white flour, commercial, added iron	993	2.70000000000000018	9.59999999999999964	1.80000000000000004
588	Bread, from white flour, commercial, added iron, toasted	1154	3.10000000000000009	11.0999999999999996	2.10000000000000009
589	Bread, from white flour, commercial, added omega-3 polyunsaturates	1044	2.39999999999999991	8.90000000000000036	2.10000000000000009
590	Bread, from white flour, commercial, added omega-3 polyunsaturates, toasted	1214	2.79999999999999982	10.4000000000000004	2.5
591	Bread, from white flour, commercial, fresh, not further defined	1002	2.70000000000000018	9.5	1.89999999999999991
592	Bread, from white flour, commercial, low GI	1040	4	8.19999999999999929	3
593	Bread, from white flour, commercial, low GI, toasted	1224	4.70000000000000018	9.59999999999999964	3.5
594	Bread, from white flour, commercial, toasted	1182	3.20000000000000018	11.4000000000000004	2.10000000000000009
595	Bread, from white flour, commercial, toasted, not further defined	1179	3.20000000000000018	11.0999999999999996	2.20000000000000018
596	Bread, from white flour, extra grainy & seeds, commercial	1110	2.5	10.5	4.59999999999999964
597	Bread, from white flour, extra grainy & seeds, commercial, toasted	1306	2.89999999999999991	12.4000000000000004	5.40000000000000036
598	Bread, from white flour, French stick or baguette, commercial	1103	3	10.6999999999999993	2
599	Bread, from white flour, French stick or baguette, commercial, toasted	1226	3.29999999999999982	11.8000000000000007	2.20000000000000018
600	Bread, from white flour, homemade from basic ingredients, added salt	1065	0.599999999999999978	7.29999999999999982	2.79999999999999982
601	Bread, from white flour, homemade from basic ingredients, added salt, toasted	1238	0.800000000000000044	8.5	3.20000000000000018
602	Bread, from white flour, organic, commercial	1031	1.30000000000000004	11.5	2.89999999999999991
603	Bread, from white flour, organic, commercial, toasted	1223	1.5	13.8000000000000007	3.39999999999999991
604	Bread, from white flour, pane di casa, commercial	1045	2.79999999999999982	10.0999999999999996	1.89999999999999991
605	Bread, from white flour, pane di casa, commercial, toasted	1244	3.39999999999999991	12	2.20000000000000018
606	Bread, from white flour, sour dough, commercial	1018	2.79999999999999982	9.80000000000000071	1.80000000000000004
607	Bread, from white flour, sour dough, commercial, toasted	1212	3.29999999999999982	11.6999999999999993	2.20000000000000018
608	Bread, from white flour, sour dough, homemade from basic ingredients	1040	0	7.59999999999999964	0.800000000000000044
609	Bread, from white flour, sour dough, homemade from basic ingredients, toasted	1238	0	9	1
610	Bread, from white Jackaroo flour, commercial, added vitamins B1 & folate & Fe	1052	3.79999999999999982	8.30000000000000071	2.29999999999999982
611	Bread, from white Jackaroo flour, commercial, added vitamins B1 & folate & Fe, toasted	1238	4.5	9.80000000000000071	2.70000000000000018
612	Bread, from white or wholemeal flour, organic, added grains, commercial	1082	1.30000000000000004	11.6999999999999993	3.60000000000000009
613	Bread, from white or wholemeal flour, organic, added grains, commercial, toasted	1273	1.5	13.8000000000000007	4.20000000000000018
614	Bread, from white or wholemeal flour, organic, commercial	1034	1.30000000000000004	11.5999999999999996	2.89999999999999991
615	Bread, from white or wholemeal flour, organic, commercial, toasted	1216	1.5	13.6999999999999993	3.39999999999999991
616	Bread, from white & wholemeal flour, commercial	1063	2.39999999999999991	9.80000000000000071	1.80000000000000004
617	Bread, from white & wholemeal flour, commercial, toasted	1251	2.89999999999999991	11.5999999999999996	2.10000000000000009
618	Bread, from wholemeal flour, added seeds, commercial	1108	2.60000000000000009	12.5999999999999996	7
619	Bread, from wholemeal flour, added seeds, commercial, toasted	1319	3.10000000000000009	15	8.40000000000000036
620	Bread, from wholemeal flour, commercial	963	2.70000000000000018	11.1999999999999993	2.29999999999999982
621	Bread, from wholemeal flour, commercial, added fibre	993	2.20000000000000018	11.6999999999999993	2.20000000000000018
622	Bread, from wholemeal flour, commercial, added fibre, toasted	1183	2.60000000000000009	13.9000000000000004	2.70000000000000018
623	Bread, from wholemeal flour, commercial, added fibre & vitamins B1, B3, B6 & E, Fe & Zn	1045	2.60000000000000009	10.6999999999999993	2.5
624	Bread, from wholemeal flour, commercial, added fibre & vitamins B1, B3, B6 & E, Fe & Zn, toasted	1244	3.10000000000000009	12.6999999999999993	3
625	Bread, from wholemeal flour, commercial, added iron	963	2.70000000000000018	11.1999999999999993	2.29999999999999982
626	Bread, from wholemeal flour, commercial, added iron, toasted	1133	3.20000000000000018	13.1999999999999993	2.70000000000000018
627	Bread, from wholemeal flour, commercial, added omega-3 polyunsaturates	1008	2.70000000000000018	11.1999999999999993	3.5
628	Bread, from wholemeal flour, commercial, added omega-3 polyunsaturates, toasted	1186	3.20000000000000018	13.1999999999999993	4.09999999999999964
629	Bread, from wholemeal flour, commercial, fresh, not further defined	964	2.70000000000000018	11.1999999999999993	2.29999999999999982
630	Bread, from wholemeal flour, commercial, toasted	1133	3.20000000000000018	13.1999999999999993	2.70000000000000018
631	Bread, from wholemeal flour, commercial, toasted, not further defined	1135	3.20000000000000018	13.1999999999999993	2.70000000000000018
632	Bread, from wholemeal flour, extra grainy, four seeds, commercial	1414	1.60000000000000009	14	17.1000000000000014
633	Bread, from wholemeal flour, extra grainy, four seeds, commercial, toasted	1664	1.89999999999999991	16.5	20.1999999999999993
634	Bread, from wholemeal flour, extra grainy & seeds, added oats, commercial	929	2.10000000000000009	10.0999999999999996	4
635	Bread, from wholemeal flour, extra grainy & seeds, added oats, commercial, toasted	1093	2.5	11.8000000000000007	4.70000000000000018
636	Bread, from wholemeal flour, extra grainy & seeds, commercial	1060	2.5	11.6999999999999993	4.59999999999999964
637	Bread, from wholemeal flour, extra grainy & seeds, commercial, toasted	1247	3	13.8000000000000007	5.40000000000000036
638	Bread, from wholemeal flour, homemade from basic ingredients, added salt	1043	1.19999999999999996	7.70000000000000018	3.39999999999999991
639	Bread, from wholemeal flour, homemade from basic ingredients, added salt, toasted	1228	1.39999999999999991	9	3.89999999999999991
640	Bread, from wholemeal flour, mixed grain & seeds, commercial	1155	1.80000000000000004	12.0999999999999996	8.69999999999999929
641	Bread, from wholemeal flour, mixed grain & seeds, commercial, toasted	1359	2.10000000000000009	14.1999999999999993	10.1999999999999993
642	Bread, from wholemeal flour, mixed grain, with quinoa & flaxseeds, commercial	1106	1.89999999999999991	11.5999999999999996	6.90000000000000036
643	Bread, from wholemeal flour, mixed grain, with quinoa & flaxseeds, commercial, toasted	1301	2.20000000000000018	13.5999999999999996	8.09999999999999964
644	Bread, from wholemeal flour, organic, commercial	1036	1.30000000000000004	11.8000000000000007	2.89999999999999991
645	Bread, from wholemeal flour, organic, commercial, toasted	1219	1.5	13.8000000000000007	3.39999999999999991
646	Bread, from wholemeal flour, sour dough, commercial	998	2.79999999999999982	11.5999999999999996	2.39999999999999991
647	Bread, from wholemeal flour, sour dough, commercial, toasted	1024	2.89999999999999991	11.9000000000000004	2.39999999999999991
648	Bread, garlic or herb, commercial, cooked	1327	3.60000000000000009	8.40000000000000036	13.5
649	Bread, garlic or herb, homemade, cooked	1250	2.29999999999999982	9.59999999999999964	11.1999999999999993
650	Bread, gluten free, commercial	888	2.60000000000000009	5.5	3.89999999999999991
651	Bread, gluten free, commercial, toasted	1057	3.10000000000000009	6.5	4.59999999999999964
652	Bread, gluten free, homemade from basic ingredients	1372	2.5	9.80000000000000071	13.9000000000000004
653	Bread, gluten free, homemade from basic ingredients, toasted	1633	3	11.5999999999999996	16.6000000000000014
654	Bread, gluten free, with added grains, commercial	1000	2.5	6.79999999999999982	7.29999999999999982
655	Bread, gluten free, with added grains, commercial, toasted	1177	3	8.09999999999999964	8.59999999999999964
656	Bread, homemade from basic ingredients, not further defined	1056	0.900000000000000022	7.5	3.10000000000000009
657	Bread, homemade from basic ingredients, not further defined, toasted	1242	1	8.80000000000000071	3.60000000000000009
658	Bread, johnny (jonny) cake, from white flour, homemade from basic ingredients	1116	0	8.09999999999999964	0.900000000000000022
659	Bread, mixed grain, added seeds, commercial	1098	1.80000000000000004	11.6999999999999993	6.79999999999999982
660	Bread, mixed grain, added seeds, commercial, toasted	1291	2.20000000000000018	13.8000000000000007	8
661	Bread, mixed grain, commercial	1043	1.80000000000000004	11.1999999999999993	5
662	Bread, mixed grain, commercial, fresh, not further defined	1060	2	11.1999999999999993	5.29999999999999982
663	Bread, mixed grain, commercial, toasted	1227	2.20000000000000018	13.0999999999999996	5.90000000000000036
664	Bread, mixed grain, commercial, toasted, not further defined	1247	2.29999999999999982	13.1999999999999993	6.20000000000000018
665	Bread, mixed grain, extra grainy & seeds, added pumpkin seeds, commercial	1232	2.39999999999999991	12.0999999999999996	8.80000000000000071
666	Bread, mixed grain, extra grainy & seeds, added pumpkin seeds, commercial, toasted	1450	2.79999999999999982	14.3000000000000007	10.3000000000000007
667	Bread, mixed grain, French stick or baguette, commercial	1159	2.10000000000000009	12.4000000000000004	5.59999999999999964
668	Bread, mixed grain, French stick or baguette, commercial, toasted	1288	2.29999999999999982	13.8000000000000007	6.20000000000000018
669	Bread, mixed grain, homemade from basic ingredients, added salt	1064	1.5	8.40000000000000036	4.29999999999999982
670	Bread, mixed grain, homemade from basic ingredients, added salt, toasted	1252	1.80000000000000004	9.90000000000000036	5
671	Bread, Naan, commercial	1141	1.39999999999999991	6.5	8.80000000000000071
672	Bread, Naan, homemade	1147	1.39999999999999991	6.59999999999999964	8.90000000000000036
673	Bread, paratha	1284	0.200000000000000011	5.90000000000000036	14.5
674	Bread, pizza base, commercial	1017	5.09999999999999964	7.20000000000000018	2.20000000000000018
675	Bread, pizza base, homemade from basic ingredients	1000	0.599999999999999978	6.70000000000000018	3.70000000000000018
676	Bread, pizza base, thick base, fast food-style	1076	0.599999999999999978	6.5	6.40000000000000036
677	Bread, pizza base, thin base, fast food-style	1069	0.599999999999999978	6.40000000000000036	5.20000000000000018
678	Bread, pumpernickel, commercial	901	4.29999999999999982	6.40000000000000036	1.60000000000000009
679	Bread, pumpernickel, commercial, toasted	1060	5.09999999999999964	7.5	1.89999999999999991
680	Bread, pumpkin	874	2.20000000000000018	6.29999999999999982	2.20000000000000018
681	Bread, pumpkin, toasted	1028	2.60000000000000009	7.40000000000000036	2.60000000000000009
682	Bread, Roti, commercial	1297	0.699999999999999956	8.30000000000000071	7.40000000000000036
683	Bread, soy & linseed, commercial	1150	1.80000000000000004	11.9000000000000004	8.69999999999999929
684	Bread, soy & linseed, commercial, toasted	1353	2.10000000000000009	14	10.3000000000000007
685	Bread, toasted, not further defined	1175	2.79999999999999982	10	3.20000000000000018
686	Bread, tortilla, corn, commercial	1362	1.89999999999999991	5.70000000000000018	7.40000000000000036
687	Bread, tortilla, corn, commercial, toasted	1514	2.10000000000000009	6.29999999999999982	8.19999999999999929
688	Bread, tortilla, for use in Mexican recipes	1402	1.39999999999999991	7.40000000000000036	9
689	Bread, tortilla, white, commercial	1437	0.5	8.09999999999999964	9.80000000000000071
690	Bread, tortilla, white, commercial, toasted	1711	0.599999999999999978	9.59999999999999964	11.6999999999999993
691	Breakfast pastry, sweet, fruit-paste filled, commercial	1655	33	4.90000000000000036	10.5
692	Bream, baked, roasted, fried, grilled or BBQd, no added fat	714	0	26.8000000000000007	7
693	Bream, baked, roasted, grilled, BBQd, fried or deep fried, fat not further defined	927	0	25.5	13.4000000000000004
694	Bream, boiled, microwaved, steamed or poached, with or without added fat	581	0	22.3999999999999986	5.40000000000000036
695	Bream, raw	521	0	19.6000000000000014	5.09999999999999964
696	Broccoli, fresh, boiled, microwaved or steamed, drained	114	1.30000000000000004	3.29999999999999982	0.400000000000000022
697	Broccoli, fresh or frozen, baked, roasted, fried, stir-fried, grilled or BBQd, canola oil	377	0.5	5.40000000000000036	6.40000000000000036
698	Broccoli, fresh or frozen, baked, roasted, fried, stir-fried, grilled or BBQd, fat not further defined	373	0.5	5.40000000000000036	6.29999999999999982
699	Broccoli, fresh or frozen, baked, roasted, fried, stir-fried, grilled or BBQd, no added fat	160	0.5	5.70000000000000018	0.400000000000000022
700	Broccoli, fresh or frozen, baked, roasted, fried, stir-fried, grilled or BBQd, olive oil	377	0.5	5.40000000000000036	6.40000000000000036
701	Broccoli, fresh or frozen, baked, roasted, fried, stir-fried, grilled or BBQd, other oil	377	0.5	5.40000000000000036	6.40000000000000036
702	Broccoli, fresh or frozen, boiled, microwaved or steamed, drained, added fat not further defined	304	0.400000000000000022	4.70000000000000018	5
703	Broccoli, fresh or frozen, raw	131	0.400000000000000022	4.70000000000000018	0.299999999999999989
704	Broccoli, frozen, boiled, microwaved or steamed, drained	124	1.39999999999999991	2.70000000000000018	0.299999999999999989
705	Broccolini, fresh or frozen, boiled, microwaved or steamed, drained	157	1.39999999999999991	3.29999999999999982	0.400000000000000022
706	Broccolini, fresh or frozen, raw	150	1.30000000000000004	3.20000000000000018	0.400000000000000022
707	Brussels sprout, fresh, boiled, microwaved or steamed, drained	156	2.20000000000000018	4	0.299999999999999989
708	Brussels sprout, fresh or frozen, baked, roasted, stir-fried, fried, grilled or BBQd, fat not further defined	360	2.20000000000000018	4	5.79999999999999982
709	Brussels sprout, fresh or frozen, raw	150	2.10000000000000009	3.79999999999999982	0.299999999999999989
710	Brussels sprout, frozen, boiled, microwaved or steamed , drained	186	3.10000000000000009	3.20000000000000018	0.299999999999999989
711	Buckwheat groats, cooked in water, no added salt	321	0.299999999999999989	2.5	0.599999999999999978
712	Buckwheat groats, uncooked	1509	1.39999999999999991	11.6999999999999993	2.70000000000000018
713	Buffalo, riverine, cube roll, raw	650	0	23.8999999999999986	6.59999999999999964
714	Buffalo, riverine, topside, raw	496	0	24.3999999999999986	2.20000000000000018
715	Buffalo, swamp, cube roll, raw	507	0	24.3999999999999986	2.5
716	Buffalo, swamp, topside, raw	448	0	24.6000000000000014	0.800000000000000044
717	Buffalo, wild caught, cooked	657	0	30.3999999999999986	3.79999999999999982
718	Bulgur (burghul, burgaul), cooked in water, no added fat or salt	383	0	2.89999999999999991	0.400000000000000022
719	Bulgur (burghul, burgaul), dry, uncooked	1336	0.800000000000000044	9.80000000000000071	1.69999999999999996
720	Bulgur (burghul, burgaul), soaked in water, no added fat or salt	664	0.400000000000000022	5.40000000000000036	0.900000000000000022
721	Bun, sweet, chocolate or with chocolate chips, uniced	1388	20.8999999999999986	5.79999999999999982	11.5
722	Bun, sweet, not further defined	1212	17.6999999999999993	6.70000000000000018	6.79999999999999982
723	Bun, sweet, steamed bun, filled with bean paste	958	13	5.79999999999999982	5.59999999999999964
724	Bun, sweet, sticky cinnamon, with icing	1547	30.1999999999999993	4.5	16.3999999999999986
725	Bun, sweet, with custard, iced	1272	25.1999999999999993	5.29999999999999982	10.6999999999999993
726	Bun, sweet, with fruit (other than sultanas), iced	1119	21.8000000000000007	5.5	6.09999999999999964
727	Bun, sweet, with fruit (other than sultanas) & nuts, iced	1387	18.8999999999999986	6.79999999999999982	15.5999999999999996
728	Bun, sweet, with fruit (other than sultanas), uniced	1057	16.8999999999999986	5.90000000000000036	5.09999999999999964
729	Bun, sweet, with mock cream & jam, uniced	1195	18.8000000000000007	6	8
730	Bun, sweet, with sultanas, iced	1325	17.6000000000000014	7.90000000000000036	9.80000000000000071
731	Bun, sweet, with sultanas, uniced	1191	16.8999999999999986	6.90000000000000036	6
732	Bun, sweet, with taro	1197	19.5	4.90000000000000036	6.29999999999999982
733	Butter, garlic or herb, homemade with butter or dairy blend	2716	0.200000000000000011	1.5	72
734	Buttermilk, cultured, 2% fat	242	5.40000000000000036	4.20000000000000018	2
735	Butter, not further defined	3027	0	1.10000000000000009	81.2999999999999972
736	Butter, plain, no added salt	3027	0	1.10000000000000009	81.2999999999999972
737	Butter, plain, reduced salt (sodium < 350 mg /100 g)	3027	0	1.10000000000000009	81.2999999999999972
738	Butter, plain, salted	3027	0	1.10000000000000009	81.2999999999999972
739	Butter, spreadable, reduced fat (~60% fat)	2258	0	1.10000000000000009	60.5
740	Butter, spreadable, regular (~80% fat)	3042	0	1.10000000000000009	81.7000000000000028
741	Cabbage, baked, roasted, fried, stir-fried, grilled or BBQd, butter, dairy blend or margarine	259	2.5	1.69999999999999996	4.59999999999999964
742	Cabbage, baked, roasted, fried, stir-fried, grilled or BBQd, canola oil	300	2.5	1.60000000000000009	5.70000000000000018
743	Cabbage, baked, roasted, fried, stir-fried, grilled or BBQd, no added fat	99	2.60000000000000009	1.69999999999999996	0.100000000000000006
744	Cabbage, baked, roasted, fried, stir-fried, grilled or BBQd, olive oil	300	2.5	1.60000000000000009	5.70000000000000018
745	Cabbage, baked, roasted, fried, stir-fried, grilled or BBQd, other oil	300	2.5	1.60000000000000009	5.70000000000000018
746	Cabbage, boiled, microwaved or steamed, drained, with or without added fat	93	2.5	1.60000000000000009	0.100000000000000006
747	Cabbage, Chinese, baked, roasted, fried, stir-fried, grilled or BBQd, fat not further defined	319	1.19999999999999996	1.5	7
748	Cabbage, Chinese, baked, roasted, fried, stir-fried, grilled or BBQd, no added fat	49	1	1.19999999999999996	0
749	Cabbage, Chinese, boiled, microwaved or steamed, drained	46	0.900000000000000022	1.10000000000000009	0
750	Cabbage, Chinese, boiled, microwaved or steamed, drained, added fat not further defined	218	0.900000000000000022	1.10000000000000009	4.70000000000000018
751	Cabbage, Chinese flowering, raw	71	0.800000000000000044	1.30000000000000004	0.299999999999999989
752	Cabbage, Chinese, raw	44	0.900000000000000022	1.10000000000000009	0
753	Cabbage, mustard, cooked	86	0.800000000000000044	2.60000000000000009	0.299999999999999989
754	Cabbage, mustard, raw	77	0.699999999999999956	2.29999999999999982	0.299999999999999989
755	Cabbage, pickled, canned, drained	65	1.10000000000000009	1.10000000000000009	0.200000000000000011
756	Cabbage, raw, not further defined	89	2.39999999999999991	1.5	0.100000000000000006
757	Cabbage, red, baked, roasted, fried, stir-fried, grilled or BBQd, fat not further defined	331	2.79999999999999982	2.29999999999999982	5.79999999999999982
758	Cabbage, red, boiled, microwaved or steamed, drained, with or without added fat	127	2.79999999999999982	2.29999999999999982	0.299999999999999989
759	Cabbage, red, canned, heated, drained	171	6.20000000000000018	1.39999999999999991	0.200000000000000011
760	Cabbage, red, raw	122	2.70000000000000018	2.20000000000000018	0.299999999999999989
761	Cabbage roll, stuffed with meat & rice	452	2.20000000000000018	9.80000000000000071	4.79999999999999982
762	Cabbage roll, stuffed with tomato & rice	332	2.39999999999999991	2	1
763	Cabbage, savoy, baked, roasted, fried, stir-fried, grilled or BBQd, with or without added fat	100	2.60000000000000009	1.89999999999999991	0.100000000000000006
764	Cabbage, savoy, boiled, microwaved or steamed, drained, with or without added fat	93	2.39999999999999991	1.80000000000000004	0.100000000000000006
765	Cabbage, savoy, raw	90	2.29999999999999982	1.69999999999999996	0.100000000000000006
766	Cabbage, white, baked, roasted, fried, stir-fried, grilled or BBQd, fat not further defined	298	3	1.39999999999999991	5.59999999999999964
767	Cabbage, white, boiled, microwaved or steamed, drained, with and without added fat	95	2.89999999999999991	1.39999999999999991	0.100000000000000006
768	Cabbage, white, raw	91	2.79999999999999982	1.30000000000000004	0.100000000000000006
769	Caffeine	0	0	0	0
770	Calcium	0	0	0	0
771	Camel, cube roll, raw	630	0	20.3000000000000007	7.70000000000000018
772	Camel, rump, raw	475	0	21.3999999999999986	3
773	Capers, pickled, canned, drained	126	0.400000000000000022	2.39999999999999991	0.900000000000000022
774	Capsicum, fresh or frozen, baked, roasted, fried, stir-fried, grilled or BBQd, canola oil	318	3.60000000000000009	1.69999999999999996	5.70000000000000018
775	Capsicum, fresh or frozen, baked, roasted, fried, stir-fried, grilled or BBQd, fat not further defined	314	3.60000000000000009	1.69999999999999996	5.59999999999999964
776	Capsicum, fresh or frozen, baked, roasted, fried, stir-fried, grilled or BBQd, no added fat	118	3.79999999999999982	1.80000000000000004	0.200000000000000011
777	Capsicum, fresh or frozen, baked, roasted, fried, stir-fried, grilled or BBQd, olive oil	318	3.60000000000000009	1.69999999999999996	5.70000000000000018
778	Capsicum, fresh or frozen, boiled, microwaved or steamed, added fat not further defined	282	3.39999999999999991	1.60000000000000009	4.90000000000000036
779	Capsicum, fresh or frozen, boiled, microwaved or steamed, drained	112	3.60000000000000009	1.69999999999999996	0.200000000000000011
780	Capsicum, fresh or frozen, raw, not further defined	106	3.39999999999999991	1.60000000000000009	0.200000000000000011
781	Capsicum, green, fresh or frozen, baked, roasted, fried, stir-fried, grilled or BBQd, fat not further defined	290	2.39999999999999991	1.60000000000000009	5.59999999999999964
782	Capsicum, green, fresh or frozen, baked, roasted, fried, stir-fried, grilled or BBQd, no added fat	93	2.60000000000000009	1.69999999999999996	0.100000000000000006
783	Capsicum, green, fresh or frozen, boiled, microwaved or steamed, added fat not further defined	260	2.29999999999999982	1.5	4.79999999999999982
784	Capsicum, green, fresh or frozen, boiled, microwaved or steamed, drained	88	2.39999999999999991	1.60000000000000009	0.100000000000000006
785	Capsicum, green, fresh or frozen, raw	84	2.29999999999999982	1.5	0.100000000000000006
786	Capsicum, red, fresh or frozen, baked, roasted, fried, stir-fried, grilled or BBQd, fat not further defined	327	4.20000000000000018	1.80000000000000004	5.70000000000000018
787	Capsicum, red, fresh or frozen, baked, roasted, fried, stir-fried, grilled or BBQd, no added fat	132	4.40000000000000036	1.89999999999999991	0.200000000000000011
788	Capsicum, red, fresh or frozen, boiled, microwaved or steamed, drained	125	4.20000000000000018	1.80000000000000004	0.200000000000000011
789	Capsicum, red, fresh or frozen, boiled, microwaved or steamed, drained, added fat not further defined	295	4	1.69999999999999996	4.90000000000000036
790	Capsicum, red, fresh or frozen, raw	118	4	1.69999999999999996	0.200000000000000011
791	Capsicum, stuffed with meat & rice	520	2.79999999999999982	8.59999999999999964	4.5
792	Capsicum, stuffed with tomato & rice	404	3.10000000000000009	2.29999999999999982	1.5
793	Caramels, hard	1620	54.6000000000000014	2.5	11.4000000000000004
794	Caramels, soft	1620	54.6000000000000014	2.5	11.4000000000000004
795	Cardamom, seeds, ground	1333	9.5	10.8000000000000007	6.70000000000000018
796	Carrot, baby, canned in brine, boiled or microwaved , drained	108	4	0.599999999999999978	0.100000000000000006
797	Carrot, baby, peeled or unpeeled, fresh or frozen, baked, roasted, fried, stir-fried, grilled or BBQd, fat not further defined	336	5.70000000000000018	0.699999999999999956	5.40000000000000036
798	Carrot, baby, peeled or unpeeled, fresh or frozen, boiled, microwaved or steamed, drained	144	5.90000000000000036	0.800000000000000044	0.100000000000000006
799	Carrot, baby, peeled or unpeeled, fresh or frozen, raw	134	5.5	0.699999999999999956	0.100000000000000006
800	Carrot, mature, peeled or unpeeled, fresh or frozen, baked, roasted, fried, stir-fried, grilled or BBQd, butter, dairy blend or margarine	334	5.79999999999999982	1	5
801	Carrot, mature, peeled or unpeeled, fresh or frozen, baked, roasted, fried, stir-fried, grilled or BBQd, canola oil	379	5.79999999999999982	0.900000000000000022	6.20000000000000018
802	Carrot, mature, peeled or unpeeled, fresh or frozen, baked, roasted, fried, stir-fried, grilled or BBQd, fat not further defined	376	5.79999999999999982	0.900000000000000022	6.09999999999999964
803	Carrot, mature, peeled or unpeeled, fresh or frozen, baked, roasted, fried, stir-fried, grilled or BBQd, no added fat	162	6.09999999999999964	1	0.100000000000000006
804	Carrot, mature, peeled or unpeeled, fresh or frozen, baked, roasted, fried, stir-fried, grilled or BBQd, olive oil	379	5.79999999999999982	0.900000000000000022	6.20000000000000018
805	Carrot, mature, peeled or unpeeled, fresh or frozen, baked, roasted, fried, stir-fried, grilled or BBQd, other oil	379	5.79999999999999982	0.900000000000000022	6.20000000000000018
806	Carrot, mature, peeled or unpeeled, fresh or frozen, boiled, microwaved or steamed, drained	129	3.70000000000000018	1.19999999999999996	0.299999999999999989
807	Carrot, mature, peeled or unpeeled, fresh or frozen, boiled, microwaved or steamed, drained, added fat not further defined	315	5.09999999999999964	0.800000000000000044	5
808	Carrot, mature, peeled or unpeeled, fresh or frozen, raw	133	5	0.800000000000000044	0.100000000000000006
809	Carrot, peeled or unpeeled, fresh or frozen, raw, not further defined	133	5.20000000000000018	0.800000000000000044	0.100000000000000006
810	Cassava, peeled, fresh or frozen, boiled, microwaved or steamed, drained	632	1.30000000000000004	1.19999999999999996	0.299999999999999989
811	Cassava, peeled, fresh or frozen, raw	587	1.19999999999999996	1.10000000000000009	0.200000000000000011
812	Cassava, white flesh, peeled, fresh or frozen, boiled, microwaved or steamed, drained	692	1.30000000000000004	0.599999999999999978	0.299999999999999989
813	Cassava, white flesh, peeled, fresh or frozen, raw	644	1.19999999999999996	0.599999999999999978	0.299999999999999989
814	Cassava, yellow flesh, peeled, fresh or frozen, boiled, microwaved or steamed, drained	571	1.30000000000000004	1.69999999999999996	0.200000000000000011
815	Cassava, yellow flesh, peeled, fresh or frozen, raw	531	1.19999999999999996	1.60000000000000009	0.200000000000000011
816	Casserole base, cream style, dry mix	1490	24.5	12.3000000000000007	3.39999999999999991
817	Casserole base, dry mix	1561	19.1000000000000014	7.09999999999999964	4.90000000000000036
818	Cauliflower, fresh or frozen, baked, roasted, fried, stir-fried, grilled or BBQd, fat not further defined	341	2.29999999999999982	2.60000000000000009	6.20000000000000018
819	Cauliflower, fresh or frozen, baked, roasted, fried, stir-fried, grilled or BBQd, no added fat	126	2.39999999999999991	2.70000000000000018	0.200000000000000011
820	Cauliflower, fresh or frozen, boiled, microwaved or steamed, added homemade cheese sauce	512	3.29999999999999982	5.59999999999999964	8.59999999999999964
821	Cauliflower, fresh or frozen, boiled, microwaved or steamed, drained	107	2.10000000000000009	2.29999999999999982	0.200000000000000011
822	Cauliflower, fresh or frozen, boiled, microwaved or steamed, drained, added fat not further defined	276	2	2.20000000000000018	4.90000000000000036
823	Cauliflower, fresh or frozen, raw	103	2	2.20000000000000018	0.200000000000000011
824	Celeriac, peeled, boiled, microwaved or steamed, drained	171	3	1.69999999999999996	0.200000000000000011
825	Celeriac, peeled, raw	159	2.79999999999999982	1.60000000000000009	0.200000000000000011
826	Celery, fresh or frozen, baked, roasted, fried, stir-fried, grilled or BBQd, fat not further defined	294	1.39999999999999991	0.699999999999999956	6.09999999999999964
827	Celery, fresh or frozen, baked, roasted, fried, stir-fried, grilled or BBQd, no added fat	76	1.5	0.699999999999999956	0.100000000000000006
828	Celery, fresh or frozen, boiled, microwaved or steamed, drained	73	1.39999999999999991	0.699999999999999956	0.100000000000000006
829	Celery, fresh or frozen, boiled, microwaved or steamed, drained, added fat not further defined	266	1.30000000000000004	0.699999999999999956	5.40000000000000036
830	Celery, fresh or frozen, raw	62	1.19999999999999996	0.599999999999999978	0.100000000000000006
831	Cheese, blended for pizza use, regular fat	1328	0.100000000000000006	28.8000000000000007	21.8999999999999986
832	Cheese, blue vein	1571	0	20.3000000000000007	32.3999999999999986
833	Cheese, bocconcini	1081	0	18.1000000000000014	20.3999999999999986
834	Cheese, brie	1543	0.100000000000000006	19.5	32
835	Cheese, camembert	1286	0.100000000000000006	19.5	25
836	Cheese, cheddar, natural, flavoured	1627	0.800000000000000044	23.6999999999999993	31.5
837	Cheese, cheddar, natural, plain, not further defined	1611	0.400000000000000022	25.3000000000000007	31.1000000000000014
838	Cheese, cheddar, natural, plain, reduced fat (~ 15%)	1109	0	31.1000000000000014	15.3000000000000007
839	Cheese, cheddar, natural, plain, reduced fat (~25%)	1403	0	28.8999999999999986	24.1999999999999993
840	Cheese, cheddar, natural, plain, regular fat	1663	0.400000000000000022	24.6000000000000014	32.7999999999999972
841	Cheese, cheddar, not further defined	1496	0.699999999999999956	24	28.3999999999999986
842	Cheese, cheddar, processed, babybel style	1563	1	22	31
843	Cheese, cheddar, processed, not further defined	1248	1.39999999999999991	21.1999999999999993	22.6999999999999993
844	Cheese, cheddar, processed, reduced fat (~16%)	1054	4.90000000000000036	22.5	15.4000000000000004
845	Cheese, cheddar, processed, reduced fat (3%)	660	5.5	26.3999999999999986	2.70000000000000018
846	Cheese, cheddar, processed, reduced fat (~8%)	806	4.90000000000000036	24.3999999999999986	7.79999999999999982
847	Cheese, cheddar, processed, reduced fat, not further defined	743	5.29999999999999982	25.5	5.40000000000000036
848	Cheese, cheddar, processed, regular fat	1311	0.100000000000000006	21.1000000000000014	25
849	Cheese, cheddar, processed, stick style	1443	5.59999999999999964	14.5	29.1999999999999993
850	Cheese, cheddar, reduced fat, not further defined	1092	2.10000000000000009	27.8999999999999986	15.3000000000000007
851	Cheese, cheddar, regular fat, not further defined	1533	0.599999999999999978	22.8999999999999986	30
852	Cheese, cheshire	1641	0	24.1999999999999993	32.5
853	Cheese, colby style	1631	0.100000000000000006	24	32.2999999999999972
854	Cheese, cottage or cream, sweet chilli flavoured	728	14	7.70000000000000018	9.19999999999999929
855	Cheese, cottage, reduced fat	398	4.20000000000000018	12.5	2.5
856	Cheese, cottage, regular fat	529	1.80000000000000004	15.4000000000000004	5.70000000000000018
857	Cheese, cream, fruit flavoured	1155	5.5	7.20000000000000018	24.6999999999999993
858	Cheese, cream, herb or spice flavoured	1229	0.5	8.40000000000000036	28.6000000000000014
859	Cheese, cream, plain, not further defined	1195	0.699999999999999956	8.69999999999999929	27.8000000000000007
860	Cheese, cream, plain, reduced fat (25% fat)	1079	0.200000000000000011	8.5	25
861	Cheese, cream, plain, reduced fat (5% fat)	445	4.79999999999999982	11	4.70000000000000018
862	Cheese, cream, plain, regular fat (35% fat)	1420	0.200000000000000011	8.5	34.2000000000000028
863	Cheese, edam	1510	0	28	27.1999999999999993
864	Cheese, fetta (feta), not further defined	1154	0.200000000000000011	18.6999999999999993	21.8999999999999986
865	Cheese, fetta (feta), reduced fat	1000	0.100000000000000006	25.6999999999999993	14.5
866	Cheese, fetta (feta), regular fat	1179	0.200000000000000011	17.6000000000000014	23.1999999999999993
867	Cheese, for use in garden s	1374	0.5	22.6999999999999993	25.8999999999999986
868	Cheese, for use on crackers or cheese platters	1503	0.299999999999999989	21.8999999999999986	29.6999999999999993
869	Cheese fruit, raw	205	7	0.800000000000000044	0.299999999999999989
870	Cheese, gloucester style	1721	0	25	34.2999999999999972
871	Cheese, goat, firm	1502	0.800000000000000044	18.6000000000000014	31.3000000000000007
872	Cheese, goat, soft	1194	0.900000000000000022	21.1999999999999993	21.6999999999999993
873	Cheese, gouda	1605	0	26.1999999999999993	30.6000000000000014
874	Cheese, haloumi	1050	1.80000000000000004	21.3000000000000007	17.1000000000000014
875	Cheese, havarti style	1716	0.100000000000000006	19.3999999999999986	36.7000000000000028
876	Cheese, jarlsberg	1620	0.100000000000000006	28.3999999999999986	30
877	Cheese, mozzarella, buffalo	1318	0.299999999999999989	17.1999999999999993	27.1000000000000014
878	Cheese, mozzarella, not further defined	1215	0	23.5	21.5
879	Cheese, mozzarella, reduced fat	1229	0.100000000000000006	31.6999999999999993	17.8999999999999986
880	Cheese, mozzarella, regular fat	1213	0	22.1999999999999993	22.1000000000000014
881	Cheese, neufchatel	1365	2.20000000000000018	9.40000000000000036	30.8999999999999986
882	Cheese, not further defined	1465	0.599999999999999978	23.6999999999999993	27.8000000000000007
883	Cheese, parmesan, dried, finely grated	1949	0	40.6000000000000014	33.2999999999999972
884	Cheese, parmesan, fresh	1690	0	35.1000000000000014	28.8000000000000007
885	Cheese, pecorino style	1512	0.200000000000000011	28	27.1999999999999993
886	Cheese, processed, stick shape with string texture	1250	0	27.3999999999999986	20.6999999999999993
887	Cheese, processed, with added phytosterols	713	4.90000000000000036	15.5	9.40000000000000036
888	Cheese, provolone style	1550	0.100000000000000006	27.8000000000000007	28.3999999999999986
889	Cheese, quark	349	2.89999999999999991	13.9000000000000004	1.10000000000000009
890	Cheese, ricotta, not further defined	458	2	9	6.70000000000000018
891	Cheese, ricotta, reduced fat	279	2	6.79999999999999982	2.79999999999999982
892	Cheese, ricotta, regular fat	551	2	10.1999999999999993	8.69999999999999929
893	Cheese, romano style	1594	0.200000000000000011	31.3000000000000007	27.8999999999999986
894	Cheese, smoked, regular fat	1487	0.299999999999999989	22.8000000000000007	28.8999999999999986
895	Cheese, soft, white mould coated, not further defined	1465	0.100000000000000006	18.6000000000000014	30.3000000000000007
896	Cheese, soy	1238	1.80000000000000004	7	28
897	Cheese spread, cheddar, regular fat	1187	3.79999999999999982	11.1999999999999993	25.3000000000000007
898	Cheese spread, cream cheese, reduced fat	921	4.59999999999999964	10.8000000000000007	18
899	Cheese spread, cream cheese, regular fat	1215	2.10000000000000009	7.79999999999999982	28.1999999999999993
900	Cheese, swiss	1620	0.100000000000000006	28.3999999999999986	30
901	Cherry, black, canned in syrup	299	15.8000000000000007	0.699999999999999956	0.100000000000000006
902	Cherry, black, canned in syrup, drained	310	15.6999999999999993	0.900000000000000022	0.100000000000000006
903	Cherry, black, canned in syrup, syrup only	288	16	0.5	0
904	Cherry, dried	1137	49.3999999999999986	3.5	0.900000000000000022
905	Cherry, glace or maraschino	1079	66.5	0.400000000000000022	0
906	Cherry, raw	250	10.9000000000000004	0.800000000000000044	0.200000000000000011
907	Chestnut puree, added sugar	1095	42.7999999999999972	1.10000000000000009	0.200000000000000011
908	Chicken, barbecued, without skin, commercial	654	0	26.3999999999999986	5.5
909	Chicken, barbecued, with skin, commercial	806	0	27.5	8.90000000000000036
910	Chicken, battered, takeaway, restaurant or cafe style, with honey & lemon sauce	841	5.29999999999999982	16.3000000000000007	11.0999999999999996
911	Chicken, bite-size pieces, coated, fast food chain, fried, fat not further defined	1199	0.5	17.3000000000000007	19.6999999999999993
912	Chicken, breast, flesh, baked or roasted, no added fat	637	0	29	3.89999999999999991
913	Chicken, breast, flesh, baked, roasted, fried, stir-fried, grilled or BBQd, butter, dairy blend, margarine spread	652	0	29.1999999999999993	4.20000000000000018
914	Chicken, breast, flesh, baked, roasted, fried, stir-fried, grilled or BBQd, canola oil	671	0	29.1000000000000014	4.79999999999999982
915	Chicken, breast, flesh, baked, roasted, fried, stir-fried, grilled or BBQd, fat not further defined	670	0	29.1000000000000014	4.70000000000000018
916	Chicken, breast, flesh, baked, roasted, fried, stir-fried, grilled or BBQd, olive oil	671	0	29.1000000000000014	4.79999999999999982
917	Chicken, breast, flesh, baked, roasted, fried, stir-fried, grilled or BBQd, other oil	671	0	29.1000000000000014	4.79999999999999982
918	Chicken, breast, flesh, boiled, casseroled, microwaved, poached, steamed or stewed, fat not further defined	644	0	28	4.5
919	Chicken, breast, flesh, boiled, casseroled, microwaved, poached, steamed or stewed, no added fat	596	0	27	3.70000000000000018
920	Chicken, breast, flesh, breadcrumb coating, cooked, fat not further defined	884	0.699999999999999956	26.3999999999999986	6
921	Chicken, breast, flesh, breadcrumb coating, cooked, no added fat	810	0.699999999999999956	26.8999999999999986	3.5
922	Chicken, breast, flesh, canned in water, drained	436	0.599999999999999978	21.6000000000000014	1.60000000000000009
923	Chicken, breast, flesh, coated, cooked, fat not further defined	919	0.800000000000000044	26.3000000000000007	5.90000000000000036
924	Chicken, breast, flesh, coated, cooked, no added fat	835	0.800000000000000044	26.3999999999999986	3.39999999999999991
925	Chicken, breast, flesh, fried or stir-fried, no added fat	681	0.699999999999999956	35	2
926	Chicken, breast, flesh, grilled or BBQd, no added fat	598	0	29.8000000000000007	2.5
927	Chicken, breast, flesh, purchased frozen with breadcrumb coating, cooked, fat not further defined	884	0.699999999999999956	26.3999999999999986	6
928	Chicken, breast, flesh, purchased frozen with breadcrumb coating, cooked, no added fat	1009	1.19999999999999996	18.6000000000000014	10.5999999999999996
929	Chicken, breast, flesh, raw	438	0	22.3000000000000007	1.60000000000000009
930	Chicken, breast, flesh, skin & fat, baked, roasted, fried, grilled or BBQd, fat not further defined	996	0	26.3000000000000007	14.8000000000000007
931	Chicken, breast, flesh, skin & fat, baked, roasted, fried, grilled or BBQd, no added fat	781	0	27.8999999999999986	8.30000000000000071
932	Chicken, breast, flesh, skin & fat, boiled, casseroled, microwaved, poached, steamed or stewed, with or without added fat	728	0	25.8999999999999986	7.79999999999999982
933	Chicken, breast, flesh, skin & fat, coated, baked, roasted, fried, grilled or BBQd, fat not further defined	1181	0.800000000000000044	24	14.0999999999999996
934	Chicken, breast, flesh, skin & fat, coated, fast food chain, fried, undefined fat	1079	0.5	20.6000000000000014	15.8000000000000007
935	Chicken, breast, flesh, skin & fat, raw	688	0	20.1000000000000014	9.40000000000000036
936	Chicken, breast, flesh, smoked, no added fat	573	0	29.1000000000000014	2.10000000000000009
937	Chicken, breast strip, coated, fast food chain, fried, fat not further defined	963	0.800000000000000044	21.5	10
938	Chicken, drumstick, flesh, baked, roasted, fried, grilled or BBQd, fat not further defined	740	0	24.1999999999999993	8.90000000000000036
939	Chicken, drumstick, flesh, baked, roasted, fried, grilled or BBQd, no added fat	830	0.400000000000000022	29.8999999999999986	8.5
940	Chicken, drumstick, flesh, boiled, casseroled, microwaved, poached, steamed or stewed, fat not further defined	793	0	25.8999999999999986	9.5
941	Chicken, drumstick, flesh, boiled, casseroled, microwaved, poached, steamed or stewed, no added fat	730	0	28.6000000000000014	6.59999999999999964
942	Chicken, drumstick, flesh, coated, cooked, fat not further defined	975	0.800000000000000044	22.3000000000000007	9.30000000000000071
943	Chicken, drumstick, flesh, coated, cooked, no added fat	904	0.800000000000000044	22.6999999999999993	6.79999999999999982
944	Chicken, drumstick, flesh, raw	492	0	18.5	4.79999999999999982
945	Chicken, drumstick, flesh, skin & fat, baked, roasted, fried, grilled or BBQd, fat not further defined	940	0	23	14.8000000000000007
946	Chicken, drumstick, flesh, skin & fat, baked, roasted, fried, grilled or BBQd, no added fat	977	0.299999999999999989	28.6000000000000014	13.0999999999999996
947	Chicken, drumstick, flesh, skin & fat, boiled, casseroled, microwaved, poached, steamed or stewed, with or without added fat	898	0	26.8000000000000007	12
948	Chicken, drumstick, flesh, skin & fat, coated, cooked, fat not further defined	1136	0.800000000000000044	21.3000000000000007	14.0999999999999996
949	Chicken, drumstick, flesh, skin & fat, coated, cooked, no added fat	1067	0.800000000000000044	21.6999999999999993	11.6999999999999993
950	Chicken, drumstick, flesh, skin & fat, coated, fast food chain, fried, undefined fat	1082	0.599999999999999978	18.1000000000000014	16.1999999999999993
951	Chicken, drumstick, flesh, skin & fat, marinated, baked, roasted, fried, grilled or BBQd, no added fat	864	4.20000000000000018	21.3000000000000007	11.4000000000000004
952	Chicken, drumstick, flesh, skin & fat, raw	645	0	17.6000000000000014	9.30000000000000071
953	Chicken, feet, boiled, casseroled, microwaved, poached or steamed, with or without added fat	870	0	19.3999999999999986	14.5999999999999996
954	Chicken, fillet or kebab, coated, cooked, fat not further defined, no added marinade	1131	0.800000000000000044	22.8999999999999986	13.3000000000000007
955	Chicken, fillet or kebab, flesh, baked, roasted, fried, stir-fried, grilled or BBQd, butter or dairy blend, no added marinade	689	0	26.6000000000000014	6.40000000000000036
956	Chicken, fillet or kebab, flesh, baked, roasted, fried, stir-fried, grilled or BBQd, canola oil, no added marinade	709	0	26.5	7
957	Chicken, fillet or kebab, flesh, baked, roasted, fried, stir-fried, grilled or BBQd, fat not further defined, no added marinade	707	0	26.5	6.90000000000000036
958	Chicken, fillet or kebab, flesh, baked, roasted, fried, stir-fried, grilled or BBQd, no added fat, no added marinade	623	0	27.1000000000000014	4.40000000000000036
959	Chicken, fillet or kebab, flesh, baked, roasted, fried, stir-fried, grilled or BBQd, olive oil, no added marinade	709	0	26.5	7
960	Chicken, fillet or kebab, flesh, baked, roasted, fried, stir-fried, grilled or BBQd, other oil, no added marinade	709	0	26.5	7
961	Chicken, fillet or kebab, flesh, boiled, steamed, poached, stewed, casseroled or microwaved, with or without added fat, no added marinade	713	0	28.6999999999999993	6.09999999999999964
962	Chicken, fillet or kebab, flesh, coated, cooked, no added fat, no added marinade	877	0.800000000000000044	24.6000000000000014	5.20000000000000018
963	Chicken, fillet or kebab, flesh, raw	467	0	20.3000000000000007	3.29999999999999982
964	Chicken, fillet or kebab, flesh, skin & fat, baked, roasted, fried, stir-fried, grilled or BBQd, fat not further defined, no added marinade	1160	0	23.1999999999999993	20.6999999999999993
965	Chicken, fillet or kebab, flesh, skin & fat, baked, roasted, fried, stir-fried, grilled or BBQd, no added fat, no added marinade	1085	0	23.6999999999999993	18.3999999999999986
966	Chicken, fillet or kebab, flesh, skin & fat, boiled, casseroled, microwaved, poached, steamed or stewed, with or without added fat, no added marinade	1203	0	25.1000000000000014	21
967	Chicken, fillet or kebab, flesh, skin & fat, raw	814	0	17.8000000000000007	13.8000000000000007
968	Chicken, fillet or kebab, raw, not further defined	640	0	19	8.59999999999999964
969	Chicken, finger or chip, purchased frozen, baked, roasted, fried, grilled or BBQd, no added fat	1117	0.699999999999999956	12.8000000000000007	14.1999999999999993
970	Chicken, flesh, baked, roasted, fried, grilled or BBQd, fat not further defined	690	0	27.6000000000000014	6
971	Chicken, flesh, baked, roasted, fried, grilled or BBQd, no added fat	605	0	28.1999999999999993	3.39999999999999991
972	Chicken, flesh, boiled, steamed, poached, stewed, casseroled or microwaved, with or without added fat	694	0	29.8999999999999986	5
973	Chicken, flesh, coated, baked, roasted, fried, grilled or BBQd, no added fat	863	0.800000000000000044	25.5	4.5
974	Chicken, flesh, raw	454	0	21.1000000000000014	2.60000000000000009
975	Chicken, for use in kebabs, cooked	1089	0.900000000000000022	20.6999999999999993	19.3000000000000007
976	Chicken, kiev, homemade from basic ingredients, baked, roasted, fried, grilled or BBQd, fat not further defined	1347	0.800000000000000044	22.1000000000000014	19.6999999999999993
977	Chicken, kiev, homemade from basic ingredients, baked, roasted, fried, grilled or BBQd, no added fat	1271	0.800000000000000044	22.6000000000000014	17.3000000000000007
978	Chicken, kiev, purchased frozen with breadcrumb coating, baked, roasted, fried, grilled or BBQd, cooked with or without added fat	1350	1	16.1999999999999993	20.5
979	Chicken, liver, fried, baked, grilled or BBQd, added fat	657	0	24.5	6.5
980	Chicken, liver, raw	466	0	16.8999999999999986	4.79999999999999982
981	Chicken, maryland, flesh, baked, roasted, fried, grilled or BBQd, fat not further defined	743	0	24	9
982	Chicken, maryland, flesh, baked, roasted, fried, grilled or BBQd, no added fat	659	0	24.5	6.59999999999999964
983	Chicken, maryland, flesh, coated, cooked, fat not further defined	969	0.800000000000000044	22	9.5
984	Chicken, maryland, flesh, coated, cooked, no added fat	899	0.800000000000000044	22.3999999999999986	7.09999999999999964
985	Chicken, maryland, flesh, raw	494	0	18.3999999999999986	4.90000000000000036
986	Chicken, maryland, flesh, skin & fat, baked, roasted, fried, grilled or BBQd, fat not further defined	1171	0	21.3000000000000007	21.8000000000000007
987	Chicken, maryland, flesh, skin & fat, baked, roasted, fried, grilled or BBQd, no added fat	1096	0	21.6999999999999993	19.6000000000000014
988	Chicken, maryland, flesh, skin & fat, boiled, casseroled, microwaved, poached, steamed or stewed, with or without added fat	1214	0	23.1000000000000014	22.1999999999999993
989	Chicken, maryland, flesh, skin & fat, coated, cooked, no added fat	1255	0.800000000000000044	20.3000000000000007	17.3999999999999986
990	Chicken, maryland, flesh, skin & fat, raw	822	0	16.3000000000000007	14.6999999999999993
991	Chicken, mince, baked, roasted, fried, stir-fried, grilled or BBQd, fat not further defined	838	0.100000000000000006	25.1000000000000014	10.5
992	Chicken, mince, baked, roasted, fried, stir-fried, grilled or BBQd, no added fat	756	0.100000000000000006	25.6000000000000014	8
993	Chicken, mince, raw	567	0.100000000000000006	19.1999999999999993	6
994	Chicken, nugget, purchased from independent & chain takeaway outlets, fried, undefined oil	1106	0.800000000000000044	12.8000000000000007	15.8000000000000007
995	Chicken, nugget, purchased from takeaway chain, fried, canola oil	1098	0.800000000000000044	12.8000000000000007	15.5999999999999996
996	Chicken, nugget, purchased from takeaway chain, grilled	818	0.900000000000000022	14.8000000000000007	5.90000000000000036
997	Chicken, nugget, purchased frozen, baked, roasted, fried, grilled or BBQd, with or without added fat	1172	0.800000000000000044	12.8000000000000007	17.6000000000000014
998	Chicken piece, flesh, skin & fat, coated, fast food outlet, fried, undefined oil	1211	0.599999999999999978	17.8999999999999986	20
999	Chicken, processed luncheon meat, low or reduced fat	472	0.200000000000000011	19.3999999999999986	1.19999999999999996
1000	Chicken, processed luncheon meat, not further defined	676	0.599999999999999978	16.3999999999999986	7.79999999999999982
1001	Chicken, processed luncheon meat, regular fat	880	0.900000000000000022	13.5	14.3000000000000007
1002	Chicken, schnitzel, breadcrumb coating, baked, roasted, fried, grilled or BBQd, butter, dairy blend or margarine	1073	0.5	22.5	12.6999999999999993
1003	Chicken, schnitzel, breadcrumb coating, baked, roasted, fried, grilled or BBQd, canola oil	1126	0.5	22.5	14.1999999999999993
1004	Chicken, schnitzel, breadcrumb coating, baked, roasted, fried, grilled or BBQd, fat not further defined	1121	0.5	22.5	14.0999999999999996
1005	Chicken, schnitzel, breadcrumb coating, baked, roasted, fried, grilled or BBQd, no added fat	911	0.599999999999999978	23.6999999999999993	7.5
1006	Chicken, schnitzel, breadcrumb coating, baked, roasted, fried, grilled or BBQd, olive oil	1126	0.5	22.5	14.1999999999999993
1401	Custard powder, dry mix, commercial	1475	1.19999999999999996	0.400000000000000022	0.100000000000000006
1007	Chicken, schnitzel, breadcrumb coating, baked, roasted, fried, grilled or BBQd, other oil	1126	0.5	22.5	14.1999999999999993
1008	Chicken, separable fat, composite, baked or roasted, no added fat	1891	0	9.80000000000000071	46.6000000000000014
1009	Chicken, separable fat, composite, boiled, casseroled, microwaved, poached, steamed or stewed, no added fat	1862	0	14.1999999999999993	43.7999999999999972
1010	Chicken, separable fat, composite, raw	2392	0	5.09999999999999964	62.2999999999999972
1011	Chicken, skin, composite, baked or roasted, no added fat	1818	0	22.3000000000000007	38.8999999999999986
1012	Chicken, skin, composite, boiled, casseroled, microwaved, poached, steamed or stewed, no added fat	1742	0	18	38.7999999999999972
1013	Chicken, skin, composite, raw	1515	0	12.6999999999999993	35.1000000000000014
1014	Chicken, thigh fillets, flesh & some fat, raw	608	0	17.5	8.40000000000000036
1015	Chicken, thigh, flesh, baked, roasted, fried, grilled or BBQd, fat not further defined	745	0	23.8999999999999986	9.19999999999999929
1016	Chicken, thigh, flesh, baked, roasted, fried, grilled or BBQd, no added fat	733	0	24.1999999999999993	8.69999999999999929
1017	Chicken, thigh, flesh, boiled, casseroled, microwaved, poached, steamed or stewed, with or without added fat	810	0	26.3000000000000007	9.80000000000000071
1018	Chicken, thigh, flesh, coated, baked, roasted, fried, grilled or BBQd, fat not further defined	1021	0.800000000000000044	21.8000000000000007	10.8000000000000007
1019	Chicken, thigh, flesh, coated, baked, roasted, fried, grilled or BBQd, no added fat	908	0.800000000000000044	22.5	7.09999999999999964
1020	Chicken, thigh, flesh, raw	496	0	18.3000000000000007	5
1021	Chicken, thigh, flesh, skin & fat, baked, roasted, fried, grilled or BBQd, fat not further defined	1325	0	20.1999999999999993	26.5
1022	Chicken, thigh, flesh, skin & fat, baked, roasted, fried, grilled or BBQd, no added fat	940	0	23.3000000000000007	14.6999999999999993
1023	Chicken, thigh, flesh, skin & fat, boiled, casseroled, microwaved, poached, steamed or stewed, with or without added fat	1023	0	24.3000000000000007	16.5
1024	Chicken, thigh, flesh, skin & fat, coated, fast food chain, fried, undefined fat	1353	0.599999999999999978	16.1999999999999993	24.3999999999999986
1025	Chicken, thigh, flesh, skin & fat, raw	940	0	15.5	18.3000000000000007
1026	Chicken, whole, flesh, skin & fat, baked, roasted, fried, grilled or BBQd, no added fat	1037	0	23.6999999999999993	17.1000000000000014
1027	Chicken, whole, flesh, skin & fat, coated, baked, roasted, fried, grilled or BBQd, no added fat	1208	0.800000000000000044	21.8999999999999986	15.4000000000000004
1028	Chicken, whole, flesh, skin & fat, raw	778	0	17.8000000000000007	12.8000000000000007
1029	Chicken, whole, lean flesh, baked, roasted, fried, grilled or BBQd, no added fat	626	0	26.8000000000000007	4.59999999999999964
1030	Chicken, wing, flesh, baked, roasted, fried, grilled or BBQd, fat not further defined	711	0	24.3999999999999986	8
1031	Chicken, wing, flesh, baked, roasted, fried, grilled or BBQd, no added fat	810	0	30.8999999999999986	7.70000000000000018
1032	Chicken, wing, flesh, boiled, casseroled, microwaved, poached, steamed or stewed, with or without added fat	800	0	27.8999999999999986	8.80000000000000071
1033	Chicken, wing, flesh, coated, baked, roasted, fried, grilled or BBQd, no added fat	880	0.800000000000000044	22.8999999999999986	6.09999999999999964
1034	Chicken, wing, flesh, raw	470	0	18.6999999999999993	4.09999999999999964
1035	Chicken, wing, flesh, skin & fat, baked, roasted, fried, grilled or BBQd, fat not further defined	1295	0	21	25.3999999999999986
1036	Chicken, wing, flesh, skin & fat, baked, roasted, fried, grilled or BBQd, no added fat	1097	0	28.1999999999999993	16.6999999999999993
1037	Chicken, wing, flesh, skin & fat, boiled, casseroled, microwaved, poached, steamed or stewed, with or without added fat	1090	0	24.8000000000000007	18
1038	Chicken, wing, flesh, skin & fat, coated, baked, roasted, fried, grilled or BBQd, fat not further defined	1423	0.800000000000000044	19.6999999999999993	22.6000000000000014
1039	Chicken, wing, flesh, skin & fat, coated, baked, roasted, fried, grilled or BBQd, no added fat	1357	0.800000000000000044	20.1000000000000014	20.3000000000000007
1040	Chicken, wing, flesh, skin & fat, coated, fast food chain, fried, undefined fat	1332	0.599999999999999978	16.8000000000000007	23.6000000000000014
1041	Chicken, wing, flesh, skin & fat, purchased frozen, breadcrumb coating, baked, roasted, fried, grilled or BBQd, with or without added fat	1388	0.599999999999999978	19.6000000000000014	24.1000000000000014
1042	Chicken, wing, flesh, skin & fat, raw	917	0	16.1000000000000014	17.3999999999999986
1043	Chickpea, canned, drained	466	0.599999999999999978	6.29999999999999982	2.10000000000000009
1044	Chickpea, dried, boiled, microwaved or steamed, drained	466	0.599999999999999978	6.29999999999999982	2.10000000000000009
1045	Chicory, boiled, microwaved or steamed, drained	79	0.800000000000000044	2.10000000000000009	0.200000000000000011
1046	Chicory, raw	67	0.699999999999999956	1.80000000000000004	0.200000000000000011
1047	Chilli (chili), baked, roasted, fried, stir-fried, grilled or BBQd, with or without fat	211	2.89999999999999991	2.29999999999999982	0.400000000000000022
1048	Chilli (chili), boiled, microwaved or steamed, drained, with or without fat	200	2.70000000000000018	2.20000000000000018	0.400000000000000022
1049	Chilli (chili), dried, ground	1573	10.4000000000000004	14.0999999999999996	16.8000000000000007
1050	Chilli (chili), green, cooked with or without added fat	201	1.10000000000000009	3.10000000000000009	0.299999999999999989
1051	Chilli (chili), green, pickled	193	1.10000000000000009	3	0.299999999999999989
1052	Chilli (chili), green, raw	181	1	2.79999999999999982	0.299999999999999989
1053	Chilli (chili) powder	1441	10.0999999999999996	12.3000000000000007	16.8000000000000007
1054	Chilli (chili), raw, not further defined	190	2.60000000000000009	2.10000000000000009	0.400000000000000022
1055	Chilli (chili), red, cooked with or without added fat	222	4.70000000000000018	1.60000000000000009	0.400000000000000022
1056	Chilli (chili), red, raw	200	4.20000000000000018	1.39999999999999991	0.400000000000000022
1057	Chives, raw	120	2.60000000000000009	1.5	0.299999999999999989
1058	Chocolate glaze, commercial	2167	51.2000000000000028	3.79999999999999982	29.6000000000000014
1059	Chocolate, liqueur-filled	1815	56.3999999999999986	4.09999999999999964	19.8000000000000007
1060	Chocolate, milk	2206	54.6000000000000014	7.59999999999999964	30.5
1061	Chocolate, milk, caramel filled	1990	53.6000000000000014	6	24.6999999999999993
1062	Chocolate, milk, fondant filled	1990	53.6000000000000014	6	24.6999999999999993
1063	Chocolate, milk & white	2214	54.6000000000000014	7.40000000000000036	31.8000000000000007
1064	Chocolate, milk, with coconut	2320	45	7.40000000000000036	37.5
1065	Chocolate, milk, with dried fruit & nuts	2112	53.2000000000000028	7.90000000000000036	28.1999999999999993
1066	Chocolate, milk, with hazelnut paste	2240	49.7000000000000028	8.19999999999999929	33.2999999999999972
1067	Chocolate, milk, with nuts	2350	39.5	10	39.7000000000000028
1068	Chocolate, milk, with toffee or nougat pieces	2165	53.6000000000000014	7.79999999999999982	29.6999999999999993
1069	Chocolate, not further defined	2115	53.1000000000000014	6.5	28.3000000000000007
1070	Chocolate, plain, not further defined	2200	52.6000000000000014	6.79999999999999982	30.6000000000000014
1071	Chocolate, reduced sugar	2131	4.59999999999999964	6	34
1072	Chocolate, white	2223	54.6000000000000014	7.09999999999999964	33.2000000000000028
1073	Chocolate, white, with macadamias	2322	48.2999999999999972	7.40000000000000036	38.2999999999999972
1074	Choko, peeled, fresh or frozen, boiled, microwaved or steamed, drained	103	3.70000000000000018	0.599999999999999978	0.200000000000000011
1075	Choko, peeled, fresh or frozen, raw	87	3.10000000000000009	0.5	0.200000000000000011
1076	Chutney or relish, commercial	752	41.5	0.5	0.299999999999999989
1077	Chutney or relish, homemade	793	39.7999999999999972	0.800000000000000044	3.29999999999999982
1078	Cider, apple, alcoholic, draught style	186	4.40000000000000036	0	0
1079	Cider, apple, alcoholic, dry style	161	3.10000000000000009	0	0
1080	Cider, apple, alcoholic, not further defined	186	4.59999999999999964	0	0
1081	Cider, apple, alcoholic, sweet style	221	6.90000000000000036	0	0
1082	Cider, pear (perry), alcoholic	198	4	0	0
1083	Cinnamon, dried, ground	1026	13.8000000000000007	4.20000000000000018	2.70000000000000018
1084	Cloves, dried, ground	1536	2.70000000000000018	6	17.3000000000000007
1085	Coating, commercial, for fish & seafood, uncooked	659	0.400000000000000022	4.29999999999999982	3.20000000000000018
1086	Coating, homemade, for chicken & meat, uncooked	1421	3.10000000000000009	11.0999999999999996	6.5
1087	Coating, homemade, for fish & seafood, uncooked	1039	2.39999999999999991	8.5	4.59999999999999964
1088	Cocoa powder	1443	0.800000000000000044	16.1000000000000014	14.4000000000000004
1089	Coconut, cream, regular fat	789	3.5	1.5	18.8999999999999986
1090	Coconut, fresh, mature fruit, flesh	1290	3.10000000000000009	3.39999999999999991	30.1000000000000014
1091	Coconut, fresh, mature, water or juice	87	4.70000000000000018	0.5	0.100000000000000006
1092	Coconut, fresh, young or immature, flesh	353	4	1.60000000000000009	5.59999999999999964
1093	Coconut, fresh, young or immature, water or juice	109	6.59999999999999964	0.200000000000000011	0
1094	Coconut, grated & desiccated	2772	6.59999999999999964	6.59999999999999964	65.4000000000000057
1095	Coconut ice, homemade	2020	52.8999999999999986	2.89999999999999991	29.5
1096	Coconut, milk, canned, not further defined	523	1.5	1.30000000000000004	12.8000000000000007
1097	Coconut, milk, canned, reduced fat	291	0.900000000000000022	0.599999999999999978	7.09999999999999964
1098	Coconut, milk, canned, regular fat	646	1.80000000000000004	1.60000000000000009	15.8000000000000007
1099	Coconut, milk, dried, powder	2824	7.20000000000000018	8.09999999999999964	66.2000000000000028
1100	Cod, Atlantic, dried, salted	1157	0	62.7999999999999972	2.39999999999999991
1101	Cod, Atlantic, flesh, raw	328	0	17.8000000000000007	0.699999999999999956
1102	Cod or hake, baked, roasted, fried, grilled or BBQd, no added fat	431	0	23.5	0.800000000000000044
1103	Cod or hake, baked, roasted, grilled, BBQd, fried or deep fried, fat not further defined	658	0	22.3999999999999986	7.5
1104	Cod or hake, boiled, microwaved, steamed or poached, with or without added fat	394	0	20.3000000000000007	1.30000000000000004
1105	Cod or hake, coated, baked, roasted, grilled, BBQd, fried or deep fried, fat not further defined	749	0.400000000000000022	18.5	8.69999999999999929
1106	Cod or hake, coated, packaged frozen, baked, roasted, fried, grilled or BBQd, with or without added fat	927	0.900000000000000022	17.8999999999999986	10.1999999999999993
1107	Cod or hake, coated, takeaway outlet, deep fried	1007	0.200000000000000011	14.1999999999999993	16.3000000000000007
1108	Cod or hake, raw	314	0	17.1999999999999993	0.599999999999999978
1109	Cod or hake, smoked, boiled, microwaved, steamed or poached, no added fat	397	0	20.1000000000000014	1.5
1110	Cod, Pacific, flesh, raw	275	0	15.3000000000000007	0.400000000000000022
1111	Cod, smoked, raw	356	0	18.8000000000000007	1
1112	Coffee, black, from instant coffee powder, decaffeinated, without milk	5	0	0.100000000000000006	0
1113	Coffee, black, from instant coffee powder, without milk	6	0	0.100000000000000006	0
1114	Coffee, cappuccino, flat white or latte, from ground coffee beans, decaffeinated, with reduced fat cows milk	160	4.20000000000000018	3	1.10000000000000009
1115	Coffee, cappuccino, flat white or latte, from ground coffee beans, decaffeinated, with regular fat cows milk	227	4.79999999999999982	2.70000000000000018	2.79999999999999982
1116	Coffee, cappuccino, flat white or latte, from ground coffee beans, decaffeinated, with skim cows milk	115	4	2.70000000000000018	0.100000000000000006
1117	Coffee, cappuccino, flat white or latte, from ground coffee beans, decaffeinated, with soy milk not further defined	172	1.89999999999999991	2.60000000000000009	1.5
1118	Coffee, cappuccino, flat white or latte, from ground coffee beans, double shot, with cows milk not further defined	131	3.20000000000000018	1.89999999999999991	1.30000000000000004
1119	Coffee, cappuccino, flat white or latte, from ground coffee beans, double shot, with soy milk not further defined	134	1.39999999999999991	2	1.19999999999999996
1120	Coffee, cappuccino, flat white or latte, from ground coffee beans, half shot, with reduced fat cows milk	177	4.59999999999999964	3.29999999999999982	1.19999999999999996
1121	Coffee, cappuccino, flat white or latte, from ground coffee beans, half shot, with regular fat cows milk	257	5.59999999999999964	3	3.10000000000000009
1122	Coffee, cappuccino, flat white or latte, from ground coffee beans, half shot, with skim cows milk	129	4.29999999999999982	3.20000000000000018	0.100000000000000006
1123	Coffee, cappuccino, flat white or latte, from ground coffee beans, half shot, with soy milk not further defined	229	2.79999999999999982	3.39999999999999991	2.5
1124	Coffee, cappuccino, from ground coffee beans, double shot, with reduced fat cows milk	113	3	2	0.800000000000000044
1125	Coffee, cappuccino, from ground coffee beans, double shot, with regular fat cows milk	156	3.39999999999999991	1.80000000000000004	1.89999999999999991
1126	Coffee, cappuccino, from ground coffee beans, double shot, with skim cows milk	84	2.79999999999999982	1.89999999999999991	0.200000000000000011
1127	Coffee, cappuccino, from ground coffee beans, with cows milk not further defined	184	4.5	2.70000000000000018	1.80000000000000004
1128	Coffee, cappuccino, from ground coffee beans, with reduced fat cows milk	158	4.20000000000000018	2.89999999999999991	1.10000000000000009
1129	Coffee, cappuccino, from ground coffee beans, with reduced fat soy milk	130	1.80000000000000004	1.89999999999999991	0.800000000000000044
1130	Coffee, cappuccino, from ground coffee beans, with regular fat cows milk	221	4.79999999999999982	2.60000000000000009	2.60000000000000009
1131	Coffee, cappuccino, from ground coffee beans, with regular fat soy milk	198	2.39999999999999991	2.89999999999999991	2.10000000000000009
1132	Coffee, cappuccino, from ground coffee beans, with rice milk	202	3.20000000000000018	0.299999999999999989	0.800000000000000044
1133	Coffee, cappuccino, from ground coffee beans, with skim cows milk	116	4	2.70000000000000018	0.200000000000000011
1134	Coffee & chicory essence, concentrate	893	51.5	1.60000000000000009	0.200000000000000011
1135	Coffee, espresso style, decaffeinated, without milk	9	0	0.100000000000000006	0.200000000000000011
1136	Coffee, espresso style, without milk	9	0	0.100000000000000006	0.200000000000000011
1137	Coffee, flat white or latte, from ground coffee beans, double shot, with reduced fat cows milk	124	3.20000000000000018	2.29999999999999982	0.900000000000000022
1138	Coffee, flat white or latte, from ground coffee beans, double shot, with regular fat cows milk	176	3.60000000000000009	2.10000000000000009	2.20000000000000018
1139	Coffee, flat white or latte, from ground coffee beans, double shot, with skim cows milk	90	2.89999999999999991	2.20000000000000018	0.100000000000000006
1140	Coffee, flat white or latte, from ground coffee beans, with cows milk not further defined	189	4.40000000000000036	2.79999999999999982	1.80000000000000004
1141	Coffee, flat white or latte, from ground coffee beans, with reduced fat cows milk	161	4.20000000000000018	3	1.10000000000000009
1142	Coffee, flat white or latte, from ground coffee beans, with reduced fat soy milk	130	1.5	2	0.800000000000000044
1143	Coffee, flat white or latte, from ground coffee beans, with regular fat cows milk	228	4.79999999999999982	2.70000000000000018	2.79999999999999982
1144	Coffee, flat white or latte, from ground coffee beans, with regular fat soy milk	203	2.20000000000000018	3.10000000000000009	2.20000000000000018
1145	Coffee, flat white or latte, from ground coffee beans, with skim cows milk	116	3.89999999999999991	2.89999999999999991	0.100000000000000006
1146	Coffee, from ground coffee beans, with regular fat coffee whitener	54	1.39999999999999991	0.200000000000000011	0.800000000000000044
1147	Coffee, from instant or ground beans, Turkish, no milk, added sugar	105	6	0.100000000000000006	0.200000000000000011
1148	Coffee, instant, dry powder or granules	692	1.19999999999999996	16.1000000000000014	0.599999999999999978
1149	Coffee, instant, dry powder or granules, decaffeinated	618	0.100000000000000006	16.1000000000000014	0.200000000000000011
1150	Coffee, long black style, from ground beans, decaffeinated, without milk	4	0.100000000000000006	0.100000000000000006	0
1151	Coffee, long black style, from ground coffee beans, double shot, without milk	3	0	0	0.100000000000000006
1152	Coffee, long black style, from ground coffee beans, half shot, without milk	1	0	0	0
1153	Coffee, long black style, from ground coffee beans, without milk	4	0.100000000000000006	0.100000000000000006	0
1154	Coffee, macchiato, from ground coffee beans, decaffeinated, with reduced fat cows milk	36	0.900000000000000022	0.699999999999999956	0.200000000000000011
1155	Coffee, macchiato, from ground coffee beans, decaffeinated, with regular fat cows milk	50	1.10000000000000009	0.599999999999999978	0.599999999999999978
1156	Coffee, macchiato, from ground coffee beans, with cows milk not further defined	46	0.900000000000000022	0.699999999999999956	0.5
1157	Coffee, macchiato, from ground coffee beans, with reduced fat cows milk	40	0.900000000000000022	0.699999999999999956	0.400000000000000022
1158	Coffee, macchiato, from ground coffee beans, with regular fat cows milk	54	1	0.699999999999999956	0.699999999999999956
1159	Coffee, macchiato, from ground coffee beans, with skim cows milk	31	0.800000000000000044	0.699999999999999956	0.200000000000000011
1160	Coffee, macchiato, from ground coffee beans, with soy milk not further defined	43	0.400000000000000022	0.599999999999999978	0.5
1161	Coffee & milk concentrate	1243	49.6000000000000014	8.59999999999999964	6.90000000000000036
1162	Coffee mix, with beverage whitener & intense sweetener, dry powder	1918	33.5	22.3999999999999986	24.6999999999999993
1163	Coffee mix, with beverage whitener & sugar, decaffeinated, dry powder	1915	38.2999999999999972	8.40000000000000036	29.1999999999999993
1164	Coffee mix, with beverage whitener & sugar, dry powder	1915	38.2999999999999972	8.40000000000000036	29.1999999999999993
1165	Coffee, mocha, from ground coffee beans, decaffeinated, with reduced fat cows milk	234	8	3.20000000000000018	1.30000000000000004
1166	Coffee, mocha, from ground coffee beans, decaffeinated, with regular fat cows milk	298	8.59999999999999964	2.89999999999999991	2.89999999999999991
1167	Coffee, mocha, from ground coffee beans, double shot, with cows milk not further defined	221	7.29999999999999982	2.39999999999999991	1.60000000000000009
1168	Coffee, mocha, from ground coffee beans, with cows milk not further defined	262	8.30000000000000071	3	2
1169	Coffee, mocha, from ground coffee beans, with reduced fat cows milk	235	8	3.20000000000000018	1.30000000000000004
1170	Coffee, mocha, from ground coffee beans, with regular fat cows milk	299	8.59999999999999964	2.89999999999999991	2.89999999999999991
1171	Coffee, mocha, from ground coffee beans, with skim cows milk	193	7.70000000000000018	3	0.400000000000000022
1172	Coffee, mocha, from ground coffee beans, with soy milk not further defined	247	5.90000000000000036	2.79999999999999982	1.80000000000000004
1173	Coffee, not further defined	47	1	0.699999999999999956	0.400000000000000022
1174	Coffee, prepared from coffee & milk concentrate, no added milk	124	5	0.900000000000000022	0.699999999999999956
1175	Coffee, prepared from coffee mix, not further defined, no added milk	114	2.20000000000000018	0.800000000000000044	1.60000000000000009
1176	Coffee, prepared from coffee mix with intense sweetener & whitener, no added milk	156	2.70000000000000018	1.80000000000000004	2
1177	Coffee, prepared from coffee mix with sugar & whitener, no added milk	96	1.89999999999999991	0.400000000000000022	1.5
1178	Coffee, prepared from coffee substitute powder & water, no added milk	46	0.200000000000000011	0.100000000000000006	0
1179	Coffee, prepared from decaffeinated coffee mix with sugar & whitener, no added milk	96	1.89999999999999991	0.400000000000000022	1.5
1180	Coffee substitute, cereal beverage, dry powder or granules	1523	7.70000000000000018	4.29999999999999982	1.10000000000000009
1181	Coffee, white, from instant coffee powder, decaffeinated, made up with cows milk not further defined	217	5	3.29999999999999982	2.10000000000000009
1182	Coffee, white, from instant coffee powder, made up with cows milk not further defined	218	5	3.29999999999999982	2.10000000000000009
1183	Coffee, white, from instant coffee powder, made up with regular fat cows milk	263	5.40000000000000036	3.20000000000000018	3.10000000000000009
1184	Coffee whitener, dry powder	2274	54.8999999999999986	4.79999999999999982	35.5
1185	Cointreau	1299	24	0	0
1186	Cone, for ice cream, not further defined	1541	7	7.59999999999999964	3.39999999999999991
1187	Cone, wafer style, for ice cream	1474	0.299999999999999989	7.90000000000000036	2.29999999999999982
1188	Cone, waffle style, for ice cream	1731	26.3000000000000007	6.79999999999999982	6.40000000000000036
1189	Cordial, 25% citrus fruit juice, intense sweetened or diet, recommended dilution	6	0.200000000000000011	0	0
1190	Cordial, 25% citrus fruit juice, regular, recommended dilution	142	8.69999999999999929	0	0
1191	Cordial, 25% non-citrus fruit juice, regular, recommended dilution	142	8.69999999999999929	0	0
1192	Cordial, 40% citrus fruit juice, regular, recommended dilution	154	9.40000000000000036	0	0
1193	Cordial, 40% non-citrus fruit juice, regular, recommended dilution	142	8.69999999999999929	0	0
1194	Cordial, apple & berry, intense sweetened or diet, recommended dilution	6	0.200000000000000011	0	0
1195	Cordial, apple & berry, regular, recommended dilution	142	8.69999999999999929	0	0
1196	Cordial, apple & berry, regular, stronger than recommended dilution	175	10.6999999999999993	0	0
1197	Cordial, apple & berry, regular, weaker than recommended dilution	104	6.40000000000000036	0	0
1198	Cordial base, 25% citrus fruit juice (orange & lemon), regular	606	37.2999999999999972	0	0
1199	Cordial base, 25% citrus fruit juice (orange or lemon), intense sweetened or diet	28	1.19999999999999996	0	0
1200	Cordial base, 25% non-citrus fruit juice (apple & berry), regular	606	37.2999999999999972	0	0
1201	Cordial base, 40% citrus fruit juice (orange, lemon or lime), regular	659	40.2000000000000028	0.200000000000000011	0
1202	Cordial base, 40% non-citrus fruit juice (apple & berry), regular	608	37.2999999999999972	0.100000000000000006	0
1203	Cordial base, apple & berry, intense sweetened or diet	28	1.19999999999999996	0	0
1204	Cordial base, apple & berry, regular	608	37.2999999999999972	0.100000000000000006	0
1205	Cordial base, blackcurrant juice, intense sweetened or diet	187	11	0.100000000000000006	0
1206	Cordial base, blackcurrant juice, regular	923	57	0.100000000000000006	0
1207	Cordial base, fruit cup or tropical, intense sweetened or diet	28	1.19999999999999996	0	0
1208	Cordial base, fruit cup or tropical, regular	606	37.2999999999999972	0	0
1209	Cordial base, ginger, regular	865	52.3999999999999986	0.200000000000000011	0.100000000000000006
1210	Cordial base, grenadine syrup	740	46.2000000000000028	0	0
1211	Cordial base, lemon, intense sweetened or diet	28	1.19999999999999996	0	0
1212	Cordial base, lemon, regular	648	39.6000000000000014	0.200000000000000011	0
1213	Cordial base, lime or green, intense sweetened or diet	23	1.19999999999999996	0.100000000000000006	0
1214	Cordial base, lime or green, regular	679	40.8999999999999986	0.100000000000000006	0
1215	Cordial base, orange or orange & mango, intense sweetened or diet	28	1.19999999999999996	0	0
1216	Cordial base, orange or orange & mango, regular	648	39.6000000000000014	0.200000000000000011	0
1217	Cordial, blackcurrant juice, intense sweetened or diet, recommended dilution	32	1.89999999999999991	0	0
1218	Cordial, blackcurrant juice, regular, recommended dilution	191	11.8000000000000007	0	0
1219	Cordial, blackcurrant juice, regular, stronger than recommended dilution	229	14.0999999999999996	0	0
1220	Cordial, blackcurrant juice, regular, weaker than recommended dilution	146	9	0	0
1221	Cordial, fruit cup or tropical, intense sweetened, recommended dilution	6	0.200000000000000011	0	0
1222	Cordial, fruit cup or tropical, regular, recommended dilution	142	8.69999999999999929	0	0
1223	Cordial, fruit cup or tropical, regular, stronger than recommended dilution	174	10.6999999999999993	0	0
1224	Cordial, fruit cup or tropical, regular, weaker than recommended dilution	103	6.40000000000000036	0	0
1225	Cordial, ginger, regular, recommended dilution	202	12.3000000000000007	0	0
1226	Cordial, lemon, intense sweetened or diet, recommended dilution	6	0.200000000000000011	0	0
1227	Cordial, lemon, regular, recommended dilution	152	9.30000000000000071	0	0
1228	Cordial, lemon, regular, weaker than recommended dilution	111	6.79999999999999982	0	0
1229	Cordial, lime or green, intense sweetened or diet, recommended dilution	5	0.200000000000000011	0	0
1230	Cordial, lime or green, regular, recommended dilution	159	9.59999999999999964	0	0
1231	Cordial, lime or green, regular, stronger than recommended dilution	196	11.8000000000000007	0	0
1232	Cordial, lime or green, regular, weaker than recommended dilution	116	7	0	0
1233	Cordial, orange or orange & mango, intense sweetened or diet, recommended dilution	6	0.200000000000000011	0	0
1234	Cordial, orange or orange & mango, regular, recommended dilution	152	9.30000000000000071	0	0
1235	Cordial, orange or orange & mango, regular, stronger than recommended dilution	187	11.4000000000000004	0	0
1236	Cordial, orange or orange & mango, regular, weaker than recommended dilution	111	6.79999999999999982	0	0
1237	Coriander, fresh, leaves & stems	167	2.5	3.10000000000000009	0.699999999999999956
1238	Coriander seed, dried, ground	1476	8.80000000000000071	13	19.8000000000000007
1239	Corn chips, cheese flavoured, salted	2083	1.30000000000000004	7.09999999999999964	27.3000000000000007
1240	Corn chips, not further defined	2068	1	7.09999999999999964	26.8000000000000007
1241	Corn chips, other flavours, salted	2083	1.30000000000000004	7.09999999999999964	27.3000000000000007
1242	Corn chips, plain, toasted, no added salt	2126	2.60000000000000009	7.20000000000000018	27.8999999999999986
1243	Corn chips, plain toasted, salted	2048	0.599999999999999978	7.20000000000000018	26.3000000000000007
1244	Corn chips, puffed, plain, salted	2267	3.20000000000000018	4.20000000000000018	31.8000000000000007
1245	Cornmeal (polenta), cooked in water & fat, no added salt	468	0.200000000000000011	2.60000000000000009	1.30000000000000004
1246	Cornmeal (polenta), cooked in water, no added salt	447	0.200000000000000011	2.60000000000000009	0.599999999999999978
1247	Cornmeal (polenta), uncooked	1406	0.599999999999999978	8.09999999999999964	2
1248	Couscous, cooked in water & fat, no added salt	700	1.39999999999999991	5.79999999999999982	1.60000000000000009
1249	Couscous, cooked in water, no added fat or salt	677	1.5	6.09999999999999964	0.100000000000000006
1250	Couscous, homemade, cooked, with roast vegetables	587	2.60000000000000009	4.09999999999999964	4.09999999999999964
1251	Couscous, homemade, cooked with roast vegetables & meat	698	2.20000000000000018	10.1999999999999993	6.29999999999999982
1252	Couscous, uncooked	1523	3.39999999999999991	13.8000000000000007	0.200000000000000011
1253	Crab, flesh, coated, fried or deep fried, fat not further defined	684	0.400000000000000022	15.6999999999999993	8.30000000000000071
1254	Crab, flesh, cooked, fat not further defined	307	0	14.6999999999999993	1.5
1255	Crab, flesh, purchased steamed, poached or boiled	274	0	14.9000000000000004	0.599999999999999978
1256	Crabmeat, canned in brine, undrained	225	1.10000000000000009	11.0999999999999996	0.5
1257	Cracker, with cheddar cheese	1589	1.30000000000000004	20.1000000000000014	24.3000000000000007
1258	Cracker, with cheese not further defined	1599	1	18.3999999999999986	24.8999999999999986
1259	Cranberry, dried, sweetened	1137	65	0.100000000000000006	1.39999999999999991
1260	Cranberry, raw	134	4	0.400000000000000022	0.100000000000000006
1261	Cream, dairy, not further defined	1357	2.70000000000000018	2.10000000000000009	34.5
1262	Cream, dairy, sugar sweetened, whipped, commercial	1371	8.19999999999999929	2	32.5
1263	Cream, dairy, sugar sweetened, whipped, homemade	1364	5.40000000000000036	2	33.5
1264	Cream, for use in commercial bakery products, not further defined	1279	11	1.60000000000000009	28.6999999999999993
1265	Cream, imitation or mock (non-dairy)	1108	16.3000000000000007	1	21.8000000000000007
1266	Cream, imitation or mock (non-dairy), reduced fat	820	27	1	8
1267	Cream of tartar, dry powder	0	0	0	0
1268	Cream, pure, 35% fat	1401	2.39999999999999991	2	35.8999999999999986
1269	Cream, reduced fat (~25%), canned	1078	3.29999999999999982	2.89999999999999991	26.3999999999999986
1270	Cream, regular thickened, 35% fat	1409	2.39999999999999991	2	36.1000000000000014
1271	Cream, regular thickened, 35% fat, ultra high temperature treated	1409	2.39999999999999991	2	36.1000000000000014
1272	Cream, regular thickened, light (~18% fat)	835	4.79999999999999982	2	19.6000000000000014
1273	Cream, rich or double thick	1882	1.69999999999999996	1.60000000000000009	49.3999999999999986
1274	Cream, sour, extra light (>12% fat)	680	7	5.29999999999999982	12.5
1275	Cream, sour, light (~18% fat)	910	4.70000000000000018	3.89999999999999991	20.3000000000000007
1276	Cream, sour, not further defined	1222	3.10000000000000009	2.70000000000000018	30.1999999999999993
1277	Cream, sour, regular fat	1414	2	1.89999999999999991	36.2999999999999972
1278	Cream, whipped, aerosol, regular fat (~28%)	1227	5.20000000000000018	3.39999999999999991	29.3999999999999986
1279	Crepe or pancake, banana, homemade from basic ingredients	810	9	6.09999999999999964	4.79999999999999982
1280	Crepe or pancake, berry, homemade from basic ingredients	796	4	7	5.40000000000000036
1281	Crepe or pancake, buckwheat flour, homemade from basic ingredients	874	4	8	6.5
1282	Crepe or pancake, buttermilk, homemade from basic ingredients	892	3.60000000000000009	8.30000000000000071	6
1283	Crepe or pancake, chocolate, homemade from basic ingredients	892	7.29999999999999982	7.70000000000000018	7.29999999999999982
1284	Crepe or pancake, gluten free, commercial or homemade	890	4.09999999999999964	5.09999999999999964	6
1285	Crepe or pancake, plain, commercial	912	13.8000000000000007	5.70000000000000018	4.29999999999999982
1286	Crepe or pancake, plain, dry mix	1408	25.1999999999999993	9.30000000000000071	3.20000000000000018
1287	Crepe or pancake, plain, prepared from dry mix using water	838	15	5.5	1.89999999999999991
1288	Crepe or pancake, plain, white wheat flour, homemade from basic ingredients	886	3.60000000000000009	7.79999999999999982	6.20000000000000018
1289	Crepe or pancake, potato, homemade from basic ingredients	705	0.900000000000000022	5	10.6999999999999993
1290	Crepe or pancake, rice based, homemade from basic ingredients	665	0.5	5.90000000000000036	2.60000000000000009
1291	Crepe or pancake, savoury, filled with duck & vegetables, with sauce (Peking duck)	1033	4.09999999999999964	7.5	19
1292	Crepe or pancake, wholemeal wheat flour, commercial or homemade	894	4	8	7.09999999999999964
1293	Crepe or pancake, with butter & syrup, fast food chain	1286	20.5	6.20000000000000018	10
1294	Crepe or pancake, with savoury filling	811	2.5	11.9000000000000004	9.09999999999999964
1295	Crocodile, back leg, raw	455	0	22	2.20000000000000018
1296	Crocodile, cooked	748	0	37.1000000000000014	3.20000000000000018
1297	Crocodile, tail fillet, raw	442	0	22.5	1.60000000000000009
1298	Croissant, chocolate filled, commercial	1628	14.5	8.80000000000000071	21
1299	Croissant, commercial, plain	1500	5.09999999999999964	10	19.1000000000000014
1300	Crumble, apple, baked, homemade	817	20	2.39999999999999991	8.09999999999999964
1301	Crumble, apple & berry, baked, homemade	787	17.8999999999999986	2.5	8.19999999999999929
1302	Crumble, apple & rhubarb, baked, homemade	803	18.5	2.79999999999999982	8.19999999999999929
1303	Crumble, stone fruits, baked, homemade	856	15.6999999999999993	3.20000000000000018	9.69999999999999929
1304	Crumpet, from white flour, commercial	740	1.69999999999999996	4.5	0.699999999999999956
1305	Crumpet, from white flour, commercial, toasted	844	1.89999999999999991	5.09999999999999964	0.800000000000000044
1306	Crumpet, from wholemeal flour, commercial, toasted	830	1.5	5.59999999999999964	1.10000000000000009
1307	Cucumber, apple crystal, unpeeled, raw	42	0.900000000000000022	0.5	0.100000000000000006
1308	Cucumber, common, peeled, raw	50	2.10000000000000009	0.400000000000000022	0.100000000000000006
1309	Cucumber, common, unpeeled, raw	50	1.19999999999999996	0.800000000000000044	0.100000000000000006
1310	Cucumber, Lebanese, unpeeled, raw	56	2.10000000000000009	0.5	0.100000000000000006
1311	Cucumber, peeled or unpeeled, cooked, no added fat	61	1.69999999999999996	0.900000000000000022	0.100000000000000006
1312	Cucumber, peeled or unpeeled, raw, not further defined	51	1.5	0.699999999999999956	0.100000000000000006
1313	Cucumber, telegraph, unpeeled, raw	56	1.39999999999999991	1.19999999999999996	0.100000000000000006
1314	Cumin (cummin) seed, dried, ground	1915	2.29999999999999982	18.3999999999999986	25.8000000000000007
1315	Cumquat (kumquat), raw	266	9.40000000000000036	1.89999999999999991	0.900000000000000022
1316	Currant, dried	1167	63.2000000000000028	2.79999999999999982	0.5
1317	Curry, commercial, beef, coconut milk based sauce	701	2.10000000000000009	11.0999999999999996	12
1318	Curry, commercial, beef, tomato based sauce	638	2.39999999999999991	11.1999999999999993	9.5
1319	Curry, commercial, beef, vindaloo sauce	577	0	13.5999999999999996	8.90000000000000036
1320	Curry, commercial, chicken, dairy based sauce, Indian	855	2.60000000000000009	16.6999999999999993	13.8000000000000007
1321	Curry, commercial, chicken & vegetable, coconut milk sauce	640	1.69999999999999996	11	10.8000000000000007
1322	Curry, commercial, fish & vegetable, coconut milk sauce	588	1.69999999999999996	9.69999999999999929	10
1323	Curry, commercial, lamb, dairy based sauce	761	7.70000000000000018	15.1999999999999993	9.80000000000000071
1324	Curry, commercial, lamb & vegetable, dairy based sauce	879	2.89999999999999991	12.0999999999999996	15.4000000000000004
1325	Curry, commercial, legume (dhal)	534	0	15.1999999999999993	4.09999999999999964
1326	Curry, commercial, pork, coconut milk sauce	801	2	16.3000000000000007	12.4000000000000004
1327	Curry, commercial, potato & pea (aloo muttar)	480	0.200000000000000011	7	6.40000000000000036
1328	Curry, commercial, prawn & vegetable, coconut milk sauce, with rice	591	1.19999999999999996	6.90000000000000036	5
1329	Curry, commercial, prawn & vegetable, tomato based sauce	539	1.89999999999999991	9.80000000000000071	8.19999999999999929
1330	Curry, commercial, spinach & cheese (palak paneer)	819	0	10.9000000000000004	16.6000000000000014
1331	Curry, commercial, tofu & vegetable	678	1.5	8.90000000000000036	11.6999999999999993
1332	Curry, commercial, vegetable, cream based sauce	638	2.70000000000000018	2.79999999999999982	12.5
1333	Curry, homemade, beef, commercial simmer sauce, Indian style	682	3.89999999999999991	14.8000000000000007	8.69999999999999929
1334	Curry, homemade, beef, homemade sauce	579	0.900000000000000022	17.1000000000000014	6.59999999999999964
1335	Curry, homemade, beef & vegetable, commercial sauce	627	3.5	12.1999999999999993	8.09999999999999964
1336	Curry, homemade, beef & vegetable, commercial sauce, with rice or noodles	630	2.20000000000000018	8.59999999999999964	5
1337	Curry, homemade, beef & vegetable, homemade coconut milk based sauce	563	1.69999999999999996	10.5	8.90000000000000036
1338	Curry, homemade, beef & vegetable, homemade coconut milk based sauce, with rice or noodles	592	1.10000000000000009	7.59999999999999964	5.5
1339	Curry, homemade, beef & vegetable, homemade tomato based sauce	457	2.10000000000000009	10.6999999999999993	5.20000000000000018
1340	Curry, homemade, chicken, commercial sauce	699	3.89999999999999991	16.8000000000000007	8.19999999999999929
1341	Curry, homemade, chicken, commercial sauce, with rice or noodles	673	2.39999999999999991	11.4000000000000004	5.09999999999999964
1342	Curry, homemade, chicken, homemade coconut milk sauce	764	1.5	17.3000000000000007	11.6999999999999993
1343	Curry, homemade, chicken, homemade coconut milk sauce, with rice or noodles	712	1	11.6999999999999993	7.20000000000000018
1344	Curry, homemade, chicken, homemade sauce	657	1	20.6999999999999993	6.90000000000000036
1345	Curry, homemade, chicken & rice	752	2.20000000000000018	12.3000000000000007	4.79999999999999982
1346	Curry, homemade, chicken & vegetable, commercial sauce	652	3.5	13.8000000000000007	8.09999999999999964
1347	Curry, homemade, chicken & vegetable, commercial sauce, with rice or noodles	645	2.20000000000000018	9.59999999999999964	5
1348	Curry, homemade, chicken & vegetable, homemade coconut milk sauce	585	1.69999999999999996	11.8000000000000007	8.90000000000000036
1349	Curry, homemade, chicken & vegetable, homemade coconut milk sauce	596	1.69999999999999996	11.6999999999999993	8.90000000000000036
1350	Curry, homemade, chicken & vegetable, homemade coconut milk sauce, with rice or noodles	605	1.10000000000000009	8.40000000000000036	5.5
1351	Curry, homemade, chicken & vegetable, homemade dairy based sauce	719	2.70000000000000018	11.0999999999999996	11.9000000000000004
1352	Curry, homemade, chicken & vegetable, homemade dairy based sauce, with rice or noodles	686	1.69999999999999996	7.90000000000000036	7.29999999999999982
1353	Curry, homemade, chicken & vegetable, homemade tomato based sauce	444	2	11	4.90000000000000036
1354	Curry, homemade, chicken & vegetable, homemade tomato based sauce, with rice or noodles	520	1.30000000000000004	7.90000000000000036	3.10000000000000009
1355	Curry, homemade, chicken, vegetable & legume, homemade sauce	568	1.60000000000000009	11.4000000000000004	8.09999999999999964
1356	Curry, homemade, chicken, vegetable & legume, homemade sauce, with rice or noodles	595	1	8.09999999999999964	5
1357	Curry, homemade, chick pea & vegetable, homemade sauce, with rice or noodles	564	0.699999999999999956	4.70000000000000018	3.20000000000000018
1358	Curry, homemade, fish, homemade coconut milk sauce	593	1.19999999999999996	18.3999999999999986	6.79999999999999982
1359	Curry, homemade, fish, homemade sauce	472	0.800000000000000044	17.5	3.60000000000000009
1360	Curry, homemade, fish, homemade sauce, with rice or noodles	537	0.5	11.8000000000000007	2.29999999999999982
1361	Curry, homemade, fish & rice	671	2	9.90000000000000036	4.29999999999999982
1362	Curry, homemade, fish & vegetable, homemade coconut milk sauce	506	1.69999999999999996	10	7.59999999999999964
1363	Curry, homemade, fish & vegetable, homemade tomato based sauce	417	2.20000000000000018	10	4.5
1364	Curry, homemade, fish & vegetable, homemade tomato based sauce, with rice or noodles	504	1.30000000000000004	7.29999999999999982	2.79999999999999982
1365	Curry, homemade, goat, homemade sauce	546	1.80000000000000004	14.9000000000000004	6.70000000000000018
1366	Curry, homemade, goat, homemade sauce, with rice or noodles	582	1.10000000000000009	10.1999999999999993	4.20000000000000018
1367	Curry, homemade, lamb, homemade sauce	769	0.900000000000000022	19.1999999999999993	10.6999999999999993
1368	Curry, homemade, lamb & rice	833	2.20000000000000018	12.0999999999999996	7
1369	Curry, homemade, lamb & vegetable, homemade coconut milk sauce	673	1.69999999999999996	11.6999999999999993	11.3000000000000007
1370	Curry, homemade, lamb & vegetable, homemade dairy based sauce	585	2.39999999999999991	11.5999999999999996	8.19999999999999929
1371	Curry, homemade, lamb & vegetable, homemade dairy based sauce, with rice or noodles	605	1.5	8.30000000000000071	5.09999999999999964
1372	Curry, homemade, lamb & vegetable, homemade tomato based sauce	566	2.10000000000000009	11.9000000000000004	7.59999999999999964
1373	Curry, homemade, lamb, vegetable & legume, homemade tomato based sauce	519	2	9.90000000000000036	6.40000000000000036
1374	Curry, homemade, legume (dhal)	485	1.80000000000000004	6.29999999999999982	2.89999999999999991
1375	Curry, homemade, okra, homemade sauce	232	3.29999999999999982	2.70000000000000018	2.60000000000000009
1376	Curry, homemade, okra, with rice or noodles	492	2.5	3.70000000000000018	2.10000000000000009
1377	Curry, homemade, pork, coconut milk sauce	754	1.69999999999999996	19.6000000000000014	10.3000000000000007
1378	Curry, homemade, pork & vegetable, coconut milk sauce	607	1.80000000000000004	14.4000000000000004	8.30000000000000071
1379	Curry, homemade, potato, dairy based sauce	443	2.5	4.70000000000000018	4.29999999999999982
1380	Curry, homemade, prawn & vegetable, homemade coconut milk sauce	494	1.69999999999999996	10.6999999999999993	7
1381	Curry, homemade, prawn & vegetable, homemade tomato based sauce	396	2.20000000000000018	10	3.89999999999999991
1382	Curry, homemade, prawn & vegetable, homemade tomato based sauce, with rice or noodles	492	1.30000000000000004	7.29999999999999982	2.5
1383	Curry, homemade, root vegetable, homemade coconut milk sauce	670	3.60000000000000009	2.39999999999999991	10.9000000000000004
1384	Curry, homemade, sausage, homemade sauce	786	2.70000000000000018	9.09999999999999964	13.8000000000000007
1385	Curry, homemade, vegetable & egg, homemade dairy based sauce	604	2.60000000000000009	3.29999999999999982	11.4000000000000004
1386	Curry, homemade, vegetable, homemade coconut milk sauce	365	2.60000000000000009	2.10000000000000009	6.20000000000000018
1387	Curry, homemade, vegetable, homemade dairy based sauce	600	2.70000000000000018	2.5	11.5
1388	Curry, homemade, vegetable, homemade sauce	284	2.89999999999999991	2.10000000000000009	3
1389	Curry, homemade, vegetable, homemade sauce, with rice or noodles	433	1.80000000000000004	2.5	2.89999999999999991
1390	Curry, homemade, vegetable & legume, homemade sauce	348	2.60000000000000009	3.60000000000000009	2.89999999999999991
1391	Curry, homemade, vegetables, commercial sauce	480	4.90000000000000036	2.39999999999999991	6.79999999999999982
1392	Curry powder	1459	10.1999999999999993	12.6999999999999993	13.8000000000000007
1393	Custard apple, african pride, peeled, raw	326	14.6999999999999993	1.39999999999999991	0.599999999999999978
1394	Custard, dairy, reduced fat, vanilla, commercial	346	11.9000000000000004	3.79999999999999982	0.900000000000000022
1395	Custard, dairy, regular fat, banana, commercial	437	14.4000000000000004	3.29999999999999982	3
1396	Custard, dairy, regular fat, chocolate, commercial	456	15.8000000000000007	4.20000000000000018	2.60000000000000009
1397	Custard, dairy, regular fat, vanilla, commercial	392	11.5999999999999996	3.29999999999999982	3
1398	Custard, dairy, vanilla, not further defined	417	12.5999999999999996	3.5	2.70000000000000018
1399	Custard, dairy, vanilla, prepared from dry mix	391	9.80000000000000071	3.79999999999999982	2.39999999999999991
1400	Custard, egg, vanilla, homemade from basic ingredients	723	24.3000000000000007	4.09999999999999964	4.59999999999999964
1402	Dairy blend, butter & edible oil spread (70% fat), reduced salt (sodium 280 mg/100 g)	2668	0.599999999999999978	0.5	71.5999999999999943
1403	Dairy blend, butter & edible oil spread (70% fat), sodium 485 mg/100 g	2668	0.599999999999999978	0.5	71.5999999999999943
1404	Dairy blend, butter & edible oil spread (~80% fat), reduced salt (sodium 290 mg/100 g)	3068	0.599999999999999978	0.599999999999999978	82.4000000000000057
1405	Dairy blend, butter & edible oil spread (~80% fat), sodium 485 mg/100 g	3068	0.599999999999999978	0.5	82.4000000000000057
1406	Dairy blend, butter & edible oil spread, not further defined	2612	0.599999999999999978	0.5	70.0999999999999943
1407	Dairy blend, butter & edible oil spread, reduced fat (16% fat) & sodium 390 mg/100 g	929	0.599999999999999978	0.5	16
1408	Dairy blend, butter & edible oil spread, reduced fat (40% fat) & sodium 380 mg/100 g	1499	0.599999999999999978	0.5	40
1409	Dairy blend, butter & edible oil spread, reduced fat (40% fat), sodium 510 mg/100 g	1499	0.599999999999999978	0.5	40
1410	Dairy blend, butter & edible oil spread, reduced fat (<60% fat), regular salt	1887	0.599999999999999978	0.599999999999999978	50.5
1411	Dairy blend, butter & edible oil spread, reduced fat (<60% fat) & salt	1516	0.599999999999999978	0.5	39.6000000000000014
1412	Dairy blend, butter & edible oil spread, reduced fat (60% fat) & salt (sodium 200 mg/100 g)	2239	0.599999999999999978	0.5	60
1413	Dairy blend, butter & edible oil spread, reduced fat (60% fat), sodium 400 mg/100 g	2239	0.599999999999999978	0.5	60
1414	Dairy blend, butter & edible oil spread, regular fat (>60% fat), regular salt	2905	0.5	0.599999999999999978	78
1415	Date, dried	1212	65.9000000000000057	2	0.200000000000000011
1416	Devon, processed luncheon meat	1001	0.800000000000000044	12.4000000000000004	18.5
1417	Dill, raw	170	1.19999999999999996	3.39999999999999991	1.19999999999999996
1418	Dressing, Asian style, with lime juice, chilli and fish sauce	390	18	2.70000000000000018	0.299999999999999989
1419	Dressing, Caesar, commercial	1840	4.79999999999999982	2.29999999999999982	45.3999999999999986
1420	Dressing, Caesar, homemade	2297	0.5	3.39999999999999991	59.6000000000000014
1421	Dressing, coleslaw, commercial, reduced fat	608	8.40000000000000036	0.599999999999999978	9.80000000000000071
1422	Dressing, coleslaw, commercial, regular fat	1607	24.5	1	30.1000000000000014
1423	Dressing, creamy, commercial, 97% fat free	534	21	0.900000000000000022	2.70000000000000018
1424	Dressing, honey mustard, homemade	1345	20.3999999999999986	1.60000000000000009	25.8999999999999986
1425	Dressing, lemon vinaigrette, homemade	2738	0.5	0.200000000000000011	73.0999999999999943
1426	Dressing, mustard, homemade	1612	1.39999999999999991	1.39999999999999991	41.1000000000000014
1427	Dressing, oil & vinegar, commercial, regular fat	1103	11.4000000000000004	0.100000000000000006	23.8000000000000007
1428	Dressing, oil, vinegar & vegetables/herbs, commercial, regular fat	1309	6.90000000000000036	0.200000000000000011	31.3999999999999986
1429	Dressing, ranch, commercial	2087	4.40000000000000036	1.19999999999999996	53.6000000000000014
1430	Dressing, sesame soy, homemade	800	10.5	2.20000000000000018	15.0999999999999996
1431	Dressing, thousand island, commercial, reduced fat	721	16.1999999999999993	0.800000000000000044	10.4000000000000004
1432	Dressing, thousand island, commercial, regular fat	1495	14.6999999999999993	1	31.8000000000000007
1433	Dressing, vinaigrette, homemade	2738	0.800000000000000044	0.100000000000000006	73
1434	Dressing, vinegar based, commercial, fat free	85	2.70000000000000018	0.100000000000000006	0.100000000000000006
1435	Dressing, vinegar based & vegetables/herbs, commercial, fat free	131	5.20000000000000018	0.200000000000000011	0
1436	Duck, lean, baked, roasted, fried, grilled or BBQd, no added fat	765	0	24.3000000000000007	9.5
1437	Duck, lean, baked, roasted, fried, stir-fried, grilled or BBQd, fat not further defined	759	0	23.3000000000000007	9.80000000000000071
1438	Duck, lean, boiled, casseroled, microwaved, poached, steamed or stewed, no added fat	723	0	25.3999999999999986	7.90000000000000036
1439	Duck, lean, raw	506	0	17.8000000000000007	5.5
1440	Duck, lean, skin & fat, baked, roasted, fried, grilled or BBQd, fat not further defined	2168	0	16.8999999999999986	50.7999999999999972
1441	Duck, lean, skin & fat, baked, roasted, fried, grilled or BBQd, no added fat	2114	0	17.3000000000000007	49.2000000000000028
1442	Duck, lean, skin & fat, coated, baked, roasted, fried, grilled or BBQd, with or without added fat	2127	0.800000000000000044	16.3999999999999986	43.1000000000000014
1443	Duck, lean, skin & fat, raw	1585	0	13	36.8999999999999986
1444	Duck, skin & fat, baked or roasted, fried, grilled or BBQd, no added fat	2016	0	13.4000000000000004	48.2999999999999972
1445	Duck, skin & fat, raw	2352	0	9.5	59.2000000000000028
1446	Dugong, wild caught, flesh, cooked	650	0	29.8999999999999986	3.79999999999999982
1447	Dugong, wild caught, flesh, raw	526	0	24.1999999999999993	3.10000000000000009
1448	Echidna, wild caught, flesh, cooked	789	0	30.6000000000000014	7.29999999999999982
1449	Echidna, wild caught, flesh, raw	552	0	21.3999999999999986	5.09999999999999964
1450	Egg, chicken, scrambled or omelette, with bacon & cheese, cooked with added fat	775	1.39999999999999991	13.4000000000000004	14.0999999999999996
1451	Egg, chicken, scrambled or omelette, with bacon & cheese, cooked without added fat	712	1.39999999999999991	13.6999999999999993	12.3000000000000007
1452	Egg, chicken, scrambled or omelette, with bacon, cheese & vegetables, cooked with added fat	688	1.60000000000000009	12.0999999999999996	12.0999999999999996
1453	Egg, chicken, scrambled or omelette, with bacon, cheese & vegetables, cooked without added fat	624	1.60000000000000009	12.3000000000000007	10.1999999999999993
1454	Egg, chicken, scrambled or omelette, with bacon, cooked with added fat	715	1.39999999999999991	12.5	12.9000000000000004
1455	Egg, chicken, scrambled or omelette, with bacon, cooked without added fat	647	1.5	12.8000000000000007	10.9000000000000004
1456	Egg, chicken, scrambled or omelette, with bacon & vegetables, cooked with added fat	623	1.69999999999999996	11.0999999999999996	10.8000000000000007
1457	Egg, chicken, scrambled or omelette, with bacon & vegetables, cooked without added fat	554	1.69999999999999996	11.4000000000000004	8.80000000000000071
1458	Egg, chicken, scrambled or omelette, with canned spaghetti, cooked without added fat	437	2.5	9	5.5
1459	Egg, chicken, scrambled or omelette, with cheese, chicken & vegetables, cooked without added fat	572	1.60000000000000009	13.3000000000000007	8.40000000000000036
1460	Egg, chicken, scrambled or omelette, with cheese, cooked with added fat	680	1.60000000000000009	12.4000000000000004	11.9000000000000004
1461	Egg, chicken, scrambled or omelette, with cheese, cooked without added fat	592	1.69999999999999996	12.5999999999999996	9.40000000000000036
1462	Egg, chicken, scrambled or omelette, with cheese & salmon or tuna, cooked without added fat	615	1.39999999999999991	14.8000000000000007	9.19999999999999929
1463	Egg, chicken, scrambled or omelette, with cheese & vegetables, cooked with added fat	595	1.80000000000000004	10.6999999999999993	10
1464	Egg, chicken, scrambled or omelette, with cheese & vegetables, cooked without added fat	528	1.89999999999999991	10.9000000000000004	8
1465	Egg, chicken, scrambled or omelette, with chicken & vegetables, cooked with added fat	570	1.60000000000000009	12.0999999999999996	8.90000000000000036
1466	Egg, chicken, scrambled or omelette, with herbs, cooked with added fat	586	1.69999999999999996	11	10
1467	Egg, chicken, scrambled or omelette, with herbs, cooked without added fat	502	1.69999999999999996	11.1999999999999993	7.59999999999999964
1468	Egg, chicken, scrambled or omelette, with meat & vegetables, cooked with added fat	574	1.60000000000000009	12.1999999999999993	9
1469	Egg, chicken, scrambled or omelette, with salmon or tuna, cooked without added fat	552	1.5	13.8000000000000007	7.90000000000000036
1470	Egg, chicken, scrambled or omelette, with salmon or tuna & vegetables, cooked with added fat	580	1.69999999999999996	11.6999999999999993	9.40000000000000036
1471	Egg, chicken, scrambled or omelette, with salmon or tuna & vegetables, cooked without added fat	506	1.69999999999999996	11.9000000000000004	7.29999999999999982
1472	Egg, chicken, scrambled or omelette, with vegetables, cooked without added fat	451	1.89999999999999991	9.90000000000000036	6.40000000000000036
1473	Egg, chicken, scrambled or omelette, with vegetables, fat not further defined	524	1.89999999999999991	9.59999999999999964	8.5
1474	Egg, chicken, scrambled, with cows milk, cooked with butter or dairy blend	594	1.89999999999999991	10.9000000000000004	10.1999999999999993
1475	Egg, chicken, scrambled, with cows milk, cooked with fat not further defined	577	2	10.5999999999999996	9.80000000000000071
1476	Egg, chicken, scrambled, with cows milk, cooked with margarine spread	545	2	10.5999999999999996	8.90000000000000036
1477	Egg, chicken, scrambled, with cows milk, cooked with oil not further defined	587	2	10.5999999999999996	10.0999999999999996
1478	Egg, chicken, scrambled, with cows milk, no fat added	491	2.10000000000000009	10.9000000000000004	7.29999999999999982
1479	Egg, chicken, white (albumen) only, fried, fat not further defined	398	0.400000000000000022	12.0999999999999996	5
1480	Egg, chicken, white (albumen) only, fried, no added fat	223	0.5	12.6999999999999993	0
1481	Egg, chicken, white (albumen) only, hard-boiled	204	0.400000000000000022	11.5999999999999996	0
1482	Egg, chicken, white (albumen) only, raw	197	0.400000000000000022	11.1999999999999993	0
1483	Egg, chicken, whole, baked, added fat not further defined	732	0.299999999999999989	13	13.6999999999999993
1484	Egg, chicken, whole, baked, no added fat	580	0.299999999999999989	13.6999999999999993	9.19999999999999929
1485	Egg, chicken, whole, cooked, no added fat	541	0.299999999999999989	13	8.40000000000000036
1486	Egg, chicken, whole, curried	948	1.60000000000000009	10.0999999999999996	19.6000000000000014
1487	Egg, chicken, whole, fried, butter or dairy blend	745	0.299999999999999989	13.5999999999999996	13.6999999999999993
1488	Egg, chicken, whole, fried, fat not further defined	766	0.299999999999999989	13.5999999999999996	14.3000000000000007
1489	Egg, chicken, whole, fried, margarine spread	705	0.299999999999999989	13.5999999999999996	12.5999999999999996
1490	Egg, chicken, whole, fried, no fat added	606	0.299999999999999989	14.3000000000000007	9.69999999999999929
1491	Egg, chicken, whole, fried, oil not further defined	786	0.299999999999999989	13.5999999999999996	14.9000000000000004
1492	Egg, chicken, whole, fried with bacon, with or without added fat	971	0.299999999999999989	15.6999999999999993	18.8000000000000007
1493	Egg, chicken, whole, fried with cheese &/or vegetables, with or without added fat	767	0.699999999999999956	13.1999999999999993	14
1494	Egg, chicken, whole, hard-boiled	583	0.299999999999999989	12.4000000000000004	9.5
1495	Egg, chicken, whole, hard-boiled, mashed with mayonnaise	839	0.5	11.0999999999999996	16.8999999999999986
1496	Egg, chicken, whole, omega-3 polyunsaturate enriched, boiled	447	0.299999999999999989	12.6999999999999993	6.09999999999999964
1497	Egg, chicken, whole, omega-3 polyunsaturate enriched, raw	438	0.299999999999999989	12.4000000000000004	6
1498	Egg, chicken, whole, poached, fat not further defined	695	0.299999999999999989	12.5	12.9000000000000004
1499	Egg, chicken, whole, poached, no added fat	556	0.299999999999999989	13.0999999999999996	8.90000000000000036
1500	Egg, chicken, whole, poached with bacon, with or without added fat	732	0.599999999999999978	21.1999999999999993	9.80000000000000071
1501	Egg, chicken, whole, poached with cheese &/or vegetables, with or without added fat	679	0.699999999999999956	13	11.6999999999999993
1502	Egg, chicken, whole, raw	533	0.299999999999999989	12.5999999999999996	8.5
1503	Egg, chicken, yolk, fried, fat not further defined	1600	0.200000000000000011	16.8999999999999986	35.3999999999999986
1504	Egg, chicken, yolk, fried, no fat added	1490	0.200000000000000011	17.6999999999999993	32
1505	Egg, chicken, yolk, hard-boiled	1450	0.200000000000000011	16.1000000000000014	31.6999999999999993
1506	Egg, chicken, yolk, raw	1311	0.200000000000000011	15.5999999999999996	28.1999999999999993
1507	Egg, chicken, yolk, scrambled, with cows milk, fat not further defined	1160	2	12.9000000000000004	24.5
1508	Egg, chicken, yolk, scrambled, with cows milk, no fat added	1114	1.89999999999999991	13.5	23
1509	Egg, duck, scrambled, with cows milk & fat not further defined	722	2.5	10.8000000000000007	13.4000000000000004
1510	Egg, duck, scrambled, with cows milk, no fat added	652	2.60000000000000009	11.0999999999999996	11.4000000000000004
1511	Egg, duck, whole, boiled	714	0.900000000000000022	12.3000000000000007	13.1999999999999993
1512	Egg, duck, whole, fried, fat not further defined	984	1	13.9000000000000004	19.8000000000000007
1513	Egg, duck, whole, raw	742	0.900000000000000022	12.8000000000000007	13.8000000000000007
1514	Egg, emu, scrambled, with cows milk, no added fat	559	2.60000000000000009	9.90000000000000036	9.30000000000000071
1515	Egg, emu, whole, raw	698	0.299999999999999989	13.1999999999999993	12.6999999999999993
1516	Eggplant, peeled or unpeeled, fresh or frozen, baked, roasted, fried, stir-fried, grilled or BBQd, no added fat	109	3.10000000000000009	1.30000000000000004	0.400000000000000022
1517	Eggplant, peeled or unpeeled, fresh or frozen, baked, roasted, fried, stir-fried, grilled or BBQd, olive oil	605	3.10000000000000009	1.30000000000000004	13.6999999999999993
1518	Eggplant, peeled or unpeeled, fresh or frozen, baked, roasted, fried, stir-fried, grilled or BBQd, other oil	756	3.89999999999999991	1.60000000000000009	17.1000000000000014
1519	Eggplant, peeled or unpeeled, fresh or frozen, boiled, microwaved or steamed, drained	100	2.79999999999999982	1.19999999999999996	0.299999999999999989
1520	Eggplant, peeled or unpeeled, fresh or frozen, boiled, microwaved or steamed, drained, added fat not further defined	449	2.5	1.10000000000000009	10
1521	Eggplant, peeled or unpeeled, fresh or frozen, raw	93	2.60000000000000009	1.10000000000000009	0.299999999999999989
1522	Egg, quail, whole, fried, fat not further defined	888	0.400000000000000022	14.0999999999999996	17.3000000000000007
1523	Egg, quail, whole, raw	639	0.400000000000000022	13	11.0999999999999996
1524	Egg, whole, preserved, cooked	835	1	14.4000000000000004	15.5
1525	Emu, fan fillet, raw	486	0	24.6999999999999993	1.80000000000000004
1526	Emu, fillet or steak, baked, roasted, fried, stir-fried, grilled or BBQd, no added fat	660	0	33.5	2.5
1527	Emu, steak, raw	504	0	25.5	1.89999999999999991
1528	Endive, raw	58	0.299999999999999989	1.5	0.200000000000000011
1529	Ethanol 100%	2900	0	0	0
1530	Fat, butter, dairy blend, ghee or margarine, not further defined, for use in meat, fish, poultry & vegetable recipes	2959	0	0.900000000000000022	79.5
1531	Fat, butter, dairy blend or margarine spread, not further defined	2554	0	0.800000000000000044	68.5999999999999943
1532	Fat, butter, dairy blend or margarine spread, not further defined	2584	0	0.800000000000000044	69.4000000000000057
1533	Fat, butter or dairy blend, for homemade cakes, biscuits & puddings, not further defined	2986	0.100000000000000006	1.10000000000000009	80.2000000000000028
1534	Fat, dairy blend or margarine spread, not further defined	2309	0.100000000000000006	0.699999999999999956	62.1000000000000014
1535	Fat, for frying at home, not further defined	2903	0.200000000000000011	0.599999999999999978	78.0999999999999943
1536	Fat or oil, not further defined, for use in home cooked meat, fish, poultry & mixed dish recipes	3636	0	0.100000000000000006	98.2000000000000028
1537	Fat or oil, not further defined, for use in homemade cake, biscuit & slice recipes	3064	0	0.900000000000000022	82.4000000000000057
1538	Fat or oil, not further defined, for use in homemade cake, biscuit & slice using dry mixes	3216	0	0.5	86.7000000000000028
1539	Fat or oil, not further defined, for use in omelette, scrambled egg & wet cooked vegetables recipes	3344	0	0.400000000000000022	90.2000000000000028
1540	Fat, solid, blend of animal & vegetable oils	3700	0	0.200000000000000011	99.9000000000000057
1541	Fat, solid, vegetable oil based	3702	0	0.200000000000000011	100
1542	Feijoa, raw	180	7.70000000000000018	0.699999999999999956	0.299999999999999989
1543	Fennel, fresh or frozen, boiled, microwaved or steamed, drained	108	3.89999999999999991	1.19999999999999996	0.100000000000000006
1544	Fennel, fresh or frozen, raw	92	3.29999999999999982	1	0.100000000000000006
1545	Fenugreek seed	1375	24.1999999999999993	23	6.40000000000000036
1546	Fibre	800	0	0	0
1547	Fig, dried	1082	52.6000000000000014	3.60000000000000009	0.699999999999999956
1548	Fig, fresh, peeled or unpeeled, baked	224	9.30000000000000071	1.60000000000000009	0.299999999999999989
1549	Fig, fresh, peeled or unpeeled, raw	195	8.09999999999999964	1.39999999999999991	0.299999999999999989
1550	Fish, eel, baked, roasted, fried, stir-fried, deep fried, grilled or BBQd, fat not further defined	1349	0	22.6999999999999993	26
1551	Fish, eel, baked, roasted, fried, stir-fried, grilled or BBQd, no added fat	1237	0	23.3999999999999986	22.6999999999999993
1552	Fish, eel, raw	903	0	17.1000000000000014	16.6000000000000014
1553	Fish paste or spread	652	0	14.9000000000000004	6.90000000000000036
1554	Fish roe (caviar), black	386	0	10.9000000000000004	5.40000000000000036
1555	Fish roe (caviar), red	631	0	19.1999999999999993	8.19999999999999929
1556	Fish, sashimi, raw, not further defined	609	0	23	5.90000000000000036
1557	Fish, white flesh, baked, roasted, fried, grilled or BBQd, no added fat	528	0	26.3000000000000007	2.20000000000000018
1558	Fish, white flesh, baked, roasted, grilled, BBQd, fried or deep fried, fat not further defined	771	0	26	8.90000000000000036
1559	Fish, white flesh, battered, packaged frozen, baked, roasted, fried, grilled or BBQd, with or without added fat	1099	0.599999999999999978	12.1999999999999993	19.3000000000000007
1560	Fish, white flesh, battered, takeaway outlet, deep fried	945	0	14.0999999999999996	13.5999999999999996
1561	Fish, white flesh, boiled, microwaved, steamed or poached, with or without added fat	497	0	23.6999999999999993	2.5
1562	Fish, white flesh, coated, baked, roasted, fried, deep fried, grilled or BBQd, fat not further defined	834	0.400000000000000022	21.3000000000000007	9.69999999999999929
1563	Fish, white flesh, crumbed, packaged frozen, baked, roasted, fried, grilled or BBQd, with or without added fat	958	0.699999999999999956	11.8000000000000007	14.5
1564	Fish, white flesh, crumbed, takeaway outlet, deep fried	1195	1.19999999999999996	16.1999999999999993	16.3999999999999986
1565	Fish, white flesh, raw, not further defined	401	0	20	1.60000000000000009
1566	Flathead, baked, roasted, fried, grilled or BBQd, no added fat	541	0	28.8999999999999986	1.39999999999999991
1567	Flathead, baked, roasted, grilled, BBQd, fried or deep fried, fat not further defined	763	0	27.3999999999999986	8
1568	Flathead, boiled, microwaved, steamed or poached, with or without added fat	487	0	26.1000000000000014	1.19999999999999996
1569	Flathead, coated, baked, roasted, fried, deep-fried, grilled or BBQd, fat not further defined	828	0.400000000000000022	22.3000000000000007	9
1570	Flathead, coated, takeaway outlet, deep fried	1593	0.299999999999999989	8.80000000000000071	30.5
1571	Flathead, raw	395	0	21.1000000000000014	1
1572	Flounder, baked, roasted, fried, grilled or BBQd, no added fat	387	0	17	2.60000000000000009
1573	Flounder, baked, roasted, grilled, BBQd, fried or deep fried, fat not further defined	617	0	16.1999999999999993	9.19999999999999929
1574	Flounder, raw	282	0	12.4000000000000004	1.89999999999999991
1575	Flour, arrowroot	1453	0	0.100000000000000006	0.200000000000000011
1576	Flour, chick pea (besan)	1478	2.60000000000000009	19.6999999999999993	5.40000000000000036
1577	Flour, cornflour, from maize starch	1529	0.800000000000000044	0.400000000000000022	0.100000000000000006
1578	Flour, cornflour, from maize & wheat starch	1442	0.100000000000000006	0.100000000000000006	0.5
1579	Flour, gluten free mix (rice, soy, corn & tapioca)	1507	1.39999999999999991	3.39999999999999991	0.699999999999999956
1580	Flour, rice	1536	0.5	5.70000000000000018	1.39999999999999991
1581	Flour, rye, wholemeal	1318	1.39999999999999991	12	2.29999999999999982
1582	Flour, soya	1573	19.8000000000000007	46.5	6.70000000000000018
1583	Flour, spelt	1471	0.900000000000000022	18.6999999999999993	2.39999999999999991
1584	Flour, wheat, white, high protein or bread making flour	1492	0.100000000000000006	11.3000000000000007	1.19999999999999996
1585	Flour, wheat, white, plain	1498	0	10.8000000000000007	1.19999999999999996
1586	Flour, wheat, white, plain, added vitamins B1, B2, B3, B6, E & folate & Fe, Mg & Zn (Jackaroo)	1417	1.10000000000000009	11.0999999999999996	1.5
1587	Flour, wheat, white, self-raising	1479	0	10.8000000000000007	1.19999999999999996
1588	Flour, wheat, white, self-raising, added calcium & folate	1479	0	10.8000000000000007	1.19999999999999996
1589	Flour, wheat, white, self-raising, added vitamins B1, B2, B3, B6, E & folate & Fe, Mg & Zn (Jackaroo)	1417	1.10000000000000009	11.0999999999999996	1.5
1590	Flour, wheat, wholemeal, plain	1464	0.900000000000000022	11.3000000000000007	2.10000000000000009
1591	Flour, wheat, wholemeal, self-raising	1458	0.900000000000000022	10.5999999999999996	2.10000000000000009
1592	Flower, rosella (native)	41	0	0.5	0
1593	Folic acid	0	0	0	0
1594	Frankfurt, canned, heated, drained	876	0.800000000000000044	11.3000000000000007	17.3999999999999986
1595	Frankfurt, cooked	1051	0.200000000000000011	14.3000000000000007	19.8999999999999986
1596	Fromais frais, berry pieces or flavour, regular fat (5% fat)	499	13.9000000000000004	6.20000000000000018	4.29999999999999982
1597	Fromais frais, fruit pieces or flavoured, regular fat (5% fat)	486	13	5.40000000000000036	4.70000000000000018
1598	Fromais frais, vanilla flavoured, regular fat (5% fat)	496	13	5.40000000000000036	4.70000000000000018
1599	Fruit, for use in garden  recipes	245	11.5999999999999996	0.800000000000000044	0.200000000000000011
1600	Fruit, fresh, not further defined	247	10.4000000000000004	0.800000000000000044	0.200000000000000011
1601	Fruit, leather	1500	28.8999999999999986	0.299999999999999989	2.29999999999999982
1602	Fruit, puree or stewed, infant	258	11.1999999999999993	0.5	0.100000000000000006
1603	Fruit, puree or stewed, not further defined	372	16.5	0.800000000000000044	0.699999999999999956
1604	Fruit, wild harvested, raw	374	13.4000000000000004	2.39999999999999991	2
1605	Garfish, coated, takeaway outlet, deep fried	1117	0.200000000000000011	17.3000000000000007	17.8000000000000007
1606	Garfish, raw	464	0	21.3999999999999986	2.70000000000000018
1607	Garlic, peeled or unpeeled, fresh or frozen, baked, roasted, fried, stir-fried, grilled, BBQd, deep-fried, with or without added fat	842	2.39999999999999991	9.80000000000000071	4.5
1608	Garlic, peeled or unpeeled, fresh or frozen, boiled, microwaved or steamed, drained, with or without added fat	580	1.69999999999999996	6.79999999999999982	3.10000000000000009
1609	Garlic, peeled or unpeeled, fresh or frozen, raw	522	1.5	6.09999999999999964	2.79999999999999982
1610	Gelatine, all types	1449	0	84.4000000000000057	0.400000000000000022
1611	Gel, energy, caffeinated, all flavours	1081	24	0	0
1612	Gemfish, boiled, microwaved, steamed or poached, no added fat	517	0.299999999999999989	23.3000000000000007	3.10000000000000009
1613	Gemfish, raw	323	0.100000000000000006	13.1999999999999993	2.60000000000000009
1614	Ghee, clarified butter	3701	0	0.299999999999999989	99.9000000000000057
1615	Gherkin, pickled, drained, commercial	442	23.6000000000000014	0.400000000000000022	0.299999999999999989
1616	Gin	899	0	0	0
1617	Ginger, crystallised	1264	76.7000000000000028	0.299999999999999989	0.100000000000000006
1618	Ginger, dried, ground	1418	0.900000000000000022	8.5	4.59999999999999964
1619	Ginger, peeled, fresh or frozen, baked, roasted, fried, stir-fried, grilled or BBQd, with or without added fat	160	2.10000000000000009	1	0.5
1620	Ginger, peeled, fresh or frozen, boiled, microwaved or steamed, with or without added fat	143	1.80000000000000004	0.900000000000000022	0.400000000000000022
1621	Ginger, peeled, fresh or frozen, raw	132	1.69999999999999996	0.800000000000000044	0.400000000000000022
1622	Ginger, pickled, drained	75	1	0.5	0.200000000000000011
1623	Glucose, liquid or syrup	1174	33	0	0
1624	Gluten, from wheat (vital wheat gluten)	1598	0.100000000000000006	74.9000000000000057	2.20000000000000018
1625	Goanna, wild caught, flesh, cooked	729	0	31.3000000000000007	4.40000000000000036
1626	Goat, cooked, with or without added fat	705	0	25.8999999999999986	7.20000000000000018
1627	Goat, flesh, raw	533	0	20.8999999999999986	4.79999999999999982
1628	Goat, forequarter, separable lean, raw	432	0	21.6000000000000014	1.80000000000000004
1629	Goat, separable fat (composite), raw	1855	0	12.1999999999999993	44.6000000000000014
1630	Goji berry, dried	1238	49.1000000000000014	12.1999999999999993	2.20000000000000018
1631	Goose, wild caught, flesh, cooked	849	0	33.3999999999999986	6.29999999999999982
1632	Goose, wild caught, flesh, raw	616	0	24.1999999999999993	4.59999999999999964
1633	Grains, boiled, for homemade mixed dishes	665	0.100000000000000006	2.70000000000000018	0.200000000000000011
1634	Grains & pasta, for homemade soup recipes	563	0.100000000000000006	4.09999999999999964	0.800000000000000044
1635	Grape, black muscatel, raw	349	18.8000000000000007	1.10000000000000009	0.100000000000000006
1636	Grape, black sultana, raw	278	14	1.19999999999999996	0.100000000000000006
1637	Grape, cornichon, raw	257	12.6999999999999993	1.30000000000000004	0.100000000000000006
1638	Grapefruit, peeled, raw	125	4.79999999999999982	0.900000000000000022	0.200000000000000011
1639	Grape, raw, not further defined	294	15.5	0.699999999999999956	0.100000000000000006
1640	Grape, red globe, raw	322	16.3000000000000007	0.900000000000000022	0.200000000000000011
1641	Grape, thompson seedless or sultana, raw	276	15	0.599999999999999978	0.100000000000000006
1642	Grape, waltham cross, raw	281	14.4000000000000004	0.800000000000000044	0.100000000000000006
1643	Gravy powder, dry mix	1311	0.699999999999999956	8.90000000000000036	6.20000000000000018
1644	Gravy powder, dry mix, reduced salt	1311	0.699999999999999956	8.90000000000000036	6.20000000000000018
1645	Gravy, prepared, commercial	188	0.100000000000000006	1.30000000000000004	1.60000000000000009
1646	Gravy, prepared from dry powder with water	109	0.100000000000000006	0.699999999999999956	0.5
1647	Gravy, prepared from pan-drippings	857	0	1.89999999999999991	16.3000000000000007
1648	Gravy, prepared, reduced salt, commercial	188	0.100000000000000006	1.30000000000000004	1.60000000000000009
1649	Gravy, reduced salt, prepared from dry powder with water	109	0.100000000000000006	0.699999999999999956	0.5
1650	Grouper, baked, roasted, fried, grilled or BBQd, fat not further defined	727	0	25.1999999999999993	8.09999999999999964
1651	Grouper, baked, roasted, fried, grilled or BBQd, no added fat	503	0	26.5	1.39999999999999991
1652	Grouper, coated, baked, roasted, grilled, or BBQd, fat not further defined	801	0.400000000000000022	20.6999999999999993	9.09999999999999964
1653	Grouper, raw	367	0	19.3999999999999986	1
1654	Guava, hawaiian, raw	144	3.39999999999999991	0.699999999999999956	0.5
1655	Ham, leg, lean	467	0.900000000000000022	17	2.5
1656	Ham, leg, lean & fat	598	0	17.8999999999999986	7.59999999999999964
1657	Ham, leg, lean & fat, canned	482	0.599999999999999978	17.1999999999999993	4.5
1658	Ham, shoulder, lean & fat	477	0	14.1999999999999993	6
1659	Ham, shoulder, lean & fat, canned	509	0	15.4000000000000004	6.29999999999999982
1660	Ham steak, baked, roasted, fried, grilled or BBQd, fat not further defined	739	0.800000000000000044	19	9.59999999999999964
1661	Ham steak, baked, roasted, fried, grilled or BBQd, no added fat	680	0.800000000000000044	19.3999999999999986	7.79999999999999982
1662	Ham steak, raw	520	0.400000000000000022	14.4000000000000004	6.09999999999999964
1663	Herbs, mixed, dried	1210	5.20000000000000018	11.0999999999999996	9
1664	Herbs, mixed, raw	183	1.5	2.39999999999999991	1.5
1665	Herring, Atlantic, pickled	1031	7.70000000000000018	14.1999999999999993	18
1666	Honey	1318	82.0999999999999943	0.200000000000000011	0
1667	Honeycomb, plain	1502	93.5999999999999943	0.100000000000000006	0
1668	Horseradish, prepared	200	8	1.19999999999999996	0.699999999999999956
1669	Ice cream cone, soft serve vanilla ice cream, with wafer cone, fast food style	799	21.3000000000000007	4.29999999999999982	5.09999999999999964
1670	Iced chocolate, regular fat cows milk, with ice cream & whipped cream	531	13.4000000000000004	3.10000000000000009	6.79999999999999982
1671	Iced coffee, reduced fat cows milk	91	2.29999999999999982	1.69999999999999996	0.599999999999999978
1672	Iced coffee, reduced fat cows milk, with ice cream	279	6.59999999999999964	2.89999999999999991	3
1673	Iced coffee, regular fat cows milk	133	2.70000000000000018	1.69999999999999996	1.5
1674	Iced coffee, regular fat cows milk, with added sugar	159	4.59999999999999964	1.5	1.60000000000000009
1675	Iced coffee, regular fat cows milk, with ice cream	320	7.09999999999999964	2.60000000000000009	4.09999999999999964
1676	Iced coffee, regular fat cows milk, with ice cream & whipped cream	405	6.90000000000000036	2.70000000000000018	6.5
1677	Iced coffee, regular fat cows milk, with whipped cream	215	2.79999999999999982	1.69999999999999996	3.79999999999999982
1678	Iced coffee, regular fat soy milk	115	1.19999999999999996	1.69999999999999996	1.30000000000000004
1679	Iced tea, homemade, unsweetened	49	2.39999999999999991	0.200000000000000011	0.100000000000000006
1680	Icing, chocolate ganache, commercial	1811	31.5	3.10000000000000009	32.8999999999999986
1681	Icing, chocolate ganache, homemade	1945	39.6000000000000014	3.39999999999999991	30
1682	Icing, cream cheese, homemade	1593	57	2.79999999999999982	17.1000000000000014
1683	Icing, cream style, plain & flavoured (non-chocolate & coffee), commercial	2174	52.6000000000000014	0.100000000000000006	35
1684	Icing, egg white based, non-chocolate & coffee, homemade	1347	82.4000000000000057	1.5	0
1685	Icing, homemade, not further defined (non-chocolate & coffee)	1496	64.5999999999999943	1	12
1686	Icing, sugar based, chocolate, cocoa powder, commercial	1647	64.0999999999999943	0.900000000000000022	14.3000000000000007
1687	Icing, sugar based, chocolate, cocoa powder, homemade	1493	67	0.900000000000000022	10.0999999999999996
1688	Icing, sugar based, coffee, homemade	1490	70.0999999999999943	0.200000000000000011	9.80000000000000071
1689	Icing, sugar based, non-chocolate & coffee, homemade	1407	66.7000000000000028	0.100000000000000006	9.09999999999999964
1690	Icing, sugar based, plain & flavoured (non-chocolate & coffee), commercial	1678	66	1.39999999999999991	14.9000000000000004
1691	Infant cereal, added vitamin C & Fe	1636	0	8.19999999999999929	3.39999999999999991
1692	Infant cereal, added vitamin C & Fe, prepared with water	182	0	0.900000000000000022	0.400000000000000022
1693	Infant formula, 6-12 months, added omega 3 fatty acids, prepared with water	264	7.90000000000000036	1.80000000000000004	2.89999999999999991
1694	Infant formula, 6-12 months, prepared with water	264	7.90000000000000036	1.80000000000000004	2.89999999999999991
1695	Infant rusk, teething	1476	5.79999999999999982	17.5	0.599999999999999978
1696	Insect, wild caught, raw	1159	60.7000000000000028	2	2
1697	Intense sweetener, containing aspartame/acesulfame-potassium, tablet	1624	36	58	0
1698	Intense sweetener, containing aspartame, powdered formulation	1690	2.89999999999999991	3	0
1699	Intense sweetener, containing aspartame, tablet formulation	1542	68	23.3999999999999986	0
1700	Intense sweetener, containing saccharin, liquid	0	0	0	0
1701	Intense sweetener, containing saccharin, tablet	777	0	0	0
1702	Intense sweetener, containing stevia, powdered formulation	1247	7.79999999999999982	0	0
1703	Intense sweetener, containing stevia, tablet	1506	43	1.10000000000000009	0.5
1704	Intense sweetener, containing sucralose, powdered formulation	1554	27	0	0
1705	Intense sweetener, containing sucralose, tablet	1400	76.9000000000000057	10	0
1706	Intense sweetener, powder formulation, not further defined	1579	10.6999999999999993	1.60000000000000009	0
1707	Intense sweetener, tablet, not further defined	1108	31.3999999999999986	8.5	0
1708	Iodine	0	0	0	0
1709	Jackfruit, peeled, raw	347	16.3000000000000007	2.20000000000000018	0.299999999999999989
1710	Jam, all flavours, intense sweetened	101	2.79999999999999982	0.299999999999999989	0.200000000000000011
1711	Jam, all flavours, no added sugar (100% fruit)	883	51.5	1.30000000000000004	0.5
1712	Jam, all flavours, reduced sugar	540	31.5	0.5	0.100000000000000006
1713	Jam, apricot, regular	1050	64.2999999999999972	0.200000000000000011	0
1714	Jam, blackberry, regular	1100	67.2000000000000028	0.299999999999999989	0
1715	Jam, fig, regular	923	54.7000000000000028	1	0.200000000000000011
1716	Jam, mixed berry, regular	1100	67.2000000000000028	0.299999999999999989	0
1717	Jam, not further defined	1076	65.5999999999999943	0.299999999999999989	0
1718	Jam, other fruit, regular	1050	64.2999999999999972	0.200000000000000011	0
1719	Jam, plum, regular	1050	64.2999999999999972	0.200000000000000011	0
1720	Jam, pumpkin & cinnamon, homemade	738	43.1000000000000014	0.599999999999999978	0.100000000000000006
1721	Jam, raspberry, regular	1100	67.2000000000000028	0.299999999999999989	0
1722	Jam, strawberry, regular	1100	67.2000000000000028	0.299999999999999989	0
1723	Jellyfish, coated, baked, roasted, fried, grilled or BBQd, fat not further defined	734	0.400000000000000022	17.3999999999999986	8.90000000000000036
1724	Jelly, intense sweetened, all flavours, prepared	57	0	0.5	0
1725	Jelly, intense sweetened, all flavours, prepared, added other fruits	115	3.89999999999999991	0.599999999999999978	0
1726	Jelly, intense sweetened, all flavours, prepared, added peach, apricot, mango or nectarine	97	2.5	0.599999999999999978	0
1727	Jelly, sugar sweetened, all flavours, prepared	230	13.1999999999999993	1	0
1728	Jelly, sugar sweetened, all flavours, prepared, added berries	202	10.9000000000000004	0.900000000000000022	0
1729	Jelly, sugar sweetened, all flavours, prepared, added other fruits	236	13.0999999999999996	0.900000000000000022	0
1730	Jelly, sugar sweetened, all flavours, prepared, added peach, apricot, mango or nectarine	218	11.6999999999999993	1	0
1731	Jelly, sugar sweetened, all flavours, prepared, added peach & pears	220	11.6999999999999993	0.900000000000000022	0
1732	Jelly, sugar sweetened, all flavours, prepared, added pears	221	11.8000000000000007	0.900000000000000022	0
1733	Jerky, beef, all flavours	1179	19.1999999999999993	33.5	4.5
1734	John dory, baked, roasted, fried, grilled or BBQd, no added fat	526	0.299999999999999989	28.3000000000000007	1.10000000000000009
1735	John dory, baked, roasted, grilled, BBQd, fried or deep fried, fat not further defined	749	0.299999999999999989	26.8999999999999986	7.79999999999999982
1736	John dory, coated, baked, roasted, fried, or BBQd, fat not further defined	818	0.599999999999999978	21.8999999999999986	8.80000000000000071
1737	John dory, raw	384	0.200000000000000011	20.6000000000000014	0.800000000000000044
1738	Kabana or cabanossi	1168	0	14.9000000000000004	24.6999999999999993
1739	Kale, cooked	113	3.5	1.60000000000000009	0.100000000000000006
1740	Kale, raw	109	3.39999999999999991	1.60000000000000009	0.100000000000000006
1741	Kangaroo, loin fillet, baked, roasted, fried, grilled or BBQd, fat not further defined	563	0	25.6000000000000014	3.5
1742	Kangaroo, loin fillet, baked, roasted, fried, grilled or BBQd, no added fat	566	0	30.6999999999999993	1.19999999999999996
1743	Kangaroo, loin fillet, boiled, casseroled, microwaved, poached, steamed or stewed, fat not further defined	577	0	26.1999999999999993	3.60000000000000009
1744	Kangaroo, loin fillet, raw	397	0	21.3999999999999986	0.900000000000000022
1745	Kangaroo, rump, baked, roasted, fried, grilled or BBQd, no added fat	669	0	33.8999999999999986	2.5
1746	Kangaroo, rump, raw	373	0	20.3000000000000007	0.800000000000000044
1747	Kangaroo, tail, cooked	464	0	24.3999999999999986	1.30000000000000004
1748	Kangaroo, tail, raw	381	0	20	1.10000000000000009
1749	Kangaroo, wild caught, flesh, cooked	469	0	25.3999999999999986	1
1750	Kangaroo, wild caught, flesh & organs, cooked	511	0	25.6000000000000014	1.89999999999999991
1751	Kangaroo, wild caught, tail, cooked	464	0	24.3999999999999986	1.30000000000000004
1752	Kiwifruit, gold, peeled or unpeeled, raw	244	10.9000000000000004	1.19999999999999996	0.5
1753	Kiwifruit, green (hayward), peeled, raw	218	9	1.19999999999999996	0.200000000000000011
1754	Kiwifruit, green (hayward), unpeeled, raw	216	8.69999999999999929	1.19999999999999996	0.200000000000000011
1755	Kohlrabi, peeled, fresh or frozen, boiled, microwaved or steamed, drained	170	4.40000000000000036	3.89999999999999991	0.100000000000000006
1756	Kohlrabi, peeled, fresh or frozen, raw	163	4.20000000000000018	3.70000000000000018	0.100000000000000006
1757	Lamb, all cuts, separable fat, cooked	2251	0	16.1999999999999993	53.3999999999999986
1758	Lamb, all cuts, separable fat, raw	2315	0	10.8000000000000007	57.6000000000000014
1759	Lamb, BBQ/grill/fry cuts, fully-trimmed, BBQd, grilled or fried, no added fat	951	0	28.6000000000000014	12.5999999999999996
1760	Lamb, BBQ/grill/fry cuts, fully-trimmed, raw	708	0	22.6000000000000014	8.69999999999999929
1761	Lamb, BBQ/grill/fry cuts, semi-trimmed, BBQd, grilled or fried, no added fat	1056	0	27.6000000000000014	15.9000000000000004
1762	Lamb, BBQ/grill/fry cuts, semi-trimmed, raw	906	0	21.3000000000000007	14.6999999999999993
1763	Lamb, brain, raw	505	0	12.3000000000000007	8
1764	Lamb, brain, simmered or boiled, no added fat	565	0	12.8000000000000007	9.40000000000000036
1765	Lamb, butterfly steak, fully-trimmed, baked, roasted, fried, grilled or BBQd, no added fat	914	0	29.1000000000000014	11.3000000000000007
1766	Lamb, butterfly steak, fully-trimmed, boiled, casseroled, microwaved, poached, steamed, or stewed, no added fat	921	0	34.8999999999999986	8.90000000000000036
1767	Lamb, butterfly steak, fully-trimmed, raw	737	0	27.8999999999999986	7.09999999999999964
1768	Lamb, butterfly steak, separable lean, raw	671	0	28.6000000000000014	5
1769	Lamb, casserole cuts, fully-trimmed, boiled, casseroled, microwaved, poached, steamed, or stewed, no added fat	944	0	28.3000000000000007	12.5
1770	Lamb, casserole cuts, fully-trimmed, raw	667	0	20.1999999999999993	8.80000000000000071
1771	Lamb, casserole cuts, semi-trimmed, boiled, casseroled, microwaved, poached, steamed or stewed, no added fat	994	0	24.1000000000000014	15.8000000000000007
1772	Lamb, chop, fully-trimmed, baked, roasted, fried, grilled or BBQd, butter, dairy blend or margarine	949	0	29.5	12.0999999999999996
1773	Lamb, chop, fully-trimmed, baked, roasted, fried, grilled or BBQd, canola oil	967	0	29.3999999999999986	12.5999999999999996
1774	Lamb, chop, fully-trimmed, baked, roasted, fried, grilled or BBQd, fat not further defined	965	0	29.3999999999999986	12.5999999999999996
1775	Lamb, chop, fully-trimmed, baked, roasted, fried, grilled or BBQd, no added fat	894	0	30	10.4000000000000004
1776	Lamb, chop, fully-trimmed, baked, roasted, fried, grilled or BBQd, olive oil	967	0	29.3999999999999986	12.5999999999999996
1777	Lamb, chop, fully-trimmed, baked, roasted, fried, grilled or BBQd, other oil	967	0	29.3999999999999986	12.5999999999999996
1778	Lamb, chop, fully-trimmed, boiled, casseroled, microwaved, poached, steamed or stewed, fat not further defined	989	0	30.1999999999999993	12.9000000000000004
1779	Lamb, chop, fully-trimmed, boiled, casseroled, microwaved, poached, steamed or stewed, no added fat	917	0	30.8000000000000007	10.5999999999999996
1780	Lamb, chop, fully-trimmed, coated, baked, roasted, fried, grilled or BBQd, fat not further defined	1226	0.5	24.6999999999999993	15.4000000000000004
1781	Lamb, chop, fully-trimmed, raw, not further defined	733	0	24.6000000000000014	8.5
1782	Lamb, chop, semi-trimmed, baked, roasted, fried, grilled or BBQd, canola oil	1136	0	28.1000000000000014	17.8000000000000007
1783	Lamb, chop, semi-trimmed, baked, roasted, fried, grilled or BBQd, fat not further defined	1135	0	28.1000000000000014	17.8000000000000007
1784	Lamb, chop, semi-trimmed, baked, roasted, fried, grilled or BBQd, no added fat	1067	0	28.6000000000000014	15.6999999999999993
1785	Lamb, chop, semi-trimmed, baked, roasted, fried, grilled or BBQd, olive oil	1136	0	28.1000000000000014	17.8000000000000007
1786	Lamb, chop, semi-trimmed, baked, roasted, fried, grilled or BBQd, other oil	1136	0	28.1000000000000014	17.8000000000000007
1787	Lamb, chop, semi-trimmed, boiled, casseroled, microwaved, poached, steamed or stewed, fat not further defined	1163	0	28.8000000000000007	18.1999999999999993
1788	Lamb, chop, semi-trimmed, boiled, casseroled, microwaved, poached, steamed or stewed, no added fat	1094	0	29.3000000000000007	16.1000000000000014
1789	Lamb, chop, semi-trimmed, coated, baked, roasted, fried, grilled or BBQd, fat not further defined	1350	0.5	23.6999999999999993	19.1999999999999993
1790	Lamb, chop, semi-trimmed, raw, not further defined	875	0	23.5	12.9000000000000004
1791	Lamb, chop, untrimmed, baked, roasted, fried, grilled or BBQd, canola oil	1517	0	24.3999999999999986	29.8000000000000007
1792	Lamb, chop, untrimmed, baked, roasted, fried, grilled or BBQd, fat not further defined	1516	0	24.3999999999999986	29.8000000000000007
1793	Lamb, chop, untrimmed, baked, roasted, fried, grilled or BBQd, no added fat	1456	0	24.8999999999999986	27.8999999999999986
1794	Lamb, chop, untrimmed, baked, roasted, fried, grilled or BBQd, olive oil	1517	0	24.3999999999999986	29.8000000000000007
1795	Lamb, chop, untrimmed, baked, roasted, fried, grilled or BBQd, other oil	1517	0	24.3999999999999986	29.8000000000000007
1796	Lamb, chop, untrimmed, coated, baked, roasted, fried, grilled or BBQd, with or without added fat	1469	0.599999999999999978	22.1000000000000014	22.8000000000000007
1797	Lamb, chop, untrimmed, raw, not further defined	1194	0	20.3999999999999986	22.8999999999999986
1798	Lamb, chump chop, fully-trimmed, baked, roasted, fried, grilled or BBQd, no added fat	1063	0	32.6000000000000014	13.6999999999999993
1799	Lamb, chump chop, fully-trimmed, raw	719	0	21.3000000000000007	9.59999999999999964
1800	Lamb, chump chop, semi-trimmed, baked, roasted, fried, grilled or BBQd, fat not further defined	988	0	25.1999999999999993	15.0999999999999996
1801	Lamb, chump chop, semi-trimmed, baked, roasted, fried, grilled or BBQd, no added fat	1132	0	31.6999999999999993	16
1802	Lamb, chump chop, semi-trimmed, raw	753	0	21.1000000000000014	10.5999999999999996
1803	Lamb, chump chop, separable lean, grilled or BBQd, no added fat	957	0	34.1000000000000014	10.1999999999999993
1804	Lamb, chump chop, separable lean, raw	542	0	22.5	4.29999999999999982
2117	Meringue, all flavours, commercial	1538	89.4000000000000057	2.60000000000000009	1.39999999999999991
1805	Lamb, chump chop, untrimmed, baked, roasted, fried, grilled or BBQd, fat not further defined	1261	0	23.3999999999999986	23.3000000000000007
1806	Lamb, chump chop, untrimmed, baked, roasted, fried, grilled or BBQd, no added fat	1251	0	30	20
1807	Lamb, chump chop, untrimmed, raw	981	0	19.6000000000000014	17.5
1808	Lamb, diced, fully-trimmed, baked, roasted, fried, stir-fried, grilled or BBQd, no added fat	784	0	31.1999999999999993	6.90000000000000036
1809	Lamb, diced, fully-trimmed, boiled, casseroled, microwaved, poached, steamed or stewed, fat not further defined	785	0	26	9.30000000000000071
1810	Lamb, diced, fully-trimmed, boiled, casseroled, microwaved, poached, steamed or stewed, no added fat	709	0	26.5	7
1811	Lamb, diced, fully-trimmed, raw	567	0	21.1999999999999993	5.59999999999999964
1812	Lamb, diced, separable lean, fried or stir-fried, no added fat	773	0	31.3000000000000007	6.5
1813	Lamb, diced, separable lean, raw	554	0	21.3000000000000007	5.20000000000000018
1814	Lamb, diced, untrimmed, baked, roasted, fried or stir-fried, grilled or BBQd, no added fat	806	0	31	7.59999999999999964
1815	Lamb, diced, untrimmed, raw	588	0	21.1000000000000014	6.20000000000000018
1816	Lamb, drumstick, fully-trimmed, baked, roasted, fried, grilled or BBQd, no added fat	986	0	27.1999999999999993	14.0999999999999996
1817	Lamb, drumstick, separable lean, grilled or BBQd, no added fat	898	0	28	11.4000000000000004
1818	Lamb, drumstick, separable lean, raw	559	0	20.5	5.70000000000000018
1819	Lamb, drumstick, untrimmed, baked, roasted, fried, grilled or BBQd, no added fat	1053	0	26.6000000000000014	16.1999999999999993
1820	Lamb, easy carve leg roast, fully-trimmed, baked or roasted, no added fat	833	0	29.6999999999999993	8.80000000000000071
1821	Lamb, easy carve leg roast, fully-trimmed, raw	587	0	20.5	6.5
1822	Lamb, easy carve leg roast, semi-trimmed, baked or roasted, no added fat	840	0	29.6999999999999993	9.09999999999999964
1823	Lamb, easy carve leg roast, semi-trimmed, raw	618	0	20.3000000000000007	7.40000000000000036
1824	Lamb, easy carve leg roast, separable lean, baked or roasted, no added fat	742	0	30.6000000000000014	6
1825	Lamb, easy carve leg roast, separable lean, raw	477	0	21.1000000000000014	3.20000000000000018
1826	Lamb, easy carve leg roast, untrimmed, baked or roasted, no added fat	955	0	28.6000000000000014	12.6999999999999993
1827	Lamb, easy carve leg roast, untrimmed, raw	786	0	19.3999999999999986	12.3000000000000007
1828	Lamb, easy carve shoulder, fully-trimmed, baked or roasted, no added fat	796	0	28.8000000000000007	8.30000000000000071
1829	Lamb, easy carve shoulder, fully-trimmed, raw	635	0	17.5	9.09999999999999964
1830	Lamb, easy carve shoulder, semi-trimmed, baked or roasted, no added fat	859	0	28.3000000000000007	10.1999999999999993
1831	Lamb, easy carve shoulder, semi-trimmed, breadcrumb coating, baked or roasted, no added fat	1015	0.599999999999999978	19.3000000000000007	11.6999999999999993
1832	Lamb, easy carve shoulder, semi-trimmed, raw	695	0	17.3000000000000007	10.9000000000000004
1833	Lamb, easy carve shoulder, separable lean, baked or roasted, no added fat	703	0	29.6000000000000014	5.40000000000000036
1834	Lamb, easy carve shoulder, separable lean, raw	468	0	18.1999999999999993	4.29999999999999982
1835	Lamb, easy carve shoulder, untrimmed, baked or roasted, no added fat	1095	0	26.1999999999999993	17.5
1836	Lamb, easy carve shoulder, untrimmed, raw	894	0	16.5	16.6000000000000014
1837	Lamb, eye of loin, separable lean, grilled or BBQd, no added fat	843	0	29.8000000000000007	9.09999999999999964
1838	Lamb, eye of loin, separable lean, raw	671	0	28.6000000000000014	5
1839	Lamb, fillet or tenderloin, fully-trimmed, baked, roasted, fried, stir-fried, grilled or BBQd, fat not further defined	668	0	23.6999999999999993	7.20000000000000018
1840	Lamb, fillet or tenderloin, fully-trimmed, baked, roasted, fried, stir-fried, grilled or BBQd, no added fat	671	0	27.5	5.5
1841	Lamb, fillet or tenderloin, fully-trimmed, raw	485	0	19.8000000000000007	4
1842	Lamb, forequarter chop, fully-trimmed, baked, roasted, fried, grilled or BBQd, no added fat	1060	0	26.6000000000000014	16.3999999999999986
1843	Lamb, forequarter chop, fully-trimmed, raw	733	0	19.5	10.8000000000000007
1844	Lamb, forequarter chop, semi-trimmed, baked, roasted, fried, grilled or BBQd, fat not further defined	1250	0	21.8000000000000007	23.8000000000000007
1845	Lamb, forequarter chop, semi-trimmed, baked, roasted, fried, grilled or BBQd, no added fat	1108	0	26.1999999999999993	17.8999999999999986
1846	Lamb, forequarter chop, semi-trimmed, boiled, casseroled, microwaved, poached, steamed or stewed, with or without added fat	1248	0	22.6000000000000014	23.3999999999999986
1847	Lamb, forequarter chop, semi-trimmed, raw	971	0	18.1999999999999993	17.8999999999999986
1848	Lamb, forequarter chop, separable lean, grilled or BBQd, no added fat	898	0	28	11.4000000000000004
1849	Lamb, forequarter chop, separable lean, raw	559	0	20.5	5.70000000000000018
1850	Lamb, forequarter chop, untrimmed, baked, roasted, fried, grilled or BBQd, fat not further defined	1434	0	20.8000000000000007	29.1999999999999993
1851	Lamb, forequarter chop, untrimmed, baked, roasted, fried, grilled or BBQd, no added fat	1173	0	25.6000000000000014	19.8999999999999986
1852	Lamb, forequarter chop, untrimmed, raw	1126	0	17.3999999999999986	22.3999999999999986
1853	Lamb, forequarter (easy carve shoulder, forequarter chop), separable fat, grilled or BBQd, no added fat	2251	0	16.1999999999999993	53.3999999999999986
1854	Lamb, forequarter (easy carve shoulder, forequarter chop), separable fat, raw	2315	0	10.8000000000000007	57.6000000000000014
1855	Lamb, for use in kebabs, cooked	1010	0.800000000000000044	20.6000000000000014	17.1999999999999993
1856	Lamb, frenched cutlet/rack, fully-trimmed, baked, roasted, fried, grilled or BBQd, fat not further defined	870	0	24.5	12.3000000000000007
1857	Lamb, frenched cutlet/rack, fully-trimmed, baked, roasted, fried, grilled or BBQd, no added fat	879	0	30.1000000000000014	9.90000000000000036
1858	Lamb, frenched cutlet/rack, fully-trimmed, boiled, casseroled, microwaved, poached, steamed, or stewed, with or without added fat	855	0	25.3999999999999986	11.4000000000000004
1859	Lamb, frenched cutlet/rack, fully-trimmed, breadcrumb coating, baked, roasted, fried, grilled or BBQd, fat not further defined	1161	0.5	21.1000000000000014	15.1999999999999993
1860	Lamb, frenched cutlet/rack, fully-trimmed, breadcrumb coating, baked, roasted, fried, grilled or BBQd, no added fat	977	0.599999999999999978	22.3000000000000007	9.30000000000000071
1861	Lamb, frenched cutlet/rack, fully-trimmed, raw	654	0	20.5	8.30000000000000071
1862	Lamb, frenched cutlet/rack, semi-trimmed, baked, roasted, fried, grilled or BBQd, fat not further defined	1152	0	22.8000000000000007	20.6000000000000014
1863	Lamb, frenched cutlet/rack, semi-trimmed, baked, roasted, fried, grilled or BBQd, no added fat	1107	0	27.8000000000000007	17.1000000000000014
1864	Lamb, frenched cutlet/rack, semi-trimmed, breadcrumb coating, baked, roasted, fried, grilled or BBQd, fat not further defined	1367	0.5	19.8999999999999986	21.3000000000000007
1865	Lamb, frenched cutlet/rack, semi-trimmed, raw	890	0	19.1000000000000014	15.3000000000000007
1866	Lamb, frenched cutlet/rack, separable lean, grilled or BBQd, no added fat	837	0	30.5	8.59999999999999964
1867	Lamb, frenched cutlet/rack, separable lean, raw	585	0	20.8999999999999986	6.20000000000000018
1868	Lamb, frenched cutlet/rack, untrimmed, baked, roasted, fried, grilled or BBQd, fat not further defined	1256	0	22.1999999999999993	23.6999999999999993
1869	Lamb, frenched cutlet/rack, untrimmed, baked, roasted, fried, grilled or BBQd, no added fat	1163	0	27.1999999999999993	18.8999999999999986
1870	Lamb, frenched cutlet/rack, untrimmed, raw	977	0	18.6000000000000014	17.8000000000000007
1871	Lamb, heart, baked or roasted, no added fat	770	0	28.1000000000000014	7.90000000000000036
1872	Lamb, heart, raw	510	0	17.8000000000000007	5.59999999999999964
1873	Lamb, intestine, simmered or boiled, no added fat	348	0	14.4000000000000004	2.79999999999999982
1874	Lamb, kebab, baked, roasted, fried, grilled or BBQd, no added fat, no added marinade	691	0	25.8999999999999986	6.79999999999999982
1875	Lamb, kebab, marinated, baked, roasted, fried, grilled or BBQd, fat not further defined	1110	3.79999999999999982	25.3999999999999986	16.3000000000000007
1876	Lamb, kidney, raw	383	0	17.1000000000000014	2.5
1877	Lamb, kidney, simmered or boiled, no added fat	611	0	26.6000000000000014	4.29999999999999982
1878	Lamb, leg (leg roast, mini roast, chump chop), separable fat, baked or roasted, no added fat	2251	0	16.1999999999999993	53.3999999999999986
1879	Lamb, leg (leg roast, mini roast, chump chop), separable fat, raw	2315	0	10.8000000000000007	57.6000000000000014
1880	Lamb, leg roast, fully-trimmed, baked or roasted, no added fat	833	0	29.6999999999999993	8.80000000000000071
1881	Lamb, leg roast, fully-trimmed, raw	587	0	20.5	6.5
1882	Lamb, leg roast, semi-trimmed, baked or roasted, no added fat	840	0	29.6999999999999993	9.09999999999999964
1883	Lamb, leg roast, semi-trimmed, raw	604	0	20.3999999999999986	7
1884	Lamb, leg roast, separable lean, baked or roasted, no added fat	742	0	30.6000000000000014	6
1885	Lamb, leg roast, separable lean, raw	477	0	21.1000000000000014	3.20000000000000018
1886	Lamb, leg roast, untrimmed, baked or roasted, no added fat	958	0	28.5	12.8000000000000007
1887	Lamb, leg roast, untrimmed, raw	786	0	19.3999999999999986	12.3000000000000007
1888	Lamb, liver, fried, grilled or BBQd, fat not further defined	902	0	25.6000000000000014	11.4000000000000004
1889	Lamb, liver, fried, grilled or BBQd, no added fat	1012	0	26.5	13.6999999999999993
1890	Lamb, liver, raw	680	0	21.3999999999999986	7.5
1891	Lamb, loin chop, fully-trimmed, baked, roasted, fried, grilled or BBQd, no added fat	914	0	29.1000000000000014	11.3000000000000007
1892	Lamb, loin chop, fully-trimmed, raw	737	0	27.8999999999999986	7.09999999999999964
1893	Lamb, loin chop, semi-trimmed, baked, roasted, fried, grilled or BBQd, fat not further defined	1112	0	31.8000000000000007	15.4000000000000004
1894	Lamb, loin chop, semi-trimmed, baked, roasted, fried, grilled or BBQd, no added fat	953	0	28.6999999999999993	12.5999999999999996
1895	Lamb, loin chop, semi-trimmed, raw	856	0	26.6000000000000014	10.9000000000000004
1896	Lamb, loin chop, separable lean, grilled or BBQd, no added fat	843	0	29.8000000000000007	9.09999999999999964
1897	Lamb, loin chop, separable lean, raw	671	0	28.6000000000000014	5
1898	Lamb, loin chop, untrimmed, baked, roasted, fried, grilled or BBQd, fat not further defined	1614	0	26.3999999999999986	31.5
1899	Lamb, loin chop, untrimmed, baked, roasted, fried, grilled or BBQd, no added fat	1154	0	26.8000000000000007	18.8999999999999986
1900	Lamb, loin chop, untrimmed, raw	1276	0	22	24.3999999999999986
1901	Lamb, loin, separable fat, grilled or BBQd, no added fat	2251	0	16.1999999999999993	53.3999999999999986
1902	Lamb, loin, separable fat, raw	2315	0	10.8000000000000007	57.6000000000000014
1903	Lamb, mince, baked, roasted, fried, stir-fried, grilled or BBQd, fat not further defined	961	0	29	12.5999999999999996
1904	Lamb, mince, baked, roasted, fried, stir-fried, grilled or BBQd, no added fat	729	0	24.3999999999999986	8.5
1905	Lamb, mince, raw	602	0	20.3999999999999986	6.90000000000000036
1906	Lamb, mini roast, fully-trimmed, baked or roasted, no added fat	696	0	27.6999999999999993	6.09999999999999964
1907	Lamb, mini roast, fully-trimmed, raw	582	0	21.6999999999999993	5.79999999999999982
1908	Lamb, mini roast, semi-trimmed, baked or roasted, no added fat	779	0	27.1000000000000014	8.59999999999999964
1909	Lamb, mini roast, semi-trimmed, raw	662	0	21.1999999999999993	8.19999999999999929
1910	Lamb, mini roast, separable lean, baked or roasted, no added fat	680	0	27.8000000000000007	5.59999999999999964
1911	Lamb, mini roast, separable lean, raw	546	0	21.8999999999999986	4.70000000000000018
1912	Lamb, mini roast, untrimmed, baked or roasted, no added fat	858	0	26.5	11
1913	Lamb, mini roast, untrimmed, raw	782	0	20.3999999999999986	11.8000000000000007
1914	Lamb, rib, cooked, with or without added fat	1309	0.699999999999999956	24.8000000000000007	23.5
1915	Lamb, roasting cuts, fully-trimmed, baked or roasted, no added fat	802	0	29.1999999999999993	8.30000000000000071
1916	Lamb, roasting cuts, fully-trimmed, boiled, casseroled, microwaved, poached, steamed or stewed, no added fat	760	0	26.1000000000000014	8.5
1917	Lamb, roasting cuts, fully-trimmed, raw	608	0	20.8999999999999986	6.79999999999999982
1918	Lamb, roasting cuts, semi-trimmed, baked or roasted, no added fat	909	0	28.1999999999999993	11.5999999999999996
1919	Lamb, roasting cuts, semi-trimmed, raw	723	0	20.1999999999999993	10.3000000000000007
1920	Lamb, roasting cuts, untrimmed, baked or roasted, no added fat	1035	0	23.6999999999999993	17.1000000000000014
1921	Lamb, roasting cuts, untrimmed, boiled, casseroled, microwaved, poached, steamed or stewed, no added fat	1060	0	24.3000000000000007	17.5
1922	Lamb, roasting cuts, untrimmed, raw	848	0	19.5	14
1923	Lamb, rump, separable lean, grilled or BBQd, no added fat	957	0	34.1000000000000014	10.1999999999999993
1924	Lamb, rump, separable lean, raw	542	0	22.5	4.29999999999999982
1925	Lamb, shank, fully-trimmed, baked, roasted, fried, grilled or BBQd, fat not further defined	925	0	23.6000000000000014	14.1999999999999993
1926	Lamb, shank, fully-trimmed, baked, roasted, fried, grilled or BBQd, no added fat	853	0	24.1000000000000014	12
1927	Lamb, shank, fully-trimmed, boiled, casseroled, microwaved, poached, steamed, or stewed, with or without added fat	911	0	24.3999999999999986	13.4000000000000004
1928	Lamb, shank, fully-trimmed, raw	700	0	19.6999999999999993	9.90000000000000036
1929	Lamb, shank, semi-trimmed, baked, roasted, fried, grilled or BBQd, no added fat	1068	0	22.8999999999999986	18.3000000000000007
1930	Lamb, shank, semi-trimmed, boiled, casseroled, microwaved, poached, steamed or stewed, fat not further defined	1163	0	23	20.8999999999999986
1931	Lamb, shank, semi-trimmed, boiled, casseroled, microwaved, poached, steamed or stewed, no added fat	1094	0	23.3999999999999986	18.8000000000000007
1932	Lamb, shank, semi-trimmed, raw	875	0	18.8000000000000007	15
1933	Lamb, shank, untrimmed, baked, roasted, fried, grilled or BBQd, fat not further defined	1347	0	21.1999999999999993	26.6000000000000014
1934	Lamb, shank, untrimmed, boiled, casseroled, microwaved, poached, steamed or stewed, fat not further defined	1381	0	21.8000000000000007	27.3000000000000007
1935	Lamb, shank, untrimmed, boiled, casseroled, microwaved, poached, steamed, or stewed, no added fat	1316	0	22.1999999999999993	25.3999999999999986
1936	Lamb, shank, untrimmed, raw	1053	0	17.8000000000000007	20.3000000000000007
1937	Lamb, steak, fully-trimmed, baked, roasted, fried, grilled or BBQd, fat not further defined	784	0	25.8999999999999986	9.30000000000000071
1938	Lamb, steak, fully-trimmed, baked, roasted, fried, grilled or BBQd, no added fat	696	0	27.6999999999999993	6.09999999999999964
1939	Lamb, steak, fully-trimmed, raw	582	0	21.6999999999999993	5.79999999999999982
1940	Lamb, steak, semi-trimmed, baked, roasted, fried, grilled or BBQd, no added fat	779	0	27.1000000000000014	8.59999999999999964
1941	Lamb, steak, semi-trimmed, raw	662	0	21.1999999999999993	8.19999999999999929
1942	Lamb, steak, separable lean, baked or roasted, no added fat	680	0	27.8000000000000007	5.59999999999999964
1943	Lamb, steak, separable lean, raw	546	0	21.8999999999999986	4.70000000000000018
1944	Lamb, steak, untrimmed, baked, roasted, fried, grilled or BBQd, no added fat	858	0	26.5	11
1945	Lamb, steak, untrimmed, raw	782	0	20.3999999999999986	11.8000000000000007
1946	Lamb, stir-fry cuts, fully-trimmed, cooked, no added fat	720	0	27.8000000000000007	6.70000000000000018
1947	Lamb, stir-fry cuts, fully-trimmed, raw	569	0	21.6999999999999993	5.40000000000000036
1948	Lamb, stir-fry strips, fully-trimmed, baked, roasted, fried, stir-fried, grilled or BBQd, fat not further defined	739	0	26.1000000000000014	8
1949	Lamb, stir-fry strips, fully-trimmed, baked, roasted, fried, stir-fried, grilled or BBQd, no added fat	770	0	28	7.90000000000000036
1950	Lamb, stir-fry strips, fully-trimmed, boiled, casseroled, microwaved, poached, steamed or stewed, with or without added fat	718	0	27	7
1951	Lamb, stir-fry strips, fully-trimmed, raw	544	0	21.8000000000000007	4.70000000000000018
1952	Lamb, stir-fry strips, separable lean, fried or stir fried, no added fat	763	0	28.1000000000000014	7.70000000000000018
1953	Lamb, stir-fry strips, separable lean, raw	528	0	21.8999999999999986	4.20000000000000018
1954	Lamb, stir-fry strips, untrimmed, baked, roasted, fried, stir-fried, grilled or BBQd, fat not further defined	779	0	25.8000000000000007	9.19999999999999929
1955	Lamb, stir-fry strips, untrimmed, baked, roasted, fried, stir-fried, grilled or BBQd, no added fat	781	0	28	8.30000000000000071
1956	Lamb, stir-fry strips, untrimmed, raw	578	0	21.6000000000000014	5.70000000000000018
1957	Lamb, tongue, raw	834	0	15.3000000000000007	15.5
1958	Lamb, tongue, simmered or boiled, no added fat	1158	0	23.6999999999999993	20.3999999999999986
1959	Lard	3703	0	0.200000000000000011	100
1960	Lecithin, soy, granules	2620	4.40000000000000036	6	62.3999999999999986
1961	Leek, baked, roasted, fried, stir-fried, grilled or BBQd, fat not further defined	375	4.20000000000000018	2.39999999999999991	6.40000000000000036
1962	Leek, baked, roasted, fried, stir-fried, grilled or BBQd, no added fat	164	4.5	2.5	0.5
1963	Leek, boiled, casseroled, microwaved, poached, steamed or stewed, added fat not further defined	329	3.89999999999999991	2.20000000000000018	5.40000000000000036
1964	Leek, boiled, microwaved or steamed, drained	151	4.09999999999999964	2.29999999999999982	0.400000000000000022
1965	Leek, raw	136	3.70000000000000018	2.10000000000000009	0.400000000000000022
1966	Legumes, mixed, for use in homemade soup recipes	416	1.39999999999999991	6.5	0.900000000000000022
1967	Lemon butter, homemade	1260	43.1000000000000014	2.79999999999999982	13.5999999999999996
1968	Lemon, peeled, raw	115	1.80000000000000004	0.599999999999999978	0.200000000000000011
1969	Lemon peel, raw	121	0	1.5	0.299999999999999989
1970	Lemon, preserved	93	1.19999999999999996	0.599999999999999978	0.200000000000000011
1971	Lentil, dried	1468	2.20000000000000018	24.6999999999999993	2
1972	Lentil, dried, cooked	354	0.5	6.79999999999999982	0.400000000000000022
1973	Lentil, green or brown, cooked	595	0.900000000000000022	10	0.800000000000000044
1974	Lentil, green or brown, dried	1439	2.20000000000000018	24.1999999999999993	2
1975	Lentil, red, cooked	458	0.699999999999999956	7.70000000000000018	0.599999999999999978
1976	Lentil, red, dried	1498	2.20000000000000018	25.3000000000000007	2
1977	Lettuce, baked, roasted, fried, stir-fried, grilled or BBQd, with or without added fat	89	1.69999999999999996	1.69999999999999996	0.299999999999999989
1978	Lettuce, boiled, casseroled, microwaved, poached, steamed or stewed, with or without added fat	73	1.39999999999999991	1.39999999999999991	0.299999999999999989
1979	Lettuce, cos, raw	80	1.80000000000000004	1.39999999999999991	0.299999999999999989
1980	Lettuce, iceberg, raw	38	0.400000000000000022	0.900000000000000022	0.100000000000000006
1981	Lettuce, mignonette, raw	64	1.10000000000000009	1.30000000000000004	0.299999999999999989
1982	Lettuce, raw, not further defined	62	1.19999999999999996	1.19999999999999996	0.200000000000000011
1983	Licorice, allsorts	1498	74.7000000000000028	1.89999999999999991	0.299999999999999989
1984	Licorice, black	1345	36.7999999999999972	4.90000000000000036	0.800000000000000044
1985	Licorice, chocolate-coated	1604	42.1000000000000014	5.70000000000000018	9.69999999999999929
1986	Licorice, flavoured	1345	36.7999999999999972	4.90000000000000036	0.800000000000000044
1987	Lime, native, fruit	137	0.400000000000000022	0.100000000000000006	2.70000000000000018
1988	Lime, peeled, raw	122	1.19999999999999996	0.800000000000000044	0.200000000000000011
1989	Ling, baked, roasted, fried, grilled or BBQd, no added fat	475	0	26	0.900000000000000022
1990	Ling, baked, roasted, grilled, BBQd, fried or deep fried, fat not further defined	700	0	24.6999999999999993	7.59999999999999964
1991	Ling, coated, baked, roasted, grilled, BBQd, fried or deep fried, fat not further defined	783	0.400000000000000022	20.3999999999999986	8.69999999999999929
1992	Ling, raw	346	0	19	0.599999999999999978
1993	Liqueur, 25% v/v alcohol, not cream based	646	3.70000000000000018	0	0
1994	Liqueur, advocaat	1016	24.3999999999999986	4.20000000000000018	5.79999999999999982
2187	Milk, powder, goat, regular fat	2048	36.5	27.3000000000000007	27.1000000000000014
1995	Liqueur, cream-based, coffee flavour	1363	20.8000000000000007	2.79999999999999982	15.6999999999999993
1996	Liqueur, cream-based, non-coffee flavours	1379	21.3999999999999986	2.89999999999999991	16.1999999999999993
1997	Lobster or crayfish, flesh, coated, fried or deep-fried, fat not further defined	949	0	15.3000000000000007	13.0999999999999996
1998	Lobster or crayfish, flesh, purchased steamed, poached or boiled, no added fat	407	0	22	0.900000000000000022
1999	Loquat, peeled, raw	122	4.90000000000000036	1	0.200000000000000011
2000	Lychee, peeled, canned	283	15.4000000000000004	0.599999999999999978	0
2001	Lychee, peeled, raw	296	16.1999999999999993	1.10000000000000009	0.100000000000000006
2002	Macaroni & cheese, homemade, cooked unfilled pasta, homemade cheese sauce	645	0.900000000000000022	5.5	5.29999999999999982
2003	Mackerel, baked, roasted, fried, grilled or BBQd, no added fat	768	0	26.3999999999999986	8.59999999999999964
2004	Mackerel, baked, roasted, grilled, BBQd, fried or deep fried, fat not further defined	895	0	25.6000000000000014	12.4000000000000004
2005	Mackerel, canned	1063	2.89999999999999991	19.1999999999999993	18.6000000000000014
2006	Mackerel, coated, takeaway outlet, deep fried	1107	0.100000000000000006	18.1999999999999993	18.8000000000000007
2007	Mackerel, raw	561	0	19.3000000000000007	6.29999999999999982
2008	Maltodextrin	1700	0	0	0
2009	Mandarin, canned in natural juice	222	11.5999999999999996	0.5	0.100000000000000006
2010	Mandarin, canned in syrup	241	13.4000000000000004	0.400000000000000022	0.100000000000000006
2011	Mandarin, canned in syrup, drained	254	13.5999999999999996	0.5	0.200000000000000011
2012	Mandarin, canned in syrup, syrup only	223	13.1999999999999993	0.200000000000000011	0
2013	Mandarin, peeled, raw	165	7.79999999999999982	0.800000000000000044	0.200000000000000011
2014	Mango, peeled, raw	249	12.0999999999999996	1	0.200000000000000011
2015	Mango, pulped, canned	270	13.5999999999999996	1	0.200000000000000011
2016	Margarine, cooking	2983	0.800000000000000044	0.599999999999999978	80
2017	Margarine spread, monounsaturated (65% fat)	2445	0	0.299999999999999989	65.9000000000000057
2018	Margarine spread, monounsaturated (65% fat), reduced salt (sodium = 300 mg/100 g)	2565	0	1	68.9000000000000057
2019	Margarine spread, monounsaturated (65% fat), reduced salt (sodium = 360mg/100 g)	2565	0	1	68.9000000000000057
2020	Margarine spread, monounsaturated (70%), reduced salt (sodium = 350 mg/100 g), added phytosterols	2820	0	0.699999999999999956	75.9000000000000057
2021	Margarine spread, monounsaturated (80% fat), rice bran oil, unfortified	3003	0	0.299999999999999989	81
2022	Margarine spread, monounsaturated, not further defined	2306	0	0.800000000000000044	62
2023	Margarine spread, monounsaturated or polyunsaturated, not further defined	2272	0	0.699999999999999956	61.1000000000000014
2024	Margarine spread, monounsaturated or polyunsaturated, reduced fat (<50% fat), not further defined	1661	0	0.900000000000000022	44.5
2025	Margarine spread, monounsaturated or polyunsaturated, reduced fat (<50% fat), regular salt	1830	0	1	49
2026	Margarine spread, monounsaturated or polyunsaturated, reduced fat (<50% fat) & salt (sodium ~360 mg)	1648	0	0.900000000000000022	44.1000000000000014
2027	Margarine spread, monounsaturated or polyunsaturated, reduced salt, not further defined	2225	0	0.900000000000000022	59.7000000000000028
2028	Margarine spread, monounsaturated or polyunsaturated, regular fat (>50% fat), not further defined	2492	0	0.599999999999999978	67.0999999999999943
2029	Margarine spread, monounsaturated or polyunsaturated, regular fat (>50% fat) & reduced salt (sodium <360 mg)	2546	0	0.900000000000000022	68.4000000000000057
2030	Margarine spread, monounsaturated or polyunsaturated, regular fat (>50% fat) & salt	2485	0	0.200000000000000011	67.0999999999999943
2031	Margarine spread, monounsaturated or polyunsaturated, regular salt, not further defined	2448	0	0.299999999999999989	66
2032	Margarine spread, monounsaturated, reduced fat (25% fat) & salt (sodium = 350 mg/100 g), added vitamin E & phytosterols	862	0	0.699999999999999956	23
2033	Margarine spread, monounsaturated, reduced fat (30% fat) & salt (sodium = 350 mg/100 g)	1164	0	1	31
2034	Margarine spread, monounsaturated, reduced fat (45% fat) & salt (sodium = 350 mg/100 g), added phytosterols	1750	0	0.699999999999999956	47
2035	Margarine spread, monounsaturated, reduced fat (50% fat)	1830	0	1	49
2036	Margarine spread, monounsaturated, reduced fat (<50% fat), not further defined	1718	0	0.900000000000000022	46
2037	Margarine spread, monounsaturated, reduced fat (<50% fat) & reduced salt (sodium ~360 mg)	1702	0	0.900000000000000022	45.6000000000000014
2038	Margarine spread, monounsaturated, reduced fat (50% fat) & salt (sodium = 350 mg/100 g)	1830	0	1	49
2039	Margarine spread, monounsaturated, reduced fat (50% fat) & salt (sodium = 350 mg/100 g), no added milk	1924	0	0	52
2040	Margarine spread, monounsaturated, reduced fat (50% fat) & salt (sodium = 465 mg/100 g)	1867	0	1	50
2041	Margarine spread, monounsaturated, reduced fat (60% fat), no added salt or milk	2237	0	1	60
2042	Margarine spread, monounsaturated, regular (>65% fat), not further defined	2473	0	0.699999999999999956	66.5
2043	Margarine spread, monounsaturated, regular (>65% fat) & reduced salt (sodium <360 mg)	2558	0	1	68.7000000000000028
2044	Margarine spread, olive oil blend (50% fat), reduced salt (sodium = 360 mg/100 g), added phytosterols	1793	0	1	48
2045	Margarine spread, olive oil blend (55% fat), reduced salt (sodium = 350mg/100 g)	2052	0	1	55
2046	Margarine spread, olive oil blend, (65% fat), reduced salt (sodium = 340 mg/100 g), no added milk, added vitamin E	2405	0	0	65
2047	Margarine spread, olive oil blend (65% fat), reduced salt (sodium = 360mg/100 g)	2422	0	1	65
2048	Margarine spread, polyunsaturated (60% fat), reduced salt (Na=340 mg/100 g), no added milk, added vitamin E & phytosterols	2183	0	0	59
2049	Margarine spread, polyunsaturated (65% fat), reduced salt (sodium = 360 mg/100 g), added phytosterols	2422	0	1	65
2050	Margarine spread, polyunsaturated (70% fat)	2552	0	0	69
2051	Margarine spread, polyunsaturated (70% fat), reduced salt (sodium = 280 mg/100g)	2636	0	1	70.7999999999999972
2052	Margarine spread, polyunsaturated (70% fat), reduced salt (sodium = 340 mg/100 g), no added milk, added vitamin E	2590	0	0	70
2053	Margarine spread, polyunsaturated, not further defined	2210	0	0.5	59.5
2118	Meringue, plain, homemade from basic ingredients	1510	89.0999999999999943	5	0
2054	Margarine spread, polyunsaturated, reduced fat (25% fat) & salt (sodium = 360 mg/100 g)	890	0	1	23.6000000000000014
2055	Margarine spread, polyunsaturated, reduced fat (~25% fat) & salt (sodium = 360 mg/100 g), added phytosterols	857	0	1	22.6999999999999993
2056	Margarine spread, polyunsaturated, reduced fat (40% fat), no added salt or milk	1462	0	0	39.5
2057	Margarine spread, polyunsaturated, reduced fat (~40% fat) & salt (sodium = 360 mg/100 g), added phytosterols	1534	0	1	41
2058	Margarine spread, polyunsaturated, reduced fat (50% fat) & salt (sodium = 340 mg/100 g), no added milk, added vitamin E	1813	0	0	49
2059	Margarine spread, polyunsaturated, reduced fat (50% fat) & salt (sodium = 360 mg/100 g)	1756	0	1	47
2060	Margarine spread, polyunsaturated, reduced fat (<50% fat) & salt (sodium <360 mg)	1594	0	0.800000000000000044	42.7000000000000028
2061	Margarine spread, polyunsaturated, reduced fat (60% fat), sodium = 790 mg/100 g	2126	0	1	57
2062	Margarine spread, polyunsaturated, regular (>50% fat), not further defined	2532	0	0.299999999999999989	68.2999999999999972
2063	Margarine spread, polyunsaturated, regular (>50% fat) & reduced salt (sodium <360 mg)	2518	0	0.599999999999999978	67.7999999999999972
2064	Marmalade, cumquat (kumquat), regular	1061	65.4000000000000057	0.100000000000000006	0
2065	Marmalade, ginger, reduced sugar	593	27.8999999999999986	0.100000000000000006	0.100000000000000006
2066	Marmalade, ginger, regular	1037	55.7000000000000028	0.100000000000000006	0.100000000000000006
2067	Marmalade, lime or lemon, reduced sugar	580	32.2999999999999972	0.599999999999999978	0.200000000000000011
2068	Marmalade, lime or lemon, regular	1061	65.4000000000000057	0.100000000000000006	0
2069	Marmalade, orange, no added sugar (100% fruit)	782	44.8999999999999986	1.30000000000000004	0.299999999999999989
2070	Marmalade, orange, reduced sugar	602	34.6000000000000014	0.699999999999999956	0.100000000000000006
2071	Marmalade, orange, regular	1061	65.4000000000000057	0.100000000000000006	0
2072	Marmalade, regular, not further defined	1058	64.2000000000000028	0.100000000000000006	0
2073	Marshmallow, plain or flavoured	1374	62	3.89999999999999991	0
2074	Marzipan, almond paste, added sugar	1717	54.1000000000000014	7.40000000000000036	18.1000000000000014
2075	Mayonnaise, commercial, 97% fat free	534	21	0.900000000000000022	2.70000000000000018
2076	Mayonnaise, commercial, low fat	557	16.1000000000000014	0.699999999999999956	5.29999999999999982
2077	Mayonnaise, commercial, not further defined	2383	6.5	0.900000000000000022	60.2999999999999972
2078	Mayonnaise, commercial, reduced fat	1187	18.6000000000000014	0.5	21.1999999999999993
2079	Mayonnaise, commercial, regular fat	2911	2.5	0.900000000000000022	76.7000000000000028
2080	Mayonnaise, homemade	3216	0.100000000000000006	2.10000000000000009	85.7000000000000028
2081	Mayonnaise, soybean oil, homemade	3216	0.100000000000000006	2.10000000000000009	85.7000000000000028
2082	Meatball or rissole, beef, commercial, cooked	1022	1.89999999999999991	25	11.6999999999999993
2083	Meatball or rissole, beef mince, >10% fat, homemade, raw	718	0.900000000000000022	18.3000000000000007	8.40000000000000036
2084	Meatball or rissole, beef mince, ~5-10% fat, homemade, raw	677	0.900000000000000022	18.1999999999999993	7.40000000000000036
2085	Meatball or rissole, beef mince, <5% fat, homemade, baked, roasted, fried, grilled or BBQd, fat not further defined	833	1.19999999999999996	24.6000000000000014	7.79999999999999982
2086	Meatball or rissole, beef mince, <5% fat, homemade, baked, roasted, fried, grilled or BBQd, no added fat	750	1.19999999999999996	25.1000000000000014	5.29999999999999982
2087	Meatball or rissole, beef mince, <5% fat, homemade, raw	555	0.900000000000000022	18.6000000000000014	3.89999999999999991
2088	Meatball or rissole, beef mince, homemade, baked, roasted, fried, grilled or BBQd, fat not further defined	959	1.19999999999999996	24.3000000000000007	11.4000000000000004
2089	Meatball or rissole, beef mince, homemade, baked, roasted, fried, grilled or BBQd, no added fat	832	1.19999999999999996	24.8999999999999986	7.59999999999999964
2090	Meatball or rissole, beef mince, homemade, raw	616	0.900000000000000022	18.3999999999999986	5.59999999999999964
2091	Meatball or rissole, chicken mince, commercial, breadcrumb coating, cooked, fat not further defined	1079	1.30000000000000004	16.1999999999999993	14.0999999999999996
2092	Meatball or rissole, chicken mince, homemade, baked, roasted, fried, grilled or BBQd, fat not further defined	870	1.30000000000000004	21.3999999999999986	9.80000000000000071
2093	Meatball or rissole, chicken mince, homemade, baked, roasted, fried, grilled or BBQd, no added fat	786	1.30000000000000004	21.8000000000000007	7.20000000000000018
2094	Meatball or rissole, chicken mince, homemade from basic ingredients, raw	574	1	15.9000000000000004	5.29999999999999982
2095	Meatball or rissole, kangaroo mince, cooked, with or without added fat	482	0.900000000000000022	23	2
2096	Meatball or rissole, lamb mince, homemade, baked, roasted, fried, grilled or BBQd, fat not further defined	956	1.30000000000000004	23.8999999999999986	11.3000000000000007
2097	Meatball or rissole, lamb mince, homemade, baked, roasted, fried, grilled or BBQd, no added fat	868	1.30000000000000004	24.3000000000000007	8.59999999999999964
2098	Meatball or rissole, lamb mince, homemade, raw	599	0.900000000000000022	16.8000000000000007	5.90000000000000036
2099	Meatball or rissole, pork mince, homemade, baked, roasted, fried, grilled or BBQd, fat not further defined	1081	1.30000000000000004	22.8999999999999986	15
2100	Meatball or rissole, pork mince, homemade, baked, roasted, fried, grilled or BBQd, no added fat	995	1.30000000000000004	23.3999999999999986	12.4000000000000004
2101	Meatball or rissole, pork mince, homemade, raw	687	0.900000000000000022	16.1999999999999993	8.59999999999999964
2102	Meatloaf, commercial, all meats	1080	1.30000000000000004	26	15.5
2103	Meatloaf, homemade, beef	977	1.60000000000000009	27	11.0999999999999996
2104	Meatloaf, homemade, chicken	822	1.69999999999999996	23.6000000000000014	8
2105	Meat paste, commercial	861	1.10000000000000009	12.1999999999999993	13.9000000000000004
2106	Meat, wild caught, cooked	684	0	30.1000000000000014	4.20000000000000018
2107	Melon, bitter, fresh or frozen, baked, roasted, fried, stir-fried, grilled or BBQd, fat not further defined	251	0.100000000000000006	1	5.5
2108	Melon, bitter, fresh or frozen, baked, roasted, fried, stir-fried, grilled or BBQd, no added fat	51	0.100000000000000006	1	0
2109	Melon, bitter, fresh or frozen, raw	46	0.100000000000000006	0.900000000000000022	0
2110	Melon, hairy, fresh or frozen, raw	61	1.69999999999999996	0.699999999999999956	0
2111	Melon, honey dew, skin not further defined, peeled raw	128	5.79999999999999982	0.800000000000000044	0.299999999999999989
2112	Melon, honey dew, white skin, peeled, raw	149	7.09999999999999964	0.699999999999999956	0.299999999999999989
2113	Melon, honey dew, yellow skin, peeled, raw	107	4.40000000000000036	0.800000000000000044	0.299999999999999989
2114	Melon, peeled, raw, not further defined	100	4.90000000000000036	0.400000000000000022	0.200000000000000011
2115	Melon, rockmelon (cantaloupe), peeled, raw	99	4.70000000000000018	0.5	0.100000000000000006
2116	Melon, watermelon, peeled, raw	100	5	0.400000000000000022	0.200000000000000011
2119	Mexican nachos, corn chips, beans, with cheese, guacamole & salsa	899	1.19999999999999996	6.70000000000000018	12.4000000000000004
2120	Mexican nachos, corn chips, beans, with cheese & salsa	930	1.19999999999999996	7.59999999999999964	11.5
2121	Mexican nachos, corn chips, beef & bean, with cheese, guacamole & salsa	973	1.30000000000000004	11.9000000000000004	13.4000000000000004
2122	Mexican nachos, corn chips, beef & bean, with cheese & salsa	1012	1.39999999999999991	13.5	12.6999999999999993
2123	Mexican nachos, corn chips, beef, with cheese, guacamole & salsa	1091	1.5	17.1000000000000014	15.3000000000000007
2124	Mexican nachos, corn chips, beef, with cheese & salsa	1147	1.60000000000000009	19.5	14.9000000000000004
2125	Mexican nachos, corn chips, with cheese, guacamole,  & salsa	969	1.80000000000000004	6	15
2126	Mexican nachos, corn chips, with cheese,  & salsa	842	2.60000000000000009	5.79999999999999982	11.4000000000000004
2127	Mexican nachos, corn chips, with cheese & salsa	1083	2.70000000000000018	7.29999999999999982	14.9000000000000004
2128	Mexican nachos, corn chips, with salsa	980	3.20000000000000018	3.79999999999999982	11.5999999999999996
2129	Milk, almond, fluid	143	1.89999999999999991	0.599999999999999978	2.70000000000000018
2130	Milk, canned, evaporated, reduced fat (~ 2%)	381	10.5999999999999996	7.90000000000000036	2.10000000000000009
2131	Milk, canned, evaporated, regular	590	9.90000000000000036	7.59999999999999964	8.09999999999999964
2132	Milk, canned, evaporated, skim (<0.5% fat)	317	10.5999999999999996	7.79999999999999982	0.400000000000000022
2133	Milk, canned, sweetened, condensed, regular	1362	55	8.30000000000000071	9.19999999999999929
2134	Milk, canned, sweetened, condensed, skim (~0.2% fat)	1147	60.3999999999999986	10.0999999999999996	0.200000000000000011
2135	Milk, cow, fluid, flavoured, all other flavours, reduced fat	255	9.19999999999999929	3.10000000000000009	1.5
2136	Milk, cow, fluid, flavoured, all other flavours, regular fat	328	9	3.20000000000000018	3.5
2137	Milk, cow, fluid, flavoured, chocolate, not further defined	323	8.69999999999999929	3.39999999999999991	3.10000000000000009
2138	Milk, cow, fluid, flavoured, chocolate, reduced fat	252	8.30000000000000071	3.29999999999999982	1.69999999999999996
2139	Milk, cow, fluid, flavoured, chocolate, reduced fat, added Ca & vitamin D	241	8.30000000000000071	3.29999999999999982	1.39999999999999991
2140	Milk, cow, fluid, flavoured, chocolate, reduced fat, added vitamins & minerals	351	10.4000000000000004	1.5	1.5
2141	Milk, cow, fluid, flavoured, chocolate, regular fat	338	8.80000000000000071	3.60000000000000009	3.5
2142	Milk, cow, fluid, flavoured, coffee, not further defined	323	10.4000000000000004	3.29999999999999982	2.60000000000000009
2143	Milk, cow, fluid, flavoured, coffee, reduced fat	263	9.80000000000000071	3.5	1.19999999999999996
2144	Milk, cow, fluid, flavoured, coffee, regular fat	349	10.5999999999999996	3.20000000000000018	3.20000000000000018
2145	Milk, cow, fluid, flavoured, strawberry, reduced fat	255	9.19999999999999929	3.10000000000000009	1.5
2146	Milk, cow, fluid, flavoured, strawberry, regular fat	328	9	3.20000000000000018	3.5
2147	Milk, cow, fluid, lactose free, reduced fat (~1%)	180	4.79999999999999982	3.39999999999999991	1.19999999999999996
2148	Milk, cow, fluid, lactose free, regular fat (~3.5%)	267	4.79999999999999982	3.20000000000000018	3.60000000000000009
2149	Milk, cow, fluid, lactose free, unfortified, not further defined	227	4.79999999999999982	3.29999999999999982	2.5
2150	Milk, cow, fluid, prepared from dry powder, regular fat, standard dilution	293	5.5	3.89999999999999991	3.79999999999999982
2151	Milk, cow, fluid, prepared from dry powder, regular fat, standard dilution	304	6.09999999999999964	3.60000000000000009	3.89999999999999991
2152	Milk, cow, fluid, prepared from dry powder, skim, standard dilution	156	5.40000000000000036	3.89999999999999991	0.100000000000000006
2153	Milk, cow, fluid, prepared from dry powder, skim, standard dilution	163	6	3.70000000000000018	0.100000000000000006
2154	Milk, cow, fluid, reduced fat (1%)	191	5	3.60000000000000009	1.19999999999999996
2155	Milk, cow, fluid, reduced fat (1-2%), not further defined	198	5.20000000000000018	3.70000000000000018	1.30000000000000004
2156	Milk, cow, fluid, reduced fat (1.5%), added Ca, Mg, Zn & vitamin D	223	5.90000000000000036	4.5	1.39999999999999991
2157	Milk, cow, fluid, reduced fat (1.5%), added omega 3 polyunsaturates	213	5.09999999999999964	4.5	1.39999999999999991
2158	Milk, cow, fluid, reduced fat (1.5%), increased Ca, folate & vitamin D	203	5.40000000000000036	4	1.19999999999999996
2159	Milk, cow, fluid, reduced fat (~1.5%), increased protein (~4%)	213	5.40000000000000036	4	1.60000000000000009
2160	Milk, cow, fluid, reduced fat (1%), A2	191	5	3.60000000000000009	1.19999999999999996
2161	Milk, cow, fluid, reduced fat (1%), added milk solids	207	6.09999999999999964	3.89999999999999991	1.10000000000000009
2162	Milk, cow, fluid, reduced fat (1%), added phytosterols	192	5.59999999999999964	3.60000000000000009	1
2163	Milk, cow, fluid, reduced fat (1%), increased Ca, added Fe & vitamins C & D	215	6.59999999999999964	3.89999999999999991	1.10000000000000009
2164	Milk, cow, fluid, reduced fat (1%), organic	179	5.09999999999999964	3.39999999999999991	1
2165	Milk, cow, fluid, regular fat (~3.5%)	281	6	3.39999999999999991	3.39999999999999991
2166	Milk, cow, fluid, regular fat (~3.5%), A2	281	6	3.39999999999999991	3.39999999999999991
2167	Milk, cow, fluid, regular fat (3.5%), added omega 3 polyunsaturates	256	5.09999999999999964	3.10000000000000009	3.20000000000000018
2168	Milk, cow, fluid, regular fat (~3.5%), not further defined	281	5.90000000000000036	3.39999999999999991	3.39999999999999991
2169	Milk, cow, fluid, regular fat (~3.5%), organic	285	4.79999999999999982	3.20000000000000018	4.09999999999999964
2170	Milk, cow, fluid, regular fat (~3.5%), raw	281	6	3.39999999999999991	3.39999999999999991
2171	Milk, cow, fluid, skim (~0.15% fat)	142	4.79999999999999982	3.60000000000000009	0.100000000000000006
2172	Milk, cow, fluid, skim (~0.15% fat), added milk solids	160	5.40000000000000036	4.09999999999999964	0.100000000000000006
2173	Milk, cow, fluid, skim (~0.15% fat), not further defined	142	4.79999999999999982	3.60000000000000009	0.100000000000000006
2174	Milk, cow, fluid, unflavoured, not further defined	233	5.5	3.5	2.20000000000000018
2175	Milk, cow, fluid, unflavoured, not further defined	281	5.79999999999999982	3.5	3.39999999999999991
2176	Milk, dairy or dairy alternative, not further defined, for use in protein drinks	213	5.09999999999999964	3.39999999999999991	1.69999999999999996
2177	Milkfish, boiled, microwaved, steamed or poached, with or without added fat	963	0	27.6999999999999993	13.3000000000000007
2178	Milkfish, raw	795	0	23.3999999999999986	10.6999999999999993
2179	Milk, goat, fluid, regular fat	207	3.60000000000000009	3.10000000000000009	2.60000000000000009
2180	Milk, human/breast, mature, fluid	286	6.79999999999999982	1.30000000000000004	4.20000000000000018
2181	Milk, oat, fluid, added calcium	220	0.100000000000000006	1.5	2
2182	Milk, oat, fluid, unfortified	222	0.100000000000000006	1.5	2.10000000000000009
2183	Milk, powder, cow, regular fat	2050	38.2999999999999972	27.1999999999999993	26.3999999999999986
2184	Milk, powder, cow, regular fat	2127	43	25.3000000000000007	27.3000000000000007
2185	Milk, powder, cow, skim	1455	50.2999999999999972	36.2999999999999972	0.900000000000000022
2186	Milk, powder, cow, skim	1519	56	34.8999999999999986	0.800000000000000044
2188	Milk, rice, fluid, added calcium	255	3.70000000000000018	0.299999999999999989	1
2189	Milk, rice, fluid, protein enriched, added calcium	159	2.79999999999999982	1.5	1.10000000000000009
2190	Milk & water, reduced fat cow milk & tap water	99	2.60000000000000009	1.89999999999999991	0.699999999999999956
2191	Milk & water, regular fat cow milk & tap water	141	3	1.69999999999999996	1.69999999999999996
2192	Milk & water, skim cow milk & tap water	71	2.39999999999999991	1.80000000000000004	0.100000000000000006
2193	Millet, boiled in water, no added fat or salt	489	0.100000000000000006	3.5	1
2194	Millet, uncooked	1489	0.400000000000000022	11.0999999999999996	4.20000000000000018
2195	Mineral water, citrus flavoured, regular	152	9.30000000000000071	0	0
2196	Mineral water, flavoured, intense sweetened or diet	5	0.200000000000000011	0	0
2197	Mineral water, natural, plain or unflavoured	0	0	0	0
2198	Mineral water, non-citrus flavoured, regular	152	9.30000000000000071	0	0
2199	Mint, raw	225	0.900000000000000022	3.10000000000000009	1.10000000000000009
2200	Mirin	1044	39.7999999999999972	0.400000000000000022	0
2201	Miso, soyabean paste	766	10.4000000000000004	12.9000000000000004	5.09999999999999964
2202	Mixed berry, cooked	202	9.69999999999999929	0.699999999999999956	0.100000000000000006
2203	Mixed berry, dried	864	34.1000000000000014	4.59999999999999964	1
2204	Mixed berry, puree	339	17.1999999999999993	0.900000000000000022	0.100000000000000006
2205	Mixed berry, raw, not further defined	138	5.5	0.699999999999999956	0.200000000000000011
2206	Moreton bay bug, cooked, with or without fat	509	0	27.5	1.10000000000000009
2207	Moreton bay bug or balmain bug, flesh, raw	407	0	22	0.900000000000000022
2208	Mortadella, processed meat	1365	0.400000000000000022	14.4000000000000004	29.3000000000000007
2209	Morwong, boiled, microwaved, steamed or poached, with or without added fat	528	0	23	3.70000000000000018
2210	Morwong, raw	544	0	19.3999999999999986	5.79999999999999982
2211	Mousse, chocolate, homemade from basic ingredients	1448	18.3000000000000007	5.40000000000000036	27.1999999999999993
2212	Mulberry, raw	139	4.29999999999999982	2.20000000000000018	0.200000000000000011
2213	Mullet, baked, roasted, grilled, BBQd, fried or deep fried, fat not further defined	964	0	25.1000000000000014	14.5
2214	Mullet, boiled, microwaved, steamed or poached, with or without added fat	559	0	22	5
2215	Mullet, coated, takeaway outlet, deep fried	1180	0.200000000000000011	15.6999999999999993	20.1999999999999993
2216	Mullet, raw	549	0	19.1999999999999993	6
2217	Mulloway, baked, roasted, grilled, BBQd, fried or deep fried, fat not further defined	681	0	27.6000000000000014	5.70000000000000018
2218	Mulloway, boiled, microwaved, steamed or poached, with or without added fat	540	0	23.1999999999999993	3.89999999999999991
2219	Mulloway, coated, fried or deep fried, fat not further defined	871	0.400000000000000022	21.8999999999999986	10.3000000000000007
2220	Mulloway, raw	435	0	20.6000000000000014	2.29999999999999982
2221	Mushroom, canned in brine, drained	81	0.5	1.5	0.5
2222	Mushroom, common, fresh or frozen, baked, roasted, fried, stir-fried, grilled or BBQd, butter, dairy blend or margarine	433	0	4.09999999999999964	8.19999999999999929
2223	Mushroom, common, fresh or frozen, baked, roasted, fried, stir-fried, grilled or BBQd, canola oil	503	0	4	10.1999999999999993
2224	Mushroom, common, fresh or frozen, baked, roasted, fried, stir-fried, grilled or BBQd, fat not further defined	497	0	4	10
2225	Mushroom, common, fresh or frozen, baked, roasted, fried, stir-fried, grilled or BBQd, no added fat	162	0	4.20000000000000018	0.800000000000000044
2226	Mushroom, common, fresh or frozen, baked, roasted, fried, stir-fried, grilled or BBQd, olive oil	503	0	4	10.1999999999999993
2227	Mushroom, common, fresh or frozen, baked, roasted, fried, stir-fried, grilled or BBQd, other oil	503	0	4	10.1999999999999993
2228	Mushroom, common, fresh or frozen, boiled, microwaved or steamed, drained	130	0	3.39999999999999991	0.599999999999999978
2229	Mushroom, common, fresh or frozen, boiled, microwaved or steamed, drained, added fat not further defined	377	0	3.29999999999999982	7.40000000000000036
2230	Mushroom, common, fresh or frozen, raw	86	0	2.29999999999999982	0.400000000000000022
2231	Mushroom, fresh or frozen, raw, not further defined	86	0	2.29999999999999982	0.400000000000000022
2232	Mushroom, oriental, fresh or frozen, baked, roasted, fried, stir-fried, grilled or BBQd, fat not further defined	497	0	4	10
2233	Mushroom, oriental, fresh or frozen, boiled, microwaved or steamed, drained	130	0	3.39999999999999991	0.599999999999999978
2234	Mushroom, oriental, fresh or frozen, boiled, microwaved or steamed, drained, added fat not further defined	377	0	3.29999999999999982	7.40000000000000036
2235	Mushroom, oriental, fresh or frozen, raw, not further defined	86	0	2.29999999999999982	0.400000000000000022
2236	Mushroom, straw, Asian, canned in brine, drained	72	0	2.20000000000000018	0.299999999999999989
2237	Mushroom, stuffed with cheese & bacon	763	1.5	10.0999999999999996	9.09999999999999964
2238	Mussel, blue, boiled, microwaved, steamed or poached, no added fat	438	0	16	2.29999999999999982
2239	Mussel, cooked, with or without added fat	441	0.5	15.5999999999999996	2.5
2240	Mussel, green, boiled, microwaved, steamed or poached, no added fat	445	1	15.3000000000000007	2.60000000000000009
2241	Mussel, smoked, canned in oil, drained	807	0	20.8000000000000007	10.4000000000000004
2242	Mustard, cream style	348	3.60000000000000009	5.79999999999999982	3.10000000000000009
2243	Mustard powder	2289	5	29.3999999999999986	39.5
2244	Mutton, all cuts, separable fat, cooked	2694	0	10.6999999999999993	67.9000000000000057
2245	Mutton, all cuts, separable fat, raw	2522	0	8.19999999999999929	64.4000000000000057
2246	Mutton-bird, cooked	884	1	21	13.8000000000000007
2247	Mutton, leg roast, fully-trimmed, baked or roasted, no added fat	881	0	28.8999999999999986	10.5
2248	Mutton, leg roast, fully-trimmed, raw	582	0	21.1000000000000014	6
2249	Mutton, leg roast, semi-trimmed, baked or roasted, no added fat	919	0	28.5	11.6999999999999993
2250	Mutton, leg roast, semi-trimmed, raw	634	0	20.8000000000000007	7.59999999999999964
2251	Mutton, leg roast, separable fat, baked or roasted, no added fat	2694	0	10.6999999999999993	67.9000000000000057
2252	Mutton, leg roast, separable fat, raw	2522	0	8.19999999999999929	64.4000000000000057
2253	Mutton, leg roast, separable lean, baked or roasted, no added fat	792	0	29.8000000000000007	7.70000000000000018
2254	Mutton, leg roast, separable lean, raw	509	0	21.6000000000000014	3.79999999999999982
2255	Mutton, leg roast, untrimmed, baked or roasted, no added fat	1093	0	26.8000000000000007	17.1999999999999993
2256	Mutton, leg roast, untrimmed, raw	811	0	19.6000000000000014	12.9000000000000004
2257	Mutton, shoulder, fully-trimmed, boiled, casseroled, microwaved, poached, steamed, or stewed, no added fat	1094	0	35.6000000000000014	13.1999999999999993
2258	Mutton, shoulder, fully-trimmed, raw	638	0	20.5	7.79999999999999982
2259	Mutton, shoulder, separable fat, boiled, casseroled, microwaved, poached, steamed, or stewed, no added fat	2694	0	10.6999999999999993	67.9000000000000057
2260	Mutton, shoulder, separable fat, raw	2522	0	8.19999999999999929	64.4000000000000057
2261	Mutton, shoulder, separable lean, boiled, casseroled, microwaved, poached, steamed, or stewed, no added fat	1041	0	36.3999999999999986	11.4000000000000004
2262	Mutton, shoulder, separable lean, raw	518	0	21.3000000000000007	4.20000000000000018
2263	Mutton, shoulder, untrimmed, boiled, casseroled, microwaved, poached, steamed, or stewed, no added fat	1137	0	34.8999999999999986	14.6999999999999993
2264	Mutton, shoulder, untrimmed, raw	717	0	20	10.1999999999999993
2265	Nectarine, stewed, sugar sweetened, no added fat	359	19.3999999999999986	1.10000000000000009	0.100000000000000006
2266	Nectarine, white, peeled or unpeeled, raw	181	8	1.19999999999999996	0.100000000000000006
2267	Nectarine, yellow, peeled, raw	185	8.30000000000000071	1.19999999999999996	0.100000000000000006
2268	Nectarine, yellow, unpeeled, raw	181	8	1.19999999999999996	0.100000000000000006
2269	Nile perch, baked, roasted, fried, grilled or BBQd, no added fat	528	0	26.6000000000000014	2.10000000000000009
2270	Nile perch, baked, roasted, grilled, BBQd, fried or deep fried, fat not further defined	750	0	25.3000000000000007	8.69999999999999929
2271	Nile perch, boiled, microwaved, steamed or poached, with or without added fat	478	0	23	2.39999999999999991
2272	Nile perch, coated, baked, roasted, grilled, BBQd, fried or deep fried, fat not further defined	821	0.400000000000000022	20.8000000000000007	9.5
2273	Nile perch, coated, takeaway outlet, deep fried	1059	0.200000000000000011	15.8000000000000007	16.8999999999999986
2274	Noodle, buckwheat or soba, boiled, drained	567	0.200000000000000011	4.20000000000000018	0.599999999999999978
2275	Noodle, buckwheat or soba, dry	1468	0.400000000000000022	10.8000000000000007	1.60000000000000009
2276	Noodle, cooked, not further defined	627	0	4.20000000000000018	3.79999999999999982
2277	Noodle, rice stick, boiled, drained	366	0	1.60000000000000009	0.299999999999999989
2278	Noodle, wheat, Asian style, cooked	608	0	6.29999999999999982	1
2279	Noodle, wheat, instant, flavoured, boiled, drained	750	0	3.70000000000000018	7.70000000000000018
2280	Noodle, wheat, instant, flavoured, boiled, undrained	281	0	1.39999999999999991	2.89999999999999991
2281	Noodle, wheat, instant, flavoured, dry, uncooked	1851	0	9.19999999999999929	19
2282	Noodle, wheat, instant, flavoured, fried or stir-fried, with or without fat	851	0	3.79999999999999982	10
2283	Noodle, wheat, instant, low fat, flavoured, boiled, drained	658	0	5.90000000000000036	2
2284	Noodle, wheat, instant, low fat, flavoured, boiled, undrained	247	0	2.20000000000000018	0.800000000000000044
2285	Noodle, wheat, instant, low fat, unflavoured, boiled, drained	658	0	5.90000000000000036	2
2286	Noodle, wheat, instant, low fat, unflavoured, boiled, undrained	247	0	2.20000000000000018	0.800000000000000044
2287	Noodle, wheat, instant, not further defined	688	0	3.5	6.90000000000000036
2288	Noodle, wheat, instant, unflavoured, boiled, drained	778	0	3.89999999999999991	8
2289	Noodle, wheat, instant, unflavoured, boiled, undrained	292	0	1.5	3
2290	Noodle, wheat, instant, unflavoured, dry, uncooked	1920	0	9.59999999999999964	19.6999999999999993
2291	Noodle, wheat with egg, plain, boiled, no added fat	601	0	5.70000000000000018	0.599999999999999978
2292	Noodle, wheat with egg, plain, dry	1479	0	12.6999999999999993	1.5
2293	Noodle, wheat, Asian style, cooked	608	0	6.29999999999999982	1
2294	Noodle, wheat, instant, flavoured, boiled, drained	750	0	3.70000000000000018	7.70000000000000018
2295	Noodle, wheat, instant, flavoured, boiled, undrained	281	0	1.39999999999999991	2.89999999999999991
2296	Noodle, wheat, instant, flavoured, dry, uncooked	1851	0	9.19999999999999929	19
2297	Noodle, wheat, instant, flavoured, fried or stir-fried, with or without fat	851	0	3.79999999999999982	10
2298	Noodle, wheat, instant, low fat, flavoured, boiled, drained	658	0	5.90000000000000036	2
2299	Noodle, wheat, instant, low fat, flavoured, boiled, undrained	247	0	2.20000000000000018	0.800000000000000044
2300	Noodle, wheat, instant, low fat, unflavoured, boiled, drained	658	0	5.90000000000000036	2
2301	Noodle, wheat, instant, low fat, unflavoured, boiled, undrained	247	0	2.20000000000000018	0.800000000000000044
2302	Noodle, wheat, instant, not further defined	688	0	3.5	6.90000000000000036
2303	Noodle, wheat, instant, unflavoured, boiled, drained	778	0	3.89999999999999991	8
2304	Noodle, wheat, instant, unflavoured, boiled, undrained	292	0	1.5	3
2305	Noodle, wheat, instant, unflavoured, dry, uncooked	1920	0	9.59999999999999964	19.6999999999999993
2306	Noodle, wheat with egg, plain, boiled, no added fat	601	0	5.70000000000000018	0.599999999999999978
2307	Noodle, wheat with egg, plain, dry	1479	0	12.6999999999999993	1.5
2308	Nougat, honey & nuts, traditional	1790	44.7999999999999972	9	22.6000000000000014
2309	Nut, almond meal	2568	3.89999999999999991	20.5	55.7999999999999972
2310	Nut, almond, with or without skin, raw, unsalted	2578	3.89999999999999991	21	55.6000000000000014
2311	Nut, almond, with or without skin, roasted, salted	2555	3.89999999999999991	20.8000000000000007	55.1000000000000014
2312	Nut, almond, with or without skin, roasted, unsalted	2654	3.89999999999999991	21	57.6000000000000014
2313	Nut, almond, without skin, blanched, unsalted	2568	3.89999999999999991	20.5	55.7999999999999972
2314	Nut, brazil, with or without skin, raw, unsalted	2886	2.10000000000000009	14.4000000000000004	68.5
2315	Nut, cashew, raw, unsalted	2544	5.5	17	49.2000000000000028
2316	Nut, cashew, roasted, coated in honey	2271	32.7999999999999972	12.0999999999999996	35
2317	Nut, cashew, roasted, salted	2582	5.40000000000000036	16.8000000000000007	50.5
2318	Nut, cashew, roasted, unsalted	2583	5.59999999999999964	17.3000000000000007	49.8999999999999986
2319	Nut, chestnut, raw, unsalted	731	3.29999999999999982	2.5	0.699999999999999956
2320	Nut, chestnut, roasted, unsalted	724	3.79999999999999982	3.39999999999999991	0.599999999999999978
2321	Nutgrass (nut grass), peeled, raw	958	1.10000000000000009	3.5	1.10000000000000009
2322	Nut, hazelnut, with or without skin, raw, unsalted	2689	4.40000000000000036	14.8000000000000007	61.3999999999999986
2323	Nut, macadamia, raw, unsalted	3018	4.5	9.19999999999999929	74
2324	Nut, macadamia, roasted, coated in honey	2604	31.1000000000000014	6.59999999999999964	52.8999999999999986
2325	Nut, macadamia, roasted, salted	3032	4.40000000000000036	9	74.5
2326	Nutmeg, dried, ground	2119	14.9000000000000004	6.40000000000000036	37.6000000000000014
2327	Nut, peanut, roasted, coated in honey	2516	16.8999999999999986	21.6999999999999993	45.7000000000000028
2328	Nut, peanut, without skin, roasted, with oil, salted	2667	4.40000000000000036	25.1000000000000014	52.7999999999999972
2329	Nut, peanut, without skin, roasted, with oil, unsalted	2667	4.40000000000000036	25.1000000000000014	52.7999999999999972
2330	Nut, peanut, with skin, raw or dry roasted, unsalted	2376	5.09999999999999964	24.6999999999999993	47.1000000000000014
2331	Nut, peanut, with skin, roasted, with oil, salted	2635	4.70000000000000018	24.3999999999999986	51.7000000000000028
2332	Nut, pecan, raw, unsalted	2973	4.29999999999999982	9.80000000000000071	71.9000000000000057
2333	Nut, pine, raw, unsalted	2925	3.39999999999999991	13	70
2334	Nut, pistachio, raw, unsalted	2542	5.90000000000000036	19.6999999999999993	50.6000000000000014
2335	Nut, pistachio, roasted, salted	2504	5.79999999999999982	19.3999999999999986	49.7999999999999972
2336	Nut, walnut, raw, unsalted	2904	2.70000000000000018	14.4000000000000004	69.2000000000000028
2337	Oat bran, unprocessed, uncooked	1620	2.10000000000000009	13.9000000000000004	7.5
2338	Oats, rolled, mixed with sugar, flavours & dried fruit, uncooked	1534	28	9	6.20000000000000018
2339	Oats, rolled, mixed with sugar or honey & other flavours, uncooked	1629	24	8.30000000000000071	7.5
2340	Oats, rolled, uncooked	1548	1	12.6999999999999993	8.90000000000000036
2341	Oats, rolled, uncooked, added fibre & Ca	1458	1.10000000000000009	14	7.09999999999999964
2342	Octopus, coated, takeaway outlet, fried, fat not further defined	892	0.100000000000000006	11.1999999999999993	14.9000000000000004
2343	Octopus, cooked, with or without added fat	324	0	16.6000000000000014	1.19999999999999996
2344	Octopus, marinated, baked, grilled, fried or BBQd, fat not further defined	374	0.699999999999999956	14.0999999999999996	3
2345	Octopus, raw	292	0	14.9000000000000004	1
2346	Oil, almond	3700	0	0	100
2347	Oil, blend of monounsaturated vegetable oils	3700	0	0	100
2348	Oil, blend of polyunsaturated vegetable oils	3700	0	0	100
2349	Oil, canola	3700	0	0	100
2350	Oil, canola & red palm blend	3698	0	0	100
2351	Oil, copha	3700	0	0.200000000000000011	99.9000000000000057
2352	Oil, cottonseed	3700	0	0	100
2353	Oil, grapeseed	3700	0	0	100
2354	Oil, linseed or flaxseed	3700	0	0	100
2355	Oil, macadamia	3700	0	0	100
2356	Oil, maize	3700	0	0	100
2357	Oil, mustard seed	3700	0	0	100
2358	Oil, not further defined	3700	0	0	100
2359	Oil, not further defined, for use in baked product recipes & deep fried takeaway foods	3700	0	0	100
2360	Oil, not further defined, for use in wet cooked vegetable recipes	3700	0	0	100
2361	Oil, olive	3700	0	0	100
2362	Oil, other than olive or canola oils, for use in home cooked meat, fish, poultry & dry cooked vegetable recipes	3700	0	0	100
2363	Oil, palm	3700	0	0	100
2364	Oil, peanut	3700	0	0	100
2365	Oil, rice bran	3700	0	0	100
2366	Oil, safflower	3700	0	0	100
2367	Oil, sesame	3700	0	0	100
2368	Oil, soybean	3700	0	0	100
2369	Oil, sunflower	3700	0	0	100
2370	Oil, vegetable	3700	0	0	100
2371	Okra, cooked, with or without added fat	310	1.39999999999999991	3.20000000000000018	5.5
2372	Okra, raw	112	1.39999999999999991	3.10000000000000009	0.200000000000000011
2373	Oligosaccharide	1700	0	0	0
2374	Olive, green or black, drained	856	0	2	20.5
2375	Olive, green, pimento stuffed, drained	388	0	0.800000000000000044	8.30000000000000071
2376	Onion, for  recipes, onion (red, white & brown), spring onion, shallots & leeks, raw	121	4.29999999999999982	1.60000000000000009	0.100000000000000006
2377	Onion, mature, brown skinned, peeled, raw	120	4.29999999999999982	1.60000000000000009	0.100000000000000006
2378	Onion, mature, peeled, fresh or frozen, baked, roasted, fried, stir-fried, grilled, BBQd, canola oil	485	6.70000000000000018	2.5	8.19999999999999929
2379	Onion, mature, peeled, fresh or frozen, baked, roasted, fried, stir-fried, grilled, BBQd, olive oil	485	6.70000000000000018	2.5	8.19999999999999929
2380	Onion, mature, peeled, fresh or frozen, baked, roasted, fried, stir-fried, grilled or BBQd, butter, dairy blend or margarine	425	6.70000000000000018	2.60000000000000009	6.59999999999999964
2381	Onion, mature, peeled, fresh or frozen, baked, roasted, fried, stir-fried, grilled or BBQd, fat not further defined	480	6.70000000000000018	2.5	8.09999999999999964
2382	Onion, mature, peeled, fresh or frozen, baked, roasted, fried, stir-fried, grilled or BBQd, no added fat	197	7.09999999999999964	2.60000000000000009	0.200000000000000011
2383	Onion, mature, peeled, fresh or frozen, baked, roasted, fried, stir-fried, grilled or BBQd, other oil	485	6.70000000000000018	2.5	8.19999999999999929
2384	Onion, mature, peeled, fresh or frozen, boiled, microwaved or steamed, drained	136	4.90000000000000036	1.80000000000000004	0.100000000000000006
2385	Onion, mature, peeled, fresh or frozen, boiled, microwaved or steamed, drained, added fat not further defined	315	4.59999999999999964	1.69999999999999996	5.09999999999999964
2386	Onion, mature, peeled, fresh or frozen, raw, not further defined	122	4.40000000000000036	1.60000000000000009	0.100000000000000006
2387	Onion, mature, red skinned, peeled, fresh or frozen, raw	120	4.29999999999999982	1.60000000000000009	0.100000000000000006
2388	Onion, mature, white skinned, peeled, fresh or frozen, raw	128	4.70000000000000018	1.69999999999999996	0.100000000000000006
2389	Onion, pickled, drained, commercial	260	12.3000000000000007	0.5	0.200000000000000011
2390	Onion, spring, baked, roasted, fried, stir-fried, grilled or BBQd, fat not further defined	487	6.90000000000000036	2.60000000000000009	8.19999999999999929
2391	Onion, spring, baked, roasted, fried, stir-fried, grilled or BBQd, no added fat	204	7.29999999999999982	2.70000000000000018	0.299999999999999989
2392	Onion, spring, boiled, microwaved or steamed, drained, with or without added fat	141	5	1.89999999999999991	0.200000000000000011
2393	Onion, spring, raw	127	4.5	1.69999999999999996	0.200000000000000011
2394	Orange, navel (all varieties), peeled, raw	183	8.40000000000000036	1	0.100000000000000006
2395	Orange, peeled, raw, not further defined	178	8	1	0.100000000000000006
2396	Orange, peeled, stewed, no added fat	196	9	1.10000000000000009	0.100000000000000006
2397	Orange roughy, boiled, microwaved, steamed or poached, no added fat	548	0	19.5	5.79999999999999982
2398	Orange roughy, raw	460	0	16.3999999999999986	4.90000000000000036
2399	Orange, valencia, peeled, raw	172	7.70000000000000018	1	0.100000000000000006
2400	Oregano or marjoram, dried	1096	4.09999999999999964	9	4.29999999999999982
2401	Ostrich, fan fillet, raw	424	0	23.3999999999999986	0.699999999999999956
2402	Ostrich, moon steak, raw	455	0	23.6999999999999993	1.39999999999999991
2403	Ouzo	886	0.100000000000000006	0	0
2404	Oyster, cooked, with or without added fat	307	0	12.1999999999999993	2.39999999999999991
2405	Oyster, raw	307	0	12.1999999999999993	2.39999999999999991
2406	Oyster, smoked, canned in oil, drained	858	0	17.3999999999999986	12
2407	Pancake, Chinese	981	0	5.59999999999999964	6.20000000000000018
2408	Pandanus kernel	2452	3.10000000000000009	25.8999999999999986	46.7999999999999972
2409	Pappadam, deep fried	2175	0	11.5	38.7999999999999972
2410	Pappadam, microwaved without oil or salt	1421	0	25.8999999999999986	3.29999999999999982
2411	Pappadam, raw	1406	0	25.6000000000000014	3.20000000000000018
2412	Parsley, continental, raw	100	0.599999999999999978	2.39999999999999991	0.200000000000000011
2413	Parsley, curly, raw	96	0.400000000000000022	1.89999999999999991	0.200000000000000011
2414	Parsley, not further defined, raw	99	0.5	2.20000000000000018	0.200000000000000011
2415	Parsnip, peeled, fresh or frozen, raw	237	4.79999999999999982	1.80000000000000004	0.200000000000000011
2416	Parsnip, peeled or unpeeled, fresh or frozen, baked, roasted, fried, stir-fried, grilled or BBQd, fat not further defined	496	5.59999999999999964	2.10000000000000009	6.20000000000000018
2417	Parsnip, peeled or unpeeled, fresh or frozen, baked, roasted, fried, stir-fried, grilled or BBQd, no added fat	289	5.90000000000000036	2.20000000000000018	0.200000000000000011
2418	Parsnip, peeled or unpeeled, fresh or frozen, boiled, microwaved or steamed, drained, with or without added fat	255	5.20000000000000018	1.89999999999999991	0.200000000000000011
2419	Passionfruit, pulp, canned	304	5.70000000000000018	3	0.299999999999999989
2420	Passionfruit, raw	304	5.70000000000000018	3	0.299999999999999989
2421	Pasta, filled with meat, fresh, commercial, boiled, without added sauce	629	0.299999999999999989	6.29999999999999982	3.89999999999999991
2422	Pasta, filled with spinach & ricotta, fresh, commercial, boiled, without added sauce	444	1	5.09999999999999964	2.79999999999999982
2423	Pasta, filled with spinach & ricotta, fresh, homemade, boiled, without added sauce	419	0.599999999999999978	5.70000000000000018	2.60000000000000009
2424	Pasta, filled with vegetables, fresh, commercial, boiled, without added sauce	536	1.10000000000000009	5.70000000000000018	3
2425	Pasta, gluten free, plain, boiled from dry, no added salt	639	0	3.10000000000000009	0.699999999999999956
2426	Pasta, gluten free, plain, boiled from dry, with added salt	639	0	3.10000000000000009	0.699999999999999956
2427	Pasta, maize flour (corn) based, plain, cooked	503	0	2.60000000000000009	0.699999999999999956
2428	Pasta, maize flour (corn) based, plain, dry	1453	0	7.5	2.10000000000000009
2429	Pasta, unfilled, for commercial pasta recipes	603	0	5.20000000000000018	1.19999999999999996
2430	Pasta, unfilled, for homemade pasta recipes	555	0.299999999999999989	5.20000000000000018	0.699999999999999956
2431	Pasta, white wheat flour & egg, plain, boiled, no added salt	601	0	5.70000000000000018	0.599999999999999978
2432	Pasta, white wheat flour & egg, plain, boiled, with added salt	564	0	5.29999999999999982	0.599999999999999978
2433	Pasta, white wheat flour & egg, plain, dry	1487	0	12.8000000000000007	1.5
2434	Pasta, white wheat flour, plain, boiled from dry, no added salt	510	0.200000000000000011	5.09999999999999964	0.100000000000000006
2435	Pasta, white wheat flour, plain, boiled from dry, with added salt	506	0	3.60000000000000009	0.299999999999999989
2436	Pasta, white wheat flour, plain, dry	1458	0	12.6999999999999993	1.39999999999999991
2437	Pasta, white wheat flour, plain, fresh, boiled, no added salt	682	1.10000000000000009	5.40000000000000036	3
2438	Pasta, white wheat flour, plain, fresh, uncooked	1152	0.900000000000000022	9.59999999999999964	3.39999999999999991
2439	Pasta, white wheat flour, plain, homemade, boiled, no added salt	703	0.100000000000000006	6.90000000000000036	2.29999999999999982
2440	Pasta, white wheat flour, plain, homemade, boiled, with added salt	702	0.100000000000000006	6.90000000000000036	2.29999999999999982
2441	Pasta, white wheat flour & spinach, plain, boiled, no added salt	554	0.200000000000000011	3.79999999999999982	0.400000000000000022
2442	Pasta, white wheat flour & spinach, plain, boiled, with added salt	554	0.200000000000000011	3.79999999999999982	0.400000000000000022
2443	Pasta, white wheat flour & spinach, plain, dry	1525	2.70000000000000018	11.9000000000000004	1.30000000000000004
2444	Pasta, wholemeal wheat flour, plain, boiled from dry, no added salt	579	0	5.09999999999999964	0.800000000000000044
2445	Pasta, wholemeal wheat flour, plain, boiled from dry, with added salt	579	0	5.09999999999999964	0.800000000000000044
2446	Pasta, wholemeal wheat flour, plain, dry	1404	0	12.5	2.20000000000000018
2447	Paste, curry, commercial, not further defined	919	5.70000000000000018	4.59999999999999964	14.5
2448	Paste, curry, Indian style, commercial	1306	4.20000000000000018	4.79999999999999982	26.3999999999999986
2449	Paste, flour mixed with sugar & cows milk	525	7.70000000000000018	4.79999999999999982	2
2450	Paste, green curry, commercial	461	3.39999999999999991	2.39999999999999991	7.90000000000000036
2451	Paste, green curry, homemade	450	3.5	2.39999999999999991	7.40000000000000036
2452	Paste, korma, commercial	1170	7.79999999999999982	3.20000000000000018	22.6000000000000014
2453	Paste, massaman curry, commercial	1154	5.79999999999999982	8.30000000000000071	15.0999999999999996
2454	Paste, quince	1004	58.2000000000000028	0.5	0.200000000000000011
2455	Paste, red curry, commercial or homemade	755	9.5	2.79999999999999982	8.69999999999999929
2456	Paste, shrimp	1200	50.6000000000000014	6.09999999999999964	2.5
2457	Paste, vindaloo, commercial	2050	4.90000000000000036	3.20000000000000018	46
2458	Paste, wasabi, commercial	1073	2.79999999999999982	0.599999999999999978	7.5
2459	Pastry, choux, commercial, baked, unfilled	1222	0.100000000000000006	7.79999999999999982	21.6999999999999993
2460	Pastry, choux, homemade from basic ingredients, baked, unfilled	1488	0.200000000000000011	10.8000000000000007	24.8000000000000007
2461	Pastry, choux, homemade from basic ingredients, raw	922	0.100000000000000006	6.70000000000000018	15.4000000000000004
2462	Pastry, dumpling wrapper, not further defined	933	0.100000000000000006	5.59999999999999964	1
2463	Pastry, dumpling wrapper style, raw	966	0	7.79999999999999982	1.60000000000000009
2464	Pastry, filled with salmon, with or without vegetables, homemade from basic ingredients	1317	1	14.8000000000000007	20.1000000000000014
2465	Pastry, filled with spinach & cheese, commercial, ready to eat	1215	2.70000000000000018	9.40000000000000036	16.3999999999999986
2466	Pastry, filled with spinach & cheese, from frozen, baked, no added fat	1215	2.70000000000000018	9.40000000000000036	16.3999999999999986
2467	Pastry, filled with spinach, commercial, ready to eat	1254	5.40000000000000036	5.59999999999999964	20.6000000000000014
2468	Pastry, filled with spinach, homemade from basic ingredients	1108	1.30000000000000004	5.09999999999999964	14.6999999999999993
2469	Pastry, filo (fillo), commercial, baked	1631	2.10000000000000009	12.1999999999999993	3.10000000000000009
2470	Pastry, filo (fillo), commercial, raw	1277	1.30000000000000004	9.90000000000000036	3.79999999999999982
2471	Pastry, for use in quiche recipes, raw	1553	4.90000000000000036	5.59999999999999964	21.1000000000000014
2472	Pastry, gow gee wrapper style, raw	900	0.200000000000000011	3.29999999999999982	0.400000000000000022
2473	Pastry, puff, commercial, raw, not further defined	1368	1	5.5	18.3999999999999986
2474	Pastry, puff, vegetable oil, commercial, baked	1906	1.69999999999999996	7	26.5
2475	Pastry, puff, vegetable oil, commercial, raw	1321	1	5.5	16.3999999999999986
2476	Pastry, puff, with butter, commercial, baked	1797	1.30000000000000004	7.09999999999999964	24.6999999999999993
2477	Pastry, puff, with butter, commercial, raw	1383	1	5.5	19
2478	Pastry, shortcrust style, commercial, baked	2080	9.59999999999999964	6.59999999999999964	27.5
2479	Pastry, shortcrust style, commercial, raw	1685	7.5	5.5	23.8000000000000007
2480	Pastry, shortcrust style, homemade from basic ingredients, baked	1794	5.09999999999999964	8.30000000000000071	18
2481	Pastry, shortcrust style, reduced fat, commercial, raw	1534	7.5	5.5	17.3999999999999986
2482	Pastry, shortcrust, wholemeal, commercial, baked	1937	2.39999999999999991	10	26.3000000000000007
2483	Pastry, shortcrust, wholemeal, commercial, raw	1402	2.60000000000000009	7.5	19.1999999999999993
2484	Pastry, spring roll, homemade from basic ingredients, raw	845	0.100000000000000006	6.40000000000000036	1.60000000000000009
2485	Pasty, filled with vegetables, commercial, baked	786	1.69999999999999996	4	7.70000000000000018
2486	Pasty, filled with vegetables, homemade from basic ingredients	1151	5.29999999999999982	4.59999999999999964	16.3000000000000007
2487	Pasty, filled with vegetables & meat, commercial, ready to eat	1119	2.5	6.79999999999999982	15.4000000000000004
2488	Pasty, filled with vegetables & meat, homemade from basic ingredients	1009	3.79999999999999982	10	13.5999999999999996
2489	Pawpaw (papaya), orange flesh, peeled, raw	142	6.90000000000000036	0.400000000000000022	0.100000000000000006
2490	Peach, canned in intense sweetened liquid	115	5.5	0.5	0
2491	Peach, canned in intense sweetened liquid, drained	121	5.40000000000000036	0.699999999999999956	0
2492	Peach, canned in intense sweetened liquid, liquid only	102	5.59999999999999964	0.200000000000000011	0
2493	Peach, canned in light syrup	232	12.3000000000000007	0.599999999999999978	0
2494	Peach, canned in light syrup, drained	229	11.5	0.800000000000000044	0
2495	Peach, canned in light syrup, syrup only	236	13.3000000000000007	0.299999999999999989	0
2496	Peach, canned in pear juice	184	8.30000000000000071	0.599999999999999978	0
2497	Peach, canned in pear juice, drained	191	8.19999999999999929	0.800000000000000044	0.100000000000000006
2498	Peach, canned in pear juice, juice only	174	8.5	0.400000000000000022	0
2499	Peach, canned in syrup	229	12.0999999999999996	0.599999999999999978	0
2500	Peach, canned in syrup, drained	227	11.5	0.699999999999999956	0
2501	Peach, canned in syrup, syrup only	232	13.1999999999999993	0.299999999999999989	0
2502	Peach, canned, not further defined	191	9.30000000000000071	0.699999999999999956	0
2503	Peach, peeled, raw, not further defined	196	8.69999999999999929	1	0.100000000000000006
2504	Peach, stewed, sugar sweetened, no added fat	357	19.1999999999999993	0.900000000000000022	0.100000000000000006
2505	Peach, unpeeled, raw, not further defined	165	7.20000000000000018	0.900000000000000022	0.100000000000000006
2506	Peach, white, peeled, raw	193	8.40000000000000036	1.10000000000000009	0.100000000000000006
2507	Peach, white, unpeeled, raw	157	6.79999999999999982	0.900000000000000022	0.100000000000000006
2508	Peach, yellow, peeled, raw	197	8.80000000000000071	1	0.100000000000000006
2509	Peach, yellow, unpeeled, raw	168	7.40000000000000036	0.800000000000000044	0.100000000000000006
2510	Pea, green, canned in brine, cooked	307	3.70000000000000018	5.40000000000000036	0.5
2511	Pea, green, cooked, added fat not further defined	426	2.39999999999999991	4.79999999999999982	5.20000000000000018
2512	Pea, green, cooked, no added fat	261	2.60000000000000009	5.09999999999999964	0.299999999999999989
2513	Pea, green, fresh, cooked, no added fat	246	2.70000000000000018	4.79999999999999982	0.400000000000000022
2514	Pea, green, fresh or frozen, raw	294	4	5.79999999999999982	0.400000000000000022
2515	Pea, green, frozen, cooked, no added fat	259	2.5	5.20000000000000018	0.299999999999999989
2516	Peanut butter, not further identified	2515	8.40000000000000036	22.3999999999999986	50.2999999999999972
2517	Peanut butter, smooth & crunchy, added sugar, no added salt	2486	8.59999999999999964	22.1999999999999993	50.3999999999999986
2518	Peanut butter, smooth & crunchy, added sugar & salt	2509	8.59999999999999964	22.1999999999999993	50
2519	Peanut butter, smooth & crunchy, no added sugar or salt	2634	5.5	24.3000000000000007	54.2999999999999972
2520	Pear, brown, peeled, raw	267	10.6999999999999993	0.299999999999999989	0
2521	Pear, brown, unpeeled, raw	264	10.4000000000000004	0.299999999999999989	0
2522	Pear, canned in intense sweetened liquid	120	4.90000000000000036	0.299999999999999989	0
2523	Pear, canned in intense sweetened liquid, drained	126	4.90000000000000036	0.299999999999999989	0
2524	Pear, canned in intense sweetened liquid, liquid only	111	5	0.200000000000000011	0
2525	Pear, canned in light syrup	262	13.6999999999999993	0.299999999999999989	0
2526	Pear, canned in light syrup, drained	262	13.1999999999999993	0.400000000000000022	0
2527	Pear, canned in light syrup, syrup only	261	14.5	0.200000000000000011	0
2528	Pear, canned in pear juice	194	8.69999999999999929	0.5	0
2529	Pear, canned in pear juice, drained	200	8.59999999999999964	0.599999999999999978	0
2530	Pear, canned in pear juice, juice only	185	8.80000000000000071	0.200000000000000011	0
2531	Pear, canned in sugar syrup, syrup only	273	14.6999999999999993	0.200000000000000011	0
2532	Pear, canned in syrup	278	14.0999999999999996	0.400000000000000022	0
2533	Pear, canned in syrup, drained	282	13.6999999999999993	0.599999999999999978	0
2534	Pear, canned, not further defined	216	10.1999999999999993	0.400000000000000022	0
2535	Pear, green, peeled, raw	245	9.90000000000000036	0.299999999999999989	0
2536	Pear, green, unpeeled, raw	247	9.69999999999999929	0.299999999999999989	0
2537	Pear, nashi, peeled or unpeeled, raw	209	10.5999999999999996	0.400000000000000022	0.100000000000000006
2538	Pear, packhams triumph, unpeeled, raw	238	9.59999999999999964	0.299999999999999989	0
2539	Pear, peeled, raw, not further defined	247	10	0.299999999999999989	0
2540	Pear, raw, not further defined	248	9.80000000000000071	0.299999999999999989	0
2541	Pear, stewed, sugar sweetened, no added fat	410	20.6000000000000014	0.299999999999999989	0
2542	Pear, unpeeled, raw, not further defined	248	9.80000000000000071	0.299999999999999989	0
2543	Pear, william bartlett, unpeeled, raw	228	9	0.299999999999999989	0
2544	Pea, split, dried	1427	2.5	23	2
2545	Pea, split, dried, boiled, microwaved or steamed, drained	364	2.89999999999999991	6.59999999999999964	0.400000000000000022
2546	Pectin, powder, unsweetened	725	0	0.400000000000000022	0.100000000000000006
2547	Pepino, peeled, raw	100	4.79999999999999982	0.599999999999999978	0.100000000000000006
2548	Pepper, ground, black or white	1208	0.599999999999999978	10.6999999999999993	2.70000000000000018
2549	Pepper, stuffed with cheese	645	2.29999999999999982	5.70000000000000018	13.4000000000000004
2550	Persimmon, peeled, raw	298	16.1000000000000014	0.599999999999999978	0.200000000000000011
2551	Pickles, mustard, sweet, commercial	348	14.6999999999999993	0.800000000000000044	0.5
2552	Pigeon (squab), whole, raw	1219	0	16.1999999999999993	25.5
2553	Pig (pork), wild caught, cooked	1164	0	27.3999999999999986	18.8999999999999986
2554	Pikelet, plain, commercial	912	13.8000000000000007	5.70000000000000018	4.29999999999999982
2555	Pikelet, plain, homemade from basic ingredients	1160	13.4000000000000004	7.5	5.90000000000000036
2556	Pineapple, canned in pineapple juice	236	12	0.5	0.599999999999999978
2557	Pineapple, canned in pineapple juice, drained	206	10.5	0.5	0.100000000000000006
2558	Pineapple, canned in pineapple juice, juice only	187	10.5999999999999996	0.299999999999999989	0
2559	Pineapple, canned in syrup	360	19.8000000000000007	0.299999999999999989	0.599999999999999978
2560	Pineapple, canned in syrup, drained	345	19.3999999999999986	0.200000000000000011	0.299999999999999989
2561	Pineapple, canned in syrup, syrup only	370	22	0.299999999999999989	0
2562	Pineapple (cayenne), peeled, raw	178	8.19999999999999929	0.599999999999999978	0.200000000000000011
2563	Pineapple, fresh, cooked in light syrup, drained	208	10.4000000000000004	0.200000000000000011	0.400000000000000022
2564	Pipi, wild harvested, cooked	307	0	12.1999999999999993	2.39999999999999991
2565	Plum, dark, canned in syrup	370	21.1000000000000014	0.299999999999999989	0.100000000000000006
2566	Plum, dark, canned in syrup, drained	385	21	0.400000000000000022	0.100000000000000006
2567	Plum, dark, canned in syrup, syrup only	354	21.1999999999999993	0.200000000000000011	0
2568	Plum, davidson (native), flesh	280	3.89999999999999991	1	0.200000000000000011
2569	Plum, salted	857	33.6000000000000014	3.70000000000000018	0
2570	Plum, stewed, sugar sweetened, no added fat	339	17.8000000000000007	0.599999999999999978	0.100000000000000006
2571	Plum, unpeeled, raw	162	6.5	0.599999999999999978	0.100000000000000006
2572	Polish sausage	1012	0.400000000000000022	17.6000000000000014	17.8000000000000007
2573	Pome fruit, raw, not further defined	241	11.5	0.299999999999999989	0.100000000000000006
2574	Pomegranate, peeled, raw	329	13.5	1.89999999999999991	0.200000000000000011
2575	Pork, belly, baked, roasted, fried, grilled or BBQd, fat not further defined	3117	0	13.3000000000000007	78.0999999999999943
2576	Pork, belly, baked, roasted, fried, grilled or BBQd, no added fat	3073	0	13.5	76.7999999999999972
2577	Pork, belly, boiled, casseroled, microwaved, poached, steamed or stewed, no added fat	2232	0	9.80000000000000071	55.7999999999999972
2578	Pork, belly, raw	2120	0	9.30000000000000071	53
2579	Pork, butterfly steak, fully-trimmed, baked, roasted, fried, grilled or BBQd, canola oil	773	0	34.2000000000000028	5.20000000000000018
2580	Pork, butterfly steak, fully-trimmed, baked, roasted, fried, grilled or BBQd, fat not further defined	783	0	34.7000000000000028	5.20000000000000018
2581	Pork, butterfly steak, fully-trimmed, baked, roasted, fried, grilled or BBQd, no added fat	656	0	32.5	2.79999999999999982
2582	Pork, butterfly steak, fully-trimmed, baked, roasted, fried, grilled or BBQd, olive oil	785	0	34.7000000000000028	5.20000000000000018
2583	Pork, butterfly steak, fully-trimmed, baked, roasted, fried, grilled or BBQd, other oil	785	0	34.7000000000000028	5.20000000000000018
2584	Pork, butterfly steak, fully-trimmed, raw	469	0	24.1000000000000014	1.60000000000000009
2585	Pork, butterfly steak, untrimmed, baked, roasted, fried, grilled or BBQd, no added fat	825	0	30.6000000000000014	8.19999999999999929
2586	Pork, butterfly steak, untrimmed, raw	643	0	22.6999999999999993	7
2587	Pork, coated, baked, roasted, fried, grilled or BBQd, fat not further defined	1024	0.800000000000000044	28.8999999999999986	7.20000000000000018
2588	Pork, coated, baked, roasted, fried, grilled or BBQd, no added fat	948	0.900000000000000022	29.3999999999999986	4.59999999999999964
2589	Pork, crackling, roasted, salted	2129	0	33.7999999999999972	42
2590	Pork, diced, fully-trimmed, baked, roasted, fried, stir-fried, grilled or BBQd, butter, dairy blend or margarine	811	0	32.8999999999999986	6.79999999999999982
2591	Pork, diced, fully-trimmed, baked, roasted, fried, stir-fried, grilled or BBQd, canola oil	833	0	32.8999999999999986	7.40000000000000036
2592	Pork, diced, fully-trimmed, baked, roasted, fried, stir-fried, grilled or BBQd, fat not further defined	831	0	32.8999999999999986	7.40000000000000036
2593	Pork, diced, fully-trimmed, baked, roasted, fried, stir-fried, grilled or BBQd, no added fat	647	0	31.3000000000000007	3.10000000000000009
2594	Pork, diced, fully-trimmed, baked, roasted, fried, stir-fried, grilled or BBQd, olive oil	821	0	32.3999999999999986	7.29999999999999982
2595	Pork, diced, fully-trimmed, baked, roasted, fried, stir-fried, grilled or BBQd, other oil	821	0	32.3999999999999986	7.29999999999999982
2596	Pork, diced, fully-trimmed, boiled, casseroled, microwaved, poached, steamed or stewed, fat not further defined	897	0	35.5	7.90000000000000036
2597	Pork, diced, fully-trimmed, boiled, casseroled, microwaved, poached, steamed or stewed, no added fat	797	0	36.2000000000000028	4.90000000000000036
2598	Pork, diced, fully-trimmed, raw	502	0	22.8000000000000007	3.10000000000000009
2599	Pork, fillet, fully-trimmed, baked, roasted, fried, grilled or BBQd, butter, dairy blend or margarine	712	0	33.2999999999999972	3.89999999999999991
2600	Pork, fillet, fully-trimmed, baked, roasted, fried, grilled or BBQd, canola oil	733	0	33.2999999999999972	4.5
2601	Pork, fillet, fully-trimmed, baked, roasted, fried, grilled or BBQd, fat not further defined	721	0	32.7999999999999972	4.40000000000000036
2602	Pork, fillet, fully-trimmed, baked, roasted, fried, grilled or BBQd, no added fat	566	0	28.5	2.20000000000000018
2603	Pork, fillet, fully-trimmed, baked, roasted, fried, grilled or BBQd, olive oil	702	0	31.8999999999999986	4.29999999999999982
2604	Pork, fillet, fully-trimmed, baked, roasted, fried, grilled or BBQd, other oil	723	0	32.7999999999999972	4.5
2605	Pork, fillet, fully-trimmed, boiled, casseroled, microwaved, poached, steamed or stewed, no added fat	688	0	36.7000000000000028	1.69999999999999996
2606	Pork, fillet, fully-trimmed, raw	433	0	23.1000000000000014	1.10000000000000009
2607	Pork, forequarter chop, fully-trimmed, baked, roasted, fried, grilled or BBQd, fat not further defined	793	0	28.1000000000000014	8.5
2608	Pork, forequarter chop, fully-trimmed, baked, roasted, fried, grilled or BBQd, no added fat	680	0	26.3000000000000007	6.29999999999999982
2609	Pork, forequarter chop, fully-trimmed, raw	476	0	19.5	3.89999999999999991
2610	Pork, forequarter (chop, roast, neck), separable fat, raw	2042	0	9.59999999999999964	50.7999999999999972
2611	Pork, forequarter chop, semi-trimmed, baked, roasted, fried, grilled or BBQd, no added fat	771	0	25.3999999999999986	9.19999999999999929
2612	Pork, forequarter chop, untrimmed, baked, roasted, fried, grilled or BBQd, fat not further defined	1239	0	25.3000000000000007	21.8999999999999986
2613	Pork, forequarter chop, untrimmed, baked, roasted, fried, grilled or BBQd, no added fat	988	0	23.3000000000000007	16
2614	Pork, forequarter chop, untrimmed, raw	785	0	17.5	13.1999999999999993
2615	Pork, forequarter, separable fat, grilled or BBQd, no added fat	2179	0	11.5	53.6000000000000014
2616	Pork, forequarter shoulder roast, fully-trimmed, baked or roasted, no added fat	658	0	24.8000000000000007	6.40000000000000036
2617	Pork, forequarter shoulder roast, fully-trimmed, raw	447	0	19.6000000000000014	3.10000000000000009
2618	Pork, forequarter shoulder roast, semi-trimmed, baked or roasted, no added fat	748	0	24	9.19999999999999929
2619	Pork, forequarter shoulder roast, untrimmed, baked or roasted, no added fat	901	0	22.6000000000000014	14
2620	Pork, forequarter shoulder roast, untrimmed, raw	762	0	17.6000000000000014	12.5
2621	Pork, head, cooked, with or without added fat	1210	0	27.8999999999999986	19.8999999999999986
2622	Pork, kebab, marinated, baked, roasted, fried, grilled or BBQd, fat not further defined	970	4.5	28.8000000000000007	10.5999999999999996
2623	Pork, leg roast, untrimmed, baked or roasted, no added fat	926	0	31.1999999999999993	10.6999999999999993
2624	Pork, leg roast, untrimmed, raw	685	0	21.6000000000000014	8.59999999999999964
2625	Pork, leg steak (round, rump, topside, silverside), as purchased, fried or stir-fried, no added fat	603	0	28.6000000000000014	3.10000000000000009
2626	Pork, leg steak (round, rump, topside, silverside), as purchased, raw	487	0	23.3000000000000007	2.39999999999999991
2627	Pork, leg steak (round, rump, topside, silverside), separable lean, fried or stir fried, no added fat	589	0	28.8000000000000007	2.70000000000000018
2628	Pork, leg steak (round, rump, topside, silverside), separable lean, raw	466	0	23.5	1.80000000000000004
2629	Pork, leg steak (rump), separable fat, fried or stir fried, no added fat	2191	0	12	53.7000000000000028
2630	Pork, leg steak (rump), separable fat, raw	2603	0	8.59999999999999964	66.4000000000000057
2631	Pork, loin chop, fully-trimmed, baked, roasted, fried, grilled or BBQd, butter, dairy blend or margarine	751	0	33.5	4.90000000000000036
2632	Pork, loin chop, fully-trimmed, baked, roasted, fried, grilled or BBQd, canola oil	762	0	33	5.5
2633	Pork, loin chop, fully-trimmed, baked, roasted, fried, grilled or BBQd, fat not further defined	771	0	33.3999999999999986	5.5
2634	Pork, loin chop, fully-trimmed, baked, roasted, fried, grilled or BBQd, no added fat	687	0	30.6000000000000014	4.5
2635	Pork, loin chop, fully-trimmed, baked, roasted, fried, grilled or BBQd, olive oil	773	0	33.3999999999999986	5.5
2636	Pork, loin chop, fully-trimmed, baked, roasted, fried, grilled or BBQd, other oil	762	0	33	5.5
2637	Pork, loin chop, fully-trimmed, boiled, casseroled, microwaved, poached, steamed or stewed, no added fat	732	0	36.7999999999999972	2.89999999999999991
2638	Pork, loin chop, fully-trimmed, raw	461	0	23.1999999999999993	1.80000000000000004
2639	Pork, loin chop, semi-trimmed, baked, roasted, fried, grilled or BBQd, butter, dairy blend or margarine	899	0	31.8999999999999986	9.59999999999999964
2640	Pork, loin chop, semi-trimmed, baked, roasted, fried, grilled or BBQd, canola oil	934	0	32.2999999999999972	10.4000000000000004
2641	Pork, loin chop, semi-trimmed, baked, roasted, fried, grilled or BBQd, fat not further defined	919	0	31.8999999999999986	10.1999999999999993
2642	Pork, loin chop, semi-trimmed, baked, roasted, fried, grilled or BBQd, no added fat	791	0	29.5	7.79999999999999982
2643	Pork, loin chop, semi-trimmed, baked, roasted, fried, grilled or BBQd, olive oil	934	0	32.2999999999999972	10.4000000000000004
2644	Pork, loin chop, semi-trimmed, baked, roasted, fried, grilled or BBQd, other oil	921	0	31.8999999999999986	10.1999999999999993
2645	Pork, loin chop, semi-trimmed, boiled, casseroled, microwaved, poached, steamed or stewed, no added fat	909	0	35.6000000000000014	8.19999999999999929
2646	Pork, loin chop, semi-trimmed, raw	573	0	22.3999999999999986	5.20000000000000018
2647	Pork, loin chop, separable fat, baked, roasted, fried, grilled or BBQd, no added fat	2765	0	8.80000000000000071	70.7000000000000028
2648	Pork, loin chop, separable fat, raw	2694	0	7.90000000000000036	69.2000000000000028
2649	Pork, loin chop, untrimmed, baked, roasted, fried, grilled or BBQd, no added fat	930	0	28	12.3000000000000007
2650	Pork, loin chop, untrimmed, baked, roasted, fried, grilled or BBQd, olive oil	1125	0	31	16.1000000000000014
2651	Pork, loin chop, untrimmed, baked, roasted, fried, grilled or BBQd, other oil	1125	0	31	16.1000000000000014
2652	Pork, loin chop, untrimmed, raw	705	0	21.5	9.19999999999999929
2653	Pork, loin cutlet, untrimmed, baked, roasted, fried, grilled or BBQd, no added fat	1240	0	30.8999999999999986	19.3000000000000007
2654	Pork, loin cutlet, untrimmed, raw	843	0	21	13.0999999999999996
2655	Pork, loin roast, fully-trimmed, baked or roasted, no added fat	860	0	31.8999999999999986	8.59999999999999964
2656	Pork, loin roast, fully-trimmed, boiled, casseroled, microwaved, poached, steamed, or stewed, no added fat	758	0	37	3.5
2657	Pork, loin roast, fully-trimmed, raw	478	0	23.3000000000000007	2.20000000000000018
2658	Pork, loin roast, semi-trimmed, baked or roasted, no added fat	883	0	32.8999999999999986	8.69999999999999929
2659	Pork, loin roast, semi-trimmed, raw	601	0	22.3999999999999986	5.90000000000000036
2660	Pork, loin roast, separable fat, baked or roasted, no added fat	2629	0	8.80000000000000071	67
2661	Pork, loin roast, separable fat, raw	2941	0	5.20000000000000018	77.0999999999999943
2662	Pork, loin roast, untrimmed, baked or roasted, no added fat	1093	0	28.8999999999999986	16.3000000000000007
2663	Pork, loin roast, untrimmed, raw	943	0	19.8999999999999986	16.3999999999999986
2664	Pork, medallion or loin steak, fully-trimmed, baked, roasted, fried, grilled or BBQd, fat not further defined	771	0	34.2000000000000028	5.09999999999999964
2665	Pork, medallion or loin steak, fully-trimmed, baked, roasted, fried, grilled or BBQd, no added fat	631	0	29.5	3.5
2666	Pork, medallion or loin steak, fully-trimmed, raw	469	0	24.1000000000000014	1.60000000000000009
2667	Pork, medallion or loin steak, separable fat, fried, grilled or BBQd, no added fat	2307	0	14.9000000000000004	55.5
2668	Pork, medallion or loin steak, separable fat, raw	2642	0	6.29999999999999982	68.5
2669	Pork, medallion or loin steak, untrimmed, baked, roasted, fried, grilled or BBQd, fat not further defined	979	0	32.5	11.5
2670	Pork, medallion or loin steak, untrimmed, raw	615	0	22.8999999999999986	6.09999999999999964
2671	Pork, mince, baked, roasted, fried or stir-fried, grilled or BBQd, canola oil	1103	0	26.8999999999999986	17.3999999999999986
2672	Pork, mince, baked, roasted, fried or stir-fried, grilled or BBQd, fat not further defined	1102	0	26.8999999999999986	17.3999999999999986
2673	Pork, mince, baked, roasted, fried or stir-fried, grilled or BBQd, no added fat	842	0	25.3999999999999986	11
2674	Pork, mince, baked, roasted, fried or stir-fried, grilled or BBQd, olive oil	1103	0	26.8999999999999986	17.3999999999999986
2675	Pork, mince, baked, roasted, fried or stir-fried, grilled or BBQd, other oil	1103	0	26.8999999999999986	17.3999999999999986
2676	Pork, mince, boiled, casseroled, microwaved, poached, steamed or stewed, added fat not further defined	1242	0	30.3999999999999986	19.6000000000000014
2677	Pork, mince, boiled, casseroled, microwaved, poached, steamed or stewed, no added fat	1149	0	31	16.8000000000000007
2678	Pork, mince, raw	724	0	19.5	10.5999999999999996
2679	Pork, pickled, cooked, with or without added fat	987	0	34.7000000000000028	10.8000000000000007
2680	Pork, round mini roast, fully-trimmed, baked or roasted, no added fat	682	0	34.7000000000000028	2.5
2681	Pork, round mini roast, fully-trimmed, raw	444	0	23.6999999999999993	1.10000000000000009
2682	Pork, round mini roast, separable fat, baked or roasted, no added fat	1961	0	16.3000000000000007	45.5
2683	Pork, round mini roast, separable fat, raw	1842	0	11.3000000000000007	44.6000000000000014
2684	Pork, round mini roast, untrimmed, baked or roasted, no added fat	699	0	34.5	3.10000000000000009
2685	Pork, round mini roast, untrimmed, raw	472	0	23.5	2
2686	Pork, round steak, fully-trimmed, baked, roasted, fried, grilled or BBQd, no added fat	563	0	29.3999999999999986	1.69999999999999996
2687	Pork, round steak, fully-trimmed, raw	416	0	22.1000000000000014	1.10000000000000009
2688	Pork, rump steak, fully-trimmed, baked, roasted, fried, grilled or BBQd no added fat	627	0	28.6000000000000014	3.79999999999999982
2689	Pork, rump steak, fully-trimmed, raw	508	0	25.3000000000000007	2.10000000000000009
2690	Pork, rump steak, untrimmed, baked, roasted, fried, grilled or BBQd, no added fat	836	0	36.5	5.79999999999999982
2691	Pork, rump steak, untrimmed, raw	568	0	24.8000000000000007	4
2692	Pork, scotch roast, fully-trimmed, baked or roasted, no added fat	964	0	30.6000000000000014	12
2693	Pork, scotch roast, fully-trimmed, raw	631	0	20.6000000000000014	7.59999999999999964
2694	Pork, scotch roast, separable fat, baked or roasted, no added fat	2076	0	12.1999999999999993	50.5
2695	Pork, scotch roast, separable fat, raw	2124	0	10.6999999999999993	52.5
2696	Pork, scotch roast, untrimmed, baked or roasted, fat not further defined	1393	0	27.1999999999999993	25.1999999999999993
2697	Pork, scotch roast, untrimmed, baked or roasted, no added fat	1024	0	29.6000000000000014	14.0999999999999996
2698	Pork, scotch roast, untrimmed, raw	893	0	18.8999999999999986	15.5
2699	Pork, silverside steak, fully-trimmed, baked, roasted, fried, grilled or BBQd, no added fat	585	0	27.8999999999999986	3
2700	Pork, silverside steak, fully-trimmed, raw	456	0	22.5	2
2701	Pork, silverside steak, untrimmed, raw	475	0	22.3999999999999986	2.60000000000000009
2702	Pork, spare ribs, fully-trimmed, baked, roasted, fried, grilled or BBQd, fat not further defined	1093	0	31.1999999999999993	15.1999999999999993
2703	Pork, spare ribs, fully-trimmed, baked, roasted, fried, grilled or BBQd, no added fat	1006	0	31.8999999999999986	12.5999999999999996
2704	Pork, spare ribs, fully-trimmed, boiled, casseroled, microwaved, poached, steamed, or stewed, fat not further defined	1180	0	33.7000000000000028	16.3999999999999986
2705	Pork, spare ribs, fully-trimmed, boiled, casseroled, microwaved, poached, steamed, or stewed, no added fat	1086	0	34.3999999999999986	13.5999999999999996
2706	Pork, spare ribs, fully-trimmed, raw	684	0	21.6999999999999993	8.5
2707	Pork, spare ribs, marinated, baked, roasted, fried, grilled or BBQd, fat not further defined	1504	4.5	25	26.8000000000000007
2708	Pork, spare ribs, semi-trimmed, baked, roasted, fried, grilled or BBQd, fat not further defined	1553	0	27.5	29.3000000000000007
2709	Pork, spare ribs, semi-trimmed, baked, roasted, fried, grilled or BBQd, no added fat	1477	0	28.1000000000000014	27
2710	Pork, spare ribs, semi-trimmed, boiled, casseroled, microwaved, poached, steamed, or stewed, no added fat	1618	0	30.6999999999999993	29.6000000000000014
2711	Pork, spare ribs, semi-trimmed, raw	1019	0	19.3999999999999986	18.6000000000000014
2712	Pork, spare ribs, untrimmed, baked, roasted, fried, grilled or BBQd, fat not further defined	1834	0	26.1999999999999993	37.5
2713	Pork, spare ribs, untrimmed, baked, roasted, fried, grilled or BBQd, no added fat	1762	0	26.6999999999999993	35.3999999999999986
2714	Pork, spare ribs, untrimmed, boiled, casseroled, microwaved, poached, steamed or stewed, fat not further defined	1979	0	28.1999999999999993	40.5
2715	Pork, spare ribs, untrimmed, boiled, casseroled, microwaved, poached, steamed or stewed, no added fat	1902	0	28.8000000000000007	38.2000000000000028
2716	Pork, spare ribs, untrimmed, raw	1198	0	18.1000000000000014	24
2717	Pork, strips, fully-trimmed, baked, roasted, fried, stir-fried, grilled or BBQd, no added fat	623	0	31.1999999999999993	2.5
2718	Pork, strips, fully-trimmed, raw	466	0	22.3999999999999986	2.29999999999999982
2719	Pork, topside steak, fully-trimmed, baked, roasted, fried, grilled or BBQd, no added fat	582	0	29.1999999999999993	2.29999999999999982
2720	Pork, topside steak, fully-trimmed, raw	482	0	24	2
2721	Pork, topside steak, untrimmed, baked, roasted, fried, grilled or BBQd, no added fat	583	0	29.1999999999999993	2.39999999999999991
2722	Porridge, brown rice, with added dry fruit, cooked with cows milk	425	6.70000000000000018	3.89999999999999991	2.20000000000000018
2723	Porridge, rice (congee), cooked with water	160	0	0.699999999999999956	0.100000000000000006
2724	Porridge, rolled oats mixed with sugar, flavours & dried fruit, prepared with cows milk	533	10.8000000000000007	4.90000000000000036	3.20000000000000018
2725	Porridge, rolled oats mixed with sugar, flavours & dried fruit, prepared with soy milk	517	8.19999999999999929	4.59999999999999964	3
2726	Porridge, rolled oats mixed with sugar, flavours & dried fruit, prepared with water	349	6.40000000000000036	2	1.39999999999999991
2727	Porridge, rolled oats mixed with sugar or honey & other flavours, prepared with cows milk	555	9.90000000000000036	4.70000000000000018	3.5
2728	Porridge, rolled oats mixed with sugar or honey & other flavours, prepared with soy milk	539	7.29999999999999982	4.5	3.20000000000000018
2729	Porridge, rolled oats mixed with sugar or honey & other flavours, prepared with water	371	5.5	1.89999999999999991	1.69999999999999996
2730	Porridge, rolled oats, prepared with cows milk	494	5.40000000000000036	5.59999999999999964	3.70000000000000018
2731	Porridge, rolled oats, prepared with cows milk & water	406	3	3.79999999999999982	3.20000000000000018
2732	Porridge, rolled oats, prepared with reduced fat cows milk	455	5.09999999999999964	5.70000000000000018	2.79999999999999982
2733	Porridge, rolled oats, prepared with regular fat cows milk	536	5.79999999999999982	5.40000000000000036	4.79999999999999982
2734	Porridge, rolled oats, prepared with rice milk	511	3.70000000000000018	2.5	2.5
2735	Porridge, rolled oats, prepared with skim cows milk	400	4.70000000000000018	5.59999999999999964	1.60000000000000009
2736	Porridge, rolled oats, prepared with soy milk	471	2.39999999999999991	5.29999999999999982	3.39999999999999991
2737	Porridge, rolled oats, prepared with soy milk & water	373	1.30000000000000004	3.79999999999999982	2.5
2738	Porridge, rolled oats, prepared with water	287	0.200000000000000011	2.39999999999999991	1.60000000000000009
2739	Porridge, rolled oats, with added fibre & Ca, prepared with cows milk	473	5.40000000000000036	5.79999999999999982	3.39999999999999991
2740	Port	600	12.4000000000000004	0.200000000000000011	0
2741	Possum, wild caught, flesh, cooked	701	0	33.6000000000000014	3.5
2742	Potato bake, made with bacon, cheese &/or cream	793	1.39999999999999991	5.90000000000000036	14.1999999999999993
2743	Potato bake, made with cheese	435	1	4.70000000000000018	4.59999999999999964
2744	Potato bake, made with cheese & cream	720	1.69999999999999996	4.90000000000000036	12.1999999999999993
2745	Potato bake, made with cream	612	1.80000000000000004	2.60000000000000009	9.90000000000000036
2746	Potato bake, made with mixed vegetables & cream &/or cheese	630	2.29999999999999982	4.5	10.4000000000000004
2747	Potato, chips, homemade from fresh potato, deep fried or fried, canola oil	811	0.900000000000000022	3.10000000000000009	11.9000000000000004
2748	Potato, chips, homemade from fresh potato, deep fried or fried, fat not further defined	804	0.900000000000000022	3.20000000000000018	11.6999999999999993
2749	Potato, chips, homemade from fresh potato, deep fried or fried, olive oil	811	0.900000000000000022	3.10000000000000009	11.9000000000000004
2750	Potato, chips, homemade from fresh potato, deep fried or fried, other oil	811	0.900000000000000022	3.10000000000000009	11.9000000000000004
2751	Potato, chips, reduced fat, purchased frozen, baked or roasted, no added fat	1111	0.200000000000000011	4.79999999999999982	5.40000000000000036
2752	Potato, chips, regular, fast food outlet, deep fried, blended oil, salted	948	0	3.79999999999999982	10.3000000000000007
2753	Potato, chips, regular, fast food outlet, deep fried, monounsaturated oil, salted	1025	0	3.79999999999999982	12.3000000000000007
2754	Potato, chips, regular, independent takeaway outlet, cafe or restaurant, deep fried, blended oil, no added salt	982	0	3.79999999999999982	11.1999999999999993
2755	Potato, chips, regular, independent takeaway outlet, cafe or restaurant, deep fried, blended oil, salted	982	0	3.79999999999999982	11.1999999999999993
2756	Potato, chips, regular, purchased frozen, baked or roasted, fat not further defined	1237	0.200000000000000011	4.70000000000000018	9.90000000000000036
2757	Potato, chips, regular, purchased frozen, baked or roasted, no added fat	1188	0.200000000000000011	4.79999999999999982	8.09999999999999964
2758	Potato, chips, regular, purchased frozen, deep fried or fried, fat not further defined	1274	0.200000000000000011	4.59999999999999964	11.3000000000000007
2759	Potato, coliban, peeled, baked, roasted, fried, stir-fried, grilled or BBQd, no added fat	368	1.5	3	0
2760	Potato, coliban, peeled, boiled, microwaved or steamed, drained	234	0	1	0
2761	Potato, coliban, peeled, raw	243	1	2	0
2762	Potato, desiree, peeled, baked, roasted, fried, stir-fried, grilled or BBQd, fat not further defined	621	2.39999999999999991	3.29999999999999982	7.40000000000000036
2763	Potato, desiree, peeled, baked, roasted, fried, stir-fried, grilled or BBQd, no added fat	364	2.60000000000000009	3.5	0
2764	Potato, desiree, peeled, boiled, microwaved or steamed, drained	245	1.69999999999999996	2.29999999999999982	0
2765	Potato, desiree, peeled, raw	240	1.69999999999999996	2.29999999999999982	0
2766	Potato, desiree, unpeeled, baked, roasted, fried, stir-fried, grilled or BBQd, no added fat	366	2.60000000000000009	3.5	0
2767	Potato, desiree, unpeeled, raw	242	1.69999999999999996	2.29999999999999982	0
2768	Potato, filled with bacon, cheese &/or sour cream	704	1.10000000000000009	8.09999999999999964	9.69999999999999929
2769	Potato, filled with cheese &/or sour cream	621	1.10000000000000009	5.70000000000000018	7.90000000000000036
2770	Potato, filled with legumes &/or vegetables	368	1.19999999999999996	3.5	0.5
2771	Potato, filled with meat & cheese &/or sour cream	501	1.60000000000000009	5.79999999999999982	4.90000000000000036
2772	Potato, for stuffed potato recipes	348	0.900000000000000022	2.79999999999999982	0.100000000000000006
2773	Potato, fries, fast food outlet, deep fried, blended oil, salted	1352	0.200000000000000011	4.79999999999999982	17.1999999999999993
2774	Potato, fries, fast food outlet, deep fried, monounsaturated oil, no added salt	1339	0.200000000000000011	4.79999999999999982	16.8000000000000007
2775	Potato, fries, fast food outlet, deep fried, monounsaturated oil, salted	1339	0.200000000000000011	4.79999999999999982	16.8000000000000007
2776	Potato, fries, homemade from fresh potato, peeled, deep-fried, fat not further defined	903	0.900000000000000022	3.10000000000000009	14.5999999999999996
2777	Potato, fries, independent takeaway outlet, cafe or restaurant, deep fried, blended oil, no added salt	1352	0.200000000000000011	4.79999999999999982	17.1999999999999993
2778	Potato, fries, independent takeaway outlet, cafe or restaurant, deep fried, blended oil, salted	1352	0.200000000000000011	4.79999999999999982	17.1999999999999993
2779	Potato, fries, regular, purchased frozen, baked or roasted, no added fat	1500	2.20000000000000018	7.70000000000000018	15.9000000000000004
2780	Potato, fries, regular, purchased frozen, deep fried or fried, fat not further defined	1367	1.80000000000000004	6.20000000000000018	17.1000000000000014
2781	Potato, fries, regular, purchased frozen, par-fried in canola oil, raw	720	1.10000000000000009	3.70000000000000018	7.59999999999999964
2782	Potato, gem, nugget or royal, independent takeaway outlet, cafe or restaurant, deep fried, fat not further defined	984	1.19999999999999996	4.09999999999999964	13.4000000000000004
2783	Potato, gem, nugget or royal, regular, purchased frozen, baked or roasted, with or without added fat	864	1.19999999999999996	4.20000000000000018	9.80000000000000071
2784	Potato, gem, nugget or royal, regular, purchased frozen, deep fried or fried, fat not further defined	982	1.19999999999999996	4.09999999999999964	13.4000000000000004
2785	Potato, gem, nugget or royal, regular, purchased frozen, par-fried in canola oil, raw	657	0.900000000000000022	3.20000000000000018	7.40000000000000036
2786	Potato, hash brown, independent takeaway outlet, cafe or restaurant, deep fried, oil not further defined	1042	1.19999999999999996	4.09999999999999964	15.0999999999999996
2787	Potato, hash brown, McDonalds	934	0.100000000000000006	2.10000000000000009	13.1999999999999993
2788	Potato, hash brown, purchased frozen, baked or roasted, fat not further defined	1041	1.19999999999999996	4.09999999999999964	15
2789	Potato, hash brown, purchased frozen, baked, roasted, grilled or BBQd, no added fat	964	1.19999999999999996	4.20000000000000018	12.6999999999999993
2790	Potato, hash brown, purchased frozen, par-fried in canola oil, raw	733	0.900000000000000022	3.20000000000000018	9.59999999999999964
2791	Potato, mashed, dried powder	1507	2.39999999999999991	7.09999999999999964	5.79999999999999982
2792	Potato, mashed, prepared from dried powder with cows milk or water	397	0.699999999999999956	2.70000000000000018	2.29999999999999982
2793	Potato, mashed, with gravy, as purchased from a fast food outlet	334	0.5	2.29999999999999982	2.10000000000000009
2794	Potato, new, peeled or unpeeled, baked, roasted, fried, stir-fried, grilled or BBQd, no added fat	419	0.800000000000000044	3.5	0.200000000000000011
2795	Potato, new, peeled or unpeeled, boiled, microwaved or steamed, drained	280	0.400000000000000022	2.5	0.100000000000000006
2796	Potato, new, peeled or unpeeled, raw	276	0.599999999999999978	2.29999999999999982	0.100000000000000006
2797	Potato, pale skin, peeled, baked, roasted, fried, stir-fried, grilled or BBQd, butter, dairy blend or margarine	628	0.900000000000000022	3.39999999999999991	6.20000000000000018
2798	Potato, pale skin, peeled, baked, roasted, fried, stir-fried, grilled or BBQd, canola oil	684	0.900000000000000022	3.29999999999999982	7.70000000000000018
2799	Potato, pale skin, peeled, baked, roasted, fried, stir-fried, grilled or BBQd, fat not further defined	679	0.900000000000000022	3.29999999999999982	7.59999999999999964
2800	Potato, pale skin, peeled, baked, roasted, fried, stir-fried, grilled or BBQd, no added fat	425	0.900000000000000022	3.5	0.200000000000000011
2801	Potato, pale skin, peeled, baked, roasted, fried, stir-fried, grilled or BBQd, olive oil	684	0.900000000000000022	3.29999999999999982	7.70000000000000018
2802	Potato, pale skin, peeled, baked, roasted, fried, stir-fried, grilled or BBQd, other oil	684	0.900000000000000022	3.29999999999999982	7.70000000000000018
2803	Potato, pale skin, peeled, boiled, microwaved or steamed, drained	262	0.200000000000000011	1.5	0.100000000000000006
2804	Potato, pale skin, peeled, boiled, microwaved or steamed, drained, added butter, dairy blend or margarine	423	0.599999999999999978	2.29999999999999982	4.20000000000000018
2805	Potato, pale skin, peeled, boiled, microwaved or steamed, drained, added fat not further defined	442	0.599999999999999978	2.29999999999999982	4.70000000000000018
2806	Potato, pale skin, peeled, boiled, microwaved or steamed, drained, added oil	461	0.599999999999999978	2.20000000000000018	5.20000000000000018
2807	Potato, pale skin, peeled or unpeeled, mashed with cows milk & butter or dairy blend	432	1.5	2.5	5.09999999999999964
2808	Potato, pale skin, peeled or unpeeled, mashed with cows milk & margarine spread	392	1.5	2.5	4
2809	Potato, pale skin, peeled, raw	280	0.599999999999999978	2.29999999999999982	0.100000000000000006
2810	Potato, pale skin, unpeeled, baked, roasted, fried, stir-fried, grilled or BBQd, butter, dairy blend or margarine	630	0.900000000000000022	3.39999999999999991	6.20000000000000018
2811	Potato, pale skin, unpeeled, baked, roasted, fried, stir-fried, grilled or BBQd, canola oil	686	0.900000000000000022	3.29999999999999982	7.70000000000000018
2812	Potato, pale skin, unpeeled, baked, roasted, fried, stir-fried, grilled or BBQd, fat not further defined	681	0.900000000000000022	3.29999999999999982	7.59999999999999964
2813	Potato, pale skin, unpeeled, baked, roasted, fried, stir-fried, grilled or BBQd, no added fat	427	0.900000000000000022	3.5	0.200000000000000011
2814	Potato, pale skin, unpeeled, baked, roasted, fried, stir-fried, grilled or BBQd, olive oil	686	0.900000000000000022	3.29999999999999982	7.70000000000000018
2815	Potato, pale skin, unpeeled, baked, roasted, fried, stir-fried, grilled or BBQd, other oil	686	0.900000000000000022	3.29999999999999982	7.70000000000000018
2816	Potato, pale skin, unpeeled, boiled, microwaved or steamed, added fat not further defined	444	0.599999999999999978	2.29999999999999982	4.70000000000000018
2817	Potato, pale skin, unpeeled, boiled, microwaved or steamed, drained	287	0.599999999999999978	2.39999999999999991	0.100000000000000006
2818	Potato, pale skin, unpeeled, raw	282	0.599999999999999978	2.29999999999999982	0.100000000000000006
2819	Potato, peeled, baked, roasted, fried, stir-fried, grilled or BBQd, butter, dairy blend or margarine	624	1	3.39999999999999991	6.20000000000000018
2820	Potato, peeled, baked, roasted, fried, stir-fried, grilled or BBQd, canola oil	680	1	3.29999999999999982	7.70000000000000018
2821	Potato, peeled, baked, roasted, fried, stir-fried, grilled or BBQd, fat not further defined	676	1	3.39999999999999991	7.59999999999999964
2822	Potato, peeled, baked, roasted, fried, stir-fried, grilled or BBQd, no added fat	399	1.69999999999999996	3.5	0.100000000000000006
2823	Potato, peeled, baked, roasted, fried, stir-fried, grilled or BBQd, olive oil	680	1	3.29999999999999982	7.70000000000000018
2824	Potato, peeled, baked, roasted, fried, stir-fried, grilled or BBQd, other oil	680	1	3.29999999999999982	7.70000000000000018
2825	Potato, peeled, boiled, microwaved or steamed, added fat not further defined	440	0.699999999999999956	2.29999999999999982	4.70000000000000018
2826	Potato, peeled, boiled, microwaved or steamed, drained	280	0.200000000000000011	1.69999999999999996	0.100000000000000006
2827	Potato, peeled, boiled, microwaved or steamed, drained, added butter, dairy spread or margarine	420	0.699999999999999956	2.29999999999999982	4.09999999999999964
2828	Potato, peeled, mashed, prepared, from cafe or restaurant	633	1.30000000000000004	2.29999999999999982	11
2829	Potato, peeled or unpeeled, mashed with cows milk & butter or dairy blend	430	1.60000000000000009	2.5	5.09999999999999964
2830	Potato, peeled or unpeeled, mashed with cows milk & margarine spread	390	1.60000000000000009	2.5	4
2831	Potato, peeled or unpeeled, mashed with cows milk & oil	472	1.60000000000000009	2.5	6.29999999999999982
2832	Potato, peeled, raw, not further defined	278	0.699999999999999956	2.29999999999999982	0.100000000000000006
2833	Potato, pontiac, peeled, baked, roasted, fried, stir-fried, grilled or BBQd, no added fat	421	1.10000000000000009	3.60000000000000009	0.200000000000000011
2834	Potato, pontiac, peeled, boiled, microwaved or steamed, drained	283	0.699999999999999956	2.39999999999999991	0.100000000000000006
2835	Potato, pontiac, peeled, raw	278	0.699999999999999956	2.39999999999999991	0.100000000000000006
2836	Potato, red skin, peeled, baked, roasted, fried, stir-fried, grilled or BBQd, fat not further defined	649	1.69999999999999996	3.39999999999999991	7.5
2837	Potato, red skin, peeled, baked, roasted, fried, stir-fried, grilled or BBQd, no added fat	394	1.80000000000000004	3.60000000000000009	0.100000000000000006
2838	Potato, red skin, peeled, boiled, microwaved or steamed, drained	298	0.200000000000000011	2	0
2839	Potato, red skin, peeled or unpeeled, mashed with cows milk & butter or dairy blend	414	2	2.5	5.09999999999999964
2840	Potato, red skin, peeled, raw	260	1.19999999999999996	2.39999999999999991	0
2841	Potato, red skin, unpeeled, baked, roasted, fried, stir-fried, grilled or BBQd, fat not further defined	628	2.29999999999999982	3.29999999999999982	7.5
2842	Potato, red skin, unpeeled, baked, roasted, fried, stir-fried, grilled or BBQd, no added fat	371	2.39999999999999991	3.5	0
2843	Potato, red skin, unpeeled, boiled, microwaved or steamed, added fat not further defined	408	1.60000000000000009	2.29999999999999982	4.59999999999999964
2844	Potato, red skin, unpeeled, boiled, microwaved or steamed, drained	250	1.60000000000000009	2.39999999999999991	0
2845	Potato, red skin, unpeeled, raw	245	1.60000000000000009	2.29999999999999982	0
2846	Potato, sebago, peeled, baked, roasted, fried, stir-fried, grilled or BBQd, animal fat	493	0.200000000000000011	2.89999999999999991	2.5
2847	Potato, sebago, peeled, boiled & mashed without added ingredients	289	1	2.5	0.400000000000000022
2848	Potato, sebago, peeled, raw	303	0.400000000000000022	2.5	0.200000000000000011
2849	Potato, sebago, unpeeled, baked, roasted, fried, stir-fried, grilled or BBQd, no added fat	312	0.400000000000000022	2.5	0.400000000000000022
2850	Potato, sebago, unpeeled, boiled, microwaved or steamed, drained	261	0	2.20000000000000018	0
2851	Potato straws, French fries, plain	2167	0.200000000000000011	6.90000000000000036	31
2852	Potato straws, French fries, salt & vinegar flavoured	2141	3.10000000000000009	7	31.3999999999999986
2853	Potato, unpeeled, baked, roasted, fried, stir-fried, grilled or BBQd, butter, dairy blend or margarine	623	1.10000000000000009	3.39999999999999991	6.20000000000000018
2854	Potato, unpeeled, baked, roasted, fried, stir-fried, grilled or BBQd, fat not further defined	676	1	3.39999999999999991	7.59999999999999964
2855	Potato, unpeeled, baked, roasted, fried, stir-fried, grilled or BBQd, no added fat	419	1.10000000000000009	3.5	0.100000000000000006
2856	Potato, unpeeled, baked, roasted, fried, stir-fried, grilled or BBQd, olive oil	680	1	3.29999999999999982	7.70000000000000018
2857	Potato, unpeeled, baked, roasted, fried, stir-fried, grilled or BBQd, other oil	680	1	3.29999999999999982	7.70000000000000018
2858	Potato, unpeeled, boiled, microwaved or steamed, drained, with or without added fat	284	0.699999999999999956	2.39999999999999991	0.100000000000000006
2859	Potato, unpeeled, raw, not further defined	277	0.699999999999999956	2.29999999999999982	0.100000000000000006
2860	Potato, wedges, independent takeaway outlet, cafe or restaurant, deep fried, blended oil, salted	809	0	3.79999999999999982	6.5
2861	Potato, wedges, regular, purchased frozen, baked or roasted, no added fat	784	1.10000000000000009	3.60000000000000009	5.29999999999999982
2862	Potato, wedges, regular, purchased frozen, deep fried or fried, fat not further defined	824	1.10000000000000009	3.5	6.5
2863	Potato, wedges, regular, purchased frozen, par-fried in canola oil, raw	596	0.800000000000000044	2.70000000000000018	4
2864	Potato, wild harvested, cooked	430	1.19999999999999996	1.69999999999999996	0.400000000000000022
2865	Powder, medical or special purpose, added vitamins & minerals	2041	0	0	23
2866	Prawn, coated, fried or deep fried, fat not further defined	778	0.400000000000000022	21.1000000000000014	8.30000000000000071
2867	Prawn, coated, packaged frozen, baked, roasted, fried, grilled or BBQd, fat not further defined	983	0	18.8000000000000007	8.40000000000000036
2868	Prawn, coated, takeaway outlet, deep fried	1136	1.19999999999999996	13	15
2869	Prawn, king or medium, flesh, baked, roasted, fried, grilled or BBQd, fat not further defined	504	0	25.3999999999999986	2
2870	Prawn, king or medium, flesh, baked, roasted, fried, grilled or BBQd, no added fat	463	0	25.6000000000000014	0.800000000000000044
2871	Prawn, king or medium, flesh, boiled, microwaved, steamed or poached, fat not further defined	468	0	23.5	1.89999999999999991
2872	Prawn, king or medium, flesh, boiled, microwaved, steamed or poached, no added fat	436	0	23.6999999999999993	0.900000000000000022
2873	Prawn, king or medium, raw (green)	371	0	20.5	0.599999999999999978
2874	Prawn, school, flesh, boiled, microwaved, steamed or poached, no added fat	320	0	17.1000000000000014	0.800000000000000044
2875	Prickly pear, peeled, raw	204	8.80000000000000071	0.400000000000000022	0.299999999999999989
2876	Processed meat, for use in garden s	737	0.699999999999999956	21.1999999999999993	8.69999999999999929
2877	Prosciutto	1224	0.299999999999999989	30.8000000000000007	18.8000000000000007
2878	Prune (dried plum)	841	31	2.29999999999999982	0.400000000000000022
2879	Psyllium, cooked in soy milk, no added salt	226	2.29999999999999982	3.20000000000000018	1.89999999999999991
2880	Psyllium, cooked in water, no added salt	19	0	0.100000000000000006	0
2881	Psyllium, dry, uncooked	764	1.19999999999999996	3	0.699999999999999956
2882	Pumpkin, butternut, peeled, fresh or frozen, baked, roasted, fried, stir-fried, grilled or BBQd, fat not further defined	425	5.79999999999999982	2.39999999999999991	6.40000000000000036
2883	Pumpkin, butternut, peeled, fresh or frozen, baked, roasted, fried, stir-fried, grilled or BBQd, no added fat	222	6.09999999999999964	2.5	0.699999999999999956
2884	Pumpkin, butternut, peeled, fresh or frozen, boiled, microwaved or steamed, drained, with or without added fat	197	5.40000000000000036	2.20000000000000018	0.599999999999999978
2885	Pumpkin, butternut, peeled, fresh or frozen, raw	189	5.20000000000000018	2.10000000000000009	0.599999999999999978
2886	Pumpkin, golden nugget, peeled, fresh or frozen, baked or roasted, no added fat	146	3.10000000000000009	2.60000000000000009	0.400000000000000022
2887	Pumpkin, golden nugget, peeled, fresh or frozen, raw	124	2.60000000000000009	2.20000000000000018	0.299999999999999989
2888	Pumpkin, jarrahdale, peeled, fresh or frozen, baked or roasted, no added fat	131	5.09999999999999964	0.800000000000000044	0.100000000000000006
2889	Pumpkin, jarrahdale, peeled, fresh or frozen, boiled, microwaved or steamed, drained	116	4.5	0.699999999999999956	0.100000000000000006
2890	Pumpkin, jarrahdale, peeled, fresh or frozen, raw	111	4.29999999999999982	0.699999999999999956	0.100000000000000006
2891	Pumpkin, peeled, fresh or frozen, baked, roasted, fried, stir-fried, grilled or BBQd, canola oil	353	4.20000000000000018	1	6
2892	Pumpkin, peeled, fresh or frozen, baked, roasted, fried, stir-fried, grilled or BBQd, fat not further defined	349	4.20000000000000018	1	5.90000000000000036
2893	Pumpkin, peeled, fresh or frozen, baked, roasted, fried, stir-fried, grilled or BBQd, no added fat	142	4.40000000000000036	1.10000000000000009	0.200000000000000011
2894	Pumpkin, peeled, fresh or frozen, baked, roasted, fried, stir-fried, grilled or BBQd, olive oil	353	4.20000000000000018	1	6
2895	Pumpkin, peeled, fresh or frozen, baked, roasted, fried, stir-fried, grilled or BBQd, other oil	353	4.20000000000000018	1	6
2896	Pumpkin, peeled, fresh or frozen, boiled, microwaved or steamed, added fat not further defined	294	3.70000000000000018	0.900000000000000022	4.79999999999999982
2897	Pumpkin, peeled, fresh or frozen, boiled, microwaved or steamed, drained	126	3.89999999999999991	1	0.100000000000000006
2898	Pumpkin, peeled, fresh or frozen, boiled, microwaved or steamed, drained, added butter, dairy blend or margarine	274	3.70000000000000018	1	4.29999999999999982
2899	Pumpkin, peeled, fresh or frozen, raw	121	3.70000000000000018	0.900000000000000022	0.100000000000000006
2900	Pumpkin, queensland blue, peeled, fresh or frozen, baked or roasted, no added fat	244	5.79999999999999982	2.39999999999999991	0.400000000000000022
2901	Pumpkin, queensland blue, peeled, fresh or frozen, boiled, microwaved or steamed, drained	216	5.09999999999999964	2.10000000000000009	0.299999999999999989
2902	Pumpkin, queensland blue, peeled, fresh or frozen, raw	208	4.90000000000000036	2	0.299999999999999989
2903	Pumpkin, unpeeled, fresh or frozen, baked, roasted, fried, stir-fried, grilled or BBQd, canola oil	428	6.79999999999999982	1.60000000000000009	6.09999999999999964
2904	Pumpkin, unpeeled, fresh or frozen, baked, roasted, fried, stir-fried, grilled or BBQd, fat not further defined	424	6.79999999999999982	1.60000000000000009	6
2905	Pumpkin, unpeeled, fresh or frozen, baked, roasted, fried, stir-fried, grilled or BBQd, no added fat	221	7.09999999999999964	1.69999999999999996	0.200000000000000011
2906	Pumpkin, unpeeled, fresh or frozen, baked, roasted, fried, stir-fried, grilled or BBQd, olive oil	428	6.79999999999999982	1.60000000000000009	6.09999999999999964
2907	Pumpkin, unpeeled, fresh or frozen, baked, roasted, fried, stir-fried, grilled or BBQd, other oil	428	6.79999999999999982	1.60000000000000009	6.09999999999999964
2908	Pumpkin, unpeeled, fresh or frozen, boiled, microwaved or steamed, drained, with or without added fat	196	6.29999999999999982	1.5	0.200000000000000011
2909	Pumpkin, unpeeled, fresh or frozen, raw	188	6.09999999999999964	1.39999999999999991	0.200000000000000011
2910	Quail, flesh & skin, baked, roasted, fried, grilled or BBQd, fat not further defined	1040	0	24.1999999999999993	17
2911	Quail, flesh & skin, baked, roasted, fried, grilled or BBQd, no added fat	826	0	27.6999999999999993	9.59999999999999964
2912	Quail, flesh & skin, raw	722	0	18.5	11
2913	Quandong, fruit, flesh	206	8.09999999999999964	2.5	0
2914	Quince, peeled, cooked, sweetened	322	16	0.5	0.200000000000000011
2915	Quinoa, cooked in milk, no added salt	501	5.70000000000000018	5.90000000000000036	3.10000000000000009
2916	Quinoa, cooked in water & fat, no added salt	447	1.39999999999999991	3.89999999999999991	2.70000000000000018
2917	Quinoa, cooked in water, no added salt	414	1.39999999999999991	3.89999999999999991	1.69999999999999996
2918	Quinoa, uncooked	1487	4.90000000000000036	14.0999999999999996	6.09999999999999964
2919	Rabbit, farmed, whole, raw	472	0	23.1999999999999993	2.10000000000000009
2920	Rabbit, flesh, boiled, casseroled, microwaved, poached, steamed, or stewed, no added fat	712	0.200000000000000011	29.3000000000000007	5.70000000000000018
2921	Radish, peeled or unpeeled, raw	74	2.39999999999999991	0.800000000000000044	0.200000000000000011
2922	Radish, red skinned, unpeeled, baked, roasted, fried, stir-fried, grilled or BBQd, no added fat	76	2.29999999999999982	1	0.200000000000000011
2923	Radish, red skinned, unpeeled, raw	62	1.89999999999999991	0.800000000000000044	0.200000000000000011
2924	Radish, white skinned, peeled or unpeeled, baked, roasted, fried, stir-fried, grilled or BBQd, no added fat	105	3.5	0.900000000000000022	0.400000000000000022
2925	Radish, white skinned, peeled or unpeeled, raw	86	2.89999999999999991	0.699999999999999956	0.299999999999999989
2926	Raisin	1210	66.9000000000000057	3.29999999999999982	0.5
2927	Rambutan, raw	312	15.6999999999999993	1	0.400000000000000022
2928	Raspberry, canned in syrup	315	16.8000000000000007	0.599999999999999978	0.100000000000000006
2929	Raspberry, canned in syrup, drained	343	15.9000000000000004	1	0.200000000000000011
2930	Raspberry, canned in syrup, syrup only	296	17.5	0.200000000000000011	0
2931	Raspberry, purchased frozen	203	6.5	1.10000000000000009	0.200000000000000011
2932	Raspberry, raw	203	6.5	1.10000000000000009	0.200000000000000011
2933	Relish, corn, commercial	435	17.8000000000000007	0.599999999999999978	0.100000000000000006
2934	Relish, onion, commercial	715	19	1.19999999999999996	9.69999999999999929
2935	Rhubarb, stalk, raw	94	1.69999999999999996	1.5	0.200000000000000011
2936	Rhubarb, stewed, sugar sweetened, no added fat	269	13	1.39999999999999991	0.200000000000000011
2937	Rice bran, extruded or low processed, uncooked	1631	6.5	13.4000000000000004	20.3999999999999986
2938	Rice, brown, boiled, no added salt	639	0.299999999999999989	2.89999999999999991	1
2939	Rice, brown, fried, no meat or vegetables, oil not further defined, homemade	970	0.400000000000000022	3.89999999999999991	4.09999999999999964
2940	Rice, brown, fried with bacon or ham, egg & mixed vegetables	709	2.10000000000000009	7.09999999999999964	5.90000000000000036
2941	Rice, brown, fried with chicken, egg & mixed vegetables	685	1.80000000000000004	10.1999999999999993	5.29999999999999982
2942	Rice, brown, fried with mixed vegetables	692	2.5	3.39999999999999991	4.90000000000000036
2943	Rice, brown, purchased par-cooked or instant, cooked	669	0.299999999999999989	2.89999999999999991	2
2944	Rice, brown, uncooked	1554	0.699999999999999956	7.29999999999999982	2.39999999999999991
2945	Rice, cooked, for making sushi	637	2.20000000000000018	2.39999999999999991	0.100000000000000006
2946	Rice, flavoured, instant dry mix	1620	1.60000000000000009	8	9.59999999999999964
2947	Rice, flavoured, prepared from dry mix	692	0.699999999999999956	3.39999999999999991	4.09999999999999964
2948	Rice, ground brown rice, with added dry fruit, uncooked	1486	13.5	6.40000000000000036	2
2949	Rice paper wrapper, soaked in water	691	0.200000000000000011	2.5	0.599999999999999978
2950	Rice, purchased as parboiled (gold rice), boiled, no added salt	512	0.299999999999999989	2.10000000000000009	0.400000000000000022
2951	Rice, purchased as parboiled (gold rice), uncooked	1525	0.800000000000000044	6.70000000000000018	1.19999999999999996
2952	Rice, red, steamed or rice cooker, no added salt	639	0.299999999999999989	2.89999999999999991	1
2953	Rice, white, boiled, no added salt	671	0.100000000000000006	2.70000000000000018	0.100000000000000006
2954	Rice, white, boiled, steamed or microwaved with coconut milk	759	1.10000000000000009	2.70000000000000018	5.40000000000000036
2955	Rice, white, fried, no meat or vegetables, oil not further defined, homemade or commercial	1215	0.299999999999999989	3.70000000000000018	10.8000000000000007
2956	Rice, white, fried with bacon or ham, egg & mixed vegetables	728	2	7	5.40000000000000036
2957	Rice, white, fried with bacon or ham, egg, mixed vegetables & nuts	880	2.29999999999999982	8	8.90000000000000036
2958	Rice, white, fried with bacon or ham, egg, prawns & vegetables	920	0.400000000000000022	5.70000000000000018	8.5
2959	Rice, white, fried with beef, lamb or pork & mixed vegetables	734	1.80000000000000004	10.9000000000000004	4.79999999999999982
2960	Rice, white, fried with chicken, egg & mixed vegetables	701	1.69999999999999996	10.0999999999999996	4.90000000000000036
2961	Rice, white, fried with chicken & mixed vegetables	698	1.80000000000000004	9.59999999999999964	4.40000000000000036
2962	Rice, white, fried with egg	1012	0.900000000000000022	7.70000000000000018	10.0999999999999996
2963	Rice, white, fried with egg & mixed vegetables	746	2.20000000000000018	4.59999999999999964	5.70000000000000018
2964	Rice, white, fried with egg, mixed vegetables & seafood	691	1.69999999999999996	11.1999999999999993	4.09999999999999964
2965	Rice, white, fried with lentils	642	0.599999999999999978	4.70000000000000018	4.59999999999999964
2966	Rice, white, fried with mixed vegetables	715	2.39999999999999991	3.20000000000000018	4.29999999999999982
2967	Rice, white, fried with mixed vegetables & seafood	736	1.80000000000000004	11.3000000000000007	4.59999999999999964
2968	Rice, white, pilaf style, with butter, stock & spices	892	0.200000000000000011	3.39999999999999991	3.70000000000000018
2969	Rice, white, purchased par-cooked or instant, cooked	701	0.100000000000000006	2.70000000000000018	1.10000000000000009
2970	Rice, white, steamed or rice cooker, no added salt	671	0.100000000000000006	2.70000000000000018	0.100000000000000006
2971	Rice, white, uncooked	1486	0.200000000000000011	6.29999999999999982	0.5
2972	Rice, wild, boiled, no added salt	425	0.699999999999999956	4	0.299999999999999989
2973	Rice, wild, uncooked	1505	2.5	14.6999999999999993	1.10000000000000009
2974	Rocket, cooked, with or without added fat	111	0.200000000000000011	3.79999999999999982	0.599999999999999978
2975	Rocket, raw	95	0.200000000000000011	3.20000000000000018	0.5
2976	Rosemary, dried	1405	18.1000000000000014	9.5	16.6999999999999993
2977	Rosemary, raw	492	6.29999999999999982	3.29999999999999982	5.90000000000000036
2978	Rum, dark & light coloured	887	0	0	0
2979	Rye, grains, cooked in water	655	0.699999999999999956	5.90000000000000036	1.10000000000000009
2980	Rye, uncooked	1318	1.39999999999999991	12	2.29999999999999982
2981	Sage, dried	1320	1.69999999999999996	10.5999999999999996	12.8000000000000007
2982	Sago, cooked in milk, no added salt	349	5.29999999999999982	3.39999999999999991	2.20000000000000018
2983	Sago, cooked in water, no added salt	229	0	0	0.100000000000000006
2984	Sago, dry, uncooked	1453	0	0	0.400000000000000022
2985	Salami, danish	1858	0.800000000000000044	19.6000000000000014	40.2000000000000028
2986	Salami, hungarian	1783	0	21.6000000000000014	37.3999999999999986
2987	Salami, mettwurst	1791	0.5	21.8999999999999986	37.5
2988	Salami, milano	1781	1	21.6999999999999993	36.8999999999999986
2989	Salami, not further defined	1797	0.599999999999999978	21.6999999999999993	37.6000000000000014
2990	Salami, pepperoni	1774	0.800000000000000044	23.5	36.1000000000000014
2991	Salmon, Atlantic, raw	863	0	21.5	13.4000000000000004
2992	Salmon, baked, roasted, fried, grilled or BBQd, butter, dairy blend or margarine	1288	0	28.3999999999999986	21.8000000000000007
2993	Salmon, baked, roasted, fried, grilled or BBQd, no added fat	1202	0	29.1999999999999993	19.1000000000000014
2994	Salmon, baked, roasted, grilled, BBQd, fried or deep fried, canola oil	1318	0	28.3000000000000007	22.6000000000000014
2995	Salmon, baked, roasted, grilled, BBQd, fried or deep fried, fat not further defined	1315	0	28.3000000000000007	22.5
2996	Salmon, baked, roasted, grilled, BBQd, fried or deep fried, olive oil	1318	0	28.3000000000000007	22.6000000000000014
2997	Salmon, baked, roasted, grilled, BBQd, fried or deep fried, other oil	1318	0	28.3000000000000007	22.6000000000000014
2998	Salmon, boiled, microwaved, steamed or poached, with or without added fat	1061	0	25.3000000000000007	17.1000000000000014
2999	Salmon, canned, drained, not further defined	604	0.5	22.1999999999999993	5.79999999999999982
3000	Salmon, coated, baked, roasted, fried, grilled or BBQd, fat not further defined	1302	0.400000000000000022	22.6000000000000014	21.6999999999999993
3001	Salmon, coated, baked, roasted, fried, grilled or BBQd, no added fat	1107	0.5	23.6999999999999993	15.3000000000000007
3002	Salmon, flavoured, canned, drained	584	4.40000000000000036	16.8000000000000007	5.40000000000000036
3003	Salmon, Pacific king, raw	1149	0	18.1000000000000014	22.8000000000000007
3004	Salmon, pink, unflavoured, canned in brine, drained	579	0	20.6999999999999993	6.20000000000000018
3005	Salmon, pink, unflavoured, canned in water, drained	613	0	21.8999999999999986	6.5
3006	Salmon, raw, not further defined	877	0	21.3000000000000007	13.9000000000000004
3007	Salmon, red, unflavoured, canned in brine, drained	617	0	24.3999999999999986	5.5
3008	Salmon, red, unflavoured, canned in water, drained	702	0	21.8999999999999986	8.90000000000000036
3009	Salmon, sashimi style, raw	879	0	22.3000000000000007	13.5
3010	Salmon, smoked, sliced	724	0	23	9
3011	Salmon, unflavoured, canned, drained	606	0	22.8999999999999986	5.79999999999999982
3012	Salmon, unflavoured, canned in brine, drained	604	0	23.1000000000000014	5.70000000000000018
3013	Salmon, unflavoured, canned in oil	760	0	21.5	10.6999999999999993
3014	Salmon, unflavoured, canned in water, drained	622	0	21.8999999999999986	6.70000000000000018
3015	Saltbush, ruby, fruit	442	11	5.70000000000000018	0.400000000000000022
3016	Salt, cooking	0	0	0	0
3017	Salt, flavoured	0	0	0	0
3018	Salt, not further defined	0	0	0	0
3019	Salt, rock	0	0	0	0
3020	Salt, sea	0	0	0	0
3021	Salt, table, iodised	0	0	0	0
3022	Salt, table, non-iodised	0	0	0	0
3023	Paprika, dry powder	1311	10.3000000000000007	14.0999999999999996	12.9000000000000004
3024	Sardine, canned in oil, drained	952	0	21.8000000000000007	15.6999999999999993
3025	Sardine, canned in oil, undrained	1283	0	17.6000000000000014	26.6000000000000014
3026	Sardine, canned in tomato sauce, undrained	678	1.39999999999999991	17	9.90000000000000036
3027	Sardine, canned in water, drained	721	0	21.5	9.59999999999999964
3028	Sardine, cooked, not further defined	687	0	25.3000000000000007	6.90000000000000036
3029	Sardine, raw	442	0	19.6999999999999993	2.89999999999999991
3030	Sauce, apple, commercial	325	18.3999999999999986	0.200000000000000011	0.100000000000000006
3031	Sauce, apple, homemade	287	15.3000000000000007	0.299999999999999989	0.200000000000000011
3032	Sauce, apricot, commercial or homemade	275	6.29999999999999982	0.800000000000000044	0.400000000000000022
3033	Sauce, barbecue, commercial	738	40.2000000000000028	0.699999999999999956	0.200000000000000011
3034	Sauce, barbecue, homemade	570	25.8999999999999986	1.39999999999999991	0.400000000000000022
3035	Sauce, basil pesto, homemade	2149	0.5	6.59999999999999964	53.7999999999999972
3036	Sauce, bearnaise, homemade	1554	0.599999999999999978	3.29999999999999982	39.2000000000000028
3037	Sauce, black bean, commercial	528	15.3000000000000007	4.09999999999999964	2.79999999999999982
3038	Sauce, butter chicken, commercial	425	3.60000000000000009	1.30000000000000004	7.90000000000000036
3039	Sauce, cheese, homemade with undefined cows milk & fat	834	4.29999999999999982	8	14.5999999999999996
3040	Sauce, chilli (chili), Asian, commercial	472	15	0.900000000000000022	2.60000000000000009
3041	Sauce, cocktail or seafood, commercial or homemade	884	18.8999999999999986	1.60000000000000009	12.4000000000000004
3042	Sauce, cranberry, commercial	643	39.1000000000000014	0.200000000000000011	0.100000000000000006
3043	Sauce, cream based, homemade from basic ingredients	1201	3.5	2.20000000000000018	29.6999999999999993
3044	Sauce, curry, Asian, commercial	620	2.20000000000000018	1.30000000000000004	11.8000000000000007
3045	Sauce, enchilada, commercial	167	6.09999999999999964	0.699999999999999956	0.299999999999999989
3046	Sauce, fish, commercial	213	4.40000000000000036	6.79999999999999982	0.299999999999999989
3047	Sauce, garlic, commercial	781	6.59999999999999964	1.5	5.79999999999999982
3048	Sauce, garlic, homemade	2060	0.699999999999999956	1	52.5
3049	Sauce, hoi sin, commercial	922	33.5	1.69999999999999996	5.40000000000000036
3050	Sauce, hollandaise, homemade	2403	0.200000000000000011	5.09999999999999964	62.3999999999999986
3051	Sauce, honey soy, commercial	677	31.3000000000000007	1.69999999999999996	1.10000000000000009
3052	Sauce, horseradish, commercial	784	13.6999999999999993	4.20000000000000018	11
3053	Sauce, HP, commercial, regular	569	23.3000000000000007	0.699999999999999956	0.100000000000000006
3054	Sauce, lemon chicken, commercial	461	21	0.5	0.200000000000000011
3055	Sauce, mint, commercial or homemade	564	33	0.100000000000000006	0
3056	Sauce, mushroom, commercial, ready to eat	619	1.69999999999999996	0.900000000000000022	11.4000000000000004
3057	Sauce, mushroom, homemade	791	1.5	2.20000000000000018	18.6000000000000014
3058	Sauce, mushroom, prepared from commercial dry mix	153	0.400000000000000022	0.900000000000000022	0.699999999999999956
3059	Sauce, mustard, homemade	627	5.09999999999999964	3	12
3060	Sauce, oyster, commercial	473	15.5999999999999996	2.79999999999999982	1
3061	Sauce, pad Thai, commercial	618	27.1999999999999993	1.5	0.299999999999999989
3062	Sauce, pasta, basil pesto, commercial	1598	2.10000000000000009	5.29999999999999982	37.1000000000000014
3063	Sauce, pasta, beef bolognese, commercial	378	4.40000000000000036	5.40000000000000036	4.59999999999999964
3064	Sauce, pasta, bolognese, homemade using beef mince & commercial tomato based sauce	489	3.70000000000000018	10.4000000000000004	6.09999999999999964
3065	Sauce, pasta, bolognese, homemade using beef mince & homemade tomato based sauce	379	1.5	9.40000000000000036	4.79999999999999982
3066	Sauce, pasta, bolognese, homemade using beef mince & homemade tomato based sauce with vegetables	356	2	8.5	4.20000000000000018
3067	Sauce, pasta, carbonara, commercial	565	2.70000000000000018	3.60000000000000009	10.5999999999999996
3068	Sauce, pasta, carbonara, homemade	1367	0.900000000000000022	18	28
3069	Sauce, pasta, cheese or cream-based, commercial	436	3.29999999999999982	1.69999999999999996	8.30000000000000071
3070	Sauce, pasta or simmer, not further defined, commercial, low fat	240	3.5	0.800000000000000044	2.89999999999999991
3071	Sauce, pasta, pesto, for pasta recipes	1582	2.20000000000000018	5.70000000000000018	37.5
3072	Sauce, pasta, rocket pesto, homemade	2141	0.599999999999999978	7	53.7999999999999972
3073	Sauce, pasta, tomato-based, commercial	227	6.09999999999999964	1.60000000000000009	1.60000000000000009
3074	Sauce, pasta, tomato based, homemade	110	3.70000000000000018	1	0.299999999999999989
3075	Sauce, pasta, tomato pesto, commercial	1265	3.20000000000000018	5.40000000000000036	29.1000000000000014
3076	Sauce, pepper, commercial	238	3.60000000000000009	2.39999999999999991	0.5
3077	Sauce, pepper, homemade	1019	1.5	2	24
3078	Sauce, plum, commercial	958	48.2000000000000028	0.100000000000000006	0.800000000000000044
3079	Sauce, salsa, tomato-based, commercial	146	4.90000000000000036	1.30000000000000004	0
3080	Sauce, salsa, tomato-based, homemade from basic ingredients	96	2.70000000000000018	1.19999999999999996	0.200000000000000011
3081	Sauce, satay, commercial	1176	15.3000000000000007	4.90000000000000036	17.1999999999999993
3082	Sauce, satay, homemade	1163	8.90000000000000036	7.40000000000000036	22.8000000000000007
3083	Sauce, savoury meat with vegetables and gravy, commercial	472	2.39999999999999991	7.09999999999999964	6.90000000000000036
3084	Sauce, savoury meat with vegetables and gravy, homemade	406	2.20000000000000018	10.5	4.29999999999999982
3085	Sauce, simmer, curry flavoured, commercial	437	7.09999999999999964	2.10000000000000009	5.40000000000000036
3086	Sauce, simmer for chicken, not further defined, commercial	376	3.29999999999999982	0.800000000000000044	7.29999999999999982
3087	Sauce, soy, commercial, reduced salt	136	1.69999999999999996	5.40000000000000036	0
3088	Sauce, soy, commercial, regular	136	1.69999999999999996	5.40000000000000036	0
3089	Sauce, stroganoff, commercial	397	5.5	1	6.59999999999999964
3090	Sauce, stroganoff, homemade	502	1.60000000000000009	2.20000000000000018	9
3091	Sauce, sweet, caramel, homemade	1916	46.3999999999999986	1.19999999999999996	31.1999999999999993
3092	Sauce, sweet, caramel, liquid, filling (as used in chocolates, biscuits and ice creams), commercial	1767	72.2999999999999972	2.60000000000000009	15.3000000000000007
3093	Sauce, sweet chilli (chili), commercial	947	52.8999999999999986	0.400000000000000022	0.100000000000000006
3094	Sauce, sweet, chocolate, homemade	2042	29.3000000000000007	3.10000000000000009	38.2999999999999972
3095	Sauce, sweet, lemon & butter, homemade	937	18	0.299999999999999989	16.6000000000000014
3096	Sauce, sweet, mixed berry coulis	270	12.1999999999999993	0.900000000000000022	0.200000000000000011
3097	Sauce, sweet & sour, commercial	786	37.7999999999999972	0.599999999999999978	0.5
3098	Sauce, tabasco, commercial	74	0.100000000000000006	1.30000000000000004	0.800000000000000044
3099	Sauce, taco style, commercial	123	3.5	0.900000000000000022	0.299999999999999989
3100	Sauce, tartare (tartar), commercial, regular fat	1764	9.59999999999999964	1	42.2999999999999972
3101	Sauce, tartare (tartar), homemade	1800	8.09999999999999964	1	43.7000000000000028
3102	Sauce, teriyaki, commercial	850	34.1000000000000014	3.79999999999999982	1
3103	Sauce, tomato, commercial, no added salt	435	23.3000000000000007	1.19999999999999996	0.200000000000000011
3104	Sauce, tomato, commercial, reduced salt	435	23.3000000000000007	1.19999999999999996	0.200000000000000011
3105	Sauce, tomato, commercial, regular	435	23.3000000000000007	1.19999999999999996	0.200000000000000011
3106	Sauce, tomato, homemade	281	3.79999999999999982	1.19999999999999996	4.70000000000000018
3107	Sauce, tomato, not further defined	431	22.8000000000000007	1.19999999999999996	0.299999999999999989
3108	Sauce, white, savoury, homemade with an undefined cows milk & fat	653	5	4.09999999999999964	10.8000000000000007
3109	Sauce, wine reduction, homemade	587	0.900000000000000022	0.699999999999999956	14
3110	Sauce, worcestershire, commercial	311	16.8999999999999986	1.30000000000000004	0.200000000000000011
3111	Sausage, beef, flavoured, fried, grilled, BBQd or baked	1026	0.400000000000000022	15.9000000000000004	17.8999999999999986
3112	Sausage, beef, fried	1026	0.400000000000000022	15.9000000000000004	17.8999999999999986
3113	Sausage, beef, grilled, BBQd or baked	1120	0.400000000000000022	13.9000000000000004	21.5
3114	Sausage, beef, plain or flavoured, boiled, casseroled, microwaved, poached, steamed, or stewed	1100	0	13.3000000000000007	22
3115	Sausage, beef, plain or flavoured, reduced fat, boiled, casseroled, microwaved, poached, steamed or stewed	661	1.19999999999999996	14.5999999999999996	8.40000000000000036
3116	Sausage, beef, plain or flavoured, reduced fat, fried, grilled, BBQd or baked	654	1.19999999999999996	14.5	8.30000000000000071
3117	Sausage, beef, plain or flavoured, reduced fat, raw	621	1.10000000000000009	13.8000000000000007	7.90000000000000036
3118	Sausage, beef, raw	1034	0	12.5	20.6000000000000014
3119	Sausage, boiled, casseroled, microwaved, poached, steamed or stewed	1082	0.100000000000000006	13.8000000000000007	21
3120	Sausage, chicken, flavoured, fried, grilled, BBQd or baked, with or without fat	841	0.800000000000000044	18.1999999999999993	12
3121	Sausage, chicken, plain, fried, grilled, BBQd or baked, with or without added fat	841	0.800000000000000044	18.1999999999999993	12
3122	Sausage, chicken, reduced fat, fried, grilled, BBQd or baked, fat not further defined	820	0.100000000000000006	19	11.0999999999999996
3123	Sausage, chicken, reduced fat, fried, grilled, BBQd or baked, no added fat	779	0.100000000000000006	20.1000000000000014	9.40000000000000036
3124	Sausage, chicken, reduced fat, raw	662	0.100000000000000006	17.1000000000000014	8
3125	Sausage, chorizo, cooked	1245	0.800000000000000044	21.1999999999999993	23.3000000000000007
3126	Sausage, chorizo, uncooked	1183	0.800000000000000044	20.1000000000000014	22.1000000000000014
3127	Sausage, deep fried, commercial	1323	2.70000000000000018	15.3000000000000007	25.1999999999999993
3128	Sausage, fried, grilled, BBQd or baked	1072	0.5	15.5	19.3999999999999986
3129	Sausage, kangaroo, plain or flavoured, fried, grilled, BBQd or baked	494	0.5	21.8999999999999986	1.5
3130	Sausage, lamb, flavoured, fried, grilled, BBQd or baked	960	1.30000000000000004	15.5999999999999996	16.1000000000000014
3131	Sausage, lamb, plain, fried, grilled, BBQd or baked	960	1.30000000000000004	15.5999999999999996	16.1000000000000014
3132	Sausage, pork, flavoured, fried, grilled, BBQd or baked	1083	0.699999999999999956	16.5	19.3999999999999986
3133	Sausage, pork, plain, fried	1083	0.699999999999999956	16.5	19.3999999999999986
3134	Sausage, pork, plain, grilled, BBQd or baked	1203	0.599999999999999978	16.8000000000000007	21.6999999999999993
3135	Sausage, pork, plain or flavoured, boiled, casseroled, microwaved, poached, steamed or stewed	1160	0	12.8000000000000007	23.6000000000000014
3136	Sausage, pork, raw	1090	0	12	22.1999999999999993
3137	Sausage, vegetarian style, added Fe, Zn and vitamin B12, raw	807	1.89999999999999991	19	9.40000000000000036
3138	Sausage, vegetarian style, raw	807	1.89999999999999991	19	9.40000000000000036
3139	Saveloy, battered, deep fried, oil not further defined	1293	3.29999999999999982	11.9000000000000004	20.8000000000000007
3140	Scallop with or without roe, baked, roasted, grilled, fried, deep fried or BBQd, fat not further defined	568	0.5	16.1999999999999993	7
3141	Scallop with or without roe, baked, roasted, grilled, fried or BBQd, no added fat	359	0.5	17	0.900000000000000022
3142	Scallop with or without roe, boiled, microwaved, steamed or poached, with or without added fat	441	0	22.1999999999999993	1.5
3143	Scallop with or without roe, coated, baked, roasted, grilled or BBQd, fat not further defined	640	0.900000000000000022	14.5	6.29999999999999982
3144	Scallop with or without roe, coated, takeaway outlet, deep fried	1256	0.400000000000000022	10.4000000000000004	25.1999999999999993
3145	Scallop, with roe, raw	287	0.400000000000000022	13.5999999999999996	0.800000000000000044
3146	Scone, cheese, commercial	1570	5.90000000000000036	12.3000000000000007	15.0999999999999996
3147	Scone, cheese, homemade from basic ingredients	1307	2.10000000000000009	10.3000000000000007	10.0999999999999996
3148	Scone, chocolate, with chocolate chips, commercial	1590	20.5	7.40000000000000036	14.0999999999999996
3149	Scone, date, commercial	1322	22.3000000000000007	6.29999999999999982	5.59999999999999964
3150	Scone, date, homemade from basic ingredients	1279	13.4000000000000004	7.29999999999999982	7.40000000000000036
3151	Scone, plain, commercial	1357	6.5	7.90000000000000036	7.40000000000000036
3152	Scone, plain, homemade from basic ingredients	1294	5.59999999999999964	8.5	7.79999999999999982
3153	Scone, pumpkin, commercial	1424	8.09999999999999964	9.5	7.40000000000000036
3154	Scone, pumpkin, homemade from basic ingredients	1173	7.70000000000000018	7.70000000000000018	6.29999999999999982
3155	Scone, sultana, commercial	1401	26.1999999999999993	7.5	5.20000000000000018
3156	Scone, sultana, homemade from basic ingredients	1288	14.0999999999999996	7.40000000000000036	7.40000000000000036
3157	Scone, wholemeal, commercial	1348	6.5	8.90000000000000036	8.09999999999999964
3158	Scone, wholemeal, homemade from basic ingredients	1281	6.20000000000000018	8.40000000000000036	8.40000000000000036
3159	Seafood or fish stick (surimi), coated, takeaway outlet, deep fried	966	2.20000000000000018	8	15.0999999999999996
3160	Seafood or fish stick (surimi), packaged frozen, boiled, microwaved, steamed or poached, no added fat	422	3.5	11.1999999999999993	0.900000000000000022
3161	Seafood or fish stick (surimi), packaged frozen, fried, peanut oil	584	4.09999999999999964	11.5	4.79999999999999982
3162	Seafood or fish stick (surimi), packaged frozen, raw	372	3.10000000000000009	9.80000000000000071	0.800000000000000044
3163	Seasoning mix, chilli-based, for tacos	1010	19.1999999999999993	5.90000000000000036	4.09999999999999964
3164	Seaweed, boiled, microwaved or steamed, drained	228	0.100000000000000006	8.40000000000000036	0.800000000000000044
3165	Seaweed, nori, dried	1266	0.299999999999999989	46.7000000000000028	4.29999999999999982
3166	Seed, chia, cooked, no added salt	392	5	4.79999999999999982	5.09999999999999964
3167	Seed, chia, dried	1825	0	16.5	30.6999999999999993
3168	Seed, linseed or flaxseed	2116	1.60000000000000009	18.3000000000000007	42.2000000000000028
3169	Seed, poppy	2273	0	18	44.7000000000000028
3170	Seed, pumpkin, hulled & dried, unsalted	2424	1.39999999999999991	30.1999999999999993	49
3171	Seed, sesame, unsalted	2620	0.599999999999999978	22.1999999999999993	55.6000000000000014
3172	Seeds, mixed	2407	1.39999999999999991	25.6999999999999993	49.1000000000000014
3173	Seed, sunflower, unsalted	2465	2	26.8000000000000007	51
3174	Semolina, cooked in cows milk, no added salt	456	4.79999999999999982	4.90000000000000036	2.20000000000000018
3175	Semolina, cooked in water, no added salt	433	0	3.10000000000000009	0.400000000000000022
3176	Semolina, uncooked	1361	0	9.80000000000000071	1.19999999999999996
3177	Shallot, peeled, baked, roasted, fried, stir-fried, grilled or BBQd, no added fat	165	5.20000000000000018	2.39999999999999991	0.200000000000000011
3178	Shallot, peeled, raw	102	3.20000000000000018	1.5	0.200000000000000011
3179	Shark (flake), baked, roasted, fried, grilled or BBQd, no added fat	615	0	35.8999999999999986	0.100000000000000006
3180	Shark (flake), baked, roasted, grilled, BBQd, fried or deep fried, fat not further defined	833	0	34.1000000000000014	6.90000000000000036
3181	Shark (flake), boiled, microwaved, steamed or poached, with or without added fat	523	0	30.3000000000000007	0.200000000000000011
3182	Shark (flake), coated, baked, roasted, grilled or BBQd, fat not further defined	881	0.400000000000000022	27.3999999999999986	8.19999999999999929
3183	Shark (flake), coated, packaged frozen, baked, roasted, fried, grilled or BBQd, with or without added fat	1045	0.900000000000000022	25.8000000000000007	9.69999999999999929
3184	Shark (flake), coated, takeaway outlet, deep fried	1106	0.200000000000000011	20.8000000000000007	15.9000000000000004
3185	Shark (flake), raw	449	0	26.1999999999999993	0.100000000000000006
3186	Sheep, milk or yoghurt	385	3.5	5.20000000000000018	5.5
3187	Sherbet powder	1496	93.5	0	0
3188	Sherry, dry style (~ 1% sugars)	435	1.19999999999999996	0.100000000000000006	0
3189	Sherry, not further defined	520	7.09999999999999964	0.200000000000000011	0
3190	Sherry, sweet style (~11% sugars)	577	11.0999999999999996	0.200000000000000011	0
3191	Shortening, commercial, animal fat (for short pastry, pie bases, tarts and flans)	3703	0	0.200000000000000011	100
3192	Shortening, commercial, blend of animal & vegetable fat (for cakes, muffins, shortbreads & biscuits)	2983	0.800000000000000044	0.599999999999999978	80
3193	Shortening, commercial, vegetable fat (for bread, buns & yeast doughs)	3700	0	0	100
3194	Shortening, commercial, vegetable fat (for coatings, creams, icings, confectionery & fillings)	3700	0	0.200000000000000011	99.9000000000000057
3195	Shortening, commercial, vegetable fat (for flaky pastry, pie tops, sausage rolls & danishes)	2960	0	0	80
3196	Silverbeet, fresh or frozen, boiled, microwaved or steamed, drained	77	1.19999999999999996	1.80000000000000004	0.200000000000000011
3197	Silverbeet, fresh or frozen, raw	66	1	1.5	0.200000000000000011
3198	Silver perch, baked, roasted, fried, grilled or BBQd, no added fat	1266	0	26.6999999999999993	22
3199	Silver perch, baked, roasted, grilled, BBQd, fried or deep fried, fat not further defined	1377	0	25.8999999999999986	25.3000000000000007
3200	Silver perch, boiled, microwaved, steamed or poached, with or without added fat	1116	0	23.1000000000000014	19.6000000000000014
3201	Silver perch, raw	924	0	19.5	16
3202	Slice, brownie, chocolate, with nuts, commercial	1862	35.7000000000000028	6.20000000000000018	23.8000000000000007
3203	Slice, brownie, chocolate, with nuts, homemade from basic ingredients, fat not further defined	1935	35.2999999999999972	6.5	25.5
3204	Slice, brownie, chocolate, without nuts, homemade from basic ingredients, butter or dairy blend	1943	36.5	5.59999999999999964	27.6000000000000014
3205	Slice, brownie, chocolate, without nuts, homemade from basic ingredients, fat not further defined	1962	36.5	5.59999999999999964	28.1000000000000014
3206	Slice, brownie, chocolate, without nuts, homemade from basic ingredients, with oil	2117	36.5	5.40000000000000036	32.3999999999999986
3207	Slice, caramel, commercial	1777	43.1000000000000014	5.90000000000000036	20.1000000000000014
3208	Slice, caramel, homemade from basic ingredients, fat not further defined	1945	43.6000000000000014	5.70000000000000018	25.6000000000000014
3209	Slice, cherry, homemade from basic ingredients, fat not further defined	1926	45.1000000000000014	5.70000000000000018	23.6999999999999993
3210	Slice, chocolate, commercial, chocolate icing	2095	38.7000000000000028	3.79999999999999982	29.6999999999999993
3211	Slice, chocolate, homemade from basic ingredients, fat not further defined, chocolate icing	2063	39.5	3.79999999999999982	28.8000000000000007
3212	Slice, coconut, with jam, commercial	1911	35.7000000000000028	5.59999999999999964	25.6999999999999993
3213	Slice, coconut, with jam, homemade from basic ingredients, fat not further defined	1853	37.2000000000000028	5.40000000000000036	22.5
3214	Slice, dried fruit, homemade from basic ingredients, fat not further defined	1827	40.7999999999999972	4.70000000000000018	20.3999999999999986
3215	Slice, fruit mince, commercial, with icing	1261	34.7000000000000028	3.79999999999999982	9.40000000000000036
3216	Slice, hedgehog, commercial, chocolate icing	1639	44.1000000000000014	5.40000000000000036	17.5
3217	Slice, hedgehog, homemade from basic ingredients, fat not further defined, chocolate icing	1891	37.6000000000000014	4.59999999999999964	26.1000000000000014
3218	Slice, jelly, commercial	1094	18.6000000000000014	5.40000000000000036	16.3999999999999986
3219	Slice, jelly, homemade from basic ingredients, fat not further defined	1099	18.5	5.40000000000000036	16.6000000000000014
3220	Slice, lemon, homemade from basic ingredients, fat not further defined	1369	38.5	4.90000000000000036	11.5
3221	Slice, meringue, with jam, homemade from basic ingredients, fat not further defined	1876	22.3999999999999986	6.5	26.3000000000000007
3222	Slice, muesli, with sultanas & apricot, homemade from basic ingredients, fat not further defined	1701	33	6.09999999999999964	17.3999999999999986
3223	Slice, not further defined	1595	34.2999999999999972	4.79999999999999982	18.1999999999999993
3224	Slice, nut, homemade from basic ingredients, fat not further defined	2208	29.6000000000000014	8.19999999999999929	36
3225	Slice, oat, with caramel, marshmallow & chocolate, homemade from basic ingredients, fat not further defined	2064	28.6000000000000014	9	27.3000000000000007
3226	Slice, passionfruit	1702	37.2999999999999972	6.20000000000000018	21.1999999999999993
3227	Slice, vanilla, commercial, with icing (except chocolate flavoured)	857	14	3.20000000000000018	8.90000000000000036
3228	Slice, vanilla, homemade from basic ingredients, fat not further defined, with icing (except chocolate flavoured)	1130	18.5	3.39999999999999991	14.4000000000000004
3229	Smoked fish (including eel & trout), smoked	631	0	27.8000000000000007	4.29999999999999982
3230	Snow pea, fresh or frozen, baked, roasted, fried, stir-fried, grilled or BBQd, fat not further defined	414	3.39999999999999991	3.60000000000000009	6.40000000000000036
3231	Snow pea, fresh or frozen, baked, roasted, fried, stir-fried, grilled or BBQd, no added fat	196	3.60000000000000009	3.79999999999999982	0.200000000000000011
3232	Snow pea, fresh or frozen, boiled, microwaved or steamed, added fat not further defined	340	3	3.10000000000000009	5.09999999999999964
3233	Snow pea, fresh or frozen, boiled, microwaved or steamed, drained	169	3.10000000000000009	3.20000000000000018	0.200000000000000011
3234	Snow pea, fresh or frozen, raw	157	2.89999999999999991	3	0.200000000000000011
3235	Soy bean curd skins, dried, rehydrated in boiling water	346	0.400000000000000022	8.69999999999999929	3.79999999999999982
3236	Soy beverage, chocolate flavoured, reduced fat (~ 1.5%), added Ca & vitamins A, B1, B2 & B12	278	5.79999999999999982	3.20000000000000018	1.5
3237	Soy beverage, chocolate flavoured, regular fat (~3%), added Ca & vitamins A, B1, B2 & B12	288	5.79999999999999982	3.20000000000000018	2.70000000000000018
3238	Soy beverage, coffee flavoured, reduced fat (~ 1.5%), added Ca & vitamins A, B1, B2 & B12	266	5.20000000000000018	3.10000000000000009	1.5
3239	Soy beverage, low fat (~ 0.1%), added Ca & vitamins A, B1, B2 & B12	210	1.30000000000000004	3.20000000000000018	0.100000000000000006
3240	Soy beverage, reduced fat (1-2%), unflavoured, not further defined	160	1.89999999999999991	2.5	1
3241	Soy beverage, reduced fat (~1.5% fat), added Ca	157	1.60000000000000009	3	1.5
3242	Soy beverage, reduced fat (~1.5% fat), added fibre, Ca & vitamins A, B1, B2, B6 & B12	240	2.10000000000000009	3.20000000000000018	1.5
3243	Soy beverage, reduced fat (~1.5% fat), added vitamins A, B1, B2, B3, B6, B12, C, E, folate & Ca & Fe	260	1.30000000000000004	3.20000000000000018	1.39999999999999991
3244	Soy beverage, reduced fat (~1% fat), added Ca & vitamins A, B1, B2 & B12	187	1.69999999999999996	3	0.900000000000000022
3245	Soy beverage, reduced fat (~1% fat), added Ca & vitamins A, B2 & B12	191	1.69999999999999996	3	1
3246	Soy beverage, reduced fat (~1% fat), unfortified	113	2.39999999999999991	1.39999999999999991	0.699999999999999956
3247	Soy beverage, regular fat (~3%), added Ca	246	2.60000000000000009	3.70000000000000018	2.70000000000000018
3248	Soy beverage, regular fat (~3%), added Ca & vitamins A, B1, B2 & B12	251	2.60000000000000009	4.09999999999999964	2.70000000000000018
3249	Soy beverage, regular fat (~3%), added Ca & vitamins A, B1, B2, B6, B12, & D	273	4.20000000000000018	3.20000000000000018	3
3250	Soy beverage, regular fat (~3%), added Ca & vitamins A, B2, & B12	230	1.60000000000000009	3.10000000000000009	3
3251	Soy beverage, regular fat (~3%), homemade from basic ingredients, unfortified	246	2.60000000000000009	3.70000000000000018	2.70000000000000018
3252	Soy beverage, regular fat (~3%), unflavoured, not further defined	250	2.70000000000000018	3.79999999999999982	2.70000000000000018
3253	Soy beverage, regular fat (~3%), unfortified	246	2.60000000000000009	3.70000000000000018	2.70000000000000018
3254	Soy beverage, unflavoured, not further defined	213	2.29999999999999982	3.20000000000000018	1.89999999999999991
3255	Spam, canned	1238	1.19999999999999996	14.1999999999999993	26.1000000000000014
3256	Spelt, uncooked	1471	0.900000000000000022	18.6999999999999993	2.39999999999999991
3257	Spice, mixed or all spice	1560	10.5	5.5	19.1999999999999993
3258	Spinach, boiled, microwaved or steamed, drained, not further defined	123	0.599999999999999978	3.20000000000000018	0.400000000000000022
3259	Spinach, fresh, baked, roasted, fried, stir-fried, grilled or BBQd, fat not further defined	389	0.800000000000000044	3.29999999999999982	7.40000000000000036
3260	Spinach, fresh, baked, roasted, fried, stir-fried, grilled or BBQd , no added fat	136	0.900000000000000022	3.39999999999999991	0.400000000000000022
3261	Spinach, fresh, boiled, microwaved or steamed, added fat not further defined	303	0.699999999999999956	2.70000000000000018	5.59999999999999964
3262	Spinach, fresh, boiled, microwaved or steamed, drained	112	0.699999999999999956	2.79999999999999982	0.400000000000000022
3263	Spinach, fresh, raw	95	0.599999999999999978	2.39999999999999991	0.299999999999999989
3264	Spinach, frozen, boiled, microwaved or steamed, drained	134	0.5	3.5	0.5
3265	Spinach, water, cooked, with or without added fat	414	0.699999999999999956	3.89999999999999991	7.79999999999999982
3266	Spinach, water, raw	110	0.5	2.89999999999999991	0.5
3267	Spirit, not further defined	912	2.60000000000000009	0.100000000000000006	0.400000000000000022
3268	Spread, hazelnut & chocolate flavoured	2260	57.2000000000000028	6.79999999999999982	32.1000000000000014
3269	Spread, vegetable & yeast extract, mightymite	681	4.5	9.40000000000000036	1.60000000000000009
3270	Spread, vegetable & yeast extract, Promite	856	18.3999999999999986	14.5999999999999996	2.20000000000000018
3271	Spread, yeast, cheesybite	1033	4.40000000000000036	5.29999999999999982	17.1000000000000014
3272	Spread, yeast, marmite	624	11.8000000000000007	13.3000000000000007	0.900000000000000022
3273	Spread, yeast, not further defined	688	2.5	23.5	1
3274	Spread, yeast, vegemite, my first vegemite	889	4.70000000000000018	24.6000000000000014	0.900000000000000022
3275	Spread, yeast, vegemite, regular	679	1.60000000000000009	24.1000000000000014	0.900000000000000022
3276	Sprout, alfalfa, raw	91	0.5	3.20000000000000018	0.299999999999999989
3277	Sprout, bean, cooked, fat not further defined	319	1.10000000000000009	3.5	5.90000000000000036
3278	Sprout, bean, cooked, no added fat	110	1.19999999999999996	3.60000000000000009	0.100000000000000006
3279	Sprout, bean, raw	94	1	3.10000000000000009	0.100000000000000006
3280	Sprout, for use in salad recipes, alfalfa & mung bean	92	0.800000000000000044	3.20000000000000018	0.200000000000000011
3281	Squash, button, fresh or frozen, boiled, microwaved or steamed, drained	131	3.5	3.20000000000000018	0.200000000000000011
3282	Squash, button, fresh or frozen, raw	110	2.89999999999999991	2.70000000000000018	0.200000000000000011
3283	Squash, scallopini, fresh or frozen, boiled, microwaved or steamed, drained	100	2.39999999999999991	2.60000000000000009	0.200000000000000011
3284	Squash, scallopini, fresh or frozen, raw	84	2	2.20000000000000018	0.200000000000000011
3285	Squid or calamari, baked, roasted, fried, stir-fried, deep fried, grilled or BBQd, fat not further defined	617	0	19.8000000000000007	7.59999999999999964
3286	Squid or calamari, baked, roasted, fried, stir-fried, grilled or BBQd, no added fat	410	0	20.8999999999999986	1.5
3287	Squid or calamari, battered, takeaway outlet, deep fried	988	0	12.9000000000000004	17.1999999999999993
3288	Squid or calamari, boiled, microwaved, steamed or poached, with or without added fat	431	0	20.8000000000000007	2.10000000000000009
3289	Squid or calamari, coated, baked, roasted, fried, grilled or BBQd, fat not further defined	734	0.400000000000000022	17.3999999999999986	8.90000000000000036
3290	Squid or calamari, coated, packaged frozen, baked, roasted, fried, grilled or BBQd, with or without added fat	811	0.5	10.1999999999999993	6.90000000000000036
3291	Squid or calamari, crumbed, takeaway outlet, deep fried	1239	0	18.3000000000000007	17.1000000000000014
3292	Squid or calamari, raw	328	0	16.6999999999999993	1.19999999999999996
3293	Starch, potato	1332	0	0	0.5
3294	Steamed bun, savoury, plain	1020	5.29999999999999982	5.70000000000000018	7.70000000000000018
3295	Steamed bun, savoury, pork	785	4.40000000000000036	7.20000000000000018	6.90000000000000036
3296	Stingray, wild caught, flesh, baked, roasted, fried, grilled or BBQd, no added fat	615	0	35.8999999999999986	0.100000000000000006
3297	Stock, dry powder or cube	900	4.29999999999999982	11.3000000000000007	8.90000000000000036
3298	Stock, dry powder or cube, reduced salt	900	4.29999999999999982	11.3000000000000007	8.90000000000000036
3299	Stock, liquid, all flavours (except fish), homemade from basic ingredients	68	0	2.29999999999999982	0.800000000000000044
3300	Stock, liquid, all flavours (except fish), prepared from commercial powder or cube	18	0.100000000000000006	0.200000000000000011	0.200000000000000011
3301	Stock, liquid, all flavours, reduced salt, prepared from commercial powder or cube	18	0.100000000000000006	0.200000000000000011	0.200000000000000011
3302	Stock, liquid, fish, commercial	27	0.400000000000000022	0.699999999999999956	0.100000000000000006
3303	Stock, liquid, fish, homemade from basic ingredients	68	0	2.29999999999999982	0.800000000000000044
3304	Stone fruit, peeled or unpeeled, raw, not further defined	178	7.59999999999999964	0.900000000000000022	0.100000000000000006
3305	Strawberry, canned in syrup	335	18.6999999999999993	0.5	0.200000000000000011
3306	Strawberry, canned in syrup, drained	353	18.5	0.900000000000000022	0.100000000000000006
3307	Strawberry, canned in syrup, syrup only	321	18.8000000000000007	0.100000000000000006	0.200000000000000011
3308	Strawberry, chocolate coated	907	22.5	3	11.8000000000000007
3309	Strawberry, purchased frozen	108	3.79999999999999982	0.699999999999999956	0.200000000000000011
3310	Strawberry, raw	108	3.79999999999999982	0.699999999999999956	0.200000000000000011
3311	Stuffing, bread-based, commercial	804	1.39999999999999991	6.40000000000000036	8.40000000000000036
3312	Suet	3395	0	0	86.7000000000000028
3313	Sugar, brown	1552	96.7999999999999972	0.200000000000000011	0
3314	Sugar, cinnamon	1543	91.4000000000000057	0.400000000000000022	0.299999999999999989
3315	Sugar, raw	1597	99.7999999999999972	0	0
3316	Sugar, raw, low GI (glucose index)	1597	99.7999999999999972	0	0
3317	Sugar, white, fruit sugar (fructose), granulated or lump	1600	100	0	0
3318	Sugar, white, granulated or lump	1600	100	0	0
3319	Sugar, white, icing	1600	100	0	0
3320	Sugar, white, icing mixture	1598	95.5999999999999943	0	0
3321	Sugar, white, with added stevia, granulated	1599	99.5999999999999943	0	0
3322	Sultana	1329	73.2000000000000028	2.79999999999999982	0.900000000000000022
3323	Swede, peeled, fresh or frozen, baked, roasted, fried, stir-fried, grilled or BBQd, fat not further defined	330	3.89999999999999991	1	6
3324	Swede, peeled, fresh or frozen, boiled, microwaved or steamed, drained	100	3.70000000000000018	1	0
3325	Swede, peeled, fresh or frozen, raw	93	3.39999999999999991	0.900000000000000022	0
3326	Sweetcorn, baby, canned in brine, heated, drained	105	1.60000000000000009	1.60000000000000009	0.200000000000000011
3327	Sweetcorn, creamed, canned, heated	366	5.09999999999999964	2	0.699999999999999956
3328	Sweetcorn, fresh or frozen, boiled, microwaved or steamed, drained	435	3.79999999999999982	4	1.80000000000000004
3329	Sweetcorn, fresh or frozen on cob, baked, roasted, fried, stir-fried, grilled or BBQd, added fat not further defined	658	4.20000000000000018	4.5	7.70000000000000018
3330	Sweetcorn, fresh or frozen on cob, baked, roasted, fried, stir-fried, grilled or BBQd, no added fat	480	4.40000000000000036	4.79999999999999982	2.29999999999999982
3331	Sweetcorn, fresh or frozen on cob, boiled, microwaved or steamed, drained	436	4	4.29999999999999982	2.10000000000000009
3332	Sweetcorn, fresh or frozen on cob, boiled, microwaved or steamed, drained, added fat not further defined	583	3.79999999999999982	4.09999999999999964	6.59999999999999964
3333	Sweetcorn, fresh or frozen on cob, boiled or microwaved in brine, drained	438	5.29999999999999982	4.20000000000000018	2.79999999999999982
3334	Sweetcorn, fresh or frozen on cob, raw	432	4	4.29999999999999982	2.10000000000000009
3335	Sweetcorn, fresh or frozen, raw, not further defined	418	3.60000000000000009	3.89999999999999991	1.69999999999999996
3336	Sweetcorn, kernels, baked, roasted, fried, stir-fried, grilled or BBQd, fat not further defined	614	3.20000000000000018	3.20000000000000018	6.40000000000000036
3337	Sweetcorn, kernels, canned in brine, drained	391	3.5	2.89999999999999991	1
3338	Sweetcorn, kernels, canned in brine, heated, drained	478	3.5	3.10000000000000009	1
3339	Sweetcorn, kernels, fresh or frozen, boiled, microwaved or steamed, drained	452	2.60000000000000009	3.10000000000000009	0.900000000000000022
3340	Sweetcorn, kernels, fresh or frozen, boiled, microwaved or steamed, drained, added fat not further defined	597	2.5	3	5.40000000000000036
3341	Sweetcorn, kernels, fresh or frozen, boiled or microwaved in brine, drained	392	2.60000000000000009	3.10000000000000009	1
3342	Sweetcorn, kernels, fresh or frozen, raw	390	3	3	0.900000000000000022
3343	Sweet potato, chips, regular, purchased frozen, baked or roasted, with or without added fat	1101	12.3000000000000007	4.20000000000000018	9.80000000000000071
3344	Sweet potato, chips, regular, purchased frozen, par-fried in canola oil, raw	771	8.59999999999999964	2.89999999999999991	6.79999999999999982
3345	Sweet potato, orange flesh, mashed with fat not further defined	541	5.29999999999999982	1.80000000000000004	7.09999999999999964
3346	Sweet potato, orange flesh, peeled or unpeeled, fresh or frozen, baked, fried, grilled, fat not further defined	565	6.5	2.20000000000000018	6.09999999999999964
3347	Sweet potato, orange flesh, peeled or unpeeled, fresh or frozen, baked, roasted, fried, stir-fried, grilled or BBQd, canola oil	569	6.5	2.20000000000000018	6.20000000000000018
3348	Sweet potato, orange flesh, peeled or unpeeled, fresh or frozen, baked, roasted, fried, stir-fried, grilled or BBQd, no added fat	362	6.79999999999999982	2.29999999999999982	0.100000000000000006
3349	Sweet potato, orange flesh, peeled or unpeeled, fresh or frozen, baked, roasted, fried, stir-fried, grilled or BBQd, olive oil	569	6.5	2.20000000000000018	6.20000000000000018
3350	Sweet potato, orange flesh, peeled or unpeeled, fresh or frozen, baked, roasted, fried, stir-fried, grilled or BBQd, other oil	569	6.5	2.20000000000000018	6.20000000000000018
3351	Sweet potato, orange flesh, peeled or unpeeled, fresh or frozen, boiled, microwaved or steamed, added fat not further defined	483	5.70000000000000018	2	5
3352	Sweet potato, orange flesh, peeled or unpeeled, fresh or frozen, boiled, microwaved or steamed, drained	319	6	2	0.100000000000000006
3353	Sweet potato, orange flesh, peeled or unpeeled, fresh or frozen, raw	297	5.59999999999999964	1.89999999999999991	0.100000000000000006
3354	Sweet potato, white flesh, peeled or unpeeled, fresh or frozen, baked, roasted, fried, stir-fried, grilled or BBQd, no added fat	450	3.60000000000000009	1.19999999999999996	0.200000000000000011
3355	Sweet potato, white flesh, peeled or unpeeled, fresh or frozen, boiled, microwaved or steamed, drained	397	3.20000000000000018	1	0.200000000000000011
3356	Sweet potato, white flesh, peeled or unpeeled, fresh or frozen, raw	369	3	1	0.200000000000000011
3357	Sweet potato, white flesh, peeled or unpeeled, fresh or frozen, stir-fried, fat not further defined	649	3.39999999999999991	1.10000000000000009	6.20000000000000018
3358	Swordfish, baked, roasted, fried, grilled or BBQd, no added fat	748	0	26.8999999999999986	7.79999999999999982
3359	Swordfish, baked, roasted, grilled, BBQd, fried or deep fried, fat not further defined	833	0	26.3999999999999986	10.4000000000000004
3360	Swordfish, raw	546	0	19.6999999999999993	5.70000000000000018
3361	Syrup, agave, light & dark, liquid	1216	76	0	0
3362	Syrup, golden	1203	74.9000000000000057	0.200000000000000011	0
3363	Syrup, maple, pure (100% maple)	960	59.5	0	0.200000000000000011
3364	Taco shell, from corn flour, plain	1946	1.19999999999999996	7.20000000000000018	22.6000000000000014
3365	Tahini, sesame seed pulp	2717	0.699999999999999956	20.3999999999999986	60.7000000000000028
3366	Tamarillo, peeled, raw	150	3.39999999999999991	2	0.100000000000000006
3367	Tamarind, paste, pure, raw	1029	57.3999999999999986	2.79999999999999982	0.599999999999999978
3368	Tangelo, peeled, raw	172	7.79999999999999982	0.599999999999999978	0.100000000000000006
3369	Tangerine or tangor, peeled, raw	180	8.09999999999999964	1	0.200000000000000011
3370	Tapioca, pearl or seed style, uncooked	1458	0	0	0.200000000000000011
3371	Tapioca, seed or pearl style, boiled in water, no added fat or salt	123	0	0	0
3372	Taro, peeled, fresh or frozen, boiled, microwaved or steamed, drained	504	1.19999999999999996	2	0.200000000000000011
3373	Taro, peeled, fresh or frozen, raw	469	1.10000000000000009	1.89999999999999991	0.200000000000000011
3374	Tea, chai, flavoured, without milk	6	0	0.100000000000000006	0.100000000000000006
3375	Tea, chai, instant dry powder	1258	5.5	20.1999999999999993	0
3376	Tea, chai, plain, without milk	6	0	0.100000000000000006	0.100000000000000006
3377	Tea, decaffeinated, black, brewed from leaf or teabags, plain, without milk	6	0	0.100000000000000006	0.100000000000000006
3378	Tea, green, flavoured, without milk	6	0	0.100000000000000006	0.100000000000000006
3379	Tea, green, plain, without milk	6	0	0.100000000000000006	0.100000000000000006
3380	Tea, herbal, chamomile, without milk	6	0	0.100000000000000006	0.100000000000000006
3381	Tea, herbal, lemon, without milk	6	0	0.100000000000000006	0.100000000000000006
3382	Tea, herbal, mint, without milk	6	0	0.100000000000000006	0.100000000000000006
3383	Tea, herbal, other, without milk	6	0	0.100000000000000006	0.100000000000000006
3384	Tea, jasmine, plain, without milk	6	0	0.100000000000000006	0.100000000000000006
3385	Tea, regular, black, brewed from leaf or teabags, flavoured, without milk	6	0	0.100000000000000006	0.100000000000000006
3386	Tea, regular, black, brewed from leaf or teabags, plain, without milk	6	0	0.100000000000000006	0.100000000000000006
3387	Tea, regular, white, brewed from leaf or teabags, with cows milk not further defined	33	0.699999999999999956	0.5	0.400000000000000022
3388	Tempeh (fermented soy beans), fried	1875	0.900000000000000022	23.1999999999999993	33.7999999999999972
3389	Tempura for coating food, commercial, uncooked	506	0.100000000000000006	2.70000000000000018	0.400000000000000022
3390	Tempura for coating food, homemade, uncooked	523	0	4.79999999999999982	1.39999999999999991
3391	Tequila	886	0.100000000000000006	0	0
3392	Thiamin	0	0	0	0
3393	Thyme, dried, ground	1149	1.80000000000000004	8.09999999999999964	6
3394	Tilapia, boiled, microwaved, steamed or poached, no added fat	568	0	22	5.20000000000000018
3395	Tilapia, raw	477	0	18.5	4.40000000000000036
3396	Tofu (soy bean curd), firm, as purchased	502	0	12	7.29999999999999982
3397	Tofu (soy bean curd), fried, stir-fried, grilled or BBQd, fat not further defined	773	0	16.1000000000000014	12.5
3398	Tofu (soy bean curd), fried, stir-fried, grilled or BBQd, no added fat	688	0	16.3999999999999986	10
3399	Tofu (soy bean curd), silken or soft, as purchased	224	0.599999999999999978	5.40000000000000036	2.5
3400	Tofu (soy bean curd), smoked, as purchased	751	0.299999999999999989	17.3000000000000007	9.80000000000000071
3401	Tomato, cherry or grape, raw	65	2.20000000000000018	0.5	0.100000000000000006
3402	Tomato, common, boiled with salt, drained	72	2.29999999999999982	0.900000000000000022	0.100000000000000006
3403	Tomato, common, raw	74	2.29999999999999982	1	0.100000000000000006
3404	Tomato, fresh, baked, roasted, fried, stir-fried, grilled or BBQd, butter, dairy blend or margarine	272	2.70000000000000018	1.19999999999999996	5.09999999999999964
3405	Tomato, fresh, baked, roasted, fried, stir-fried, grilled or BBQd, canola oil	318	2.70000000000000018	1.10000000000000009	6.40000000000000036
3406	Tomato, fresh, baked, roasted, fried, stir-fried, grilled or BBQd, fat not further defined	314	2.70000000000000018	1.10000000000000009	6.29999999999999982
3407	Tomato, fresh, baked, roasted, fried, stir-fried, grilled or BBQd, no added fat	92	2.89999999999999991	1.19999999999999996	0.100000000000000006
3408	Tomato, fresh, baked, roasted, fried, stir-fried, grilled or BBQd, olive oil	318	2.70000000000000018	1.10000000000000009	6.40000000000000036
3409	Tomato, fresh, baked, roasted, fried, stir-fried, grilled or BBQd, other oil	318	2.70000000000000018	1.10000000000000009	6.40000000000000036
3410	Tomato, fresh, boiled, microwaved or steamed, drained	94	2.89999999999999991	1.19999999999999996	0.100000000000000006
3411	Tomato, fresh, boiled, microwaved or steamed, drained, added fat not further defined	304	2.79999999999999982	1.19999999999999996	5.90000000000000036
3412	Tomato, hydroponic, raw	60	2.29999999999999982	0.699999999999999956	0
3413	Tomato, paste, no added salt	298	11	3.10000000000000009	0.299999999999999989
3414	Tomato, paste, not further defined	284	10.0999999999999996	3.10000000000000009	0.299999999999999989
3415	Tomato, paste, with added salt	281	9.90000000000000036	3.10000000000000009	0.299999999999999989
3416	Tomato, puree, commercial	106	4.20000000000000018	1.5	0.100000000000000006
3417	Tomato, raw, not further defined	73	2.29999999999999982	0.900000000000000022	0.100000000000000006
3418	Tomato, roma, raw	74	2.29999999999999982	1	0.100000000000000006
3419	Tomato, stuffed with breadcrumbs, cheese & vegetables, cooked	535	2.79999999999999982	5.29999999999999982	8.19999999999999929
3420	Tomato, sundried or semi-sundried	1101	33.8999999999999986	11.1999999999999993	4.59999999999999964
3421	Tomato, whole, canned in tomato juice, boiled or microwaved, drained	93	3.39999999999999991	0.900000000000000022	0.100000000000000006
3422	Tomato, whole, canned in tomato juice, boiled or microwaved, undrained	94	3.29999999999999982	0.800000000000000044	0.200000000000000011
3423	Tomato, whole, canned in tomato juice, drained	88	3	0.800000000000000044	0.299999999999999989
3424	Tomato, whole, canned in tomato juice, undrained	78	2.89999999999999991	0.699999999999999956	0.100000000000000006
3425	Topping, caramel	770	43.1000000000000014	0.699999999999999956	0.299999999999999989
3426	Topping, chocolate	817	47.2000000000000028	0.699999999999999956	0.299999999999999989
3427	Topping, chocolate, hard	2605	38.6000000000000014	4	50.2999999999999972
3428	Topping, fruit-flavoured, regular	749	44.3999999999999986	0	0
3429	Trevally or kingfish, baked, roasted, grilled, BBQd, fried or deep fried, fat not further defined	759	0	27.8999999999999986	7.70000000000000018
3430	Trevally or kingfish, coated, baked, roasted, fried, deep fried, grilled or BBQd, fat not further defined	891	0.400000000000000022	22.3000000000000007	10.8000000000000007
3431	Trevally or kingfish, cooked, no fat added	628	0	28.8000000000000007	3.79999999999999982
3432	Trevally or kingfish, raw	459	0	21	2.79999999999999982
3433	Trout, coral, cooked, with or without added fat	513	0	24.6000000000000014	2.60000000000000009
3434	Trout, rainbow, baked, roasted, fried, grilled or BBQd, no added fat	883	0	26.8000000000000007	11.5999999999999996
3435	Trout, rainbow, baked, roasted, grilled, BBQd, fried or deep fried, fat not further defined	1006	0	26	15.1999999999999993
3436	Trout, rainbow, boiled, microwaved, steamed or poached, with or without added fat	785	0	23.1999999999999993	10.5999999999999996
3437	Trout, rainbow, coated, baked, roasted, fried, deep fried, grilled or BBQd, fat not further defined	1081	0.400000000000000022	20.8999999999999986	16.5
3438	Trout, rainbow, raw	645	0	19.6000000000000014	8.40000000000000036
3439	Tuna, baked, roasted, fried, grilled or BBQd, no added fat	596	0	32.1000000000000014	1.39999999999999991
3440	Tuna, baked, roasted, grilled, BBQd, fried or deep fried, fat not further defined	815	0	30.5	8
3441	Tuna, boiled, microwaved, steamed or poached, with or without added fat	537	0	27.6999999999999993	1.80000000000000004
3442	Tuna, canned, not further defined	651	0.699999999999999956	23	6.59999999999999964
3443	Tuna, flavoured, canned, drained	577	2.5	18	5.79999999999999982
3444	Tuna, raw	435	0	23.3999999999999986	1
3445	Tuna, sashimi style, raw	514	0	26.3000000000000007	1.80000000000000004
3446	Tuna, tartare (tartar)	847	0.299999999999999989	20	13.3000000000000007
3447	Tuna, unflavoured, canned in brine, drained	529	0	25.5	2.60000000000000009
3448	Tuna, unflavoured, canned in vegetable oil, drained	922	0	24.3999999999999986	13.6999999999999993
3449	Tuna, unflavoured, canned in water, drained	518	0	24.8000000000000007	2.60000000000000009
3450	Turkey, breast, lean, baked, roasted, fried, grilled or BBQd, fat not further defined	737	0	28.3000000000000007	6.90000000000000036
3451	Turkey, breast, lean, baked, roasted, fried, grilled or BBQd, no added fat	648	0	29.3999999999999986	4
3516	Veal, loin chop, separable fat, raw	1486	0	19.3000000000000007	31.3000000000000007
3452	Turkey, breast, lean, breadcrumb coating, baked, roasted, fried, grilled or BBQd, fat not further defined	973	0.800000000000000044	25.6000000000000014	7.70000000000000018
3453	Turkey, breast, lean, raw	490	0	21.6000000000000014	3.29999999999999982
3454	Turkey, breast, lean, skin & fat, baked, roasted, fried, grilled or BBQd, no added fat	825	0	20.3000000000000007	13
3455	Turkey, breast, lean, skin & fat, raw	663	0	20.3999999999999986	8.5
3456	Turkey, hindquarter, lean, baked, roasted, fried, grilled or BBQd, no added fat	714	0	26.8000000000000007	7
3457	Turkey, hindquarter, lean, raw	510	0	18.3999999999999986	5.29999999999999982
3458	Turkey, hindquarter, lean, skin & fat, baked, roasted, fried, grilled or BBQd, fat not further defined	1119	0	24.3000000000000007	19.1000000000000014
3459	Turkey, hindquarter, lean, skin & fat, baked, roasted, fried, grilled or BBQd, no added fat	911	0	25.6000000000000014	12.9000000000000004
3460	Turkey, hindquarter, lean, skin & fat, boiled, casseroled, microwaved, poached, steamed or stewed, with or without added fat	773	0	26.1000000000000014	8.90000000000000036
3461	Turkey, hindquarter, lean, skin & fat, raw	782	0	18.6000000000000014	12.5999999999999996
3462	Turkey, processed luncheon meat	428	0.599999999999999978	15.1999999999999993	3.89999999999999991
3463	Turkey, roast, deli-sliced	608	0	15.5	8.69999999999999929
3464	Turkey, whole, lean, baked, roasted, fried, grilled or BBQd, no added fat	666	0	26.6999999999999993	5.70000000000000018
3465	Turkey, whole, lean, boiled, casseroled, microwaved, poached, steamed or stewed, with or without added fat	759	0	28.3000000000000007	7.5
3466	Turkey, whole, lean, skin & fat, baked, roasted, fried, grilled or BBQd, no added fat	964	0	26	14.0999999999999996
3467	Turkey, wild caught, lean, skin & fat, cooked	964	0	26	14.0999999999999996
3468	Turkish delight, plain	1299	69.5999999999999943	2.70000000000000018	0.100000000000000006
3469	Turmeric, dried, ground	1380	25.1000000000000014	7.70000000000000018	8.59999999999999964
3470	Turnip, white, peeled, fresh or frozen, raw	94	3.20000000000000018	1.30000000000000004	0
3471	Turnip, white, peeled or unpeeled, fresh or frozen, baked, roasted, fried, stir-fried, grilled or BBQd, with or without added fat	115	3.89999999999999991	1.60000000000000009	0
3472	Turnip, white, peeled or unpeeled, fresh or frozen, boiled, microwaved or steamed, drained, with or without added fat	101	3.39999999999999991	1.39999999999999991	0
3473	Turtle, wild caught, flesh, cooked	696	0	33.8999999999999986	2.5
3474	Turtle, wild caught, flesh, raw	505	0	24.6000000000000014	1.80000000000000004
3475	Vanilla, artificial	231	14.4000000000000004	0	0
3476	Veal, all cuts, separable fat, cooked	1573	0	20.6999999999999993	33
3477	Veal, all cuts, separable fat, raw	1403	0	19.3999999999999986	29
3478	Veal, cutlet, fully-trimmed, baked, roasted, fried, grilled or BBQd, no added fat	595	0	27.8000000000000007	3.29999999999999982
3479	Veal, cutlet, fully-trimmed, breadcrumb coating, baked, roasted, fried, grilled or BBQd, fat not further defined	1022	0.5	24.5	9.90000000000000036
3480	Veal, cutlet, fully-trimmed, raw	494	0	24.3999999999999986	2.10000000000000009
3481	Veal, cutlet, semi-trimmed, baked, roasted, fried, grilled or BBQd, no added fat	625	0	27.6000000000000014	4.20000000000000018
3482	Veal, cutlet, semi-trimmed, raw	512	0	24.3000000000000007	2.70000000000000018
3483	Veal, cutlet, separable lean, fried, grilled or BBQd, no added fat	552	0	28.1000000000000014	2
3484	Veal, cutlet, separable lean, raw	459	0	24.6000000000000014	1.10000000000000009
3485	Veal, cutlet, untrimmed, baked, roasted, fried, grilled or BBQd, no added fat	632	0	27.5	4.40000000000000036
3486	Veal, cutlet, untrimmed, raw	523	0	24.1999999999999993	3
3487	Veal, diced, fully-trimmed, baked, roasted, fried, stir-fried, grilled or BBQd, fat not further defined	629	0	27.6000000000000014	4.29999999999999982
3488	Veal, diced, fully-trimmed, baked, roasted, fried, stir-fried, grilled or BBQd, no added fat	660	0	31.8000000000000007	3.20000000000000018
3489	Veal, diced, fully-trimmed, boiled, casseroled, microwaved, poached, steamed, or stewed, no added fat	565	0	28.8999999999999986	2
3490	Veal, diced, fully-trimmed, raw	452	0	23.1000000000000014	1.60000000000000009
3491	Veal, diced, separable lean, fried, stir-fried, grilled or BBQd, no added fat	653	0	31.8999999999999986	3
3492	Veal, diced, separable lean, raw	448	0	23.1000000000000014	1.5
3493	Veal, diced, untrimmed, baked, roasted, fried, stir-fried, grilled or BBQd, no added fat	679	0	31.6000000000000014	3.79999999999999982
3494	Veal, diced, untrimmed, raw	466	0	23	2
3495	Veal, heart, baked or roasted, no added fat	762	0	32	5.90000000000000036
3496	Veal, heart, raw	429	0	18.5	3.10000000000000009
3497	Veal, kidney, fried, grilled or BBQd, no added fat	702	0	26.6999999999999993	6.70000000000000018
3498	Veal, kidney, raw	448	0	17.3999999999999986	4.09999999999999964
3499	Veal, leg roast, fully-trimmed, baked or roasted, no added fat	665	0	34.2000000000000028	2.20000000000000018
3500	Veal, leg roast, fully-trimmed, raw	489	0	24.3000000000000007	2
3501	Veal, leg roast, separable lean, fried, grilled or BBQd, no added fat	655	0	34.3999999999999986	1.89999999999999991
3502	Veal, leg roast, separable lean, raw	470	0	24.3999999999999986	1.5
3503	Veal, leg steak, fully-trimmed, baked, roasted, fried, grilled or BBQd, fat not further defined	663	0	29.1000000000000014	4.59999999999999964
3504	Veal, leg steak, fully-trimmed, baked, roasted, fried, grilled or BBQd, no added fat	662	0	34.2999999999999972	2.10000000000000009
3505	Veal, leg steak, fully-trimmed, raw	481	0	24.3000000000000007	1.80000000000000004
3506	Veal, leg steak, separable lean, fried, grilled or BBQd, no added fat	655	0	34.3999999999999986	1.89999999999999991
3507	Veal, leg steak, separable lean, raw	470	0	24.3999999999999986	1.5
3508	Veal, leg steak, untrimmed, baked, roasted, fried, grilled or BBQd, no added fat	675	0	34.1000000000000014	2.60000000000000009
3509	Veal, leg steak, untrimmed, raw	482	0	24.3000000000000007	1.80000000000000004
3510	Veal, liver, fried, grilled or BBQd, no added fat	786	0	27	8.09999999999999964
3511	Veal, liver, raw	567	0	18.3999999999999986	5.5
3512	Veal, loin chop, fully-trimmed, baked, roasted, fried, grilled or BBQd, no added fat	652	0	29.3999999999999986	4.09999999999999964
3513	Veal, loin chop, fully-trimmed, raw	461	0	22.5	2.10000000000000009
3514	Veal, loin chop, semi-trimmed, raw	512	0	24.3000000000000007	2.70000000000000018
3515	Veal, loin chop, separable fat, fried, grilled or BBQd, no added fat	1685	0	20.1000000000000014	36.2999999999999972
3517	Veal, loin chop, separable lean, fried, grilled or BBQd, no added fat	606	0	29.8000000000000007	2.70000000000000018
3518	Veal, loin chop, separable lean, raw	440	0	22.6000000000000014	1.5
3519	Veal, loin chop, untrimmed, baked, roasted, fried, grilled or BBQd, no added fat	674	0	29.1999999999999993	4.79999999999999982
3520	Veal, loin chop, untrimmed, raw	555	0	22.1999999999999993	4.79999999999999982
3521	Veal, mince, untrimmed, raw	466	0	23	2
3522	Veal, schnitzel, breadcrumb coating, baked, roasted, fried, grilled or BBQd, canola oil	1041	0.5	24.1000000000000014	11.6999999999999993
3523	Veal, schnitzel, breadcrumb coating, baked, roasted, fried, grilled or BBQd, fat not further defined	1037	0.5	24.1000000000000014	11.5999999999999996
3524	Veal, schnitzel, breadcrumb coating, baked, roasted, fried, grilled or BBQd, no added fat	846	0.5	25.3999999999999986	5.5
3525	Veal, schnitzel, breadcrumb coating, baked, roasted, fried, grilled or BBQd, olive oil	1041	0.5	24.1000000000000014	11.6999999999999993
3526	Veal, schnitzel, breadcrumb coating, baked, roasted, fried, grilled or BBQd, other oil	1041	0.5	24.1000000000000014	11.6999999999999993
3527	Veal, schnitzel, breadcrumb coating, boiled, casseroled, microwaved, poached, steamed or stewed, no added fat	846	0.5	25.3999999999999986	5.5
3528	Veal, schnitzel, breadcrumb coating, cooked with tomato sauce & cheese (veal parmigiana)	908	2.29999999999999982	18.6999999999999993	11
3529	Veal, stir-fry strips, fully-trimmed, baked, roasted, fried, stir-fried, grilled or BBQd, no added fat	620	0	29.8999999999999986	3
3530	Veal, stir-fry strips, fully-trimmed, raw	547	0	27.1000000000000014	2.29999999999999982
3531	Veal, stir-fry strips, separable lean, fried, stir-fried, grilled or BBQd, no added fat	614	0	30	2.79999999999999982
3532	Veal, stir-fry strips, separable lean, raw	536	0	27.1999999999999993	2
3533	Veal, stir-fry strips, untrimmed, baked, roasted, fried, stir-fried, grilled or BBQd, no added fat	623	0	29.8999999999999986	3.10000000000000009
3534	Veal, stir-fry strips, untrimmed, raw	551	0	27.1000000000000014	2.5
3535	Venison, diced, lean, baked, roasted, fried, stir-fried, grilled or BBQd, no added fat	539	0	28	1.69999999999999996
3536	Venison, diced, lean, raw	415	0	22	1.10000000000000009
3537	Venison, leg medallion, lean, baked, roasted, fried, stir-fried, grilled or BBQd, fat not further defined	634	0	28.1000000000000014	4.20000000000000018
3538	Venison, leg medallion, lean, baked, roasted, fried, stir-fried, grilled or BBQd, no added fat	549	0	28.6999999999999993	1.60000000000000009
3539	Venison, leg medallion, lean, raw	457	0	23.5	1.5
3540	Venison, mince, premium, baked, roasted, fried, stir-fried, grilled or BBQd, no added fat	644	0	29.8000000000000007	3.70000000000000018
3541	Venison, mince, premium, raw	465	0	21	2.89999999999999991
3542	Venison, stir fry strips, lean, baked, roasted, fried, stir-fried, grilled or BBQd, no added fat	654	0	35.2000000000000028	1.5
3543	Venison, stir fry strips, lean, raw	439	0	23.6000000000000014	1
3544	Vinegar, balsamic	329	15	0.5	0
3545	Vinegar (except balsamic vinegar)	65	0	0.100000000000000006	0
3546	Vine leaf, grape, canned	243	0.200000000000000011	4.29999999999999982	2
3547	Vine leaf, stuffed with rice & meat, homemade from basic ingredients	606	0.599999999999999978	8.09999999999999964	10.0999999999999996
3548	Vine leaf, stuffed with rice & tomato, commercial	688	0.800000000000000044	2.39999999999999991	8.19999999999999929
3549	Vine leaf, stuffed with rice & tomato, homemade from basic ingredients	728	0.800000000000000044	2.29999999999999982	9.5
3550	Vitamin C	0	0	0	0
3551	Vitamin E	0	0	0	0
3552	Vodka	886	0.100000000000000006	0	0
3553	Wasabi, root, raw	427	8	4.79999999999999982	0.599999999999999978
3554	Water, bore	0	0	0	0
3555	Water, bottled, carbonated or soda water	0	0	0	0
3556	Water, bottled, still	0	0	0	0
3557	Water, bottled, with added sugar, vitamins & minerals	70	4.40000000000000036	0	0
3558	Water chestnut, peeled, canned, drained	219	5.09999999999999964	0.599999999999999978	0.900000000000000022
3559	Watercress, boiled, microwaved or steamed, drained	130	0.800000000000000044	3.39999999999999991	0.5
3560	Watercress, boiled, microwaved or steamed, drained, added fat not further defined	320	0.800000000000000044	3.29999999999999982	5.79999999999999982
3561	Watercress, raw	110	0.699999999999999956	2.89999999999999991	0.400000000000000022
3562	Water, filtered	0	0	0	0
3563	Water, ice	0	0	0	0
3564	Water, rainwater or tank water	0	0	0	0
3565	Water, tap	0	0	0	0
3566	Wattle seed (acacia), ground	1183	0	20.3000000000000007	6.09999999999999964
3567	Wax jambu, raw	109	4.5	0.699999999999999956	0.200000000000000011
3568	Wheat bran, unprocessed, uncooked	1119	2.70000000000000018	14.8000000000000007	4.09999999999999964
3569	Wheat germ	1297	7.5	22.6000000000000014	7.09999999999999964
3570	Whisky or scotch	892	0	0	0
3571	Whitebait, floured, fried, not further defined	1818	0.100000000000000006	21	38
3572	Whiting, baked, roasted, fried, grilled or BBQd, no added fat	517	0	28.1999999999999993	1
3573	Whiting, baked, roasted, grilled, BBQd, fried or deep fried, fat not further defined	751	0	26.8000000000000007	8
3574	Whiting, boiled, microwaved, steamed or poached, with or without added fat	437	0	23.3000000000000007	1.10000000000000009
3575	Whiting, coated, baked, roasted, fried, deep fried, grilled, or BBQd, fat not further defined	795	0.400000000000000022	21	8.80000000000000071
3576	Whiting, coated, packaged frozen, baked, roasted, fried, grilled, or BBQd, with or without added fat	735	0.400000000000000022	22.3999999999999986	6.09999999999999964
3577	Whiting, coated, takeaway outlet, deep fried	1042	0.200000000000000011	16	16.3000000000000007
3578	Whiting, raw	362	0	19.8000000000000007	0.699999999999999956
3579	Wine cooler, wine & fruit juice blend, all flavours	214	7.59999999999999964	0.100000000000000006	0
3580	Wine, not further defined	310	0.400000000000000022	0.200000000000000011	0
3581	Wine, red	324	0	0.200000000000000011	0
3582	Wine, red, cooked	98	0	0.200000000000000011	0
3583	Wine, red, reduced alcohol	195	0	0.200000000000000011	0
3584	Wine, red, sparkling	338	2	0.200000000000000011	0
3585	Wine, rose	331	3.60000000000000009	0.200000000000000011	0
3586	Wine, white, cooked	108	1.19999999999999996	0.200000000000000011	0
3587	Wine, white, dry style (sugars content < 1%)	298	0.299999999999999989	0.200000000000000011	0
3588	Wine, white, medium dry style (~ 1% sugars)	309	1.10000000000000009	0.200000000000000011	0
3589	Wine, white, medium sweet style (~ 2.5% sugars)	268	2.60000000000000009	0.200000000000000011	0
3590	Wine, white, not further defined	296	0.599999999999999978	0.200000000000000011	0
3591	Wine, white, reduced alcohol	173	1.10000000000000009	0.200000000000000011	0
3592	Wine, white, sparkling	292	1	0.200000000000000011	0
3593	Wine, white, sparkling, de-alcoholised	31	1	0.200000000000000011	0
3594	Wine, white, sweet dessert style	402	10	0.200000000000000011	0
3595	Yabby (yabbie), flesh, cooked, no added fat	407	0	22	0.900000000000000022
3596	Yam, wild harvested, cooked	453	1.19999999999999996	3.20000000000000018	0.299999999999999989
3597	Yeast, bakers, compressed	454	0	13.5999999999999996	2
3598	Yeast, dry powder	1068	0	36.3999999999999986	5
3599	Yoghurt, apple & cinnamon flavoured, regular fat (~3%), added cereals	482	14.9000000000000004	4.5	3.39999999999999991
3600	Yoghurt, apricot, peach or nectarine pieces or flavoured, low fat (<0.5%)	310	12.5	5	0.100000000000000006
3601	Yoghurt, apricot, peach or nectarine pieces or flavoured, low fat (<0.5%), intense sweetened	165	4.20000000000000018	4.09999999999999964	0.200000000000000011
3602	Yoghurt, apricot, peach or nectarine pieces or flavoured, reduced fat (1%)	355	13.4000000000000004	5	1
3603	Yoghurt, apricot, peach or nectarine pieces or flavoured, regular fat (~3%)	386	11.0999999999999996	4.20000000000000018	3.20000000000000018
3604	Yoghurt, banana & honey flavoured, low fat (<0.5%), intense sweetened	194	5.40000000000000036	4	0.100000000000000006
3605	Yoghurt, banana & honey flavoured, regular fat (~3%), added cereals	439	12.6999999999999993	4.5	3.10000000000000009
3606	Yoghurt, banana pieces or flavoured, regular fat (~3%)	386	11.5999999999999996	4.5	2.79999999999999982
3607	Yoghurt, banana pieces or flavoured, regular fat (~3%), added omega-3 polyunsaturates	383	11	4.79999999999999982	2.79999999999999982
3608	Yoghurt, berry flavoured, regular fat (~3%), added cereals	486	13.9000000000000004	4.70000000000000018	3.5
3609	Yoghurt, berry pieces or flavoured, low fat (<0.5%)	328	12.0999999999999996	5.20000000000000018	0.299999999999999989
3610	Yoghurt, berry pieces or flavoured, low fat (<0.5%), intense sweetened	160	4	4.09999999999999964	0.200000000000000011
3611	Yoghurt, berry pieces or flavoured, low fat (<0.5%), intense sweetened, added fibre	180	4	4.09999999999999964	0.200000000000000011
3612	Yoghurt, berry pieces or flavoured, reduced fat (1%)	368	14.5999999999999996	4.79999999999999982	0.900000000000000022
3613	Yoghurt, berry pieces or flavoured, reduced fat (1%), added fibre	380	14.5999999999999996	4.79999999999999982	0.900000000000000022
3614	Yoghurt, berry pieces or flavoured, reduced fat (2%), added vitamins A, C, E, & omega-3 polyunsaturates	364	11.0999999999999996	5.40000000000000036	2
3615	Yoghurt, berry pieces or flavoured, regular fat (~3%)	401	11.5999999999999996	4.70000000000000018	3.10000000000000009
3616	Yoghurt, berry pieces or flavoured, regular fat (~3%), added omega-3 polyunsaturates	363	9.90000000000000036	4.79999999999999982	2.79999999999999982
3617	Yoghurt, berry pieces or flavoured, with added fruit juice, reduced fat (~2%)	451	17.1999999999999993	3.39999999999999991	1.80000000000000004
3618	Yoghurt, dessert flavoured, low fat (<0.5%), intense sweetened	193	4.79999999999999982	3.89999999999999991	0.100000000000000006
3619	Yoghurt, dessert flavoured, low fat (<0.5%), intense sweetened, added fibre	272	7	5.40000000000000036	0.100000000000000006
3620	Yoghurt, dessert flavoured, reduced fat (~1%)	417	16.1999999999999993	4.90000000000000036	1.39999999999999991
3621	Yoghurt, drinking style, fruit flavoured, reduced fat (1%)	286	11.3000000000000007	3.60000000000000009	0.599999999999999978
3622	Yoghurt, drinking style, vanilla flavoured, reduced fat (1%)	298	12.0999999999999996	3.5	0.599999999999999978
3623	Yoghurt, flavoured, reduced fat (~1.5%), homemade from basic ingredients	391	13.6999999999999993	5.5	1.5
3624	Yoghurt, flavoured, regular fat (~4%), homemade from basic ingredients	451	13.6999999999999993	4.5	3.60000000000000009
3625	Yoghurt, frozen, berry flavoured, regular fat	523	22.1000000000000014	3.5	2.89999999999999991
3626	Yoghurt, frozen, tropical or fruit salad flavoured, regular fat	563	20.6000000000000014	3.60000000000000009	3
3627	Yoghurt, fruit pieces or flavoured, reduced fat (~2%), added Ca & vitamin D	366	12	3.29999999999999982	1.80000000000000004
3628	Yoghurt, fruit pieces, reduced fat (2%), added vitamins A, B1, B2, B3, B6, B12, C, D, E, & folate	415	10.6999999999999993	5.29999999999999982	2
3629	Yoghurt, Greek style (~10%), natural	589	6.90000000000000036	4.90000000000000036	10.0999999999999996
3630	Yoghurt, Greek style (~8%), natural	500	5.79999999999999982	5.09999999999999964	8
3631	Yoghurt, Greek style, reduced fat (~2%), natural	376	8.30000000000000071	7.5	2.10000000000000009
3632	Yoghurt, Greek style, regular fat (~5%), natural	441	9	5.70000000000000018	4.79999999999999982
3633	Yoghurt, honey flavoured, high fat (~5%)	502	12.4000000000000004	4.59999999999999964	4.59999999999999964
3634	Yoghurt, honey flavoured, reduced fat (~1%)	414	15.4000000000000004	5	0.900000000000000022
3635	Yoghurt, honey flavoured, reduced fat (~2%)	406	8.80000000000000071	5.20000000000000018	1.69999999999999996
3636	Yoghurt, mango pieces or flavoured, low fat (<0.5%), intense sweetened	174	4.90000000000000036	4	0.100000000000000006
3637	Yoghurt, mango pieces or flavoured, reduced fat (1%)	381	15.1999999999999993	4.90000000000000036	1
3638	Yoghurt, mango pieces or flavoured, regular fat (~3%)	430	13.5999999999999996	4.09999999999999964	3.29999999999999982
3639	Yoghurt, natural, low fat (<0.5%)	241	5.90000000000000036	6.59999999999999964	0.299999999999999989
3640	Yoghurt, natural, not further defined	309	5.29999999999999982	5.59999999999999964	2.89999999999999991
3641	Yoghurt, natural or Greek, high fat (~6%), added berry pieces	520	12.5999999999999996	4.70000000000000018	5.79999999999999982
3642	Yoghurt, natural or Greek, high fat (~6%), added mango &/or passionfruit pieces	517	11.9000000000000004	4.90000000000000036	5.79999999999999982
3643	Yoghurt, natural or Greek, high fat (~8%), added honey or sugar	549	10.4000000000000004	4.79999999999999982	7.59999999999999964
3644	Yoghurt, natural or Greek, regular fat (~3.5%), added honey	439	13.3000000000000007	4.79999999999999982	3.39999999999999991
3645	Yoghurt, natural or Greek, regular fat (~4%), added berry pieces	486	14.5999999999999996	4.79999999999999982	4
3646	Yoghurt, natural or Greek, regular fat (~4%), added mango &/or passionfruit pieces	540	17.8999999999999986	4.5	4
3647	Yoghurt, natural, reduced fat (~1.5%)	309	8.59999999999999964	5.5	1.5
3648	Yoghurt, natural, reduced fat (~1.5%), homemade from basic ingredients	309	8.59999999999999964	5.5	1.5
3649	Yoghurt, natural, regular fat (~4%)	324	4.20000000000000018	5.29999999999999982	3.89999999999999991
3650	Yoghurt, natural, regular fat (~4%), homemade from basic ingredients	353	4.79999999999999982	5.70000000000000018	4.20000000000000018
3651	Yoghurt, not further defined	370	9.80000000000000071	4.90000000000000036	2.89999999999999991
3652	Yoghurt, passionfruit flavoured, low fat (<0.5%), intense sweetened	171	4.59999999999999964	4.09999999999999964	0.100000000000000006
3653	Yoghurt, passionfruit flavoured, reduced fat (1%)	371	14.4000000000000004	4.90000000000000036	1
3654	Yoghurt, passionfruit flavoured, reduced fat (1%), added fibre	352	12.5	5.09999999999999964	0.900000000000000022
3655	Yoghurt, passionfruit flavoured, reduced fat (1%), reduced sugar	224	5.29999999999999982	4.79999999999999982	1
3656	Yoghurt, passionfruit flavoured, regular fat (~3%)	402	11.4000000000000004	4.29999999999999982	3.39999999999999991
3657	Yoghurt, peach, mango & passionfruit pieces or flavoured, high fat (~6%)	495	10.5999999999999996	5.20000000000000018	5.79999999999999982
3658	Yoghurt, peach & mango pieces or flavoured, low fat (<0.5%), intense sweetened	174	4.79999999999999982	4.09999999999999964	0.100000000000000006
3659	Yoghurt, peach & mango pieces or flavoured, reduced fat (1%)	368	14.3000000000000007	4.90000000000000036	1
3660	Yoghurt, peach & mango pieces or flavoured, reduced fat (1%), added fibre	368	13.5999999999999996	5.09999999999999964	0.800000000000000044
3661	Yoghurt, peach & mango pieces or flavoured, reduced fat (2%)	414	15.4000000000000004	5.20000000000000018	1.60000000000000009
3662	Yoghurt, peach & mango pieces or flavoured, regular fat (~3%)	406	12	4.20000000000000018	3.29999999999999982
3663	Yoghurt, soy based, apricot or mango flavoured, reduced fat (approx. 1%)	321	10	3.29999999999999982	0.599999999999999978
3664	Yoghurt, soy based, berry flavoured, reduced fat (1%)	337	11.0999999999999996	3.20000000000000018	0.599999999999999978
3665	Yoghurt, soy based, berry flavoured, regular fat (approx. 3%)	416	8.40000000000000036	3.70000000000000018	3.70000000000000018
3666	Yoghurt, soy based, vanilla flavoured, reduced fat (approx. 1%)	309	8.40000000000000036	3.70000000000000018	0.800000000000000044
3667	Yoghurt, tropical fruit or fruit salad pieces or flavoured, low fat (<0.5%), intense sweetened	170	4.5	4.09999999999999964	0.100000000000000006
3668	Yoghurt, tropical fruit or fruit salad pieces or flavoured, low fat (<0.5%), intense sweetened, added fibre	261	7.29999999999999982	5.5	0.100000000000000006
3669	Yoghurt, tropical fruit or fruit salad pieces or flavoured, reduced fat (1%)	368	14.1999999999999993	4.90000000000000036	1
3670	Yoghurt, tropical fruit or fruit salad pieces or flavoured, regular fat (~3%)	401	11.9000000000000004	4.29999999999999982	3.20000000000000018
3671	Yoghurt, tropical fruit or fruit salad pieces or flavoured, regular fat (~3%), added omega-3 polyunsaturates	381	11.3000000000000007	4.70000000000000018	2.70000000000000018
3672	Yoghurt, tropical fruit or fruit salad pieces or flavoured, with added fruit juice, reduced fat (~2%)	447	17	3.39999999999999991	1.80000000000000004
3673	Yoghurt, vanilla flavoured, low fat (<0.5%)	367	12.6999999999999993	5.79999999999999982	0.5
3674	Yoghurt, vanilla flavoured, low fat (<0.5%), intense sweetened	186	4.29999999999999982	3.89999999999999991	0.100000000000000006
3675	Yoghurt, vanilla flavoured, low fat (<0.5%), with added protein & fibre, intense sweetened	309	6.79999999999999982	5.40000000000000036	0.100000000000000006
3676	Yoghurt, vanilla flavoured, reduced fat (~1%)	363	14	4.90000000000000036	0.900000000000000022
3677	Yoghurt, vanilla flavoured, reduced fat (~1%), added fibre	370	13.8000000000000007	5	0.800000000000000044
3678	Yoghurt, vanilla flavoured, reduced fat (~1%), intense sweetened	262	6.5	4.90000000000000036	0.900000000000000022
3679	Yoghurt, vanilla flavoured, reduced fat (2%), added berry pieces	489	19.3999999999999986	4.40000000000000036	1.5
3680	Yoghurt, vanilla flavoured, regular fat (~3%)	388	9.80000000000000071	4.90000000000000036	3.39999999999999991
3681	Yoghurt, vanilla flavoured, regular fat (~3%), added omega-3 polyunsaturates	379	11	4.79999999999999982	2.70000000000000018
3682	Zucchini, golden, fresh or frozen, peeled or unpeeled, boiled, microwaved or steamed, drained	93	1.30000000000000004	2.60000000000000009	0.400000000000000022
3683	Zucchini, golden, fresh or frozen, peeled or unpeeled, raw	78	1.10000000000000009	2.20000000000000018	0.299999999999999989
3684	Zucchini, green skin, fresh or frozen, peeled or unpeeled, baked, roasted, fried, stir-fried, grilled or BBQd, canola oil	352	2.29999999999999982	1.19999999999999996	7.59999999999999964
3685	Zucchini, green skin, fresh or frozen, peeled or unpeeled, baked, roasted, fried, stir-fried, grilled or BBQd, fat not further defined	347	2.29999999999999982	1.19999999999999996	7.40000000000000036
3686	Zucchini, green skin, fresh or frozen, peeled or unpeeled, baked, roasted, fried, stir-fried, grilled or BBQd, no added fat	92	2.39999999999999991	1.30000000000000004	0.400000000000000022
3687	Zucchini, green skin, fresh or frozen, peeled or unpeeled, baked, roasted, fried, stir-fried, grilled or BBQd, olive oil	352	2.29999999999999982	1.19999999999999996	7.59999999999999964
3688	Zucchini, green skin, fresh or frozen, peeled or unpeeled, boiled, microwaved or steamed, drained	77	2	1.10000000000000009	0.400000000000000022
3689	Zucchini, green skin, fresh or frozen, peeled or unpeeled, boiled, microwaved or steamed, drained, added fat not further defined	293	1.89999999999999991	1	6.29999999999999982
3690	Zucchini, green skin, fresh or frozen, peeled or unpeeled, raw	65	1.69999999999999996	0.900000000000000022	0.299999999999999989
3691	Zucchini, green skin, fresh or frozen, peeled or unpeeled, stir-fried, butter, dairy blend or margarine	299	2.29999999999999982	1.30000000000000004	6.09999999999999964
3692	Zucchini slice, with bacon	820	1.60000000000000009	9.09999999999999964	13.3000000000000007
3693	Zucchini slice, without bacon	729	1.89999999999999991	7.70000000000000018	11.4000000000000004
\.


--
-- Name: ingredients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dave
--

SELECT pg_catalog.setval('ingredients_id_seq', 3693, true);


--
-- Data for Name: mealplan; Type: TABLE DATA; Schema: public; Owner: dave
--

COPY mealplan (userid, recipeid, mealcode, dateadded) FROM stdin;
10	10	2	2016-10-19
10	5	3	2016-10-20
10	14	2	2016-10-20
10	10	1	2016-10-20
10	14	2	2016-10-22
10	1	1	2016-10-22
10	13	3	2016-10-22
11	1	1	2016-10-22
11	13	2	2016-10-22
11	10	3	2016-10-22
11	5	3	2016-10-22
\.


--
-- Data for Name: ratings; Type: TABLE DATA; Schema: public; Owner: dave
--

COPY ratings (id, userid, recipe, rating) FROM stdin;
108	9	1	1
109	9	2	2
110	9	3	5
111	9	4	5
112	9	5	5
113	9	6	4
114	9	7	5
115	9	8	1
116	9	9	5
117	10	1	1
118	10	2	2
119	10	6	5
120	10	7	5
121	10	8	1
122	10	9	5
123	11	2	3
124	11	3	5
125	11	4	4
126	11	5	3
127	11	6	4
128	11	7	5
129	11	8	4
130	11	9	5
131	12	1	5
132	12	2	5
133	12	3	5
134	12	4	0
135	12	5	2
136	12	6	3
137	12	7	1
138	12	8	4
139	12	9	1
\.


--
-- Name: ratings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dave
--

SELECT pg_catalog.setval('ratings_id_seq', 139, true);


--
-- Data for Name: recipes; Type: TABLE DATA; Schema: public; Owner: dave
--

COPY recipes (id, name, author, instruction_file) FROM stdin;
8	Beef and Tomato Casserole with Herb Dumplings	\N	instrfiles/8.instr
13	Sticky Chilli Chicken with Brown Rice	\N	instrfiles/13.instr
14	Chicken Saltimbocca	\N	instrfiles/14.instr
5	Choc-Berry Roulade	\N	instrfiles/5.instr
15	Thai Chicken and Asparagus Curry	\N	instrfiles/15.instr
1	Shake	10	
3	Crispy Squid Salad	\N	instrfiles/3.instr
11	Fried Fish and Chips	\N	instrfiles/11.instr
2	Green Smoothie Bowl	\N	instrfiles/2.instr
7	Vietnamese Beef Noodle Soup	\N	instrfiles/7.instr
9	Barbequed Seafood with Truffled Mash	\N	instrfiles/9.instr
10	Coronotation Chicken with Mango Rice Salad	\N	instrfiles/10.instr
6	Rum and Maple Steak with Fries	\N	instrfiles/6.instr
12	Mediterranean Fish With Olives and Tomatoes	\N	instrfiles/12.instr
4	Cheese Frittatta	\N	instrfiles/4.instr
16	Satay Chicken Sticks	\N	instrfiles/16.instr
\.


--
-- Name: recipes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dave
--

SELECT pg_catalog.setval('recipes_id_seq', 1, true);


--
-- Data for Name: userattr; Type: TABLE DATA; Schema: public; Owner: dave
--

COPY userattr (id, sex, height, weight, age, exercise, userid) FROM stdin;
3	M	180	80	22	2	9
4	M	185	80	23	2	10
5	M	185	80	22	2	11
6	M	180	90	23	3	12
7	M	180	90	23	3	13
\.


--
-- Name: userattr_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dave
--

SELECT pg_catalog.setval('userattr_id_seq', 7, true);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: dave
--

COPY users (id, name, pwrd, email, attrid) FROM stdin;
9	fraz	d2105a520cac3cf8004af7dfeec669151f7970e4ea04571a0bbbfe9dcbdd46ed9cdd0ca4b3ebb7e364010c6f984946f029642b49f6308caed4d87d3a698b0565	haha@lol.com	\N
10	fraz	d2105a520cac3cf8004af7dfeec669151f7970e4ea04571a0bbbfe9dcbdd46ed9cdd0ca4b3ebb7e364010c6f984946f029642b49f6308caed4d87d3a698b0565	ethics@fuckwobcke.com	\N
11	Fraz	d2105a520cac3cf8004af7dfeec669151f7970e4ea04571a0bbbfe9dcbdd46ed9cdd0ca4b3ebb7e364010c6f984946f029642b49f6308caed4d87d3a698b0565	ethics@kant.com	\N
12	Dave	67aaf3b7dcfb32df090628542d1808813b94b9cd301637098f0b68619433c2e131d0636d86a62c69b0bdd43b13502ad8f3e61797ec3eb5171276dcc7a407b4bd	hello@world.com	\N
13	DaveJr	67aaf3b7dcfb32df090628542d1808813b94b9cd301637098f0b68619433c2e131d0636d86a62c69b0bdd43b13502ad8f3e61797ec3eb5171276dcc7a407b4bd	foo@bar.com	\N
\.


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dave
--

SELECT pg_catalog.setval('users_id_seq', 13, true);


--
-- Name: contains contains_pkey; Type: CONSTRAINT; Schema: public; Owner: dave
--

ALTER TABLE ONLY contains
    ADD CONSTRAINT contains_pkey PRIMARY KEY (id);


--
-- Name: ingredients ingredients_pkey; Type: CONSTRAINT; Schema: public; Owner: dave
--

ALTER TABLE ONLY ingredients
    ADD CONSTRAINT ingredients_pkey PRIMARY KEY (id);


--
-- Name: ratings ratings_pkey; Type: CONSTRAINT; Schema: public; Owner: dave
--

ALTER TABLE ONLY ratings
    ADD CONSTRAINT ratings_pkey PRIMARY KEY (id);


--
-- Name: ratings ratings_userid_recipe_key; Type: CONSTRAINT; Schema: public; Owner: dave
--

ALTER TABLE ONLY ratings
    ADD CONSTRAINT ratings_userid_recipe_key UNIQUE (userid, recipe);


--
-- Name: recipes recipes_pkey; Type: CONSTRAINT; Schema: public; Owner: dave
--

ALTER TABLE ONLY recipes
    ADD CONSTRAINT recipes_pkey PRIMARY KEY (id);


--
-- Name: userattr userattr_pkey; Type: CONSTRAINT; Schema: public; Owner: dave
--

ALTER TABLE ONLY userattr
    ADD CONSTRAINT userattr_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: dave
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users user_valid_attr; Type: FK CONSTRAINT; Schema: public; Owner: dave
--

ALTER TABLE ONLY users
    ADD CONSTRAINT user_valid_attr FOREIGN KEY (attrid) REFERENCES userattr(id);


--
-- Name: contains valid_recipe; Type: FK CONSTRAINT; Schema: public; Owner: dave
--

ALTER TABLE ONLY contains
    ADD CONSTRAINT valid_recipe FOREIGN KEY (recipe) REFERENCES recipes(id);


--
-- Name: recipes valid_user; Type: FK CONSTRAINT; Schema: public; Owner: dave
--

ALTER TABLE ONLY recipes
    ADD CONSTRAINT valid_user FOREIGN KEY (author) REFERENCES users(id);


--
-- Name: userattr valid_userid; Type: FK CONSTRAINT; Schema: public; Owner: dave
--

ALTER TABLE ONLY userattr
    ADD CONSTRAINT valid_userid FOREIGN KEY (userid) REFERENCES users(id);


--
-- PostgreSQL database dump complete
--

