alter table webrelease.releasemanager add UnixSa map<text, timestamp, timestamp > ;

/* alter table webrelease.releasemanager delete UnixSa
 */


use webrelease;

create TYPE UnixSaType (
TASK_DETAILS text,
TASK_END_TIME TIMESTAMP,
TASK_START_TIME TIMESTAMP
);

create TYPE DBATasksType (
LIST_OF_SP_EBF text,
PHASED_ text,
SP_EBF_LABEL text,
TASK_END TIMESTAMP,
TASK_START TIMESTAMP,
TEST_SERVER text,
RELEASE_ID text
);

CREATE TABLE DBO.RELEASE_MISC_INFO (
ID text,
DATA_KEY text,
PRIMARY KEY (ID)
);

CREATE TABLE DBO.RELEASE_OPTIONS (
ID_OPTIONS text,
OPTION_DESCRIPTION text,
OPTION_NAME text,
OPTION_TYPE text,
OPTION_VALUE text,
PRIMARY KEY (ID_OPTIONS)
);

CREATE TABLE DBO.RELEASE_PROPERTIES (
ID_PROPERTIES text,
PROPERTY_DESCRIPTION text,
PROPERTY_LOCALE text,
PROPERTY_NAME text,
PROPERTY_TYPE texxt,
PROPERTY_VALUE texxt,
PRIMARY KEY (ID_PROPERTIES)
);

CREATE TABLE DBO.RELEASE_TYPE_QUESTIONS (
ID_QUESTION text
BOOLEAN_YES_text,
MANDATORY_YES_NO text,
QUESTION_DESCRIPTION text,
QUESTION_NAME text,
QUESTION_ORDER number,
TEXT_TEMPLATE text,
QUESTION_PROPERTY text,
QUESTION_TYPE text,
PRIMARY KEY (ID_QUESTION)
);



CREATE TABLE Application(
APPLICATION_NAME text,
APPLICATION_DESCRIPTION text,
ITSM_TEMPLATE text,
VERSION_TEXT_REQUIRED text,
PRIMARY KEY (APPLICATION_NAME)
);





CREATE TABLE webrelease.releasemanager (
	attachmentscollection list<text> ,
	rrmcontact text,
	applicationname text,
	regionsimpacted text,
	statusind text,
	releasestart timestamp,
	dbataskdetails LIST <FROZEN <DBATasksType>>,
	textareacollection List <text>,
	workrequestedby text,
	changetype text,
	dbatask text,
	releaseend timestamp,
	releasetype text,
	rrmapproved text,
	idreleasenumber uuid,
	rrmapprovedautomation text,
	releaseid text,
	primarysupportad text,
	versionnumber text,
	UnixSa  list <FROZEN <UnixSaType>>,		
	PRIMARY KEY (applicationname, releaseid, idreleasenumber, versionnumber)
)
WITH cdc = TRUE;
;

alter table webrelease.releasemanager add UnixSa set< FROZEN <UnixSaType> >




UPDATE
	webrelease.releasemanager
SET
	attachmentscollection = ,
	rrmcontact = '',
	unixsa = '',
	applicationname = '',
	regionsimpacted = '',
	statusind = '',
	releasestart = '',
	dbataskdetailscollection = ,
	textareacollection = ,
	unixsacollection = ,
	workrequestedby = '',
	changetype = '',
	dbatask = '',
	releaseend = '',
	releasetype = '',
	rrmapproved = '',
	idreleasenumber = ,
	rrmapprovedautomation = '',
	releaseid = '',
	primarysupportad = '',
	versionnumber = ''
WHERE ;

/** 
Java Lucent code snippet



*/




package info.archinnov.achilles.demo.music.utils;

import java.io.IOException;
import java.io.StringReader;
import java.util.ArrayList;
import java.util.List;
import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.analysis.TokenStream;
import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.analysis.tokenattributes.CharTermAttribute;
import org.apache.lucene.util.Version;

public class LuceneUtils {

    private static final Analyzer ANALYZER = new StandardAnalyzer(Version.LUCENE_44);

    public static List<String> tokenizeString(String string) {
        List<String> result = new ArrayList<String>();
        try {
            TokenStream stream = ANALYZER.tokenStream("field", new StringReader(string));

            stream.reset();
            while (stream.incrementToken()) {
                result.add(stream.getAttribute(CharTermAttribute.class).toString());
            }
        } catch (IOException e) {
            // not thrown b/c we're using a string reader...
            throw new RuntimeException(e);
        }
        return result;
    }
}