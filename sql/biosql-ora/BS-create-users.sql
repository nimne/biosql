--
-- SQL script to create the CLONETRAILS users.
--
-- $Id$
--

--
-- (c) Hilmar Lapp, hlapp at gnf.org, 2002.
-- (c) GNF, Genomics Institute of the Novartis Research Foundation, 2002.
--
-- You may distribute this module under the same terms as Perl.
-- Refer to the Perl Artistic License (see the license accompanying this
-- software package, or see http://www.perl.com/language/misc/Artistic.html)
-- for the terms under which you may use, modify, and redistribute this module.
-- 
-- THIS PACKAGE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED
-- WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF
-- MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
--

@BS-defs

--
-- The read-only user for the schema. Note that this is the 'default' user;
-- real users should use their personal login and be granted the BIOSQL_USER
-- role.
--
CREATE USER biosql
       PROFILE "DEFAULT" IDENTIFIED BY "biosql"
       DEFAULT TABLESPACE "&biosql_data"
       TEMPORARY TABLESPACE "TEMP" ACCOUNT UNLOCK
;
GRANT &biosql_user TO biosql;


