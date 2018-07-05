<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>동네북스에 오신 것을 환영합니다!</title>
<link rel="stylesheet" href="https://bootswatch.com/4/minty/bootstrap.min.css">
</head>
<body>
<jsp:include page="include/header.jsp"/>
<div class="container">
	<div class="row">
		<div class="col-sm-12">
			<div class="jumbotron">
  <h1 class="display-6">Welcome to DongneBooks!</h1>
  <p class="lead">This is a simple hero unit, a simple jumbotron-style component for calling extra attention to featured content or information.</p>
  <hr class="my-4">
  <p>It uses utility classes for typography and spacing to space content out within the larger container.</p>
</div>
		</div>
  </div>

	<div class="row">
		<div class="col-sm-9">

		</div>
		<div class="col-sm-3">
		<jsp:include page="include/right.jsp"/>
		</div>
	</div>
</div>
<jsp:include page="include/footer.jsp"/>
<!-- script library -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
</body>
</html>