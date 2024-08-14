package com.example.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.demo.ContactUs;



@Repository
public interface ContactUsDao extends JpaRepository<ContactUs, Integer> {

}
