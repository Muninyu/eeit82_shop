package com.example.demo.repository;



import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.example.demo.Checkinlogs;

@Repository
public interface CheckinDao extends JpaRepository<Checkinlogs, Integer> {

	
	@Query(value = "SELECT c.* FROM Checkinlogs c JOIN Users u ON c.user_id = u.user_id WHERE u.user_id = :userId", nativeQuery = true)                              
    List<Checkinlogs> findByUserId(@Param("userId") int userId);
	
	@Query(value = "SELECT (CASE WHEN (SELECT COUNT(*) FROM Checkinlogs c WHERE c.user_id = :userId AND c.checkin_date = CURRENT_DATE) > 0 THEN 'true' ELSE 'false' END) ", nativeQuery = true)
    boolean existsByUserIdAndCheckinDateToday(@Param("userId") int userId);
}

