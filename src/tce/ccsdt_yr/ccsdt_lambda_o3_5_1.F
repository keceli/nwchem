      SUBROUTINE ccsdt_lambda_o3_5_1(d_a,k_a_offset,d_b,k_b_offset,d_c,k
     &_c_offset)
C     $Id$
C     This is a Fortran77 program generated by Tensor Contraction Engine v.1.0
C     Copyright (c) Battelle & Pacific Northwest National Laboratory (2002)
C     i1 ( h4 h5 h6 h7 p1 p2 )_yt + = 1 * Sum ( p8 ) * t ( p8 h7 )_t * y ( h4 h5 h6 p1 p2 p8 )_y
      IMPLICIT NONE
#include "global.fh"
#include "mafdecls.fh"
#include "sym.fh"
#include "errquit.fh"
#include "tce.fh"
      INTEGER d_a
      INTEGER k_a_offset
      INTEGER d_b
      INTEGER k_b_offset
      INTEGER d_c
      INTEGER k_c_offset
      INTEGER NXTVAL
      INTEGER next
      INTEGER nprocs
      INTEGER count
      INTEGER h4b
      INTEGER h5b
      INTEGER h6b
      INTEGER p1b
      INTEGER p2b
      INTEGER h7b
      INTEGER dimc
      INTEGER l_c_sort
      INTEGER k_c_sort
      INTEGER p8b
      INTEGER p8b_1
      INTEGER h7b_1
      INTEGER h4b_2
      INTEGER h5b_2
      INTEGER h6b_2
      INTEGER p1b_2
      INTEGER p2b_2
      INTEGER p8b_2
      INTEGER dim_common
      INTEGER dima_sort
      INTEGER dima
      INTEGER dimb_sort
      INTEGER dimb
      INTEGER l_a_sort
      INTEGER k_a_sort
      INTEGER l_a
      INTEGER k_a
      INTEGER l_b_sort
      INTEGER k_b_sort
      INTEGER l_b
      INTEGER k_b
      INTEGER l_c
      INTEGER k_c
      EXTERNAL NXTVAL
      nprocs = GA_NNODES()
      count = 0
      next = NXTVAL(nprocs)
      DO h4b = 1,noab
      DO h5b = h4b,noab
      DO h6b = h5b,noab
      DO p1b = noab+1,noab+nvab
      DO p2b = p1b,noab+nvab
      DO h7b = 1,noab
      IF (next.eq.count) THEN
      IF ((.not.restricted).or.(int_mb(k_spin+h4b-1)+int_mb(k_spin+h5b-1
     &)+int_mb(k_spin+h6b-1)+int_mb(k_spin+p1b-1)+int_mb(k_spin+p2b-1)+i
     &nt_mb(k_spin+h7b-1).ne.12)) THEN
      IF (int_mb(k_spin+h4b-1)+int_mb(k_spin+h5b-1)+int_mb(k_spin+h6b-1)
     & .eq. int_mb(k_spin+p1b-1)+int_mb(k_spin+p2b-1)+int_mb(k_spin+h7b-
     &1)) THEN
      IF (ieor(int_mb(k_sym+h4b-1),ieor(int_mb(k_sym+h5b-1),ieor(int_mb(
     &k_sym+h6b-1),ieor(int_mb(k_sym+p1b-1),ieor(int_mb(k_sym+p2b-1),int
     &_mb(k_sym+h7b-1)))))) .eq. ieor(irrep_y,irrep_t)) THEN
      dimc = int_mb(k_range+h4b-1) * int_mb(k_range+h5b-1) * int_mb(k_ra
     &nge+h6b-1) * int_mb(k_range+p1b-1) * int_mb(k_range+p2b-1) * int_m
     &b(k_range+h7b-1)
      IF (.not.MA_PUSH_GET(mt_dbl,dimc,'noname',l_c_sort,k_c_sort)) CALL
     & ERRQUIT('ccsdt_lambda_o3_5_1',0,MA_ERR)
      CALL DFILL(dimc,0.0d0,dbl_mb(k_c_sort),1)
      DO p8b = noab+1,noab+nvab
      IF (int_mb(k_spin+p8b-1) .eq. int_mb(k_spin+h7b-1)) THEN
      IF (ieor(int_mb(k_sym+p8b-1),int_mb(k_sym+h7b-1)) .eq. irrep_t) TH
     &EN
      CALL TCE_RESTRICTED_2(p8b,h7b,p8b_1,h7b_1)
      CALL TCE_RESTRICTED_6(h4b,h5b,h6b,p1b,p2b,p8b,h4b_2,h5b_2,h6b_2,p1
     &b_2,p2b_2,p8b_2)
      dim_common = int_mb(k_range+p8b-1)
      dima_sort = int_mb(k_range+h7b-1)
      dima = dim_common * dima_sort
      dimb_sort = int_mb(k_range+h4b-1) * int_mb(k_range+h5b-1) * int_mb
     &(k_range+h6b-1) * int_mb(k_range+p1b-1) * int_mb(k_range+p2b-1)
      dimb = dim_common * dimb_sort
      IF ((dima .gt. 0) .and. (dimb .gt. 0)) THEN
      IF (.not.MA_PUSH_GET(mt_dbl,dima,'noname',l_a_sort,k_a_sort)) CALL
     & ERRQUIT('ccsdt_lambda_o3_5_1',1,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dima,'noname',l_a,k_a)) CALL ERRQUIT('
     &ccsdt_lambda_o3_5_1',2,MA_ERR)
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h7b_1
     & - 1 + noab * (p8b_1 - noab - 1)))
      CALL TCE_SORT_2(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p8b-1)
     &,int_mb(k_range+h7b-1),2,1,1.0d0)
      IF (.not.MA_POP_STACK(l_a)) CALL ERRQUIT('ccsdt_lambda_o3_5_1',3,M
     &A_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dimb,'noname',l_b_sort,k_b_sort)) CALL
     & ERRQUIT('ccsdt_lambda_o3_5_1',4,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dimb,'noname',l_b,k_b)) CALL ERRQUIT('
     &ccsdt_lambda_o3_5_1',5,MA_ERR)
      IF ((p8b .lt. p1b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p2b_2
     & - noab - 1 + nvab * (p1b_2 - noab - 1 + nvab * (p8b_2 - noab - 1 
     &+ nvab * (h6b_2 - 1 + noab * (h5b_2 - 1 + noab * (h4b_2 - 1)))))))
      CALL TCE_SORT_6(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h4b-1)
     &,int_mb(k_range+h5b-1),int_mb(k_range+h6b-1),int_mb(k_range+p8b-1)
     &,int_mb(k_range+p1b-1),int_mb(k_range+p2b-1),6,5,3,2,1,4,1.0d0)
      END IF
      IF ((p1b .le. p8b) .and. (p8b .lt. p2b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p2b_2
     & - noab - 1 + nvab * (p8b_2 - noab - 1 + nvab * (p1b_2 - noab - 1 
     &+ nvab * (h6b_2 - 1 + noab * (h5b_2 - 1 + noab * (h4b_2 - 1)))))))
      CALL TCE_SORT_6(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h4b-1)
     &,int_mb(k_range+h5b-1),int_mb(k_range+h6b-1),int_mb(k_range+p1b-1)
     &,int_mb(k_range+p8b-1),int_mb(k_range+p2b-1),6,4,3,2,1,5,-1.0d0)
      END IF
      IF ((p2b .le. p8b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p8b_2
     & - noab - 1 + nvab * (p2b_2 - noab - 1 + nvab * (p1b_2 - noab - 1 
     &+ nvab * (h6b_2 - 1 + noab * (h5b_2 - 1 + noab * (h4b_2 - 1)))))))
      CALL TCE_SORT_6(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h4b-1)
     &,int_mb(k_range+h5b-1),int_mb(k_range+h6b-1),int_mb(k_range+p1b-1)
     &,int_mb(k_range+p2b-1),int_mb(k_range+p8b-1),5,4,3,2,1,6,1.0d0)
      END IF
      IF (.not.MA_POP_STACK(l_b)) CALL ERRQUIT('ccsdt_lambda_o3_5_1',6,M
     &A_ERR)
      CALL DGEMM('T','N',dima_sort,dimb_sort,dim_common,1.0d0,dbl_mb(k_a
     &_sort),dim_common,dbl_mb(k_b_sort),dim_common,1.0d0,dbl_mb(k_c_sor
     &t),dima_sort)
      IF (.not.MA_POP_STACK(l_b_sort)) CALL ERRQUIT('ccsdt_lambda_o3_5_1
     &',7,MA_ERR)
      IF (.not.MA_POP_STACK(l_a_sort)) CALL ERRQUIT('ccsdt_lambda_o3_5_1
     &',8,MA_ERR)
      END IF
      END IF
      END IF
      END DO
      IF (.not.MA_PUSH_GET(mt_dbl,dimc,'noname',l_c,k_c)) CALL ERRQUIT('
     &ccsdt_lambda_o3_5_1',9,MA_ERR)
      CALL TCE_SORT_6(dbl_mb(k_c_sort),dbl_mb(k_c),int_mb(k_range+p2b-1)
     &,int_mb(k_range+p1b-1),int_mb(k_range+h6b-1),int_mb(k_range+h5b-1)
     &,int_mb(k_range+h4b-1),int_mb(k_range+h7b-1),5,4,3,2,1,6,1.0d0)
      CALL ADD_HASH_BLOCK(d_c,dbl_mb(k_c),dimc,int_mb(k_c_offset),(h7b -
     & 1 + noab * (p2b - noab - 1 + nvab * (p1b - noab - 1 + nvab * (h6b
     & - 1 + noab * (h5b - 1 + noab * (h4b - 1)))))))
      IF (.not.MA_POP_STACK(l_c)) CALL ERRQUIT('ccsdt_lambda_o3_5_1',10,
     &MA_ERR)
      IF (.not.MA_POP_STACK(l_c_sort)) CALL ERRQUIT('ccsdt_lambda_o3_5_1
     &',11,MA_ERR)
      END IF
      END IF
      END IF
      next = NXTVAL(nprocs)
      END IF
      count = count + 1
      END DO
      END DO
      END DO
      END DO
      END DO
      END DO
      next = NXTVAL(-nprocs)
      call GA_SYNC()
      RETURN
      END
