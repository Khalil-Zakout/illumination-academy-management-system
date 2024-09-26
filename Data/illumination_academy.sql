--
-- PostgreSQL database dump
--

-- Dumped from database version 14.9
-- Dumped by pg_dump version 15rc2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: courses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.courses (
    course_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    course_name character varying(20) NOT NULL,
    description text NOT NULL,
    duration smallint NOT NULL,
    skills character varying(30)[] NOT NULL,
    instructor_id uuid
);


ALTER TABLE public.courses OWNER TO postgres;

--
-- Name: instructors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.instructors (
    instructor_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    first_name character varying(20) NOT NULL,
    last_name character varying(20) NOT NULL,
    birthday date NOT NULL,
    hourly_pay smallint NOT NULL
);


ALTER TABLE public.instructors OWNER TO postgres;

--
-- Name: student_course; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.student_course (
    course_id uuid NOT NULL,
    std_id uuid NOT NULL,
    enrollment_date date DEFAULT CURRENT_DATE NOT NULL
);


ALTER TABLE public.student_course OWNER TO postgres;

--
-- Name: students; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.students (
    std_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    first_name character varying(20) NOT NULL,
    last_name character varying(20) NOT NULL,
    phone_number character varying(20) NOT NULL,
    email character varying(50) NOT NULL,
    major character varying(40) NOT NULL,
    birthday date NOT NULL
);


ALTER TABLE public.students OWNER TO postgres;

--
-- Data for Name: courses; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.courses (course_id, course_name, description, duration, skills, instructor_id) VALUES
	('2426b496-efee-4741-8033-2db8d222ff33', 'Networks', 'Crash course on networks basics and the OSI model', 12, '{OSI,LAN,IP,Protocols,Routing}', '0fb74a55-63a4-4244-b2e7-fb95140f409a'),
	('fa7ef0b2-ce07-4543-8f22-c9d736a96303', 'Python programming', 'Entry level course for beginners who want to learn python from scratch', 22, '{Python,Programming,Functions,"Data Types"}', '3e33c2e3-871f-430a-8381-03897d022fc3'),
	('51722081-a9a3-47a2-a101-3a6602b52719', 'Ai', 'A crash course about the basics of AI and how to learn it and the most comman uses for AI', 8, '{AI,Python,"Machine learning",data,"data science"}', '02780f1b-96f9-402b-a858-6df294c68592'),
	('a6a23470-bfb3-4d4f-9125-10592f6edb84', 'Cyber sequrity', 'Crash Course about the field and most famous cyber attacks', 7, '{"Cyber Attacks","Social Engineering",Programming,Encryption}', '5528dab1-fd59-4387-be5d-a3a381c27220'),
	('ea27e90f-66e7-404e-984d-cc91f1f3b6dc', 'Web development', 'Crash course of the web development industry and its technologies', 14, '{Web,HTTP,HTML,CSS,"Java Script",Design}', '5528dab1-fd59-4387-be5d-a3a381c27220'),
	('e192363c-365c-4873-9b46-4e575cccda2b', 'Ui/ux', 'Crash course about the user interface design and user experience', 8, '{UI,UX,Design,Programming}', '03153bfc-e1a2-480f-9092-b6fdde16f4f5'),
	('96c07a62-ef18-4b75-87f8-9fa9ea85cf0e', 'Java', 'introduction to Java programming from basics to OOP', 18, '{Java,Programming,OOP,Functions,GUI}', '108ee8c9-c69b-4d4f-a9e0-c51f07087f1d'),
	('b0f9bb29-984b-4e56-834a-49545e19e5b9', 'Database', 'Database crash course for beginners using PostgreSQL', 16, '{SQL,Database,PostgreSQL,DBMS}', 'ed3599ad-5563-4880-8f46-510634424ee7'),
	('6ca84b0a-1c61-47ab-9698-2c5d6b8a0fdc', 'Advanced databases', 'a deep dive into databases and connection with programming languages', 22, '{DatabaseAdvanced,Sequrity,Networks}', '3759ce89-6ec8-4493-9bce-84cc52436ffd');


--
-- Data for Name: instructors; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.instructors (instructor_id, first_name, last_name, birthday, hourly_pay) VALUES
	('02780f1b-96f9-402b-a858-6df294c68592', 'Khalil', 'Zakout', '2003-06-15', 20),
	('5528dab1-fd59-4387-be5d-a3a381c27220', 'Mohammed', 'Shurrab', '2004-10-01', 25),
	('0fb74a55-63a4-4244-b2e7-fb95140f409a', 'Ahmed', 'Meqdad', '2003-09-21', 30),
	('b6815dbe-6d8c-41f2-b178-6b1cbe82f029', 'Anas', 'Lubbad', '2005-03-11', 15),
	('08a95dc1-2f9f-4642-bce2-043c2fac5800', 'Sufyan', 'Serdah', '2003-06-21', 35),
	('474754de-2e18-46da-8d03-ebe2d15ae6f6', 'Hesham', 'Awad', '2003-06-21', 22),
	('3e33c2e3-871f-430a-8381-03897d022fc3', 'Waseem', 'Abo safia', '2004-09-04', 18),
	('03153bfc-e1a2-480f-9092-b6fdde16f4f5', 'Mohammed', 'Qedwa', '2003-09-22', 16),
	('108ee8c9-c69b-4d4f-a9e0-c51f07087f1d', 'Mohammed', 'Safi', '1999-01-25', 20),
	('efad900d-c4d7-4d0b-85ef-bc9914348ed2', 'Alii', 'Alii', '2000-02-02', 12),
	('5f2778cd-8f57-4825-b2da-1f86d3dfc1ba', 'Alii', 'Alii', '2003-03-03', 14),
	('ed3599ad-5563-4880-8f46-510634424ee7', 'Fadi', 'Ahmed', '2001-04-21', 28),
	('3759ce89-6ec8-4493-9bce-84cc52436ffd', 'Mohmmed', 'Rabee', '2000-11-15', 15);


--
-- Data for Name: student_course; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.student_course (course_id, std_id, enrollment_date) VALUES
	('51722081-a9a3-47a2-a101-3a6602b52719', '461954b7-d7d4-4e34-a20c-a9a9d2c1dd1e', '2024-08-20'),
	('a6a23470-bfb3-4d4f-9125-10592f6edb84', '461954b7-d7d4-4e34-a20c-a9a9d2c1dd1e', '2024-08-20'),
	('ea27e90f-66e7-404e-984d-cc91f1f3b6dc', '461954b7-d7d4-4e34-a20c-a9a9d2c1dd1e', '2024-08-20'),
	('ea27e90f-66e7-404e-984d-cc91f1f3b6dc', 'c197521d-a264-4d63-9d1d-196353106f4a', '2024-08-20'),
	('2426b496-efee-4741-8033-2db8d222ff33', 'c197521d-a264-4d63-9d1d-196353106f4a', '2024-08-20'),
	('51722081-a9a3-47a2-a101-3a6602b52719', 'b2363650-30d5-462e-ad48-5b8bb536e643', '2024-08-22'),
	('ea27e90f-66e7-404e-984d-cc91f1f3b6dc', 'b2363650-30d5-462e-ad48-5b8bb536e643', '2024-08-22'),
	('2426b496-efee-4741-8033-2db8d222ff33', 'b2363650-30d5-462e-ad48-5b8bb536e643', '2024-08-27'),
	('a6a23470-bfb3-4d4f-9125-10592f6edb84', '91bb185c-b1a2-434d-b08e-ac62371e83d5', '2024-08-27'),
	('a6a23470-bfb3-4d4f-9125-10592f6edb84', '62bfd2b5-9dc2-4a1c-906b-19c42d2621c9', '2024-08-27'),
	('51722081-a9a3-47a2-a101-3a6602b52719', '62bfd2b5-9dc2-4a1c-906b-19c42d2621c9', '2024-08-27'),
	('51722081-a9a3-47a2-a101-3a6602b52719', '14fb04d1-74b2-4751-bfd4-907405e1610f', '2024-08-31'),
	('51722081-a9a3-47a2-a101-3a6602b52719', '13a240fc-d49b-4f8e-933c-6056c40a63d6', '2024-08-31'),
	('2426b496-efee-4741-8033-2db8d222ff33', '13a240fc-d49b-4f8e-933c-6056c40a63d6', '2024-09-01'),
	('2426b496-efee-4741-8033-2db8d222ff33', '14fb04d1-74b2-4751-bfd4-907405e1610f', '2024-09-01'),
	('2426b496-efee-4741-8033-2db8d222ff33', '62bfd2b5-9dc2-4a1c-906b-19c42d2621c9', '2024-09-01'),
	('2426b496-efee-4741-8033-2db8d222ff33', 'e8652ead-43ee-467c-b72c-91de977b7a2a', '2024-09-20'),
	('51722081-a9a3-47a2-a101-3a6602b52719', 'e8652ead-43ee-467c-b72c-91de977b7a2a', '2024-09-20'),
	('a6a23470-bfb3-4d4f-9125-10592f6edb84', 'e8652ead-43ee-467c-b72c-91de977b7a2a', '2024-09-20'),
	('a6a23470-bfb3-4d4f-9125-10592f6edb84', '9f5e7984-4b91-4971-80ad-998e670fc124', '2024-09-21'),
	('ea27e90f-66e7-404e-984d-cc91f1f3b6dc', '9f5e7984-4b91-4971-80ad-998e670fc124', '2024-09-21'),
	('51722081-a9a3-47a2-a101-3a6602b52719', '9f5e7984-4b91-4971-80ad-998e670fc124', '2024-09-21'),
	('51722081-a9a3-47a2-a101-3a6602b52719', '89c55ccf-f330-432c-ba66-65a8415ccda8', '2024-09-22'),
	('a6a23470-bfb3-4d4f-9125-10592f6edb84', '89c55ccf-f330-432c-ba66-65a8415ccda8', '2024-09-22'),
	('a6a23470-bfb3-4d4f-9125-10592f6edb84', '7fc686f2-68c6-49d3-b887-ba674c9eb567', '2024-09-23'),
	('ea27e90f-66e7-404e-984d-cc91f1f3b6dc', '7fc686f2-68c6-49d3-b887-ba674c9eb567', '2024-09-23'),
	('2426b496-efee-4741-8033-2db8d222ff33', '7fc686f2-68c6-49d3-b887-ba674c9eb567', '2024-09-23'),
	('51722081-a9a3-47a2-a101-3a6602b52719', '4f1c4dfe-694e-4879-a5ad-5b187cd628a1', '2024-09-24'),
	('ea27e90f-66e7-404e-984d-cc91f1f3b6dc', '9848b29a-763c-43df-8833-fc50be031885', '2024-09-24'),
	('a6a23470-bfb3-4d4f-9125-10592f6edb84', 'ce583a16-a09d-4cfb-b815-616d28c70754', '2024-09-24'),
	('96c07a62-ef18-4b75-87f8-9fa9ea85cf0e', '62bfd2b5-9dc2-4a1c-906b-19c42d2621c9', '2024-09-24'),
	('e192363c-365c-4873-9b46-4e575cccda2b', '9f5e7984-4b91-4971-80ad-998e670fc124', '2024-09-24'),
	('51722081-a9a3-47a2-a101-3a6602b52719', '238fb709-5103-4894-ba0e-0c3e10221221', '2024-09-25'),
	('2426b496-efee-4741-8033-2db8d222ff33', '238fb709-5103-4894-ba0e-0c3e10221221', '2024-09-25'),
	('ea27e90f-66e7-404e-984d-cc91f1f3b6dc', '238fb709-5103-4894-ba0e-0c3e10221221', '2024-09-25'),
	('a6a23470-bfb3-4d4f-9125-10592f6edb84', '238fb709-5103-4894-ba0e-0c3e10221221', '2024-09-25'),
	('51722081-a9a3-47a2-a101-3a6602b52719', 'd59d7b3c-d8bf-4a55-9e41-2b8177da59a6', '2024-09-25'),
	('e192363c-365c-4873-9b46-4e575cccda2b', 'd59d7b3c-d8bf-4a55-9e41-2b8177da59a6', '2024-09-25'),
	('2426b496-efee-4741-8033-2db8d222ff33', 'd59d7b3c-d8bf-4a55-9e41-2b8177da59a6', '2024-09-25'),
	('51722081-a9a3-47a2-a101-3a6602b52719', '5adf6d02-0fc5-439a-9ab1-f17529531aea', '2024-09-25'),
	('a6a23470-bfb3-4d4f-9125-10592f6edb84', '5adf6d02-0fc5-439a-9ab1-f17529531aea', '2024-09-25'),
	('b0f9bb29-984b-4e56-834a-49545e19e5b9', '1b436c3b-2286-4117-babd-71613cee068b', '2024-09-26'),
	('2426b496-efee-4741-8033-2db8d222ff33', '1b436c3b-2286-4117-babd-71613cee068b', '2024-09-26'),
	('e192363c-365c-4873-9b46-4e575cccda2b', '1b436c3b-2286-4117-babd-71613cee068b', '2024-09-26'),
	('e192363c-365c-4873-9b46-4e575cccda2b', 'e233e2cf-8f97-463a-babf-eae16f5b3422', '2024-09-26'),
	('2426b496-efee-4741-8033-2db8d222ff33', 'e233e2cf-8f97-463a-babf-eae16f5b3422', '2024-09-26'),
	('6ca84b0a-1c61-47ab-9698-2c5d6b8a0fdc', 'fe5dce49-8411-4ccb-a12c-9dc4ede1d1a6', '2024-09-26');


--
-- Data for Name: students; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.students (std_id, first_name, last_name, phone_number, email, major, birthday) VALUES
	('7fc686f2-68c6-49d3-b887-ba674c9eb567', 'Abood', 'Radi', '01236985741', 'aboodrr@gmail.com', 'Business', '2006-12-23'),
	('62d1d149-97a7-4b22-8a04-23dc28c41168', 'Sameer', 'Ahmed', '01236645221', 'sameerahmed@gmail.com', 'Multi media', '2004-07-14'),
	('c0985f63-7d21-4d83-ab6c-5a3f2de3e775', 'Ali', 'Ali', '01233365421', 'aliali@gmail.com', 'It', '2004-04-04'),
	('4f1c4dfe-694e-4879-a5ad-5b187cd628a1', 'Ali', 'Ali', '01233354777', 'aliali1212@gmail.com', 'It', '2005-05-05'),
	('13a240fc-d49b-4f8e-933c-6056c40a63d6', 'Zaki', 'Safi', '01157733222', 'zzsafi@gmail.com', 'It', '2005-03-22'),
	('c197521d-a264-4d63-9d1d-196353106f4a', 'Ahmed', 'Ali', '01233348755', 'ahmedali@gmail.com', 'It', '2000-12-30'),
	('9f5e7984-4b91-4971-80ad-998e670fc124', 'Essam', 'Abo shahla', '01156874320', '3somso@gmail.com', 'It', '2003-10-02'),
	('14fb04d1-74b2-4751-bfd4-907405e1610f', 'Talal', 'Abo murad', '01164520893', 'talalmurad@gmail.com', 'Social science', '2005-07-23'),
	('62bfd2b5-9dc2-4a1c-906b-19c42d2621c9', 'Rabee', 'Abo maraq', '01141530233', 'rabeemaraq@gmail.com', 'Computer science', '2005-04-12'),
	('91bb185c-b1a2-434d-b08e-ac62371e83d5', 'Mohammed', 'Rami', '01245378911', 'moharami@gmail.com', 'Software engineering', '2003-05-12'),
	('9848b29a-763c-43df-8833-fc50be031885', 'Hassan', 'Saloka', '01211133220', 'hassansal@gmail.com', 'Business', '2001-06-14'),
	('ce583a16-a09d-4cfb-b815-616d28c70754', 'Hassan', 'Farooq', '01036645982', 'hassfar@gmail.com', 'Cyber sequrity', '1998-04-04'),
	('e8652ead-43ee-467c-b72c-91de977b7a2a', 'Mahmoud', 'Zakout', '01122236781', 'mahzak@gmail.com', 'Cyber sequrity', '2004-09-21'),
	('89c55ccf-f330-432c-ba66-65a8415ccda8', 'Essa', 'Abo selmeya', '01156874444', 'essaselmeya@gmail.com', 'Cyber sequrity', '2003-07-13'),
	('b2363650-30d5-462e-ad48-5b8bb536e643', 'Sami', 'Adel', '01157834223', 'samiad@gmail.com', 'Software eningeering', '2005-11-12'),
	('461954b7-d7d4-4e34-a20c-a9a9d2c1dd1e', 'Aya', 'Zakout', '+2001236678951', 'ayaz@gmail.com', 'Cyber sequrity', '1998-09-05'),
	('238fb709-5103-4894-ba0e-0c3e10221221', 'Wael', 'Mhadi', '01126698732', 'waelmhadi@gmail.com', 'Computer science', '1997-08-19'),
	('e233e2cf-8f97-463a-babf-eae16f5b3422', 'Waed', 'Safi', '01136654120', 'waedsafi@gmail.com', 'Computer science', '2002-12-12'),
	('1b436c3b-2286-4117-babd-71613cee068b', 'Samah', 'Zaki', '01134456122', 'samahzak@gmail.com', 'Computer science', '1995-11-23'),
	('5a067d5e-a425-48ea-a885-a232284c170c', 'Rami', 'Sabri', '01134456555', 'ramisabri@gmail.com', 'Computer science', '1999-09-27'),
	('fe5dce49-8411-4ccb-a12c-9dc4ede1d1a6', 'Waleed', 'Mohammed', '01134556999', 'waleedmoha@gmail.com', 'Software engineering', '2000-10-27'),
	('d59d7b3c-d8bf-4a55-9e41-2b8177da59a6', 'Saleem', 'Sameer', '01134511203', 'saleemsameer@gmail.com', 'Software engineering', '1996-03-12'),
	('5adf6d02-0fc5-439a-9ab1-f17529531aea', 'Bashar', 'Sameer', '01134514485', 'basharsameer@gmail.com', 'Software engineering', '1997-04-07');


--
-- Name: courses courses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT courses_pkey PRIMARY KEY (course_id);


--
-- Name: instructors instructors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instructors
    ADD CONSTRAINT instructors_pkey PRIMARY KEY (instructor_id);


--
-- Name: student_course student_course_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_course
    ADD CONSTRAINT student_course_pkey PRIMARY KEY (course_id, std_id);


--
-- Name: students students_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_email_key UNIQUE (email);


--
-- Name: students students_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_pkey PRIMARY KEY (std_id);


--
-- Name: courses courses_instructor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT courses_instructor_id_fkey FOREIGN KEY (instructor_id) REFERENCES public.instructors(instructor_id);


--
-- Name: student_course student_course_course_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_course
    ADD CONSTRAINT student_course_course_id_fkey FOREIGN KEY (course_id) REFERENCES public.courses(course_id);


--
-- Name: student_course student_course_std_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_course
    ADD CONSTRAINT student_course_std_id_fkey FOREIGN KEY (std_id) REFERENCES public.students(std_id) ON DELETE CASCADE;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- Name: TABLE courses; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.courses TO viewer;


--
-- Name: TABLE instructors; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT ON TABLE public.instructors TO viewer;


--
-- Name: TABLE student_course; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.student_course TO viewer;


--
-- Name: TABLE students; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.students TO viewer;


--
-- PostgreSQL database dump complete
--

