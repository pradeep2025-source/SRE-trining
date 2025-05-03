# Use official Tomcat base image
FROM tomcat:9.0

# Remove default webapps (optional cleanup)
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the WAR file from Maven target directory to Tomcat webapps as ROOT.war
COPY target/my-webapp-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war

# Expose default Tomcat port
EXPOSE 8080

# Start Tomcat server
CMD ["catalina.sh", "run"]
