<%@ Page Language="C#" AutoEventWireup="True" Inherits="Umbraco.Web.UI.Config.Splashes.NoNodes" CodeBehind="NoNodes.aspx.cs" %>

<%@ Import Namespace="Umbraco.Core.Configuration" %>
<%@ Import Namespace="Umbraco.Core.IO" %>

<!doctype html>
<!--[if lt IE 7]> <html class="no-js ie6 oldie" lang="en"> <![endif]-->
<!--[if IE 7]>    <html class="no-js ie7 oldie" lang="en"> <![endif]-->
<!--[if IE 8]>    <html class="no-js ie8 oldie" lang="en"> <![endif]-->
<!--[if gt IE 8]><!-->
<html class="no-js" lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">

    <title></title>
    <meta name="description" content="">
    <meta name="author" content="">

    <link rel="stylesheet" href="../../Umbraco/assets/css/nonodes.style.min.css" />

</head>
<body>

    <section>
        <article>
            <div>
                <div class="logo"></div>

                <h1>Welcome to your Umbraco installation</h1>
                <h3>You're seeing the wonderful page because your website doesn't contain any published content yet.</h3>

                <div class="cta">
                    <a href="<%= IOHelper.ResolveUrl(SystemDirectories.Umbraco) %>/umbraco.aspx" class="button">Open Umbraco</a>
                </div>



            </div>
        </article>

    </section>

    <script src="https://code.jquery.com/jquery-latest.min.js"></script>

</body>
</html>
