<?xml version="1.0" encoding="ISO-8859-1"?>
<ncl id="main" xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">
  <head>
    <regionBase>
    	<region id="rgTitulo" width="100%" height="20%" left="0" top="0" />
        <region id="rgImg1" width="50%" height="50%" left="0" top="20%" />
        <region id="rgImg2" width="50%" height="50%" left="50%" top="20%" />
        <region id="rgLua"  width="100%" height="30%" left="0" top="70%" />
    </regionBase>

    <descriptorBase>
    	<descriptor id="dTitulo" region="rgTitulo" />
        <descriptor id="dImg1" region="rgImg1" />
        <descriptor id="dImg2" region="rgImg2" />
        <descriptor id="dLua"  region="rgLua" />
    </descriptorBase>

    <connectorBase>
 		<importBase alias="conn" documentURI="ConnectorBase.ncl">
		</importBase>   
    </connectorBase>
  </head>

  <body>
      <port id="pInicio" component="lua"/>

	  <media id="titulo" src="media/titulo.txt" descriptor="dTitulo">
	 		<property name="fontSize" value="20">
			</property>
	  </media>
      <media id="img1" src="media/img1.jpg" descriptor="dImg1"/>
      <media id="img2" src="media/img2.jpg" descriptor="dImg2"/>

      <media id="lua" src="main.lua" descriptor="dLua">
          <property name="sinal1"/>
          <property name="sinal2"/>
      </media>
      
      <link xconnector="conn#onBeginStart">
          <bind role="onBegin" component="lua"/>
          <bind role="start" component="titulo" />
      </link>

      <link xconnector="conn#onEndAttributionStart">
          <bind role="onEndAttribution" component="lua" interface="sinal1"/>
          <bind role="start" component="img1" />
      </link>

      <link xconnector="conn#onEndAttributionStart">
          <bind role="onEndAttribution" component="lua" interface="sinal2"/>
          <bind role="start" component="img2" />
      </link>
      
      <link xconnector="conn#onKeySelectionStopN">
		<bind component="titulo" role="onSelection">
			<bindParam name="keyCode" value="RED">
			</bindParam>
		</bind>
		<bind component="img1" role="stop"/>
		<bind component="img2" role="stop"/>
		</link>
  </body>
</ncl>