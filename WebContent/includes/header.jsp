<html>
<head>
<title> Sofiya Agencies - Billing System </title>

<% 
String baseURL = "/billing/";
%>

<link rel="stylesheet" href="<%=baseURL%>css/bootstrap-4.0.0-alpha.6.min.css">
<link href = "<%=baseURL%>css/bootstrap-autocomplete.css" rel = "stylesheet">
<link href = "<%=baseURL%>css/datepicker.css" rel = "stylesheet"> 
<link href = "<%=baseURL%>css/app-styles.css" rel = "stylesheet">

<script type="text/javascript" src="<%=baseURL%>js/jquery-3.2.1.js"></script>
<script src="<%=baseURL%>js/bootstrap-4.0.0-alpha.6.min.js" ></script>

 
<script src = "<%=baseURL%>js/bootstrap-autocomplete.js"></script>
<script src = "<%=baseURL%>js/bootstrap-datepicker.js"></script>


<script type = "text/javascript">
var jsVarbaseURL = "<%=baseURL%>";
</script>
</head>
<body>

<nav class="navbar navbar-toggleable-md navbar-inverse bg-inverse">
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarTogglerDemo01" aria-controls="navbarTogglerDemo01" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="navbarTogglerDemo01">
    <a class="navbar-brand" href="#">Sofiya Agencies</a>
    <ul class="navbar-nav mr-auto mt-2 mt-lg-0">
      <li class="nav-item active">
        <a class="nav-link" href = "<%=baseURL%>modules/customer-details.jsp">Customers <span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href = "<%=baseURL%>modules/supplier-details.jsp">Suppliers</a>
      </li>
      <li class="nav-item">
        <a class="nav-link " href = "<%=baseURL%>modules/stock-details.jsp">Stock</a>
      </li>
       <li class="nav-item">
        <a class="nav-link " href = "<%=baseURL%>modules/invoice-entry-view.jsp">New Invoice</a>
      </li>
    </ul>
    <!-- <form class="form-inline my-2 my-lg-0">
      <input class="form-control mr-sm-2" type="text" placeholder="Search">
      <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
    </form> -->
  </div>
</nav>

