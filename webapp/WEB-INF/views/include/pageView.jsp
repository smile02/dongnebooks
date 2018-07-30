<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
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
<link
	href="https://stackpath.bootstrapcdn.com/bootswatch/4.1.1/minty/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-4eGtnTOp6je5m6l1Zcp2WUGR9Y7kJZuAiD3Pk2GAW3uNRgHQSIqcrcAxBipzlbWP"
	crossorigin="anonymous">
<link rel="stylesheet" href="/css/style.css" />
<style>
.carousel-inner img {
      width: 100%;
      height: 300px;
  }
</style>
</head>
<body>

<div id="demo" class="carousel slide" data-ride="carousel">
  <ul class="carousel-indicators">
    <li data-target="#demo" data-slide-to="0" class="active"></li>
    <li data-target="#demo" data-slide-to="1"></li>
    <li data-target="#demo" data-slide-to="2"></li>
    <li data-target="#demo" data-slide-to="3"></li>
    <li data-target="#demo" data-slide-to="4"></li>
  </ul>
  <div class="carousel-inner">
    <div class="carousel-item active">
      <img src="/image/photo/main_photo1.jpg" alt="Los Angeles">
      <div class="carousel-caption">
        <h3>메인화면</h3>
        <p>최근등록된 도서와 게시판의 내용을 볼 수있습니다.</p>
      </div>   
    </div>
    <div class="carousel-item">
      <img src="/image/photo/main_photo2.jpg" alt="Chicago">
      <div class="carousel-caption">
        <h3>소개화면</h3>
        <p>Dongnebooks의 소개페이지입니다.</p>
      </div>   
    </div>
    <div class="carousel-item">
      <img src="/image/photo/main_photo3.jpg" alt="New York">
      <div class="carousel-caption">
        <h3>도서등록화면</h3>
        <p>도서를 등록하거나 수정,구매할 수 있으며 댓글을 달 수 있습니다.</p>
      </div>   
    </div>
    <div class="carousel-item">
      <img src="/image/photo/main_photo4.jpg" alt="New York">
      <div class="carousel-caption">
        <h3>게시판화면</h3>
        <p>질문,신고,일반적인 내용을 작성할 수 있습니다.</p>
      </div>   
    </div>
    <div class="carousel-item">
      <img src="/image/photo/main_photo5.jpg" alt="New York">
      <div class="carousel-caption">
        <h3>New York</h3>
        <p>We love the Big Apple!</p>
      </div>   
    </div>
  </div>
  <a class="carousel-control-prev" href="#demo" data-slide="prev">
    <span class="carousel-control-prev-icon"></span>
  </a>
  <a class="carousel-control-next" href="#demo" data-slide="next">
    <span class="carousel-control-next-icon"></span>
  </a>
</div>

		<script
			src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
		<script
			src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
		<script
			src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
</body>
</html>