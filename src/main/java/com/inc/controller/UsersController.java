package com.inc.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.inc.service.UsersService;

@Controller
public class UsersController {
	@Autowired
	private UsersService usersService;
}
