package com.example.demo.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.ContactUs;
import com.example.demo.repository.ContactUsDao;


@Service
public class ContactUsService {

	
	@Autowired
    private ContactUsDao contactUsDao;

    public void saveContactUs(ContactUs contactUs) {
    	contactUsDao.save(contactUs);
    }
    
 // 新增读取所有联络记录的方法
    public List<ContactUs> findAll() {
        return contactUsDao.findAll();
    }

    // 新增通过ID读取联络记录的方法
    public Optional<ContactUs> findById(Integer id) {
        return contactUsDao.findById(id);
    }
}
