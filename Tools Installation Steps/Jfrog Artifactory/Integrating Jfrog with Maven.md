# **Integrating Jfrog with Maven**

## **Prerequisites**
Before integrating Jfrog with Maven, ensure the following are installed:

- **Java** (JDK 11 or higher)
- **Maven**
- **Jfrog is up and running**

---

### **Step 1: Clone the Repository**  
```sh
git clone https://github.com/techworldwithmurali/user-registration.git
```

---

## **Step 2: Configure `pom.xml` to Use artifactory**
Modify your project’s `pom.xml` file to point to the artifactory repository.

### **Distribution Management Configuration**
Add the following section to deploy artifacts to artifactory:

```xml
<distributionManagement>
    <snapshotRepository>
        <id>artifactory-snapshots</id>
        <url>https://artifactory.techworldwithmurali.in/artifactory/maven-snapshots/</url>
    </snapshotRepository>
    <repository>
        <id>artifactory-releases</id>
        <url>https://artifactory.techworldwithmurali.in/artifactory/maven-releases/</url>
    </repository>
</distributionManagement>
```
---
## **Step 3: Configure Maven to Use artifactory**
Modify the `settings.xml` file in your Maven installation (`$MAVEN_HOME/conf/settings.xml`) or user home (`~/.m2/settings.xml`).

### **Add artifactory Repository Credentials**
Ensure Maven can authenticate with artifactory by adding the following to the `<servers>` section of `settings.xml`:

```xml
<servers>
    <server>
        <id>artifactory-snapshots</id>
        <username>admin</username>
        <password>Admin@2580</password>
    </server>
    <server>
        <id>artifactory-releases</id>
        <username>admin</username>
        <password>Admin@2580</password>
    </server>
</servers>
```
---

## **3. Deploy Artifacts to artifactory**
To upload an artifact to artifactory, run:

```sh
mvn clean deploy
```

Make sure your `pom.xml` includes the **Maven Deploy Plugin**:

```xml
<build>
    <plugins>
        <plugin>
            <artifactId>maven-deploy-plugin</artifactId>
            <version>2.8.2</version>
        </plugin>
    </plugins>
</build>
```

---

## **4. Verify Deployment**
1. Open your artifactory UI at:
   ```
   https://artifactory.techworldwithmurali.in/
   ```
2. Log in with your **admin** credentials.

### Congratulations! You have successfully integrated JFrog with Maven, and now we can see the artifacts in JFrog.
