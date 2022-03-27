<?xml version="1.0" encoding="UTF-8"?>
<!-- ============================================================================================= -->
<!--
  © Copyright 2019
	
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

	Disclaimer
	This work is provided without warranty, expressed or implied, that it is complete or accurate or that it
	is fit for any particular purpose.  All such warranties are expressly disclaimed and excluded.
	
	Document history
	Version 2.0.0	Build 20190422	Initial draft Raphael Malyankar for NOAA. (No prior versions.)
-->

<!-- 
  This file contains the Schematron rules to enforce constraints on metadata that are specific to S-102.
  It should be used along with the generic S-100 schematron rules file, which enforces generic constraints.
  Note that since the S-102 extends the S-100 generic schemas for exchange catalogues to add discovery metadata
  elements, the namespace for the dataset discovery element is different from the S-100 exchange catalogue namespace.
-->
<!-- ============================================================================================= -->
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" schemaVersion="2.0.0-20190422" queryBinding="xslt">
  <sch:ns prefix="cit" uri="http://standards.iso.org/iso/19115/-3/cit/2.0"/>
  <sch:ns prefix="gco" uri="http://standards.iso.org/iso/19115/-3/gco/1.0"/>
  <sch:ns prefix="gcx" uri="http://standards.iso.org/iso/19115/-3/gcx/1.0"/>
  <sch:ns prefix="gex" uri="http://standards.iso.org/iso/19115/-3/gex/1.0"/>
  <sch:ns prefix="lan" uri="http://standards.iso.org/iso/19115/-3/lan/1.0"/>
  <sch:ns prefix="mco" uri="http://standards.iso.org/iso/19115/-3/mco/1.0"/>
  <sch:ns prefix="mri" uri="http://standards.iso.org/iso/19115/-3/mri/1.0"/>
  <sch:ns prefix="gml" uri="http://www.opengis.net/gml/3.2"/>
  <sch:ns uri="http://www.iho.int/s100/xc" prefix="S100XC"/>
  <sch:ns uri="http://www.iho.int/s102/2.0/xc" prefix="S102XC"/>
    
  <sch:title>IHO S-102 Schematron validation rules for S-102 Exchange Catalogues</sch:title>

  <!-- Diagnostics to allow user to verify that this file is being used with an exchange catalogue that includes S-102 -->
  <!-- Diagnostic information about namespaces -->
  <sch:pattern fpi="S102.BasicDiagnostics">
    <sch:rule context="/*/S100XC:datasetDiscoveryMetadata" role="info">
      <sch:let name="NUMPSDSBLOCKS" value="count(S102XC:S102_DatasetDiscoveryMetadata[S100XC:productSpecification/S100XC:name = 'S-102'])"/>
      <sch:report test="1">Exchange catalogue contains <sch:value-of select="$NUMPSDSBLOCKS"/> S-102 dataset discovery blocks</sch:report>
    </sch:rule>
    <sch:rule context="/*"  role="info">
      <sch:let name="NUMCATBLOCKS" value="count(*[(local-name() = 'S100_CatalogueMetadata') and (S100XC:productSpecification/S100XC:name = 'S-102')])"/>
      <sch:report test="1">Exchange catalogue contains <sch:value-of select="$NUMCATBLOCKS"/> discovery blocks for S-102 catalogues</sch:report>
    </sch:rule>
  </sch:pattern>    


  <!-- Test for mandatory string type sub-elements of dataset discovery -->
  <sch:pattern fpi="S102.12_1" >
    <sch:title>Rule to report errors for missing or blank mandatory elements in Dataset Discovery Metadata for S-102 dataset discovery blocks</sch:title>
    <sch:p>Note: filePath CAN be empty, but not blank</sch:p>

    <sch:rule context="/*/S100XC:datasetDiscoveryMetadata/S102XC:S102_DatasetDiscoveryMetadata">
      <sch:p>tests for mandatory and unused attributes of the basic S-100 dataset discovery metadata block</sch:p>
      <sch:assert test="string-length(normalize-space(S100XC:fileName)) > 0">S100_DatasetDiscoveryMetadata.filename is mandatory in S-102</sch:assert>
      <!--<sch:assert test="(string-length(S100XC:filePath) = 0) or (string-length(normalize-space(S100XC:filePath)) > 0)">S100_DatasetDiscoveryMetadata.filePath must not be blank (but may be empty)</sch:assert>-->
      <sch:assert test="string-length(normalize-space(S100XC:description)) > 0">S100_DatasetDiscoveryMetadata.description is mandatory in S-102</sch:assert>
      <!--<sch:assert test="string-length(normalize-space(S100XC:dataProtection)) > 0">S100_DatasetDiscoveryMetadata.dataProtection is mandatory in S-102</sch:assert>-->
      <!--<sch:assert test="string-length(normalize-space(S100XC:classification)) > 0">S100_DatasetDiscoveryMetadata.classification is mandatory in S-102</sch:assert>-->
      <!--<sch:assert test="string-length(normalize-space(S100XC:purpose)) > 0">S100_DatasetDiscoveryMetadata.purpose is mandatory in S-102</sch:assert>-->
      <!--<sch:assert test="string-length(normalize-space(S100XC:specificUsage)) > 0">S100_DatasetDiscoveryMetadata.specificUsage is mandatory in S-102</sch:assert>-->
      <sch:assert test="string-length(normalize-space(S100XC:editionNumber)) > 0">S100_DatasetDiscoveryMetadata.editionNumber is mandatory in S-102</sch:assert>
      <sch:report test="S100XC:updateNumber">S100_DatasetDiscoveryMetadata.updateNumber is not used in S-102</sch:report>
      <sch:report test="S100XC:updateApplicationDate">S100_DatasetDiscoveryMetadata.updateApplicationDate is not used in S-102</sch:report>
      <sch:assert test="S100XC:verticalDatum">vertical datum is mandatory in S-102</sch:assert>
      <sch:assert test="S100XC:soundingDatum">sounding datum is mandatory in S-102</sch:assert>
      <sch:assert test="string-length(normalize-space(S100XC:dataTypeVersion)) > 0">S100_DatasetDiscoveryMetadata.dataTypeVersion is mandatory</sch:assert>
      <!--<sch:report test="S100XC:maximumDisplayScale">maximum display scale is not used in S-102</sch:report>-->
      <!--<sch:report test="S100XC:optimumDisplayScale">optimum display scale is not used in S-102</sch:report>-->
      <!--<sch:report test="S100XC:minimumDisplayScale">minimum display scale is not used in S-102</sch:report>-->
      <sch:assert test="S100XC:dataCoverage">data coverage is mandatory in S-102 dataset discovery metadata</sch:assert>
    </sch:rule>

    <!--<sch:rule context="/*/S100XC:datasetDiscoveryMetadata/S102XC:S102_DatasetDiscoveryMetadata/S100XC:dataCoverage">
      <sch:p>tests for mandatory and omitted attributes of each data coverage sub-block in an S-102 dataset discovery metadata block</sch:p>
      <sch:report test="S100XC:maximumDisplayScale">maximum display scale is not used in S-102 data coverage elements</sch:report>
      <sch:report test="S100XC:optimumDisplayScale">optimum display scale is not used in S-102 data coverage elements</sch:report>
      <sch:report test="S100XC:minimumDisplayScale">minimum display scale is not used in S-102 data coverage elements</sch:report>
    </sch:rule>-->
  </sch:pattern>

  <sch:pattern fpi="S102.12_2" >
    <sch:title>Rule to check data format for S-102 dataset discovery blocks</sch:title>
    <sch:p></sch:p>
    <sch:rule context="/*/S100XC:datasetDiscoveryMetadata/S102XC:S102_DatasetDiscoveryMetadata">
      <sch:assert test="(count(S100XC:dataType) > 0) and (normalize-space(S100XC:dataType) = 'HDF5')">Data format for S-102 dataset discovery must be 'HDF5'</sch:assert>
    </sch:rule> 
  </sch:pattern>

  <sch:pattern fpi="S102.12_3" >
    <sch:title>Rule to check dataReplacement and replacedData for the exchange catalogue block</sch:title>
    <sch:p></sch:p>
    <sch:rule context="/*" role="warn">
      <sch:report test="S100XC:dataReplacement">dataReplacement is not used in S-102</sch:report>
      <sch:report test="S100XC:replacedData">replacedData is not used in S-102</sch:report>
    </sch:rule> 
  </sch:pattern>

<!-- S-102 datasets do not have support files, so there must be no support file references in the dataset discovery block for an S-102 dataset.
    (Meta-feature files are presumably described in an second dataset discovery block.) Since the dataset may be in a mixed exchange set, the
    rule that checks for the support file discovery block produces just a warning.
 -->
  <sch:pattern fpi="S102.12_4">
    <sch:rule context="/*/S100XC:datasetDiscoveryMetadata/S102XC:S102_DatasetDiscoveryMetadata" fpi="S102.12_4.A">
      <sch:assert test="count(S100XC:supportFileDiscoveryMetadataReference) = 0">
        supportFileDiscoveryMetadataReference found in S-102 dataset discovery block, but S-102 datasets do not use support files.
      </sch:assert>
    </sch:rule>

    <sch:rule context="/*" role="warn" fpi="S102.12_4.B">
      <sch:report test="S100XC:supportFileDiscoveryMetadata">
        Support file discovery block for <sch:value-of select="S100XC:supportFileDiscoveryMetadata/S100XC:fileName"/> found, but support files are not used by S-102 datasets (is it used by a different product in the exchange set?)
      </sch:report>
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