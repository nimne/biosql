-- -*-Sql-*- mode (to keep my emacs happy)
--
-- SQL script to create the trigger(s) enabling the load API for
-- SGLD_Bioentrys.
--
-- Scaffold auto-generated by gen-api.pl.
--
--
-- $GNF: projects/gi/symgene/src/DB/load-trgs/Bioentries.trg,v 1.7 2003/06/12 01:03:40 hlapp Exp $
--

--
-- Copyright 2002-2003 Genomics Institute of the Novartis Research Foundation
-- Copyright 2002-2008 Hilmar Lapp
-- 
--  This file is part of BioSQL.
--
--  BioSQL is free software: you can redistribute it and/or modify it
--  under the terms of the GNU Lesser General Public License as
--  published by the Free Software Foundation, either version 3 of the
--  License, or (at your option) any later version.
--
--  BioSQL is distributed in the hope that it will be useful,
--  but WITHOUT ANY WARRANTY; without even the implied warranty of
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--  GNU Lesser General Public License for more details.
--
--  You should have received a copy of the GNU Lesser General Public License
--  along with BioSQL. If not, see <http://www.gnu.org/licenses/>.
--

CREATE OR REPLACE TRIGGER BIR_Bioentries
       INSTEAD OF INSERT
       ON SGLD_Bioentries
       REFERENCING NEW AS new OLD AS old
       FOR EACH ROW
DECLARE
	pk		SG_BIOENTRY.OID%TYPE DEFAULT :new.Ent_Oid;
	do_DML		INTEGER DEFAULT BSStd.DML_I;
BEGIN
	-- do insert 
	pk := Ent.get_oid(
			Ent_OID => pk,
		        Ent_ACCESSION   => :new.Ent_ACCESSION,
			Ent_IDENTIFIER	=> :new.Ent_IDENTIFIER,
			Ent_NAME        => :new.Ent_DISPLAY_ID,
			Ent_DESCRIPTION => :new.Ent_DESCRIPTION,
			Ent_VERSION 	=> :new.Ent_VERSION,
			Ent_DIVISION 	=> :new.Ent_DIVISION,
			DB_OID 		=> :new.DB_OID,
			DB_NAME 	=> :new.DB_NAME,
			DB_ACRONYM 	=> :new.DB_ACRONYM,
			TAX_OID 	=> :new.TAX_OID,
			Tnm_NAME 	=> :new.Tax_NAME,
			Tax_NCBI_TAXON_ID => :new.Tax_NCBI_TAXON_ID,
			do_DML          => do_DML);
	-- check whether a sequence length or version was provided, and if
	-- so, create the corresponding Biosequence record
	IF (:new.Ent_Seq_Version IS NOT NULL) OR
	   (:new.Ent_Length IS NOT NULL) OR
	   (:new.Ent_Alphabet IS NOT NULL) THEN
	   pk := Seq.get_oid(
			Seq_OID => pk,
			Seq_VERSION => :new.Ent_Seq_Version,
			Seq_LENGTH => :new.Ent_Length,
			Seq_ALPHABET => :new.Ent_ALPHABET,
			do_DML => do_DML);
	END IF;
END;
/
