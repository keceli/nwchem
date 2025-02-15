      SUBROUTINE eomccsd_2pdm_hppp_mo(d_i0,d_t1,d_x0,d_x1,d_y2,k_i0_offs
     &et,k_t1_offset,k_x0_offset,k_x1_offset,k_y2_offset)
C     $Id$
C     This is a Fortran77 program generated by Tensor Contraction Engine v.1.0
C     Copyright (c) Battelle & Pacific Northwest National Laboratory (2002)
C     i0 ( h4 p1 p2 p3 )_yx + = -1/2 * P( 2 ) * Sum ( h5 ) * x ( p1 h5 )_x * y ( h4 h5 p2 p3 )_y
C     i0 ( h4 p3 p1 p2 )_xty + = -1/2 * P( 2 ) * Sum ( h5 ) * y ( h4 h5 p1 p2 )_y * i1 ( p3 h5 )_xt
C         i1 ( p1 h5 )_xt + = 1 * t ( p1 h5 )_t * x ( )_x
      IMPLICIT NONE
#include "global.fh"
#include "mafdecls.fh"
#include "util.fh"
#include "errquit.fh"
#include "tce.fh"
      INTEGER d_i0
      INTEGER k_i0_offset
      INTEGER d_x1
      INTEGER k_x1_offset
      INTEGER d_y2
      INTEGER k_y2_offset
      INTEGER d_i1
      INTEGER k_i1_offset
      INTEGER l_i1_offset
      INTEGER d_t1
      INTEGER k_t1_offset
      INTEGER d_x0
      INTEGER k_x0_offset
      INTEGER size_i1
      CHARACTER*255 filename
      CALL eomccsd_2pdm_hppp_mo_1(d_x1,k_x1_offset,d_y2,k_y2_offset,d_i0
     &,k_i0_offset)
      CALL OFFSET_eomccsd_2pdm_hppp_mo_2_1(l_i1_offset,k_i1_offset,size_
     &i1)
      CALL TCE_FILENAME('eomccsd_2pdm_hppp_mo_2_1_i1',filename)
      CALL CREATEFILE(filename,d_i1,size_i1)
      CALL eomccsd_2pdm_hppp_mo_2_1(d_t1,k_t1_offset,d_x0,k_x0_offset,d_
     &i1,k_i1_offset)
      CALL RECONCILEFILE(d_i1,size_i1)
      CALL eomccsd_2pdm_hppp_mo_2(d_y2,k_y2_offset,d_i1,k_i1_offset,d_i0
     &,k_i0_offset)
      CALL DELETEFILE(d_i1)
      IF (.not.MA_POP_STACK(l_i1_offset)) CALL ERRQUIT('eomccsd_2pdm_hpp
     &p_mo',-1,MA_ERR)
      RETURN
      END
      SUBROUTINE eomccsd_2pdm_hppp_mo_1(d_a,k_a_offset,d_b,k_b_offset,d_
     &c,k_c_offset)
C     $Id$
C     This is a Fortran77 program generated by Tensor Contraction Engine v.1.0
C     Copyright (c) Battelle & Pacific Northwest National Laboratory (2002)
C     i0 ( h4 p1 p2 p3 )_yx + = -1/2 * P( 2 ) * Sum ( h5 ) * x ( p1 h5 )_x * y ( h4 h5 p2 p3 )_y
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
      INTEGER p1b
      INTEGER h4b
      INTEGER p2b
      INTEGER p3b
      INTEGER dimc
      INTEGER l_c_sort
      INTEGER k_c_sort
      INTEGER h5b
      INTEGER p1b_1
      INTEGER h5b_1
      INTEGER h4b_2
      INTEGER h5b_2
      INTEGER p2b_2
      INTEGER p3b_2
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
      DO p1b = noab+1,noab+nvab
      DO h4b = 1,noab
      DO p2b = noab+1,noab+nvab
      DO p3b = p2b,noab+nvab
      IF (next.eq.count) THEN
      IF ((.not.restricted).or.(int_mb(k_spin+h4b-1)+int_mb(k_spin+p1b-1
     &)+int_mb(k_spin+p2b-1)+int_mb(k_spin+p3b-1).ne.8)) THEN
      IF (int_mb(k_spin+h4b-1)+int_mb(k_spin+p1b-1) .eq. int_mb(k_spin+p
     &2b-1)+int_mb(k_spin+p3b-1)) THEN
      IF (ieor(int_mb(k_sym+h4b-1),ieor(int_mb(k_sym+p1b-1),ieor(int_mb(
     &k_sym+p2b-1),int_mb(k_sym+p3b-1)))) .eq. ieor(irrep_y,irrep_x)) TH
     &EN
      dimc = int_mb(k_range+h4b-1) * int_mb(k_range+p1b-1) * int_mb(k_ra
     &nge+p2b-1) * int_mb(k_range+p3b-1)
      IF (.not.MA_PUSH_GET(mt_dbl,dimc,'noname',l_c_sort,k_c_sort)) CALL
     & ERRQUIT('eomccsd_2pdm_hppp_mo_1',0,MA_ERR)
      CALL DFILL(dimc,0.0d0,dbl_mb(k_c_sort),1)
      DO h5b = 1,noab
      IF (int_mb(k_spin+p1b-1) .eq. int_mb(k_spin+h5b-1)) THEN
      IF (ieor(int_mb(k_sym+p1b-1),int_mb(k_sym+h5b-1)) .eq. irrep_x) TH
     &EN
      CALL TCE_RESTRICTED_2(p1b,h5b,p1b_1,h5b_1)
      CALL TCE_RESTRICTED_4(h4b,h5b,p2b,p3b,h4b_2,h5b_2,p2b_2,p3b_2)
      dim_common = int_mb(k_range+h5b-1)
      dima_sort = int_mb(k_range+p1b-1)
      dima = dim_common * dima_sort
      dimb_sort = int_mb(k_range+h4b-1) * int_mb(k_range+p2b-1) * int_mb
     &(k_range+p3b-1)
      dimb = dim_common * dimb_sort
      IF ((dima .gt. 0) .and. (dimb .gt. 0)) THEN
      IF (.not.MA_PUSH_GET(mt_dbl,dima,'noname',l_a_sort,k_a_sort)) CALL
     & ERRQUIT('eomccsd_2pdm_hppp_mo_1',1,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dima,'noname',l_a,k_a)) CALL ERRQUIT('
     &eomccsd_2pdm_hppp_mo_1',2,MA_ERR)
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h5b_1
     & - 1 + noab * (p1b_1 - noab - 1)))
      CALL TCE_SORT_2(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p1b-1)
     &,int_mb(k_range+h5b-1),1,2,1.0d0)
      IF (.not.MA_POP_STACK(l_a)) CALL ERRQUIT('eomccsd_2pdm_hppp_mo_1',
     &3,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dimb,'noname',l_b_sort,k_b_sort)) CALL
     & ERRQUIT('eomccsd_2pdm_hppp_mo_1',4,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dimb,'noname',l_b,k_b)) CALL ERRQUIT('
     &eomccsd_2pdm_hppp_mo_1',5,MA_ERR)
      IF ((h5b .lt. h4b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p3b_2
     & - noab - 1 + nvab * (p2b_2 - noab - 1 + nvab * (h4b_2 - 1 + noab 
     &* (h5b_2 - 1)))))
      CALL TCE_SORT_4(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h5b-1)
     &,int_mb(k_range+h4b-1),int_mb(k_range+p2b-1),int_mb(k_range+p3b-1)
     &,4,3,2,1,-1.0d0)
      END IF
      IF ((h4b .le. h5b)) THEN
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(p3b_2
     & - noab - 1 + nvab * (p2b_2 - noab - 1 + nvab * (h5b_2 - 1 + noab 
     &* (h4b_2 - 1)))))
      CALL TCE_SORT_4(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+h4b-1)
     &,int_mb(k_range+h5b-1),int_mb(k_range+p2b-1),int_mb(k_range+p3b-1)
     &,4,3,1,2,1.0d0)
      END IF
      IF (.not.MA_POP_STACK(l_b)) CALL ERRQUIT('eomccsd_2pdm_hppp_mo_1',
     &6,MA_ERR)
      CALL DGEMM('T','N',dima_sort,dimb_sort,dim_common,1.0d0,dbl_mb(k_a
     &_sort),dim_common,dbl_mb(k_b_sort),dim_common,1.0d0,dbl_mb(k_c_sor
     &t),dima_sort)
      IF (.not.MA_POP_STACK(l_b_sort)) CALL ERRQUIT('eomccsd_2pdm_hppp_m
     &o_1',7,MA_ERR)
      IF (.not.MA_POP_STACK(l_a_sort)) CALL ERRQUIT('eomccsd_2pdm_hppp_m
     &o_1',8,MA_ERR)
      END IF
      END IF
      END IF
      END DO
      IF (.not.MA_PUSH_GET(mt_dbl,dimc,'noname',l_c,k_c)) CALL ERRQUIT('
     &eomccsd_2pdm_hppp_mo_1',9,MA_ERR)
c
c      CALL TCE_SORT_4(dbl_mb(k_c_sort),dbl_mb(k_c),int_mb(k_range+p3b-1)
c     &,int_mb(k_range+p2b-1),int_mb(k_range+h4b-1),int_mb(k_range+p1b-1)
c     &,3,4,2,1,-1.0d0/2.0d0)
c
      CALL TCE_SORT_4(dbl_mb(k_c_sort),dbl_mb(k_c),int_mb(k_range+p3b-1)
     &,int_mb(k_range+p2b-1),int_mb(k_range+h4b-1),int_mb(k_range+p1b-1)
     &,3,4,2,1,1.0d0)
      CALL ADD_HASH_BLOCK(d_c,dbl_mb(k_c),dimc,int_mb(k_c_offset),(p3b -
     & noab - 1 + nvab * (p2b - noab - 1 + nvab * (p1b - noab - 1 + nvab
     & * (h4b - 1)))))
c
c      CALL TCE_SORT_4(dbl_mb(k_c_sort),dbl_mb(k_c),int_mb(k_range+p3b-1)
c     &,int_mb(k_range+p2b-1),int_mb(k_range+h4b-1),int_mb(k_range+p1b-1)
c     &,4,3,2,1,1.0d0/2.0d0)
c      CALL ADD_HASH_BLOCK(d_c,dbl_mb(k_c),dimc,int_mb(k_c_offset),(p3b -
c     & noab - 1 + nvab * (p2b - noab - 1 + nvab * (h4b - 1 + noab * (p1b
c     & - noab - 1)))))
c
      IF (.not.MA_POP_STACK(l_c)) CALL ERRQUIT('eomccsd_2pdm_hppp_mo_1',
     &10,MA_ERR)
      IF (.not.MA_POP_STACK(l_c_sort)) CALL ERRQUIT('eomccsd_2pdm_hppp_m
     &o_1',11,MA_ERR)
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
      SUBROUTINE eomccsd_2pdm_hppp_mo_2(d_a,k_a_offset,d_b,k_b_offset,d_
     &c,k_c_offset)
C     $Id$
C     This is a Fortran77 program generated by Tensor Contraction Engine v.1.0
C     Copyright (c) Battelle & Pacific Northwest National Laboratory (2002)
C     i0 ( h4 p3 p1 p2 )_xty + = -1/2 * P( 2 ) * Sum ( h5 ) * y ( h4 h5 p1 p2 )_y * i1 ( p3 h5 )_xt
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
      INTEGER p3b
      INTEGER p1b
      INTEGER p2b
      INTEGER dimc
      INTEGER l_c_sort
      INTEGER k_c_sort
      INTEGER h5b
      INTEGER h4b_1
      INTEGER h5b_1
      INTEGER p1b_1
      INTEGER p2b_1
      INTEGER p3b_2
      INTEGER h5b_2
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
      DO p3b = noab+1,noab+nvab
      DO p1b = noab+1,noab+nvab
      DO p2b = p1b,noab+nvab
      IF (next.eq.count) THEN
      IF ((.not.restricted).or.(int_mb(k_spin+h4b-1)+int_mb(k_spin+p3b-1
     &)+int_mb(k_spin+p1b-1)+int_mb(k_spin+p2b-1).ne.8)) THEN
      IF (int_mb(k_spin+h4b-1)+int_mb(k_spin+p3b-1) .eq. int_mb(k_spin+p
     &1b-1)+int_mb(k_spin+p2b-1)) THEN
      IF (ieor(int_mb(k_sym+h4b-1),ieor(int_mb(k_sym+p3b-1),ieor(int_mb(
     &k_sym+p1b-1),int_mb(k_sym+p2b-1)))) .eq. ieor(irrep_x,ieor(irrep_t
     &,irrep_y))) THEN
      dimc = int_mb(k_range+h4b-1) * int_mb(k_range+p3b-1) * int_mb(k_ra
     &nge+p1b-1) * int_mb(k_range+p2b-1)
      IF (.not.MA_PUSH_GET(mt_dbl,dimc,'noname',l_c_sort,k_c_sort)) CALL
     & ERRQUIT('eomccsd_2pdm_hppp_mo_2',0,MA_ERR)
      CALL DFILL(dimc,0.0d0,dbl_mb(k_c_sort),1)
      DO h5b = 1,noab
      IF (int_mb(k_spin+h4b-1)+int_mb(k_spin+h5b-1) .eq. int_mb(k_spin+p
     &1b-1)+int_mb(k_spin+p2b-1)) THEN
      IF (ieor(int_mb(k_sym+h4b-1),ieor(int_mb(k_sym+h5b-1),ieor(int_mb(
     &k_sym+p1b-1),int_mb(k_sym+p2b-1)))) .eq. irrep_y) THEN
      CALL TCE_RESTRICTED_4(h4b,h5b,p1b,p2b,h4b_1,h5b_1,p1b_1,p2b_1)
      CALL TCE_RESTRICTED_2(p3b,h5b,p3b_2,h5b_2)
      dim_common = int_mb(k_range+h5b-1)
      dima_sort = int_mb(k_range+h4b-1) * int_mb(k_range+p1b-1) * int_mb
     &(k_range+p2b-1)
      dima = dim_common * dima_sort
      dimb_sort = int_mb(k_range+p3b-1)
      dimb = dim_common * dimb_sort
      IF ((dima .gt. 0) .and. (dimb .gt. 0)) THEN
      IF (.not.MA_PUSH_GET(mt_dbl,dima,'noname',l_a_sort,k_a_sort)) CALL
     & ERRQUIT('eomccsd_2pdm_hppp_mo_2',1,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dima,'noname',l_a,k_a)) CALL ERRQUIT('
     &eomccsd_2pdm_hppp_mo_2',2,MA_ERR)
      IF ((h5b .lt. h4b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(p2b_1
     & - noab - 1 + nvab * (p1b_1 - noab - 1 + nvab * (h4b_1 - 1 + noab 
     &* (h5b_1 - 1)))))
      CALL TCE_SORT_4(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+h5b-1)
     &,int_mb(k_range+h4b-1),int_mb(k_range+p1b-1),int_mb(k_range+p2b-1)
     &,4,3,2,1,-1.0d0)
      END IF
      IF ((h4b .le. h5b)) THEN
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(p2b_1
     & - noab - 1 + nvab * (p1b_1 - noab - 1 + nvab * (h5b_1 - 1 + noab 
     &* (h4b_1 - 1)))))
      CALL TCE_SORT_4(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+h4b-1)
     &,int_mb(k_range+h5b-1),int_mb(k_range+p1b-1),int_mb(k_range+p2b-1)
     &,4,3,1,2,1.0d0)
      END IF
      IF (.not.MA_POP_STACK(l_a)) CALL ERRQUIT('eomccsd_2pdm_hppp_mo_2',
     &3,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dimb,'noname',l_b_sort,k_b_sort)) CALL
     & ERRQUIT('eomccsd_2pdm_hppp_mo_2',4,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dimb,'noname',l_b,k_b)) CALL ERRQUIT('
     &eomccsd_2pdm_hppp_mo_2',5,MA_ERR)
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),(h5b_2
     & - 1 + noab * (p3b_2 - noab - 1)))
      CALL TCE_SORT_2(dbl_mb(k_b),dbl_mb(k_b_sort),int_mb(k_range+p3b-1)
     &,int_mb(k_range+h5b-1),1,2,1.0d0)
      IF (.not.MA_POP_STACK(l_b)) CALL ERRQUIT('eomccsd_2pdm_hppp_mo_2',
     &6,MA_ERR)
      CALL DGEMM('T','N',dima_sort,dimb_sort,dim_common,1.0d0,dbl_mb(k_a
     &_sort),dim_common,dbl_mb(k_b_sort),dim_common,1.0d0,dbl_mb(k_c_sor
     &t),dima_sort)
      IF (.not.MA_POP_STACK(l_b_sort)) CALL ERRQUIT('eomccsd_2pdm_hppp_m
     &o_2',7,MA_ERR)
      IF (.not.MA_POP_STACK(l_a_sort)) CALL ERRQUIT('eomccsd_2pdm_hppp_m
     &o_2',8,MA_ERR)
      END IF
      END IF
      END IF
      END DO
      IF (.not.MA_PUSH_GET(mt_dbl,dimc,'noname',l_c,k_c)) CALL ERRQUIT('
     &eomccsd_2pdm_hppp_mo_2',9,MA_ERR)
c
c      CALL TCE_SORT_4(dbl_mb(k_c_sort),dbl_mb(k_c),int_mb(k_range+p3b-1)
c     &,int_mb(k_range+p2b-1),int_mb(k_range+p1b-1),int_mb(k_range+h4b-1)
c     &,4,1,3,2,-1.0d0/2.0d0)
c
      CALL TCE_SORT_4(dbl_mb(k_c_sort),dbl_mb(k_c),int_mb(k_range+p3b-1)
     &,int_mb(k_range+p2b-1),int_mb(k_range+p1b-1),int_mb(k_range+h4b-1)
     &,4,1,3,2,1.0d0)
      CALL ADD_HASH_BLOCK(d_c,dbl_mb(k_c),dimc,int_mb(k_c_offset),(p2b -
     & noab - 1 + nvab * (p1b - noab - 1 + nvab * (p3b - noab - 1 + nvab
     & * (h4b - 1)))))
c
c      CALL TCE_SORT_4(dbl_mb(k_c_sort),dbl_mb(k_c),int_mb(k_range+p3b-1)
c     &,int_mb(k_range+p2b-1),int_mb(k_range+p1b-1),int_mb(k_range+h4b-1)
c     &,1,4,3,2,1.0d0/2.0d0)
c      CALL ADD_HASH_BLOCK(d_c,dbl_mb(k_c),dimc,int_mb(k_c_offset),(p2b -
c     & noab - 1 + nvab * (p1b - noab - 1 + nvab * (h4b - 1 + noab * (p3b
c     & - noab - 1)))))
c
      IF (.not.MA_POP_STACK(l_c)) CALL ERRQUIT('eomccsd_2pdm_hppp_mo_2',
     &10,MA_ERR)
      IF (.not.MA_POP_STACK(l_c_sort)) CALL ERRQUIT('eomccsd_2pdm_hppp_m
     &o_2',11,MA_ERR)
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
      SUBROUTINE eomccsd_2pdm_hppp_mo_2_1(d_a,k_a_offset,d_b,k_b_offset,
     &d_c,k_c_offset)
C     $Id$
C     This is a Fortran77 program generated by Tensor Contraction Engine v.1.0
C     Copyright (c) Battelle & Pacific Northwest National Laboratory (2002)
C     i1 ( p1 h5 )_xt + = 1 * t ( p1 h5 )_t * x ( )_x
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
      INTEGER p1b
      INTEGER h5b
      INTEGER dimc
      INTEGER l_c_sort
      INTEGER k_c_sort
      INTEGER p1b_1
      INTEGER h5b_1
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
      DO p1b = noab+1,noab+nvab
      DO h5b = 1,noab
      IF (next.eq.count) THEN
      IF ((.not.restricted).or.(int_mb(k_spin+p1b-1)+int_mb(k_spin+h5b-1
     &).ne.4)) THEN
      IF (int_mb(k_spin+p1b-1) .eq. int_mb(k_spin+h5b-1)) THEN
      IF (ieor(int_mb(k_sym+p1b-1),int_mb(k_sym+h5b-1)) .eq. ieor(irrep_
     &x,irrep_t)) THEN
      dimc = int_mb(k_range+p1b-1) * int_mb(k_range+h5b-1)
      IF (.not.MA_PUSH_GET(mt_dbl,dimc,'noname',l_c_sort,k_c_sort)) CALL
     & ERRQUIT('eomccsd_2pdm_hppp_mo_2_1',0,MA_ERR)
      CALL DFILL(dimc,0.0d0,dbl_mb(k_c_sort),1)
      IF (int_mb(k_spin+p1b-1) .eq. int_mb(k_spin+h5b-1)) THEN
      IF (ieor(int_mb(k_sym+p1b-1),int_mb(k_sym+h5b-1)) .eq. irrep_t) TH
     &EN
      CALL TCE_RESTRICTED_2(p1b,h5b,p1b_1,h5b_1)
      dim_common = 1
      dima_sort = int_mb(k_range+p1b-1) * int_mb(k_range+h5b-1)
      dima = dim_common * dima_sort
      dimb_sort = 1
      dimb = dim_common * dimb_sort
      IF ((dima .gt. 0) .and. (dimb .gt. 0)) THEN
      IF (.not.MA_PUSH_GET(mt_dbl,dima,'noname',l_a_sort,k_a_sort)) CALL
     & ERRQUIT('eomccsd_2pdm_hppp_mo_2_1',1,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dima,'noname',l_a,k_a)) CALL ERRQUIT('
     &eomccsd_2pdm_hppp_mo_2_1',2,MA_ERR)
      CALL GET_HASH_BLOCK(d_a,dbl_mb(k_a),dima,int_mb(k_a_offset),(h5b_1
     & - 1 + noab * (p1b_1 - noab - 1)))
      CALL TCE_SORT_2(dbl_mb(k_a),dbl_mb(k_a_sort),int_mb(k_range+p1b-1)
     &,int_mb(k_range+h5b-1),2,1,1.0d0)
      IF (.not.MA_POP_STACK(l_a)) CALL ERRQUIT('eomccsd_2pdm_hppp_mo_2_1
     &',3,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dimb,'noname',l_b_sort,k_b_sort)) CALL
     & ERRQUIT('eomccsd_2pdm_hppp_mo_2_1',4,MA_ERR)
      IF (.not.MA_PUSH_GET(mt_dbl,dimb,'noname',l_b,k_b)) CALL ERRQUIT('
     &eomccsd_2pdm_hppp_mo_2_1',5,MA_ERR)
      CALL GET_HASH_BLOCK(d_b,dbl_mb(k_b),dimb,int_mb(k_b_offset),0)
      CALL TCE_SORT_0(dbl_mb(k_b),dbl_mb(k_b_sort),1.0d0)
      IF (.not.MA_POP_STACK(l_b)) CALL ERRQUIT('eomccsd_2pdm_hppp_mo_2_1
     &',6,MA_ERR)
      CALL DGEMM('T','N',dima_sort,dimb_sort,dim_common,1.0d0,dbl_mb(k_a
     &_sort),dim_common,dbl_mb(k_b_sort),dim_common,1.0d0,dbl_mb(k_c_sor
     &t),dima_sort)
      IF (.not.MA_POP_STACK(l_b_sort)) CALL ERRQUIT('eomccsd_2pdm_hppp_m
     &o_2_1',7,MA_ERR)
      IF (.not.MA_POP_STACK(l_a_sort)) CALL ERRQUIT('eomccsd_2pdm_hppp_m
     &o_2_1',8,MA_ERR)
      END IF
      END IF
      END IF
      IF (.not.MA_PUSH_GET(mt_dbl,dimc,'noname',l_c,k_c)) CALL ERRQUIT('
     &eomccsd_2pdm_hppp_mo_2_1',9,MA_ERR)
      CALL TCE_SORT_2(dbl_mb(k_c_sort),dbl_mb(k_c),int_mb(k_range+h5b-1)
     &,int_mb(k_range+p1b-1),2,1,1.0d0)
      CALL ADD_HASH_BLOCK(d_c,dbl_mb(k_c),dimc,int_mb(k_c_offset),(h5b -
     & 1 + noab * (p1b - noab - 1)))
      IF (.not.MA_POP_STACK(l_c)) CALL ERRQUIT('eomccsd_2pdm_hppp_mo_2_1
     &',10,MA_ERR)
      IF (.not.MA_POP_STACK(l_c_sort)) CALL ERRQUIT('eomccsd_2pdm_hppp_m
     &o_2_1',11,MA_ERR)
      END IF
      END IF
      END IF
      next = NXTVAL(nprocs)
      END IF
      count = count + 1
      END DO
      END DO
      next = NXTVAL(-nprocs)
      call GA_SYNC()
      RETURN
      END
      SUBROUTINE OFFSET_eomccsd_2pdm_hppp_mo_2_1(l_a_offset,k_a_offset,s
     &ize)
C     $Id$
C     This is a Fortran77 program generated by Tensor Contraction Engine v.1.0
C     Copyright (c) Battelle & Pacific Northwest National Laboratory (2002)
C     i1 ( p1 h5 )_xt
      IMPLICIT NONE
#include "global.fh"
#include "mafdecls.fh"
#include "sym.fh"
#include "errquit.fh"
#include "tce.fh"
      INTEGER l_a_offset
      INTEGER k_a_offset
      INTEGER size
      INTEGER length
      INTEGER addr
      INTEGER p1b
      INTEGER h5b
      length = 0
      DO p1b = noab+1,noab+nvab
      DO h5b = 1,noab
      IF (int_mb(k_spin+p1b-1) .eq. int_mb(k_spin+h5b-1)) THEN
      IF (ieor(int_mb(k_sym+p1b-1),int_mb(k_sym+h5b-1)) .eq. ieor(irrep_
     &x,irrep_t)) THEN
      IF ((.not.restricted).or.(int_mb(k_spin+p1b-1)+int_mb(k_spin+h5b-1
     &).ne.4)) THEN
      length = length + 1
      END IF
      END IF
      END IF
      END DO
      END DO
      IF (.not.MA_PUSH_GET(mt_int,2*length+1,'noname',l_a_offset,k_a_off
     &set)) CALL ERRQUIT('eomccsd_2pdm_hppp_mo_2_1',0,MA_ERR)
      int_mb(k_a_offset) = length
      addr = 0
      size = 0
      DO p1b = noab+1,noab+nvab
      DO h5b = 1,noab
      IF (int_mb(k_spin+p1b-1) .eq. int_mb(k_spin+h5b-1)) THEN
      IF (ieor(int_mb(k_sym+p1b-1),int_mb(k_sym+h5b-1)) .eq. ieor(irrep_
     &x,irrep_t)) THEN
      IF ((.not.restricted).or.(int_mb(k_spin+p1b-1)+int_mb(k_spin+h5b-1
     &).ne.4)) THEN
      addr = addr + 1
      int_mb(k_a_offset+addr) = h5b - 1 + noab * (p1b - noab - 1)
      int_mb(k_a_offset+length+addr) = size
      size = size + int_mb(k_range+p1b-1) * int_mb(k_range+h5b-1)
      END IF
      END IF
      END IF
      END DO
      END DO
      RETURN
      END
