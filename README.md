# MS-Graph API integration

## Overview

The provided sample includes:

- Generating MS Graph API access tokens via OAuth 2.0.
- Authenticating and connecting to the MS Graph API via Linx
- Template requests: Retrieving and sending data to the MS Graph API via HTTP requests.

---

### Additional resources

- [MS Graph - Linx integration guide](https://community.linx.software/community/t/connecting-to-microsoft-graph-api/499)
- [MS Graph API authentication documentation](https://docs.microsoft.com/en-us/graph/auth/auth-concepts)

---

## Dependencies

### Pre-requisites

- Linx Designer
- Azure account
- Microsoft 365 account
- SQL Server Database

### Linx Designer

This solution was developed in the Linx Designer `v5.20.2.0`

### Database

The solution uses a SQL server database to store the authentication tokens in a table `[dbo].[tblToken]` with the below structure:

```sql
IF OBJECT_ID(N'dbo.tblToken', N'U') IS  NULL
BEGIN
   CREATE TABLE [dbo].[tblToken](
   [ID] INT IDENTITY(1,1) NOT NULL,
   [platform] VARCHAR(500) NULL,
   [platform_id] VARCHAR(500) NULL,
   [state] VARCHAR(500) NULL,
   [code_verifier] VARCHAR(500) NULL,
   [code_challenge] VARCHAR(500) NULL,
   [token_object] VARCHAR(8000) NULL,
   [token_type]  VARCHAR(500) NULL,
   [access_token] VARCHAR(8000) NULL,
   [refresh_token] VARCHAR(8000) NULL,
   [expires_in] INT NULL,
   [expiry_time] DATETIME NULL,
   [last_updated] DATETIME NULL
) ON [PRIMARY]
END
```

The above CREATE [script](create_table_scipts.sql) is automatically executed inside Linx when the tokens are generated.

---

## Setting up the sample

Register a new app on Azure:

1. Login to the <a href="https://portal.azure.com/#blade/Microsoft_AAD_IAM/ActiveDirectoryMenuBlade/Overview">Microsoft Azure Portal</a>.
2. Open the App Registrations tab (Left Menu bar > Manage > **App registrations**).
3. Click on the **+ New Registration** button at the top of the screen.

4. Give the connected application a name such as "LinxDemoApp" and appropriate account type.
5. For the **Redirect URI** set the type to `Web` and add the following:
   ```
   http://localhost:8080/microsoft/oauth/token
   ```
6. Click **Register** at the bottom of the screen.

   Your connected application has now been registered and the client identifiers are displayed on the screen.

7. Copy and store the **Application ID** (Client ID) and **Directory ID** (Tenant ID) for later use.

Generate a Client Secret
Now that we’ve registered an App on Azure, we now have to generate a **client secret** which is a set of characters that identifies your App when requesting for tokens. This will be used in conjunction with the client identifiers generated earlier.

1. On the new App’s overview page, navigate to **Certificates and secrets**.
2. Next, under the ‘Client secrets’ section, click on **+New Client Secret**.
3. Give your secret description as well as an expiry period and click **Add**.
4. Once generated, your client secret will be displayed. Copy the **Value** and save it in a secure location for the next section.

Configure the Solution's $.Settings:

1. Open the [sample Solution](Solution.lsoz) in your Linx Designer.
1. Edit the $.Settings values:

   - `linx_database_conn_string`: Connection string used for storing and retrieving the authentication token from a database. .
   - `microsoft_app_client_id`: Your connected app’s `Client ID`.
   - `microsoft_app_client_secret`: Your connected app’s `Client Secret`.
   - `microsoft_app_scopes`: Access scopes of the app.
   - `microsoft_app_tenantID`: Tenant identifier - referred to as the Directory ID or the Tenant ID on the App's overview page.

1. Save the Solution.

Generate access tokens:

1. Start the debugger on the RESTHost service in the Linx Designer.
2. Make a request in your browser to `http://localhost:8080/microsoft/oauth/authorize`
3. You will be redirected to the Office 365 OAuth 2.0 access consent screen.
4. Authorize the connected application.
5. View success message.

---

## Using the sample

### Authentication

In order to authenticate the request, include the `Authorization` header containing the access token generated in the previous step like below:

```
Authorization: "Bearer " + {access token}
```

In the provided sample Solution, the access token is for retrieved from the database before each request is made.

The retrieved access token is then submitted in the `Authorization` header:

```
= "Bearer " +   RetrieveToken_database.token.access_token
```

---

## Template HTTP requests

The following custom functions wrap the different types of HTTP calls into their own re-usable functions which can be thought of as 'custom MS Graph connectors'.

---

### GetApplication

Makes a `GET` request to the `/applications` endpoint and returns the details of the authorized application.
