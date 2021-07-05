# MS-Graph API integration

## Description
Integration template between Linx and the Microsoft Graph API.


## Installation
### Pre-requisites

- Linx Designer
- Azure account
- Microsoft 365 account
- SQL Server Database


### Database setup

1. Run the create scripts.

### Register a new app on Azure

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

### Generate a Client Secret
Now that we’ve registered an App on Azure, we now have to generate a **client secret** which is a set of characters that identifies your App when requesting for tokens. This will be used in conjunction with the client identifiers generated earlier.

1. On the new App’s overview page, navigate to **Certificates and secrets**.
2. Next, under the ‘Client secrets’ section, click on **+New Client Secret**.
3. Give your secret description as well as an expiry period and click **Add**.
4. Once generated, your client secret will be displayed. Copy the **Value** and save it in a secure location for the next section.

### Configure the Solution's $.Settings

1. Open the [sample Solution](Solution.lsoz) in your Linx Designer.
1. Edit the $.Settings values:

   - `linx_database_conn_string`: Connection string used for storing and retrieving the authentication token from a database. .
   - `microsoft_app_client_id`: Your connected app’s `Client ID`.
   - `microsoft_app_client_secret`: Your connected app’s `Client Secret`.
   - `microsoft_app_scopes`: Access scopes of the app.
   - `microsoft_app_tenantID`: Tenant identifier - referred to as the Directory ID or the Tenant ID on the App's overview page.

1. Save the Solution.

### Generate access tokens

1. Start the debugger on the RESTHost service in the Linx Designer.
2. Make a request in your browser to `http://localhost:8080/microsoft/oauth/authorize`
3. You will be redirected to the Office 365 OAuth 2.0 access consent screen.
4. Authorize the connected application.
5. View success message.

## Usage

### GetApplication

Makes a `GET` request to the `/applications` endpoint and returns the details of the authorized application.

## Contributing

For questions please ask the [Linx community](https://linx/software/community) or use the [Slack channel](https://linxsoftware.slack.com/archives/C01FLBC1XNX). 

## License

[MIT](https://github.com/linx-software/template-repo/blob/main/LICENSE.txt)





