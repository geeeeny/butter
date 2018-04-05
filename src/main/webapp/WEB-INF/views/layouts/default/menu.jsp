<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:url value="/" var="root"/>

<nav class="navbar navbar-expand-md bg-dark navbar-dark">
  <!-- Brand -->
  <a class="navbar-brand" href="#">Seojin :D</a>

  <!-- Toggler/collapsibe Button -->
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
    <span class="navbar-toggler-icon"></span>
  </button>
	
  <!-- Navbar links -->
  <div class="collapse navbar-collapse" id="collapsibleNavbar">
    <ul class="navbar-nav">
      <li class="nav-item">
        <a class="nav-link" href="${root}login">Login</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="${root}join">Join</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="${root}gallery">Gallery</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="${root}flickr">Flickr</a>
      </li> 
    </ul>
  </div> 
</nav>