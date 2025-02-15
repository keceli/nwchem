      SUBROUTINE ccsdt_lr_beta_2_8_31_1(d_a,k_a_offset,d_b,k_b_offset,d_
     &c,k_c_offset)
C     $Id$
C     This is a Fortran77 program generated by Tensor Contraction Engine v.1.0
C     Copyright (c) Battelle & Pacific Northwest National Laboratory (2002)
C     i2 ( h10 p11 h14 h15 )_ytrbt + = 1 * Sum ( p5 p6 ) * t ( p5 p6 h14 h15 )_t * i3 ( h10 p11 p5 p6 )_ytrb
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
      INTEGER h10b
      INTEGER p11b
      INTEGER h14b
      INTEGER h15b
      INTEGER dimc
      INTEGER l_c_sort
      INTEGER k_c_sort
      INTEGER p5b
      INTEGER p6b
      INTEGER p5b_1
      INTEGER p6b_1
      INTEGER h14b_1
      INTEGER h15b_1
      INTEGER h10b_2
      INTEGER p11b_2
      INTEGER p5b_2
      INTEGER p6b_2
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
      INTEGER nsuperp(2)
      INTEGER isuperp
      INTEGER l_c
      INTEGER k_c
      DOUBLE PRECISION FACTORIAL
      EXTERNAL NXTVAL
      EXTERNAL FACTORIAL
      nprocs = GA_NNODES()
      count = 0
      next = NXTVAL(nprocs)
      DO h10b = 1,noab
      DO p11b = noab+1,noab+nvab
      DO h14b = 1,noab
      DO h15b = h14b,noab
      IF (next.eq.count) THEN
      IF ((.not.restricted).or.(int_mb(k_spin+h10b-1)+int_mb(k_spin+p11b
     &-1)+int_mb(k_spin+h14b-1)+int_mb(k_spin+h15b-1).ne.8)) THEN
      IF (int_mb(k_spin+h10b-1)+int_mb(k_spin+p11b-1) .eq. int_mb(k_spin
     &+h14b-1)+int_mb(k_spin+h15b-1)) THEN
      IF (ieor(int_mb(k_sym+h10b-1),ieor(int_mb(k_sym+p11b-1),ieor(int_m
     &b(k_sym+h14b-1),int_mb(k_sym+h15b-1)))) .eq. ieor(irrep_y,ieor(irr
     &ep_trb,irrep_t))) THEN
      dimc = int_mb(k_range+h10b-1) * int_mb(k_range+p11b-1) * int_mb(k_
     &range+h14b-1) * int_mb(k_range+h15b-1)
      IF (.not.MA_PUSH_GET(mt_dbl,dimc,'noname',l_c_sort,k_c_sort)) CALL
     & ERRQUIT('ccsdt_lr_beta_2_8_31_1',0,MA_ERR)
      CALL DFILL(dimc,0.0d0,dbl_mb(k_c_sort),1)
      DO p5b = noab+1,noab+nvab
      DO p6b = p5b,noab+nvab
      IF (int_mb(k_spin+p5b-1)+int_mb(k_spin+p6b-1) .eq. int_mb(k_spin+h
     &14b-1)+int_mb(k_spin+h15b-1)) THEN
      IF (ieor(int_mb(k_sym+p5b-1),ieor(int_mb(k_sym+p6b-1),ieor(int_mb(
     &k_sym+h14b-1),int_mb(k_sym+h15b-1)))) .eq. irrep_t) THEN
      CALL TCE_RESTRICTED_4(p5b,p6b,h14b,h15b,p5b_1,p6b_1,h14b_1,h15b_1)
      CALL TCE_RESTRICTED_4(h10b,p11b,p5b,p6b,h10b_2,p11b_2,p5b_2,p6b_2)
      dim_common = int_mb(k_range+p5b-1) * int_mb(k_range+p6b-1)
      dima_sort = int_mb(k_range+h14b-1) * int_mb(k_range+h15b-1)
      dima = dim_common * dima_sort
      dimb_sort = int_mb(k_range+h10b-1) * int_mb(k_range+p11b-1)
      dimb = dim_common * dimb_sort
      IF ((dima .gt. 0) .and. (dimb .gt. 0)) THEN
      IF (.not.MA_PUSH_GET(mt_dbl,dima,'noname',l_a_sort,k_a_sort)) CALL
     & ERRQUIT('ccsdt_lr_beta_2_8_31_1',1,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dima,'noname',l_a,k_a)) CALL ERRQUIT('
     &ccsdt_lr_beta_2_8_31_1',2,MA_ERR)
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h15b_
     &1 - 1 + noab * (h14b_1 - 1 + noab * (p6b_1 - noab - 1 + nvab * (p5
     &b_1 - noab - 1)))))
      CALL TCE_SORT_4(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p5b-1)
     &,int_mb(k_range+p6b-1),int_mb(k_range+h14b-1),int_mb(k_range+h15b-
     &1),4,3,2,1,1.0d0)
      IF (.not.MA_POP_STACK(l_a)) CALL ERRQUIT('ccsdt_lr_beta_2_8_31_1',
     &3,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dimb,'noname',l_b_sort,k_b_sort)) CALL
     & ERRQUIT('ccsdt_lr_beta_2_8_31_1',4,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dimb,'noname',l_b,k_b)) CALL ERRQUIT('
     &ccsdt_lr_beta_2_8_31_1',5,MA_ERR)
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p6b_2
     & - noab - 1 + nvab * (p5b_2 - noab - 1 + nvab * (p11b_2 - noab - 1
     & + nvab * (h10b_2 - 1)))))
      CALL TCE_SORT_4(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h10b-1
     &),int_mb(k_range+p11b-1),int_mb(k_range+p5b-1),int_mb(k_range+p6b-
     &1),2,1,4,3,1.0d0)
      IF (.not.MA_POP_STACK(l_b)) CALL ERRQUIT('ccsdt_lr_beta_2_8_31_1',
     &6,MA_ERR)
      nsuperp(1) = 1
      nsuperp(2) = 1
      isuperp = 1
      IF (p5b .eq. p6b) THEN
      nsuperp(isuperp) = nsuperp(isuperp) + 1
      ELSE
      isuperp = isuperp + 1
      END IF
      CALL DGEMM('T','N',dima_sort,dimb_sort,dim_common,2.0d0/FACTORIAL(
     &nsuperp(1))/FACTORIAL(nsuperp(2)),dbl_mb(k_a_sort),dim_common,dbl_
     &mb(k_b_sort),dim_common,1.0d0,dbl_mb(k_c_sort),dima_sort)
      IF (.not.MA_POP_STACK(l_b_sort)) CALL ERRQUIT('ccsdt_lr_beta_2_8_3
     &1_1',7,MA_ERR)
      IF (.not.MA_POP_STACK(l_a_sort)) CALL ERRQUIT('ccsdt_lr_beta_2_8_3
     &1_1',8,MA_ERR)
      END IF
      END IF
      END IF
      END DO
      END DO
      IF (.not.MA_PUSH_GET(mt_dbl,dimc,'noname',l_c,k_c)) CALL ERRQUIT('
     &ccsdt_lr_beta_2_8_31_1',9,MA_ERR)
      CALL TCE_SORT_4(dbl_mb(k_c_sort),dbl_mb(k_c),int_mb(k_range+p11b-1
     &),int_mb(k_range+h10b-1),int_mb(k_range+h15b-1),int_mb(k_range+h14
     &b-1),2,1,4,3,1.0d0)
      CALL ADD_HASH_BLOCK(d_c,dbl_mb(k_c),dimc,int_mb(k_c_offset),(h15b 
     &- 1 + noab * (h14b - 1 + noab * (p11b - noab - 1 + nvab * (h10b - 
     &1)))))
      IF (.not.MA_POP_STACK(l_c)) CALL ERRQUIT('ccsdt_lr_beta_2_8_31_1',
     &10,MA_ERR)
      IF (.not.MA_POP_STACK(l_c_sort)) CALL ERRQUIT('ccsdt_lr_beta_2_8_3
     &1_1',11,MA_ERR)
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
