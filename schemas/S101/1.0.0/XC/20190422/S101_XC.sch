<?xml version="1.0" encoding="UTF-8"?>
<!-- ============================================================================================= -->
<!--
  © Copyright 2018 (IHO); 2019
	Prepared under NOAA contract
	
	License
  Certain parts of the text of this document refer to or are based on the standards of the International
  Organization for Standardization (ISO). The ISO standards can be obtained from any ISO member and from the
  Web site of the ISO Central Secretariat at www.iso.org.
    
  Permission to copy and distribute this document is hereby granted provided that this notice is retained
  on all copies, and that IHO & NOAA are credited when the material is redistributed or used in part or
	whole in derivative works.
	
  Certain parts of this work are derived from or were originally prepared as works for the UK Location Programme
  (UKLP) and GEMINI project and are (C) Crown copyright (UK). These parts are included under and subject to the
  terms of the Open Government license.

	Disclaimer	(Draft)
	This work is provided without warranty, expressed or implied, that it is complete or accurate or that it
	is fit for any particular purpose.  All such warranties are expressly disclaimed and excluded.
	
	Document history
	Version 1.0.0	Build 20181031	Initial draft Raphael Malyankar for NOAA
                Build 20190331  Updated with warning for deprecated usage of supportfilediscovery metadata
                  as embedded element in dataset discovery metadata; revised patterns for
                  checking display scale element values; removed obsolete rules
                Build 20190422  Removed unused namespaces and rules; removed rules duplicating generic S100
                  Schematron rules from S100_XC.sch
-->

<!-- 
  This file contains the Schematron rules to enforce constraints on metadata that are specific to S-101.
  It should be used along with the generic S-100 schematron rules file, which enforces generic constraints.
  Note that since the S-101 exchange catalogue uses the S-100 generic schemas without extension, the namespace
  is the S-100 exchange catalogue namespace.
-->
<!-- ============================================================================================= -->
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" schemaVersion="1.0.0-20190422" queryBinding="xslt">
  <sch:ns prefix="cit" uri="http://standards.iso.org/iso/19115/-3/cit/2.0"/>
  <sch:ns prefix="gco" uri="http://standards.iso.org/iso/19115/-3/gco/1.0"/>
  <sch:ns prefix="gcx" uri="http://standards.iso.org/iso/19115/-3/gcx/1.0"/>
  <sch:ns prefix="gex" uri="http://standards.iso.org/iso/19115/-3/gex/1.0"/>
  <sch:ns prefix="lan" uri="http://standards.iso.org/iso/19115/-3/lan/1.0"/>
  <sch:ns prefix="mco" uri="http://standards.iso.org/iso/19115/-3/mco/1.0"/>
  <sch:ns prefix="mri" uri="http://standards.iso.org/iso/19115/-3/mri/1.0"/>
  <sch:ns prefix="gml" uri="http://www.opengis.net/gml/3.2"/>
  <sch:ns uri="http://www.iho.int/s100/xc" prefix="S100XC"/>
  <sch:ns uri="http://www.iho.int/s101/1.0/xc" prefix="S101XC"/>
    
  <sch:title>IHO S-101 Schematron validation rules for S-101 Exchange Catalogues</sch:title>

  <!-- Diagnostics to allow user to verify that this file is being used with an exchange catalogue that includes S-101 -->
  <!-- Diagnostic information -->
  <sch:pattern fpi="S101.BasicDiagnostics">
    <sch:rule context="/*/S100XC:datasetDiscoveryMetadata" role="info">
      <sch:let name="NUMS101DSBLOCKS" value="count(S100XC:S100_DatasetDiscoveryMetadata[S100XC:productSpecification/S100XC:name = 'S-101'])"/>
      <sch:report test="1">Exchange catalogue contains <sch:value-of select="$NUMS101DSBLOCKS"/> S-101 dataset discovery blocks</sch:report>
    </sch:rule>
    <sch:rule context="/*"  role="info">
      <sch:let name="NUMCATBLOCKS" value="count(*[(local-name() = 'S100_CatalogueMetadata') and (S100XC:productSpecification/S100XC:name = 'S-101')])"/>
      <sch:report test="1">Exchange catalogue contains <sch:value-of select="$NUMCATBLOCKS"/> catalogue discovery blocks for S-101 catalogues</sch:report>
    </sch:rule>
  </sch:pattern>    


  <!-- Test for mandatory string type sub-elements of dataset discovery -->
  <!-- The S-100 4.0.0 rule is that mandatory attributes are nillable (4a-5.5), but the generic S-100
        check is made stricter by the S-101 product-specific rules which require that the mandatory
        elements be encoded. (S-101 1.0.0 12.1).
  -->
  <sch:pattern fpi="S101.12.1.2_1" >
    <sch:title>Rule to report errors for missing or blank mandatory elements in Dataset Discovery Metadata for S-101 dataset discovery blocks</sch:title>
    <sch:p>Note: filePath CAN be empty, but not blank</sch:p>

    <sch:rule context="/*/S100XC:datasetDiscoveryMetadata/S100XC:S100_DatasetDiscoveryMetadata[S100XC:productSpecification/S100XC:name = 'S-101']">
      <sch:p>tests for mandatory attributes of the basic S-101 dataset discovery metadata block</sch:p>
      <sch:assert test="string-length(normalize-space(S100XC:fileName)) > 0">S100_DatasetDiscoveryMetadata.filename is mandatory in S-101</sch:assert>
      <!--<sch:assert test="(string-length(S100XC:filePath) = 0) or (string-length(normalize-space(S100XC:filePath)) > 0)">S100_DatasetDiscoveryMetadata.filePath must not be blank (but may be empty)</sch:assert>-->
      <sch:assert test="string-length(normalize-space(S100XC:description)) > 0">S100_DatasetDiscoveryMetadata.description is mandatory in S-101</sch:assert>
      <sch:assert test="string-length(normalize-space(S100XC:dataProtection)) > 0">S100_DatasetDiscoveryMetadata.dataProtection is mandatory in S-101</sch:assert>
      <sch:assert test="string-length(normalize-space(S100XC:classification)) > 0">S100_DatasetDiscoveryMetadata.classification is mandatory in S-101</sch:assert>
      <sch:assert test="string-length(normalize-space(S100XC:purpose)) > 0">S100_DatasetDiscoveryMetadata.purpose is mandatory in S-101</sch:assert>
      <sch:assert test="string-length(normalize-space(S100XC:specificUsage)) > 0">S100_DatasetDiscoveryMetadata.specificUsage is mandatory in S-101</sch:assert>
      <sch:assert test="string-length(normalize-space(S100XC:editionNumber)) > 0">S100_DatasetDiscoveryMetadata.editionNumber is mandatory in S-101</sch:assert>
      <sch:assert test="string-length(normalize-space(S100XC:updateNumber)) > 0">S100_DatasetDiscoveryMetadata.updateNumber is mandatory in S-101</sch:assert>
      <!--<sch:assert test="S100XC:verticalDatum">vertical datum is mandatory in S-101</sch:assert>-->
      <!--<sch:assert test="S100XC:soundingDatum">sounding datum is mandatory in S-101</sch:assert>-->
      <sch:assert test="string-length(normalize-space(S100XC:dataTypeVersion)) > 0">S100_DatasetDiscoveryMetadata.dataTypeVersion is mandatory in S-101</sch:assert>
      <sch:assert test="S100XC:maximumDisplayScale">maximum display scale is mandatory in S-101</sch:assert>
      <sch:assert test="string-length(normalize-space(S100XC:verticalDatum) > 0)">vertical datum is mandatory in S-101 dataset discovery block</sch:assert>
      <sch:assert test="string-length(normalize-space(S100XC:soundingDatum) > 0)">sounding datum is mandatory in S-101</sch:assert>
      <sch:assert test="S100XC:dataCoverage">data coverage is mandatory in S-101 dataset discovery metadata</sch:assert>
    </sch:rule>

    <sch:rule context="/*/S100XC:datasetDiscoveryMetadata/S100XC:S100_DatasetDiscoveryMetadata[S100XC:productSpecification/S100XC:name = 'S-101']/S100XC:dataCoverage">
      <sch:p>tests for mandatory attributes of each data coverage sub-block in an S-101 dataset discovery metadata block</sch:p>
      <sch:assert test="S100XC:maximumDisplayScale">maximum display scale is mandatory in S-101 data coverage elements</sch:assert>
      <sch:assert test="S100XC:minimumDisplayScale">minimum display scale is mandatory in S-101 data coverage elements</sch:assert>
    </sch:rule>
  </sch:pattern>

  <sch:pattern fpi="S101.12.1.2_2" >
    <sch:title>Rule to check that update number is an integer</sch:title>
    <sch:p>Update number 0 is assigned to a new dataset. Characters forming the updateNumber must be integers.</sch:p>
    <sch:rule context="/*/S100XC:datasetDiscoveryMetadata/S100XC:S100_DatasetDiscoveryMetadata[(S100XC:productSpecification/S100XC:name = 'S-101') and (count(S100XC:updateNumber) > 0)]">
      <sch:let name="UPDATENUM" value="number(S100XC:updateNumber)"/>
      <sch:assert test="$UPDATENUM = number(S100XC:updateNumber) and (ceiling($UPDATENUM) = $UPDATENUM) and ($UPDATENUM > -1)">S100_DatasetDiscoveryMetadata.updateNumber must be a non-negative integer</sch:assert>
    </sch:rule> 
  </sch:pattern>

  <sch:pattern fpi="S101.12.1.2_3" >
    <sch:title>Rule to warn if update application date for S-101 dataset discovery blocks is omitted</sch:title>
    <sch:p>This date is only used for the base dataset files (that is new dataset, re-issue and new edition), not update dataset files. All updates dated on or before this date must have been applied by the producer</sch:p>
    <sch:rule context="/*/S100XC:datasetDiscoveryMetadata/S100XC:S100_DatasetDiscoveryMetadata[S100XC:productSpecification/S100XC:name = 'S-101']" role="warn">
      <sch:report test="(count(S100XC:updateApplicationDate) = 0) and not(contains('new|reissue|re-issue', S100XC:purpose))">No updateApplicationDate in S-101 dataset discovery block (mandatory except for new or reissued datasets).</sch:report>
    </sch:rule> 
  </sch:pattern>

  <sch:pattern fpi="S101.12.1.2.5_4" >
    <sch:title>Rule to check data format for S-101 dataset discovery blocks</sch:title>
    <sch:p></sch:p>
    <sch:rule context="/*/S100XC:datasetDiscoveryMetadata/S100XC:S100_DatasetDiscoveryMetadata[S100XC:productSpecification/S100XC:name = 'S-101']" role="warn">
      <sch:assert test="(count(S100XC:dataType) > 0) and (normalize-space(S100XC:dataType) = 'ISO/IEC 8211')">Data format for S-101 dataset discovery must be 'ISO/IEC 8211'</sch:assert>
    </sch:rule> 
  </sch:pattern>

  <!-- Check for presence or absence of digital signature for support file metadata -->
  <sch:pattern>
    <sch:p>S-101 1.0.0 Figure 26.</sch:p>
    <sch:rule context="/*/S100XC:supportFileDiscoveryMetadata[S100XC:fileName = /*/S100XC:datasetDiscoveryMetadata/S100XC:S100_DatasetDiscoveryMetadata[S100XC:productSpecification/S100XC:name = 'S-101']/S100XC:supportFileDiscoveryMetadataReference/text()]" role="warn">
      <sch:assert test="S100XC:digitalSignatureValue">Support file discovery block for S-101 support files must have a digital signature</sch:assert>
    </sch:rule>
  </sch:pattern>

  <!-- S-101 1.0.0 12.1.2 maximumDisplayScale values in dataset discovery block -->
  <sch:pattern fpi="S101.12.1.2_4">
    <sch:rule context="/*/S100XC:datasetDiscoveryMetadata/S100XC:S100_DatasetDiscoveryMetadata[S100XC:productSpecification/S100XC:name = 'S-101']/S100XC:maximumDisplayScale" role="warn">
      <sch:let name="DSVAL" value="number()"/>
      <sch:assert test="($DSVAL = 1000) or 
        ($DSVAL = 2000) or
        ($DSVAL = 3000) or
        ($DSVAL = 4000) or
        ($DSVAL = 8000) or
        ($DSVAL = 12000) or
        ($DSVAL = 22000) or
        ($DSVAL = 45000) or
        ($DSVAL = 90000) or
        ($DSVAL = 180000) or
        ($DSVAL = 350000) or
        ($DSVAL = 700000) or
        ($DSVAL = 1500000) or
        ($DSVAL = 3500000) or
        ($DSVAL = 10000000)">maximum display scale '<sch:value-of select="$DSVAL"/>' in S-101 dataset discovery block must be one of {1000, 2000, 3000, 4000, 8000, 12000, 22000, 45000, 90000, 180000, 350000, 700000, 1500000, 3500000, 10000000}</sch:assert>
    </sch:rule>
  </sch:pattern>

  <!-- S-101 1.0.0 12.1.3 maximumDisplayScale and minimumDisplayScale values in dataCoverage sub-block of dataset discovery block -->
  <sch:pattern fpi="S101.12.1.3_1">
    <sch:rule context="/*/S100XC:datasetDiscoveryMetadata/S100XC:S100_DatasetDiscoveryMetadata[S100XC:productSpecification/S100XC:name = 'S-101']/S100XC:dataCoverage/S100XC:maximumDisplayScale" role="warn">
      <sch:let name="DSVAL" value="number()"/>
      <sch:assert test="($DSVAL = 1000) or 
        ($DSVAL = 2000) or
        ($DSVAL = 3000) or
        ($DSVAL = 4000) or
        ($DSVAL = 8000) or
        ($DSVAL = 12000) or
        ($DSVAL = 22000) or
        ($DSVAL = 45000) or
        ($DSVAL = 90000) or
        ($DSVAL = 180000) or
        ($DSVAL = 350000) or
        ($DSVAL = 700000) or
        ($DSVAL = 1500000) or
        ($DSVAL = 3500000) or
        ($DSVAL = 10000000)">maximum display scale '<sch:value-of select="$DSVAL"/>' in dataCoverage sub-block of S-101 dataset discovery block must be one of {1000, 2000, 3000, 4000, 8000, 12000, 22000, 45000, 90000, 180000, 350000, 700000, 1500000, 3500000, 10000000}</sch:assert>
    </sch:rule>
    <sch:rule context="/*/S100XC:datasetDiscoveryMetadata/S100XC:S100_DatasetDiscoveryMetadata[S100XC:productSpecification/S100XC:name = 'S-101']/S100XC:dataCoverage/S100XC:minimumDisplayScale" role="warn">
      <sch:let name="DSVAL" value="number()"/>
      <sch:assert test="(number() != $DSVAL) or
        ($DSVAL = 2000) or
        ($DSVAL = 3000) or
        ($DSVAL = 4000) or
        ($DSVAL = 8000) or
        ($DSVAL = 12000) or
        ($DSVAL = 22000) or
        ($DSVAL = 45000) or
        ($DSVAL = 90000) or
        ($DSVAL = 180000) or
        ($DSVAL = 350000) or
        ($DSVAL = 700000) or
        ($DSVAL = 1500000) or
        ($DSVAL = 3500000) or
        ($DSVAL = 10000000)">minimum display scale '<sch:value-of select="$DSVAL"/>' in dataCoverage sub-block of S-101 dataset discovery block must be nilled or one of {2000, 3000, 4000, 8000, 12000, 22000, 45000, 90000, 180000, 350000, 700000, 1500000, 3500000, 10000000}</sch:assert>
    </sch:rule>
  </sch:pattern>

  <!-- ========================================================================================== -->
  <!-- The following patterns are extracts from the Schematron Schema for the UK GEMINI Standard  -->
  <!-- Version 2.1 and are incuded subject to the terms applicable to that schema, reproduced     -->
  <!-- below.                                                                                     -->
  <!-- ========================================================================================== -->
  <!-- None -->
  
  
  <!-- ========================================================================================== -->
  <!-- Abstract Patterns                                                                          -->
  <!-- ========================================================================================== -->
  <!-- None -->

</sch:schema>