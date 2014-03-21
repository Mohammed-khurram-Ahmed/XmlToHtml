<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
 	<xsl:output method="html" encoding="utf-8" indent="yes" />
		<xsl:template match="product">	
			
					<xsl:apply-templates select="section"/>
		</xsl:template>
		<xsl:template match="section">
		<xsl:if test="@visible= 'true'">
		
			<xsl:if test="@type = 'dynamic'">
			
			<div class="row">
					<div class="panel-group" id="accordion">
						<div class="row bi-accordian-bg">
							<label class="bi-accodian-header pull-left"><xsl:value-of select="@label" /></label>
							<a href="" style="display:none;" class="sectionedit btn-bi-edit"><input type="button" class="btn" value="Edit" /></a>
							<div class="pull-right less_show showcls" data-toggle="collapse" data-target="#" id="class{@id}"></div>
						</div>
					</div>
				</div>
			
			
		
      <div id="{@id}" class="panel-collapse collapse in">
				
      	<xsl:apply-templates select="row"/>	</div>
      
      </xsl:if>
      <xsl:if test="@type = 'static'">
      <xsl:apply-templates select="row"/>	
      </xsl:if>		</xsl:if>
      	<xsl:if test="@visible= 'false'">
		
			<xsl:if test="@type = 'dynamic'">
			<div class="{@id}" style="display:none;">
		<div class="row">
					<div class="panel-group" id="accordion">
						<div class="row bi-accordian-bg">
							<label class="bi-accodian-header pull-left"><xsl:value-of select="@label" /></label>
							<a href="" style="display:none;" class="sectionedit btn-bi-edit"><input type="button" class="btn" value="Edit" /></a>
							<div class="pull-right less_show showcls" data-toggle="collapse" data-target="#" id="class{@id}"></div>
						</div>
					</div>
				</div>
			
			
		
      <div id="{@id}" class="panel-collapse collapse in">
					
      	<xsl:apply-templates select="row"/>	</div>
      </div>
      </xsl:if>
      <xsl:if test="@type = 'static'">
      <xsl:apply-templates select="row"/>	
      </xsl:if>		</xsl:if>
		
						
	</xsl:template>
	<xsl:template match="row">		
			<div class="form-group"><div class="row">
				<xsl:apply-templates select="columns"/>							
		</div>
			</div>
	</xsl:template> 
	<xsl:template match="columns">

			<xsl:apply-templates select="column"/>
	</xsl:template>	
	<xsl:template match="column">		
				<xsl:if test="@type = 'text'">
				<xsl:choose>
				<xsl:when test="@label = 'First' or @label = 'Middle' or @label = 'Last'">
				<div class="fielset2"><xsl:variable name="textid" select="@id"/>	
					<xsl:element name="input">
							<xsl:attribute name="type"><xsl:text>text</xsl:text></xsl:attribute>
												
						<xsl:attribute name="id">
							<xsl:value-of select="@id" />
						</xsl:attribute>
						<xsl:attribute name="name">
							<xsl:value-of select="@name" />
						</xsl:attribute>
						<xsl:if test="@visible= 'false'">
				<xsl:attribute name="style">display:none</xsl:attribute>				
				</xsl:if>
						<xsl:attribute name="value">
							<xsl:value-of select="value" />
						</xsl:attribute>
						
						<xsl:attribute name="maxlength">
							<xsl:value-of select="validations/maxLength" />
						</xsl:attribute>
						<xsl:attribute name="minlength">
							<xsl:value-of select="validations/minLength" />
						</xsl:attribute>
						
					<xsl:choose>
					<xsl:when test="@picker = 'true'">
					<xsl:attribute name="class">
							<xsl:text>form-control1</xsl:text>
						</xsl:attribute>
					</xsl:when>
					<xsl:otherwise><xsl:attribute name="class">
							<xsl:text>form-control</xsl:text>
						</xsl:attribute></xsl:otherwise>
					</xsl:choose> 
					<!-- 	<xsl:attribute name="pattern">
							<xsl:text>.{</xsl:text><xsl:value-of select="validations/minLength" /><xsl:text>,</xsl:text><xsl:value-of select="validations/maxLength" /><xsl:text>}</xsl:text>
						</xsl:attribute> -->
						<xsl:attribute name="placeholder">
							<xsl:value-of select="@label"/>
						</xsl:attribute>
					<!-- 	<xsl:attribute name="onblur">
						<xsl:value-of select="validations/scripts/script[@triggerOn='onblur']"/>
						</xsl:attribute> -->
						<xsl:attribute name="onchange">
							<xsl:variable name="dt" select="validations/dataType"/>		
						<xsl:variable name="min" select="validations/minLength"/>	
					
						<xsl:if test="validations/dataType!=''">
			validateField('<xsl:value-of select="validations/dataType"/>',<xsl:value-of select="@id" />,<xsl:value-of select="validations/minLength" />)
									</xsl:if>
				<xsl:for-each select="validations/dependencies/dependency">	
						dependency('<xsl:value-of select="$textid" />','<xsl:value-of select="operator" />',<xsl:value-of select="rValue" />,'<xsl:value-of select="$dt"/>')
						</xsl:for-each>
						</xsl:attribute>
						<xsl:attribute name="onblur">
						<xsl:value-of select="validations/scripts/script[@triggerOn='onblur']" />
						</xsl:attribute>
						<xsl:attribute name="onfocus">
						quickTip('<xsl:value-of select="@tooltip" />')
						</xsl:attribute>
						<xsl:if test="@required = 'true'">
						<xsl:attribute name="data-rule-required">
							<xsl:value-of select="@required"/>
						</xsl:attribute></xsl:if>
						
						<xsl:if test="@readonly = 'true'">
						<xsl:attribute name="readonly">
							<xsl:value-of select="@readonly"/>
						</xsl:attribute>
							<xsl:attribute name="max">
							<xsl:value-of select="validations/max"/>
						</xsl:attribute>
						<xsl:attribute name="min">
							<xsl:value-of select="validations/min"/>
						</xsl:attribute>
						</xsl:if>
					
					
					</xsl:element><xsl:if test="@picker = 'true'"> <img src="images/bi/calender.png" class="picker" style="cursor:pointer;padding-left:3px;margin-top:-2px;"/></xsl:if>
			</div>
				</xsl:when>
				<xsl:otherwise>
				
				<div class="fielset"><xsl:variable name="textid" select="@id"/>	
					<xsl:element name="input">
							<xsl:attribute name="type"><xsl:text>text</xsl:text></xsl:attribute>
												
						<xsl:attribute name="id">
							<xsl:value-of select="@id" />
						</xsl:attribute>
						<xsl:attribute name="name">
							<xsl:value-of select="@name" />
						</xsl:attribute>
						<xsl:if test="@visible= 'false'">
				<xsl:attribute name="style">display:none</xsl:attribute>				
				</xsl:if>
						<xsl:attribute name="value">
							<xsl:value-of select="value" />
						</xsl:attribute>
						
						<xsl:attribute name="maxlength">
							<xsl:value-of select="validations/maxLength" />
						</xsl:attribute>
						<xsl:attribute name="minlength">
							<xsl:value-of select="validations/minLength" />
						</xsl:attribute>
						
					<xsl:choose>
					<xsl:when test="@picker = 'true'">
					<xsl:attribute name="class">
							<xsl:text>form-control1</xsl:text>
						</xsl:attribute>
					</xsl:when>
					<xsl:otherwise><xsl:attribute name="class">
							<xsl:text>form-control</xsl:text>
						</xsl:attribute></xsl:otherwise>
					</xsl:choose> 
					<!-- 	<xsl:attribute name="pattern">
							<xsl:text>.{</xsl:text><xsl:value-of select="validations/minLength" /><xsl:text>,</xsl:text><xsl:value-of select="validations/maxLength" /><xsl:text>}</xsl:text>
						</xsl:attribute> -->
						<xsl:attribute name="placeholder">
							<xsl:value-of select="@label"/>
						</xsl:attribute>
					<!-- 	<xsl:attribute name="onblur">
						<xsl:value-of select="validations/scripts/script[@triggerOn='onblur']"/>
						</xsl:attribute> -->
						<xsl:attribute name="onchange">
							<xsl:variable name="dt" select="validations/dataType"/>		
						<xsl:variable name="min" select="validations/minLength"/>	
					
						<xsl:if test="validations/dataType!=''">
			validateField('<xsl:value-of select="validations/dataType"/>',<xsl:value-of select="@id" />,<xsl:value-of select="validations/minLength" />)
									</xsl:if>
				<xsl:for-each select="validations/dependencies/dependency">	
						dependency('<xsl:value-of select="$textid" />','<xsl:value-of select="operator" />',<xsl:value-of select="rValue" />,'<xsl:value-of select="$dt"/>')
						</xsl:for-each>
						</xsl:attribute>
						<xsl:attribute name="onblur">
						<xsl:value-of select="validations/scripts/script[@triggerOn='onblur']" />
						</xsl:attribute>
						<xsl:attribute name="onfocus">
						quickTip('<xsl:value-of select="@tooltip" />')
						</xsl:attribute>
						<xsl:if test="@required = 'true'">
						<xsl:attribute name="data-rule-required">
							<xsl:value-of select="@required"/>
						</xsl:attribute></xsl:if>
						
						<xsl:if test="@readonly = 'true'">
						<xsl:attribute name="readonly">
							<xsl:value-of select="@readonly"/>
						</xsl:attribute>
							<xsl:attribute name="max">
							<xsl:value-of select="validations/max"/>
						</xsl:attribute>
						<xsl:attribute name="min">
							<xsl:value-of select="validations/min"/>
						</xsl:attribute>
						</xsl:if>
					
					
					</xsl:element><xsl:if test="@picker = 'true'"> <img src="images/bi/calender.png" class="picker" style="cursor:pointer;padding-left:3px;margin-top:-2px;"/></xsl:if>
			</div>
				</xsl:otherwise>
				</xsl:choose>
				
				
				</xsl:if>
				<xsl:if test="@type = 'select'">
				<xsl:variable name="textid1" select="@id"/>	
				<xsl:choose>
					<xsl:when test="@label = 'Title'">
						<div class="fielset1"><select >
						<xsl:attribute name="id">
							<xsl:value-of select="@id" />
						</xsl:attribute>
						<xsl:attribute name="name">
							<xsl:value-of select="@name" />
						</xsl:attribute>	
						
					<xsl:attribute name="class">
							<xsl:text>form-control</xsl:text>
						</xsl:attribute>
						<xsl:if test="@visible= 'false'">
				<xsl:attribute name="style">display:none</xsl:attribute>				
				</xsl:if>
						<xsl:attribute name="onfocus">
						quickTip('<xsl:value-of select="@tooltip" />')
						</xsl:attribute>
						<xsl:if test="@required = 'true'">
						<xsl:attribute name="data-rule-required">
							<xsl:value-of select="@required"/>
						</xsl:attribute>
						</xsl:if>
						<xsl:attribute name="onchange">
					<xsl:for-each select="validations/dependencies/dependency">	
						dependency('<xsl:value-of select="$textid1" />','<xsl:value-of select="operator" />',<xsl:value-of select="rValue" />,'')
						</xsl:for-each>
						</xsl:attribute>
						<xsl:variable name="sss" select="value"/>					
					<xsl:for-each select="items/option">	
						
						<option value="{@value}">
					 <xsl:if test="@value=$sss">
         		 <xsl:attribute name="selected">selected</xsl:attribute>
      				</xsl:if> 
						<xsl:value-of select="."/></option>
    				</xsl:for-each>
						
					</select></div>
					</xsl:when>
					<xsl:otherwise>	<div class="fielset"><select >
						<xsl:attribute name="id">
							<xsl:value-of select="@id" />
						</xsl:attribute>
						<xsl:attribute name="name">
							<xsl:value-of select="@name" />
						</xsl:attribute>	
						
					<xsl:attribute name="class">
							<xsl:text>form-control</xsl:text>
						</xsl:attribute>
						<xsl:if test="@visible= 'false'">
				<xsl:attribute name="style">display:none</xsl:attribute>				
				</xsl:if>
						<xsl:attribute name="onfocus">
						quickTip('<xsl:value-of select="@tooltip" />')
						</xsl:attribute>
						<xsl:if test="@required = 'true'">
						<xsl:attribute name="data-rule-required">
							<xsl:value-of select="@required"/>
						</xsl:attribute>
						</xsl:if>
						<xsl:attribute name="onchange">
					<xsl:for-each select="validations/dependencies/dependency">	
						dependency('<xsl:value-of select="$textid1" />','<xsl:value-of select="operator" />',<xsl:value-of select="rValue" />,'')
						</xsl:for-each>
						</xsl:attribute>
						<xsl:variable name="sss" select="value"/>					
					<xsl:for-each select="items/option">	
						
						<option value="{@value}">
					 <xsl:if test="@value=$sss">
         		 <xsl:attribute name="selected">selected</xsl:attribute>
      				</xsl:if> 
						<xsl:value-of select="."/></option>
    				</xsl:for-each>
						
					</select></div></xsl:otherwise>
					</xsl:choose> 
				
				</xsl:if>
			<xsl:if test="@type = 'radio'">
			<xsl:variable name="sss1" select="value"/>		
			<xsl:variable name="radioid" select="@id"/>	
			<xsl:variable name="radioname" select="@name"/>	
			<xsl:variable name="radiorequire" select="@required"/>	
			<xsl:variable name="radiotooltip" select="@tooltip"/>	
				<xsl:variable name="dep" select="validations/dependencies/dependency"/>		
				<div class="fielset">
					<xsl:for-each select="items/option">	
					<div class="radio-inline"><label class="control-label label-radio">
					<xsl:element name="input">
					<xsl:attribute name="type">
							<xsl:text>radio</xsl:text>
						</xsl:attribute>																						
					
				 <xsl:attribute name="onchange">
					<xsl:for-each select="$dep">	
						dependency('<xsl:value-of select="$radioname" />','<xsl:value-of select="operator" />',<xsl:value-of select="rValue" />,'')
						</xsl:for-each>
						</xsl:attribute>
				 <xsl:if test="$radiorequire = 'true'">
						<xsl:attribute name="data-rule-required">
							<xsl:value-of select="$radiorequire"/>
						</xsl:attribute></xsl:if>
				 <xsl:attribute name="onfocus">
						quickTip('<xsl:value-of select="$radiotooltip" />')
						</xsl:attribute>	<xsl:attribute name="name">
							<xsl:value-of select="$radioname" />
						</xsl:attribute>
						<xsl:attribute name="value">
							<xsl:value-of select="@value" />
						</xsl:attribute>
					 <xsl:if test="@value=$sss1">
						<xsl:attribute name="checked"></xsl:attribute>
					</xsl:if>
					<xsl:if test="@required = 'true'">
						<xsl:attribute name="data-rule-required" />
					</xsl:if>	
					<xsl:value-of select="@value" />
				</xsl:element>
				</label></div>
				</xsl:for-each>
			<span><label>
			<xsl:attribute name="for">
							<xsl:value-of select="$radioname" />
						</xsl:attribute>
						<xsl:attribute name="class">
							error
						</xsl:attribute>
			</label></span></div>	
					</xsl:if>
				
					<xsl:if test="@type = 'checkbox'">
						<div class="checkbox"><xsl:variable name="textid1" select="@id"/>	<label class="control-label lablestyle">
					<xsl:element name="input">
						<xsl:attribute name="type">
							<xsl:text>checkbox</xsl:text>
						</xsl:attribute>
						<xsl:attribute name="id">
							<xsl:value-of select="@id" />
						</xsl:attribute>
						<xsl:attribute name="name">
							<xsl:value-of select="@name" />
						</xsl:attribute>
						
						<xsl:if test="@required = 'true'">
						<xsl:attribute name="data-rule-required">
							<xsl:value-of select="@required"/>
						</xsl:attribute></xsl:if>
						<xsl:attribute name="onfocus">
						quickTip('<xsl:value-of select="@tooltip" />')
						</xsl:attribute>
						<xsl:attribute name="value">
							<xsl:value-of select="@value" />
						</xsl:attribute>
						<xsl:if test="value ='true'">
						<xsl:attribute name="checked">checked</xsl:attribute>
					</xsl:if>
					<!-- 	<xsl:attribute name="onclick">
							<xsl:value-of select="validations/scripts/script[@triggerOn='onclick']"/>
						</xsl:attribute>
				 -->			<xsl:attribute name="onclick">
						<xsl:for-each select="validations/dependencies/dependency">	
							dependency('<xsl:value-of select="$textid1" />','<xsl:value-of select="operator" />','<xsl:value-of select="rValue" />','<xsl:value-of select="lValue"/>')
					</xsl:for-each>
						</xsl:attribute>
					
					</xsl:element><xsl:value-of select="@label"/></label>
					<br></br>
					<label>
			<xsl:attribute name="for">
							<xsl:value-of select="@name" />
						</xsl:attribute>
						<xsl:attribute name="class">
							error
						</xsl:attribute>
			</label>
					</div>
				</xsl:if>
				<xsl:if test="@type = 'label'">
				 <xsl:choose><xsl:when test="@action = 'single'">
					<div class="">
				<label class="control-label">
				<xsl:if test="@visible= 'false'">
				<xsl:attribute name="style">display:none</xsl:attribute>				
				</xsl:if>
				<xsl:attribute name="id">
							<xsl:value-of select="@id" />
						</xsl:attribute>
							<xsl:value-of select="@label" />
						<xsl:if test="@required = 'true'">
						*
					</xsl:if>	
					</label></div>
				</xsl:when>
				<xsl:otherwise>
				
					<div class="fielset">
									<label class="control-label">
				<xsl:if test="@visible= 'false'">
				<xsl:attribute name="style">display:none</xsl:attribute>				
				</xsl:if>
				<xsl:attribute name="id">
							<xsl:value-of select="@id" />
						</xsl:attribute>
							<xsl:value-of select="@label" />
							
						<xsl:if test="@required = 'true'">
						<span style="color:#f47920;">*</span>
					</xsl:if>	
					</label></div>
				
				</xsl:otherwise></xsl:choose>
					
					
					
				</xsl:if>
			
	</xsl:template>	
	<xsl:template match="items/option">
	<xsl:copy-of select="." /> 		  
	</xsl:template>
</xsl:stylesheet>