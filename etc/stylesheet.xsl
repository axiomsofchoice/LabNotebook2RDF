<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:lnb="http://biolab.isis.rl.ac.uk/camerons_labblog"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:xsi = "http://www.w3.org/2000/10/XMLSchema-instance"
	xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns="http://purl.org/rss/1.0/">
	
	<xsl:output method="xml" encoding="UTF-8" indent="yes" />
	<!-- TODO: Make certain URI parametrized via variables. -->
	
	<xsl:template match="/">
		<xsl:element name="rdf:RDF">
		<!-- <xsl:attribute name="xsi:schemaLocation">http://www.w3.org/1999/02/22-rdf-syntax-ns# http://www.w3.org/2000/07/rdf.xsd</xsl:attribute> -->

			<xsl:element name="channel">
			<xsl:attribute name="rdf:about">http://biolab.isis.rl.ac.uk/camerons_labblog/index.xml</xsl:attribute>
				<xsl:element name="title">Cameron's Labblog</xsl:element>
				<xsl:element name="link">http://biolab.isis.rl.ac.uk/camerons_labblog/index.xml</xsl:element>
				<xsl:element name="description"><!-- TODO: work out what to put into here --></xsl:element>
				<xsl:element name="items">
					<xsl:element name="rdf:Seq">
						<xsl:apply-templates select="/lnb:posts/lnb:post" mode="li" />
					</xsl:element>
				</xsl:element>
			</xsl:element>
			<xsl:apply-templates select="/lnb:posts/lnb:post" mode="item" />
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="/lnb:posts/lnb:post" mode="li">
	  <!-- Shorter form of item:
        <rdf:li resource="http://example.com/2002/09/01/"/>
        -->
		<xsl:element name="rdf:li">
			<xsl:attribute name="resource">
				<xsl:text>http://biolab.isis.rl.ac.uk/uri/</xsl:text>
				<xsl:text><xsl:value-of select="./lnb:id" /></xsl:text>
			</xsl:attribute>
		</xsl:element>
	</xsl:template>

	<xsl:template match="/lnb:posts/lnb:post" mode="item">
	  <!-- Longer form of item:
	  <item rdf:about="http://example.com/2002/09/01/">
	     <title>News for September the Second</title>
	     <link>http://example.com/2002/09/02/</link>
	     <dc:date>2002-09-02</dc:date>
	  </item> -->
		<xsl:element name="item">
		<xsl:attribute name="rdf:about">
			<xsl:text>http://biolab.isis.rl.ac.uk/uri/</xsl:text>
			<xsl:text><xsl:value-of select="./lnb:id" /></xsl:text>
		</xsl:attribute>
			<xsl:element name="title"><xsl:value-of select="./lnb:title" /></xsl:element>
			<xsl:element name="link">
				<xsl:text>http://biolab.isis.rl.ac.uk/uri/</xsl:text>
				<xsl:text><xsl:value-of select="./lnb:id" /></xsl:text>
			</xsl:element>
			<xsl:element name="dc:date"><xsl:value-of select="./lnb:datestamp" /></xsl:element>
			<xsl:element name="description">
				<xsl:attribute name="rdf:parseType">Literal</xsl:attribute>
				<xsl:value-of select="./lnb:html" />
			</xsl:element>
		</xsl:element>
	</xsl:template>
</xsl:stylesheet>