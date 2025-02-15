      SUBROUTINE beta_3_7_1(d_a,k_a_offset,d_b,k_b_offset,d_c,k_c_offset
     &)
C     $Id$
C     This is a Fortran77 program generated by Tensor Contraction Engine v.1.0
C     Copyright (c) Battelle & Pacific Northwest National Laboratory (2002)
C     i1 ( p10 p13 h9 h12 )_ytrbtra + = -1 * Sum ( p1 ) * tra ( p1 p10 h9 h12 )_tra * i2 ( p13 p1 )_ytrb
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
      INTEGER p10b
      INTEGER p13b
      INTEGER h9b
      INTEGER h12b
      INTEGER dimc
      INTEGER l_c_sort
      INTEGER k_c_sort
      INTEGER p1b
      INTEGER p10b_1
      INTEGER p1b_1
      INTEGER h9b_1
      INTEGER h12b_1
      INTEGER p13b_2
      INTEGER p1b_2
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
      DO p10b = noab+1,noab+nvab
      DO p13b = noab+1,noab+nvab
      DO h9b = 1,noab
      DO h12b = h9b,noab
      IF (next.eq.count) THEN
      IF ((.not.restricted).or.(int_mb(k_spin+p10b-1)+int_mb(k_spin+p13b
     &-1)+int_mb(k_spin+h9b-1)+int_mb(k_spin+h12b-1).ne.8)) THEN
      IF (int_mb(k_spin+p10b-1)+int_mb(k_spin+p13b-1) .eq. int_mb(k_spin
     &+h9b-1)+int_mb(k_spin+h12b-1)) THEN
      IF (ieor(int_mb(k_sym+p10b-1),ieor(int_mb(k_sym+p13b-1),ieor(int_m
     &b(k_sym+h9b-1),int_mb(k_sym+h12b-1)))) .eq. ieor(irrep_y,ieor(irre
     &p_trb,irrep_tra))) THEN
      dimc = int_mb(k_range+p10b-1) * int_mb(k_range+p13b-1) * int_mb(k_
     &range+h9b-1) * int_mb(k_range+h12b-1)
      IF (.not.MA_PUSH_GET(mt_dbl,dimc,'noname',l_c_sort,k_c_sort)) CALL
     & ERRQUIT('beta_3_7_1',0,MA_ERR)
      CALL DFILL(dimc,0.0d0,dbl_mb(k_c_sort),1)
      DO p1b = noab+1,noab+nvab
      IF (int_mb(k_spin+p10b-1)+int_mb(k_spin+p1b-1) .eq. int_mb(k_spin+
     &h9b-1)+int_mb(k_spin+h12b-1)) THEN
      IF (ieor(int_mb(k_sym+p10b-1),ieor(int_mb(k_sym+p1b-1),ieor(int_mb
     &(k_sym+h9b-1),int_mb(k_sym+h12b-1)))) .eq. irrep_tra) THEN
      CALL TCE_RESTRICTED_4(p10b,p1b,h9b,h12b,p10b_1,p1b_1,h9b_1,h12b_1)
      CALL TCE_RESTRICTED_2(p13b,p1b,p13b_2,p1b_2)
      dim_common = int_mb(k_range+p1b-1)
      dima_sort = int_mb(k_range+p10b-1) * int_mb(k_range+h9b-1) * int_m
     &b(k_range+h12b-1)
      dima = dim_common * dima_sort
      dimb_sort = int_mb(k_range+p13b-1)
      dimb = dim_common * dimb_sort
      IF ((dima .gt. 0) .and. (dimb .gt. 0)) THEN
      IF (.not.MA_PUSH_GET(mt_dbl,dima,'noname',l_a_sort,k_a_sort)) CALL
     & ERRQUIT('beta_3_7_1',1,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dima,'noname',l_a,k_a)) CALL ERRQUIT('
     &beta_3_7_1',2,MA_ERR)
      IF ((p1b .le. p10b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h12b_
     &1 - 1 + noab * (h9b_1 - 1 + noab * (p10b_1 - noab - 1 + nvab * (p1
     &b_1 - noab - 1)))))
      CALL TCE_SORT_4(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p1b-1)
     &,int_mb(k_range+p10b-1),int_mb(k_range+h9b-1),int_mb(k_range+h12b-
     &1),4,3,2,1,1.0d0)
      END IF
      IF ((p10b .lt. p1b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h12b_
     &1 - 1 + noab * (h9b_1 - 1 + noab * (p1b_1 - noab - 1 + nvab * (p10
     &b_1 - noab - 1)))))
      CALL TCE_SORT_4(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p10b-1
     &),int_mb(k_range+p1b-1),int_mb(k_range+h9b-1),int_mb(k_range+h12b-
     &1),4,3,1,2,-1.0d0)
      END IF
      IF (.not.MA_POP_STACK(l_a)) CALL ERRQUIT('beta_3_7_1',3,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dimb,'noname',l_b_sort,k_b_sort)) CALL
     & ERRQUIT('beta_3_7_1',4,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dimb,'noname',l_b,k_b)) CALL ERRQUIT('
     &beta_3_7_1',5,MA_ERR)
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p1b_2
     & - noab - 1 + nvab * (p13b_2 - noab - 1)))
      CALL TCE_SORT_2(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+p13b-1
     &),int_mb(k_range+p1b-1),1,2,1.0d0)
      IF (.not.MA_POP_STACK(l_b)) CALL ERRQUIT('beta_3_7_1',6,MA_ERR)
      CALL DGEMM('T','N',dima_sort,dimb_sort,dim_common,1.0d0,dbl_mb(k_a
     &_sort),dim_common,dbl_mb(k_b_sort),dim_common,1.0d0,dbl_mb(k_c_sor
     &t),dima_sort)
      IF (.not.MA_POP_STACK(l_b_sort)) CALL ERRQUIT('beta_3_7_1',7,MA_ER
     &R)
      IF (.not.MA_POP_STACK(l_a_sort)) CALL ERRQUIT('beta_3_7_1',8,MA_ER
     &R)
      END IF
      END IF
      END IF
      END DO
      IF (.not.MA_PUSH_GET(mt_dbl,dimc,'noname',l_c,k_c)) CALL ERRQUIT('
     &beta_3_7_1',9,MA_ERR)
      IF ((p10b .le. p13b)) THEN
      CALL TCE_SORT_4(dbl_mb(k_c_sort),dbl_mb(k_c),int_mb(k_range+p13b-1
     &),int_mb(k_range+h12b-1),int_mb(k_range+h9b-1),int_mb(k_range+p10b
     &-1),4,1,3,2,-1.0d0/2.0d0)
      CALL ADD_HASH_BLOCK(d_c,dbl_mb(k_c),dimc,int_mb(k_c_offset),(h12b 
     &- 1 + noab * (h9b - 1 + noab * (p13b - noab - 1 + nvab * (p10b - n
     &oab - 1)))))
      END IF
      IF ((p13b .le. p10b)) THEN
      CALL TCE_SORT_4(dbl_mb(k_c_sort),dbl_mb(k_c),int_mb(k_range+p13b-1
     &),int_mb(k_range+h12b-1),int_mb(k_range+h9b-1),int_mb(k_range+p10b
     &-1),1,4,3,2,1.0d0/2.0d0)
      CALL ADD_HASH_BLOCK(d_c,dbl_mb(k_c),dimc,int_mb(k_c_offset),(h12b 
     &- 1 + noab * (h9b - 1 + noab * (p10b - noab - 1 + nvab * (p13b - n
     &oab - 1)))))
      END IF
      IF (.not.MA_POP_STACK(l_c)) CALL ERRQUIT('beta_3_7_1',10,MA_ERR)
      IF (.not.MA_POP_STACK(l_c_sort)) CALL ERRQUIT('beta_3_7_1',11,MA_E
     &RR)
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
      next = NXTVAL(-nprocs)
      call GA_SYNC()
      RETURN
      END
