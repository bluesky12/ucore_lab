
bin/kernel_nopage:     file format elf32-i386


Disassembly of section .text:

00100000 <kern_entry>:
.text
.globl kern_entry
kern_entry:
    # reload temperate gdt (second time) to remap all physical memory
    # virtual_addr 0~4G=linear_addr&physical_addr -KERNBASE~4G-KERNBASE 
    lgdt REALLOC(__gdtdesc)
  100000:	0f 01 15 18 70 11 40 	lgdtl  0x40117018
    movl $KERNEL_DS, %eax
  100007:	b8 10 00 00 00       	mov    $0x10,%eax
    movw %ax, %ds
  10000c:	8e d8                	mov    %eax,%ds
    movw %ax, %es
  10000e:	8e c0                	mov    %eax,%es
    movw %ax, %ss
  100010:	8e d0                	mov    %eax,%ss

    ljmp $KERNEL_CS, $relocated
  100012:	ea 19 00 10 00 08 00 	ljmp   $0x8,$0x100019

00100019 <relocated>:

relocated:

    # set ebp, esp
    movl $0x0, %ebp
  100019:	bd 00 00 00 00       	mov    $0x0,%ebp
    # the kernel stack region is from bootstack -- bootstacktop,
    # the kernel stack size is KSTACKSIZE (8KB)defined in memlayout.h
    movl $bootstacktop, %esp
  10001e:	bc 00 70 11 00       	mov    $0x117000,%esp
    # now kernel stack is ready , call the first C function
    call kern_init
  100023:	e8 02 00 00 00       	call   10002a <kern_init>

00100028 <spin>:

# should never get here
spin:
    jmp spin
  100028:	eb fe                	jmp    100028 <spin>

0010002a <kern_init>:
int kern_init(void) __attribute__((noreturn));
void grade_backtrace(void);
static void lab1_switch_test(void);

int
kern_init(void) {
  10002a:	55                   	push   %ebp
  10002b:	89 e5                	mov    %esp,%ebp
  10002d:	83 ec 28             	sub    $0x28,%esp
    extern char edata[], end[];
    memset(edata, 0, end - edata);
  100030:	ba c8 89 11 00       	mov    $0x1189c8,%edx
  100035:	b8 36 7a 11 00       	mov    $0x117a36,%eax
  10003a:	29 c2                	sub    %eax,%edx
  10003c:	89 d0                	mov    %edx,%eax
  10003e:	89 44 24 08          	mov    %eax,0x8(%esp)
  100042:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  100049:	00 
  10004a:	c7 04 24 36 7a 11 00 	movl   $0x117a36,(%esp)
  100051:	e8 e2 5e 00 00       	call   105f38 <memset>

    cons_init();                // init the console
  100056:	e8 bf 15 00 00       	call   10161a <cons_init>

    const char *message = "(THU.CST) os is loading ...";
  10005b:	c7 45 f4 e0 60 10 00 	movl   $0x1060e0,-0xc(%ebp)
    cprintf("%s\n\n", message);
  100062:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100065:	89 44 24 04          	mov    %eax,0x4(%esp)
  100069:	c7 04 24 fc 60 10 00 	movl   $0x1060fc,(%esp)
  100070:	e8 d7 02 00 00       	call   10034c <cprintf>

    print_kerninfo();
  100075:	e8 06 08 00 00       	call   100880 <print_kerninfo>

    grade_backtrace();
  10007a:	e8 8b 00 00 00       	call   10010a <grade_backtrace>

    pmm_init();                 // init physical memory management
  10007f:	e8 c2 43 00 00       	call   104446 <pmm_init>

    pic_init();                 // init interrupt controller
  100084:	e8 fa 16 00 00       	call   101783 <pic_init>
    idt_init();                 // init interrupt descriptor table
  100089:	e8 72 18 00 00       	call   101900 <idt_init>

    clock_init();               // init clock interrupt
  10008e:	e8 3d 0d 00 00       	call   100dd0 <clock_init>
    intr_enable();              // enable irq interrupt
  100093:	e8 59 16 00 00       	call   1016f1 <intr_enable>

    //LAB1: CAHLLENGE 1 If you try to do it, uncomment lab1_switch_test()
    // user/kernel mode switch test
    lab1_switch_test();
  100098:	e8 6d 01 00 00       	call   10020a <lab1_switch_test>

    /* do nothing */
    while (1);
  10009d:	eb fe                	jmp    10009d <kern_init+0x73>

0010009f <grade_backtrace2>:
}

void __attribute__((noinline))
grade_backtrace2(int arg0, int arg1, int arg2, int arg3) {
  10009f:	55                   	push   %ebp
  1000a0:	89 e5                	mov    %esp,%ebp
  1000a2:	83 ec 18             	sub    $0x18,%esp
    mon_backtrace(0, NULL, NULL);
  1000a5:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  1000ac:	00 
  1000ad:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  1000b4:	00 
  1000b5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1000bc:	e8 41 0c 00 00       	call   100d02 <mon_backtrace>
}
  1000c1:	c9                   	leave  
  1000c2:	c3                   	ret    

001000c3 <grade_backtrace1>:

void __attribute__((noinline))
grade_backtrace1(int arg0, int arg1) {
  1000c3:	55                   	push   %ebp
  1000c4:	89 e5                	mov    %esp,%ebp
  1000c6:	53                   	push   %ebx
  1000c7:	83 ec 14             	sub    $0x14,%esp
    grade_backtrace2(arg0, (int)&arg0, arg1, (int)&arg1);
  1000ca:	8d 5d 0c             	lea    0xc(%ebp),%ebx
  1000cd:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  1000d0:	8d 55 08             	lea    0x8(%ebp),%edx
  1000d3:	8b 45 08             	mov    0x8(%ebp),%eax
  1000d6:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
  1000da:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  1000de:	89 54 24 04          	mov    %edx,0x4(%esp)
  1000e2:	89 04 24             	mov    %eax,(%esp)
  1000e5:	e8 b5 ff ff ff       	call   10009f <grade_backtrace2>
}
  1000ea:	83 c4 14             	add    $0x14,%esp
  1000ed:	5b                   	pop    %ebx
  1000ee:	5d                   	pop    %ebp
  1000ef:	c3                   	ret    

001000f0 <grade_backtrace0>:

void __attribute__((noinline))
grade_backtrace0(int arg0, int arg1, int arg2) {
  1000f0:	55                   	push   %ebp
  1000f1:	89 e5                	mov    %esp,%ebp
  1000f3:	83 ec 18             	sub    $0x18,%esp
    grade_backtrace1(arg0, arg2);
  1000f6:	8b 45 10             	mov    0x10(%ebp),%eax
  1000f9:	89 44 24 04          	mov    %eax,0x4(%esp)
  1000fd:	8b 45 08             	mov    0x8(%ebp),%eax
  100100:	89 04 24             	mov    %eax,(%esp)
  100103:	e8 bb ff ff ff       	call   1000c3 <grade_backtrace1>
}
  100108:	c9                   	leave  
  100109:	c3                   	ret    

0010010a <grade_backtrace>:

void
grade_backtrace(void) {
  10010a:	55                   	push   %ebp
  10010b:	89 e5                	mov    %esp,%ebp
  10010d:	83 ec 18             	sub    $0x18,%esp
    grade_backtrace0(0, (int)kern_init, 0xffff0000);
  100110:	b8 2a 00 10 00       	mov    $0x10002a,%eax
  100115:	c7 44 24 08 00 00 ff 	movl   $0xffff0000,0x8(%esp)
  10011c:	ff 
  10011d:	89 44 24 04          	mov    %eax,0x4(%esp)
  100121:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100128:	e8 c3 ff ff ff       	call   1000f0 <grade_backtrace0>
}
  10012d:	c9                   	leave  
  10012e:	c3                   	ret    

0010012f <lab1_print_cur_status>:

static void
lab1_print_cur_status(void) {
  10012f:	55                   	push   %ebp
  100130:	89 e5                	mov    %esp,%ebp
  100132:	83 ec 28             	sub    $0x28,%esp
    static int round = 0;
    uint16_t reg1, reg2, reg3, reg4;
    asm volatile (
  100135:	8c 4d f6             	mov    %cs,-0xa(%ebp)
  100138:	8c 5d f4             	mov    %ds,-0xc(%ebp)
  10013b:	8c 45 f2             	mov    %es,-0xe(%ebp)
  10013e:	8c 55 f0             	mov    %ss,-0x10(%ebp)
            "mov %%cs, %0;"
            "mov %%ds, %1;"
            "mov %%es, %2;"
            "mov %%ss, %3;"
            : "=m"(reg1), "=m"(reg2), "=m"(reg3), "=m"(reg4));
    cprintf("%d: @ring %d\n", round, reg1 & 3);
  100141:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  100145:	0f b7 c0             	movzwl %ax,%eax
  100148:	83 e0 03             	and    $0x3,%eax
  10014b:	89 c2                	mov    %eax,%edx
  10014d:	a1 40 7a 11 00       	mov    0x117a40,%eax
  100152:	89 54 24 08          	mov    %edx,0x8(%esp)
  100156:	89 44 24 04          	mov    %eax,0x4(%esp)
  10015a:	c7 04 24 01 61 10 00 	movl   $0x106101,(%esp)
  100161:	e8 e6 01 00 00       	call   10034c <cprintf>
    cprintf("%d:  cs = %x\n", round, reg1);
  100166:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  10016a:	0f b7 d0             	movzwl %ax,%edx
  10016d:	a1 40 7a 11 00       	mov    0x117a40,%eax
  100172:	89 54 24 08          	mov    %edx,0x8(%esp)
  100176:	89 44 24 04          	mov    %eax,0x4(%esp)
  10017a:	c7 04 24 0f 61 10 00 	movl   $0x10610f,(%esp)
  100181:	e8 c6 01 00 00       	call   10034c <cprintf>
    cprintf("%d:  ds = %x\n", round, reg2);
  100186:	0f b7 45 f4          	movzwl -0xc(%ebp),%eax
  10018a:	0f b7 d0             	movzwl %ax,%edx
  10018d:	a1 40 7a 11 00       	mov    0x117a40,%eax
  100192:	89 54 24 08          	mov    %edx,0x8(%esp)
  100196:	89 44 24 04          	mov    %eax,0x4(%esp)
  10019a:	c7 04 24 1d 61 10 00 	movl   $0x10611d,(%esp)
  1001a1:	e8 a6 01 00 00       	call   10034c <cprintf>
    cprintf("%d:  es = %x\n", round, reg3);
  1001a6:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  1001aa:	0f b7 d0             	movzwl %ax,%edx
  1001ad:	a1 40 7a 11 00       	mov    0x117a40,%eax
  1001b2:	89 54 24 08          	mov    %edx,0x8(%esp)
  1001b6:	89 44 24 04          	mov    %eax,0x4(%esp)
  1001ba:	c7 04 24 2b 61 10 00 	movl   $0x10612b,(%esp)
  1001c1:	e8 86 01 00 00       	call   10034c <cprintf>
    cprintf("%d:  ss = %x\n", round, reg4);
  1001c6:	0f b7 45 f0          	movzwl -0x10(%ebp),%eax
  1001ca:	0f b7 d0             	movzwl %ax,%edx
  1001cd:	a1 40 7a 11 00       	mov    0x117a40,%eax
  1001d2:	89 54 24 08          	mov    %edx,0x8(%esp)
  1001d6:	89 44 24 04          	mov    %eax,0x4(%esp)
  1001da:	c7 04 24 39 61 10 00 	movl   $0x106139,(%esp)
  1001e1:	e8 66 01 00 00       	call   10034c <cprintf>
    round ++;
  1001e6:	a1 40 7a 11 00       	mov    0x117a40,%eax
  1001eb:	83 c0 01             	add    $0x1,%eax
  1001ee:	a3 40 7a 11 00       	mov    %eax,0x117a40
}
  1001f3:	c9                   	leave  
  1001f4:	c3                   	ret    

001001f5 <lab1_switch_to_user>:

static void
lab1_switch_to_user(void) {
  1001f5:	55                   	push   %ebp
  1001f6:	89 e5                	mov    %esp,%ebp
    //LAB1 CHALLENGE 1 : TODO
	asm volatile (
  1001f8:	83 ec 08             	sub    $0x8,%esp
  1001fb:	cd 78                	int    $0x78
  1001fd:	89 ec                	mov    %ebp,%esp
		    "int %0 \n"
		    "movl %%ebp, %%esp"
		    :
		    : "i"(T_SWITCH_TOU)
		);
}
  1001ff:	5d                   	pop    %ebp
  100200:	c3                   	ret    

00100201 <lab1_switch_to_kernel>:

static void
lab1_switch_to_kernel(void) {
  100201:	55                   	push   %ebp
  100202:	89 e5                	mov    %esp,%ebp
    //LAB1 CHALLENGE 1 :  TODO
	asm volatile (
  100204:	cd 79                	int    $0x79
  100206:	89 ec                	mov    %ebp,%esp
		    "int %0 \n"
		    "movl %%ebp, %%esp \n"
		    :
		    : "i"(T_SWITCH_TOK)
		);
}
  100208:	5d                   	pop    %ebp
  100209:	c3                   	ret    

0010020a <lab1_switch_test>:

static void
lab1_switch_test(void) {
  10020a:	55                   	push   %ebp
  10020b:	89 e5                	mov    %esp,%ebp
  10020d:	83 ec 18             	sub    $0x18,%esp
    lab1_print_cur_status();
  100210:	e8 1a ff ff ff       	call   10012f <lab1_print_cur_status>
    cprintf("+++ switch to  user  mode +++\n");
  100215:	c7 04 24 48 61 10 00 	movl   $0x106148,(%esp)
  10021c:	e8 2b 01 00 00       	call   10034c <cprintf>
    lab1_switch_to_user();
  100221:	e8 cf ff ff ff       	call   1001f5 <lab1_switch_to_user>
    lab1_print_cur_status();
  100226:	e8 04 ff ff ff       	call   10012f <lab1_print_cur_status>
    cprintf("+++ switch to kernel mode +++\n");
  10022b:	c7 04 24 68 61 10 00 	movl   $0x106168,(%esp)
  100232:	e8 15 01 00 00       	call   10034c <cprintf>
    lab1_switch_to_kernel();
  100237:	e8 c5 ff ff ff       	call   100201 <lab1_switch_to_kernel>
    lab1_print_cur_status();
  10023c:	e8 ee fe ff ff       	call   10012f <lab1_print_cur_status>
}
  100241:	c9                   	leave  
  100242:	c3                   	ret    

00100243 <readline>:
 * The readline() function returns the text of the line read. If some errors
 * are happened, NULL is returned. The return value is a global variable,
 * thus it should be copied before it is used.
 * */
char *
readline(const char *prompt) {
  100243:	55                   	push   %ebp
  100244:	89 e5                	mov    %esp,%ebp
  100246:	83 ec 28             	sub    $0x28,%esp
    if (prompt != NULL) {
  100249:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  10024d:	74 13                	je     100262 <readline+0x1f>
        cprintf("%s", prompt);
  10024f:	8b 45 08             	mov    0x8(%ebp),%eax
  100252:	89 44 24 04          	mov    %eax,0x4(%esp)
  100256:	c7 04 24 87 61 10 00 	movl   $0x106187,(%esp)
  10025d:	e8 ea 00 00 00       	call   10034c <cprintf>
    }
    int i = 0, c;
  100262:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while (1) {
        c = getchar();
  100269:	e8 66 01 00 00       	call   1003d4 <getchar>
  10026e:	89 45 f0             	mov    %eax,-0x10(%ebp)
        if (c < 0) {
  100271:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  100275:	79 07                	jns    10027e <readline+0x3b>
            return NULL;
  100277:	b8 00 00 00 00       	mov    $0x0,%eax
  10027c:	eb 79                	jmp    1002f7 <readline+0xb4>
        }
        else if (c >= ' ' && i < BUFSIZE - 1) {
  10027e:	83 7d f0 1f          	cmpl   $0x1f,-0x10(%ebp)
  100282:	7e 28                	jle    1002ac <readline+0x69>
  100284:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  10028b:	7f 1f                	jg     1002ac <readline+0x69>
            cputchar(c);
  10028d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100290:	89 04 24             	mov    %eax,(%esp)
  100293:	e8 da 00 00 00       	call   100372 <cputchar>
            buf[i ++] = c;
  100298:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10029b:	8d 50 01             	lea    0x1(%eax),%edx
  10029e:	89 55 f4             	mov    %edx,-0xc(%ebp)
  1002a1:	8b 55 f0             	mov    -0x10(%ebp),%edx
  1002a4:	88 90 60 7a 11 00    	mov    %dl,0x117a60(%eax)
  1002aa:	eb 46                	jmp    1002f2 <readline+0xaf>
        }
        else if (c == '\b' && i > 0) {
  1002ac:	83 7d f0 08          	cmpl   $0x8,-0x10(%ebp)
  1002b0:	75 17                	jne    1002c9 <readline+0x86>
  1002b2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1002b6:	7e 11                	jle    1002c9 <readline+0x86>
            cputchar(c);
  1002b8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1002bb:	89 04 24             	mov    %eax,(%esp)
  1002be:	e8 af 00 00 00       	call   100372 <cputchar>
            i --;
  1002c3:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
  1002c7:	eb 29                	jmp    1002f2 <readline+0xaf>
        }
        else if (c == '\n' || c == '\r') {
  1002c9:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
  1002cd:	74 06                	je     1002d5 <readline+0x92>
  1002cf:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
  1002d3:	75 1d                	jne    1002f2 <readline+0xaf>
            cputchar(c);
  1002d5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1002d8:	89 04 24             	mov    %eax,(%esp)
  1002db:	e8 92 00 00 00       	call   100372 <cputchar>
            buf[i] = '\0';
  1002e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1002e3:	05 60 7a 11 00       	add    $0x117a60,%eax
  1002e8:	c6 00 00             	movb   $0x0,(%eax)
            return buf;
  1002eb:	b8 60 7a 11 00       	mov    $0x117a60,%eax
  1002f0:	eb 05                	jmp    1002f7 <readline+0xb4>
        }
    }
  1002f2:	e9 72 ff ff ff       	jmp    100269 <readline+0x26>
}
  1002f7:	c9                   	leave  
  1002f8:	c3                   	ret    

001002f9 <cputch>:
/* *
 * cputch - writes a single character @c to stdout, and it will
 * increace the value of counter pointed by @cnt.
 * */
static void
cputch(int c, int *cnt) {
  1002f9:	55                   	push   %ebp
  1002fa:	89 e5                	mov    %esp,%ebp
  1002fc:	83 ec 18             	sub    $0x18,%esp
    cons_putc(c);
  1002ff:	8b 45 08             	mov    0x8(%ebp),%eax
  100302:	89 04 24             	mov    %eax,(%esp)
  100305:	e8 3c 13 00 00       	call   101646 <cons_putc>
    (*cnt) ++;
  10030a:	8b 45 0c             	mov    0xc(%ebp),%eax
  10030d:	8b 00                	mov    (%eax),%eax
  10030f:	8d 50 01             	lea    0x1(%eax),%edx
  100312:	8b 45 0c             	mov    0xc(%ebp),%eax
  100315:	89 10                	mov    %edx,(%eax)
}
  100317:	c9                   	leave  
  100318:	c3                   	ret    

00100319 <vcprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want cprintf() instead.
 * */
int
vcprintf(const char *fmt, va_list ap) {
  100319:	55                   	push   %ebp
  10031a:	89 e5                	mov    %esp,%ebp
  10031c:	83 ec 28             	sub    $0x28,%esp
    int cnt = 0;
  10031f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
  100326:	8b 45 0c             	mov    0xc(%ebp),%eax
  100329:	89 44 24 0c          	mov    %eax,0xc(%esp)
  10032d:	8b 45 08             	mov    0x8(%ebp),%eax
  100330:	89 44 24 08          	mov    %eax,0x8(%esp)
  100334:	8d 45 f4             	lea    -0xc(%ebp),%eax
  100337:	89 44 24 04          	mov    %eax,0x4(%esp)
  10033b:	c7 04 24 f9 02 10 00 	movl   $0x1002f9,(%esp)
  100342:	e8 0a 54 00 00       	call   105751 <vprintfmt>
    return cnt;
  100347:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  10034a:	c9                   	leave  
  10034b:	c3                   	ret    

0010034c <cprintf>:
 *
 * The return value is the number of characters which would be
 * written to stdout.
 * */
int
cprintf(const char *fmt, ...) {
  10034c:	55                   	push   %ebp
  10034d:	89 e5                	mov    %esp,%ebp
  10034f:	83 ec 28             	sub    $0x28,%esp
    va_list ap;
    int cnt;
    va_start(ap, fmt);
  100352:	8d 45 0c             	lea    0xc(%ebp),%eax
  100355:	89 45 f0             	mov    %eax,-0x10(%ebp)
    cnt = vcprintf(fmt, ap);
  100358:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10035b:	89 44 24 04          	mov    %eax,0x4(%esp)
  10035f:	8b 45 08             	mov    0x8(%ebp),%eax
  100362:	89 04 24             	mov    %eax,(%esp)
  100365:	e8 af ff ff ff       	call   100319 <vcprintf>
  10036a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    va_end(ap);
    return cnt;
  10036d:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  100370:	c9                   	leave  
  100371:	c3                   	ret    

00100372 <cputchar>:

/* cputchar - writes a single character to stdout */
void
cputchar(int c) {
  100372:	55                   	push   %ebp
  100373:	89 e5                	mov    %esp,%ebp
  100375:	83 ec 18             	sub    $0x18,%esp
    cons_putc(c);
  100378:	8b 45 08             	mov    0x8(%ebp),%eax
  10037b:	89 04 24             	mov    %eax,(%esp)
  10037e:	e8 c3 12 00 00       	call   101646 <cons_putc>
}
  100383:	c9                   	leave  
  100384:	c3                   	ret    

00100385 <cputs>:
/* *
 * cputs- writes the string pointed by @str to stdout and
 * appends a newline character.
 * */
int
cputs(const char *str) {
  100385:	55                   	push   %ebp
  100386:	89 e5                	mov    %esp,%ebp
  100388:	83 ec 28             	sub    $0x28,%esp
    int cnt = 0;
  10038b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    char c;
    while ((c = *str ++) != '\0') {
  100392:	eb 13                	jmp    1003a7 <cputs+0x22>
        cputch(c, &cnt);
  100394:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  100398:	8d 55 f0             	lea    -0x10(%ebp),%edx
  10039b:	89 54 24 04          	mov    %edx,0x4(%esp)
  10039f:	89 04 24             	mov    %eax,(%esp)
  1003a2:	e8 52 ff ff ff       	call   1002f9 <cputch>
 * */
int
cputs(const char *str) {
    int cnt = 0;
    char c;
    while ((c = *str ++) != '\0') {
  1003a7:	8b 45 08             	mov    0x8(%ebp),%eax
  1003aa:	8d 50 01             	lea    0x1(%eax),%edx
  1003ad:	89 55 08             	mov    %edx,0x8(%ebp)
  1003b0:	0f b6 00             	movzbl (%eax),%eax
  1003b3:	88 45 f7             	mov    %al,-0x9(%ebp)
  1003b6:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
  1003ba:	75 d8                	jne    100394 <cputs+0xf>
        cputch(c, &cnt);
    }
    cputch('\n', &cnt);
  1003bc:	8d 45 f0             	lea    -0x10(%ebp),%eax
  1003bf:	89 44 24 04          	mov    %eax,0x4(%esp)
  1003c3:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
  1003ca:	e8 2a ff ff ff       	call   1002f9 <cputch>
    return cnt;
  1003cf:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  1003d2:	c9                   	leave  
  1003d3:	c3                   	ret    

001003d4 <getchar>:

/* getchar - reads a single non-zero character from stdin */
int
getchar(void) {
  1003d4:	55                   	push   %ebp
  1003d5:	89 e5                	mov    %esp,%ebp
  1003d7:	83 ec 18             	sub    $0x18,%esp
    int c;
    while ((c = cons_getc()) == 0)
  1003da:	e8 a3 12 00 00       	call   101682 <cons_getc>
  1003df:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1003e2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1003e6:	74 f2                	je     1003da <getchar+0x6>
        /* do nothing */;
    return c;
  1003e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  1003eb:	c9                   	leave  
  1003ec:	c3                   	ret    

001003ed <stab_binsearch>:
 *      stab_binsearch(stabs, &left, &right, N_SO, 0xf0100184);
 * will exit setting left = 118, right = 554.
 * */
static void
stab_binsearch(const struct stab *stabs, int *region_left, int *region_right,
           int type, uintptr_t addr) {
  1003ed:	55                   	push   %ebp
  1003ee:	89 e5                	mov    %esp,%ebp
  1003f0:	83 ec 20             	sub    $0x20,%esp
    int l = *region_left, r = *region_right, any_matches = 0;
  1003f3:	8b 45 0c             	mov    0xc(%ebp),%eax
  1003f6:	8b 00                	mov    (%eax),%eax
  1003f8:	89 45 fc             	mov    %eax,-0x4(%ebp)
  1003fb:	8b 45 10             	mov    0x10(%ebp),%eax
  1003fe:	8b 00                	mov    (%eax),%eax
  100400:	89 45 f8             	mov    %eax,-0x8(%ebp)
  100403:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    while (l <= r) {
  10040a:	e9 d2 00 00 00       	jmp    1004e1 <stab_binsearch+0xf4>
        int true_m = (l + r) / 2, m = true_m;
  10040f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  100412:	8b 55 fc             	mov    -0x4(%ebp),%edx
  100415:	01 d0                	add    %edx,%eax
  100417:	89 c2                	mov    %eax,%edx
  100419:	c1 ea 1f             	shr    $0x1f,%edx
  10041c:	01 d0                	add    %edx,%eax
  10041e:	d1 f8                	sar    %eax
  100420:	89 45 ec             	mov    %eax,-0x14(%ebp)
  100423:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100426:	89 45 f0             	mov    %eax,-0x10(%ebp)

        // search for earliest stab with right type
        while (m >= l && stabs[m].n_type != type) {
  100429:	eb 04                	jmp    10042f <stab_binsearch+0x42>
            m --;
  10042b:	83 6d f0 01          	subl   $0x1,-0x10(%ebp)

    while (l <= r) {
        int true_m = (l + r) / 2, m = true_m;

        // search for earliest stab with right type
        while (m >= l && stabs[m].n_type != type) {
  10042f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100432:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  100435:	7c 1f                	jl     100456 <stab_binsearch+0x69>
  100437:	8b 55 f0             	mov    -0x10(%ebp),%edx
  10043a:	89 d0                	mov    %edx,%eax
  10043c:	01 c0                	add    %eax,%eax
  10043e:	01 d0                	add    %edx,%eax
  100440:	c1 e0 02             	shl    $0x2,%eax
  100443:	89 c2                	mov    %eax,%edx
  100445:	8b 45 08             	mov    0x8(%ebp),%eax
  100448:	01 d0                	add    %edx,%eax
  10044a:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  10044e:	0f b6 c0             	movzbl %al,%eax
  100451:	3b 45 14             	cmp    0x14(%ebp),%eax
  100454:	75 d5                	jne    10042b <stab_binsearch+0x3e>
            m --;
        }
        if (m < l) {    // no match in [l, m]
  100456:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100459:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  10045c:	7d 0b                	jge    100469 <stab_binsearch+0x7c>
            l = true_m + 1;
  10045e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100461:	83 c0 01             	add    $0x1,%eax
  100464:	89 45 fc             	mov    %eax,-0x4(%ebp)
            continue;
  100467:	eb 78                	jmp    1004e1 <stab_binsearch+0xf4>
        }

        // actual binary search
        any_matches = 1;
  100469:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        if (stabs[m].n_value < addr) {
  100470:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100473:	89 d0                	mov    %edx,%eax
  100475:	01 c0                	add    %eax,%eax
  100477:	01 d0                	add    %edx,%eax
  100479:	c1 e0 02             	shl    $0x2,%eax
  10047c:	89 c2                	mov    %eax,%edx
  10047e:	8b 45 08             	mov    0x8(%ebp),%eax
  100481:	01 d0                	add    %edx,%eax
  100483:	8b 40 08             	mov    0x8(%eax),%eax
  100486:	3b 45 18             	cmp    0x18(%ebp),%eax
  100489:	73 13                	jae    10049e <stab_binsearch+0xb1>
            *region_left = m;
  10048b:	8b 45 0c             	mov    0xc(%ebp),%eax
  10048e:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100491:	89 10                	mov    %edx,(%eax)
            l = true_m + 1;
  100493:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100496:	83 c0 01             	add    $0x1,%eax
  100499:	89 45 fc             	mov    %eax,-0x4(%ebp)
  10049c:	eb 43                	jmp    1004e1 <stab_binsearch+0xf4>
        } else if (stabs[m].n_value > addr) {
  10049e:	8b 55 f0             	mov    -0x10(%ebp),%edx
  1004a1:	89 d0                	mov    %edx,%eax
  1004a3:	01 c0                	add    %eax,%eax
  1004a5:	01 d0                	add    %edx,%eax
  1004a7:	c1 e0 02             	shl    $0x2,%eax
  1004aa:	89 c2                	mov    %eax,%edx
  1004ac:	8b 45 08             	mov    0x8(%ebp),%eax
  1004af:	01 d0                	add    %edx,%eax
  1004b1:	8b 40 08             	mov    0x8(%eax),%eax
  1004b4:	3b 45 18             	cmp    0x18(%ebp),%eax
  1004b7:	76 16                	jbe    1004cf <stab_binsearch+0xe2>
            *region_right = m - 1;
  1004b9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1004bc:	8d 50 ff             	lea    -0x1(%eax),%edx
  1004bf:	8b 45 10             	mov    0x10(%ebp),%eax
  1004c2:	89 10                	mov    %edx,(%eax)
            r = m - 1;
  1004c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1004c7:	83 e8 01             	sub    $0x1,%eax
  1004ca:	89 45 f8             	mov    %eax,-0x8(%ebp)
  1004cd:	eb 12                	jmp    1004e1 <stab_binsearch+0xf4>
        } else {
            // exact match for 'addr', but continue loop to find
            // *region_right
            *region_left = m;
  1004cf:	8b 45 0c             	mov    0xc(%ebp),%eax
  1004d2:	8b 55 f0             	mov    -0x10(%ebp),%edx
  1004d5:	89 10                	mov    %edx,(%eax)
            l = m;
  1004d7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1004da:	89 45 fc             	mov    %eax,-0x4(%ebp)
            addr ++;
  1004dd:	83 45 18 01          	addl   $0x1,0x18(%ebp)
static void
stab_binsearch(const struct stab *stabs, int *region_left, int *region_right,
           int type, uintptr_t addr) {
    int l = *region_left, r = *region_right, any_matches = 0;

    while (l <= r) {
  1004e1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1004e4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  1004e7:	0f 8e 22 ff ff ff    	jle    10040f <stab_binsearch+0x22>
            l = m;
            addr ++;
        }
    }

    if (!any_matches) {
  1004ed:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1004f1:	75 0f                	jne    100502 <stab_binsearch+0x115>
        *region_right = *region_left - 1;
  1004f3:	8b 45 0c             	mov    0xc(%ebp),%eax
  1004f6:	8b 00                	mov    (%eax),%eax
  1004f8:	8d 50 ff             	lea    -0x1(%eax),%edx
  1004fb:	8b 45 10             	mov    0x10(%ebp),%eax
  1004fe:	89 10                	mov    %edx,(%eax)
  100500:	eb 3f                	jmp    100541 <stab_binsearch+0x154>
    }
    else {
        // find rightmost region containing 'addr'
        l = *region_right;
  100502:	8b 45 10             	mov    0x10(%ebp),%eax
  100505:	8b 00                	mov    (%eax),%eax
  100507:	89 45 fc             	mov    %eax,-0x4(%ebp)
        for (; l > *region_left && stabs[l].n_type != type; l --)
  10050a:	eb 04                	jmp    100510 <stab_binsearch+0x123>
  10050c:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
  100510:	8b 45 0c             	mov    0xc(%ebp),%eax
  100513:	8b 00                	mov    (%eax),%eax
  100515:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  100518:	7d 1f                	jge    100539 <stab_binsearch+0x14c>
  10051a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  10051d:	89 d0                	mov    %edx,%eax
  10051f:	01 c0                	add    %eax,%eax
  100521:	01 d0                	add    %edx,%eax
  100523:	c1 e0 02             	shl    $0x2,%eax
  100526:	89 c2                	mov    %eax,%edx
  100528:	8b 45 08             	mov    0x8(%ebp),%eax
  10052b:	01 d0                	add    %edx,%eax
  10052d:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  100531:	0f b6 c0             	movzbl %al,%eax
  100534:	3b 45 14             	cmp    0x14(%ebp),%eax
  100537:	75 d3                	jne    10050c <stab_binsearch+0x11f>
            /* do nothing */;
        *region_left = l;
  100539:	8b 45 0c             	mov    0xc(%ebp),%eax
  10053c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  10053f:	89 10                	mov    %edx,(%eax)
    }
}
  100541:	c9                   	leave  
  100542:	c3                   	ret    

00100543 <debuginfo_eip>:
 * the specified instruction address, @addr.  Returns 0 if information
 * was found, and negative if not.  But even if it returns negative it
 * has stored some information into '*info'.
 * */
int
debuginfo_eip(uintptr_t addr, struct eipdebuginfo *info) {
  100543:	55                   	push   %ebp
  100544:	89 e5                	mov    %esp,%ebp
  100546:	83 ec 58             	sub    $0x58,%esp
    const struct stab *stabs, *stab_end;
    const char *stabstr, *stabstr_end;

    info->eip_file = "<unknown>";
  100549:	8b 45 0c             	mov    0xc(%ebp),%eax
  10054c:	c7 00 8c 61 10 00    	movl   $0x10618c,(%eax)
    info->eip_line = 0;
  100552:	8b 45 0c             	mov    0xc(%ebp),%eax
  100555:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    info->eip_fn_name = "<unknown>";
  10055c:	8b 45 0c             	mov    0xc(%ebp),%eax
  10055f:	c7 40 08 8c 61 10 00 	movl   $0x10618c,0x8(%eax)
    info->eip_fn_namelen = 9;
  100566:	8b 45 0c             	mov    0xc(%ebp),%eax
  100569:	c7 40 0c 09 00 00 00 	movl   $0x9,0xc(%eax)
    info->eip_fn_addr = addr;
  100570:	8b 45 0c             	mov    0xc(%ebp),%eax
  100573:	8b 55 08             	mov    0x8(%ebp),%edx
  100576:	89 50 10             	mov    %edx,0x10(%eax)
    info->eip_fn_narg = 0;
  100579:	8b 45 0c             	mov    0xc(%ebp),%eax
  10057c:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)

    stabs = __STAB_BEGIN__;
  100583:	c7 45 f4 e0 73 10 00 	movl   $0x1073e0,-0xc(%ebp)
    stab_end = __STAB_END__;
  10058a:	c7 45 f0 a4 21 11 00 	movl   $0x1121a4,-0x10(%ebp)
    stabstr = __STABSTR_BEGIN__;
  100591:	c7 45 ec a5 21 11 00 	movl   $0x1121a5,-0x14(%ebp)
    stabstr_end = __STABSTR_END__;
  100598:	c7 45 e8 32 4c 11 00 	movl   $0x114c32,-0x18(%ebp)

    // String table validity checks
    if (stabstr_end <= stabstr || stabstr_end[-1] != 0) {
  10059f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1005a2:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  1005a5:	76 0d                	jbe    1005b4 <debuginfo_eip+0x71>
  1005a7:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1005aa:	83 e8 01             	sub    $0x1,%eax
  1005ad:	0f b6 00             	movzbl (%eax),%eax
  1005b0:	84 c0                	test   %al,%al
  1005b2:	74 0a                	je     1005be <debuginfo_eip+0x7b>
        return -1;
  1005b4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1005b9:	e9 c0 02 00 00       	jmp    10087e <debuginfo_eip+0x33b>
    // 'eip'.  First, we find the basic source file containing 'eip'.
    // Then, we look in that source file for the function.  Then we look
    // for the line number.

    // Search the entire set of stabs for the source file (type N_SO).
    int lfile = 0, rfile = (stab_end - stabs) - 1;
  1005be:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  1005c5:	8b 55 f0             	mov    -0x10(%ebp),%edx
  1005c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1005cb:	29 c2                	sub    %eax,%edx
  1005cd:	89 d0                	mov    %edx,%eax
  1005cf:	c1 f8 02             	sar    $0x2,%eax
  1005d2:	69 c0 ab aa aa aa    	imul   $0xaaaaaaab,%eax,%eax
  1005d8:	83 e8 01             	sub    $0x1,%eax
  1005db:	89 45 e0             	mov    %eax,-0x20(%ebp)
    stab_binsearch(stabs, &lfile, &rfile, N_SO, addr);
  1005de:	8b 45 08             	mov    0x8(%ebp),%eax
  1005e1:	89 44 24 10          	mov    %eax,0x10(%esp)
  1005e5:	c7 44 24 0c 64 00 00 	movl   $0x64,0xc(%esp)
  1005ec:	00 
  1005ed:	8d 45 e0             	lea    -0x20(%ebp),%eax
  1005f0:	89 44 24 08          	mov    %eax,0x8(%esp)
  1005f4:	8d 45 e4             	lea    -0x1c(%ebp),%eax
  1005f7:	89 44 24 04          	mov    %eax,0x4(%esp)
  1005fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1005fe:	89 04 24             	mov    %eax,(%esp)
  100601:	e8 e7 fd ff ff       	call   1003ed <stab_binsearch>
    if (lfile == 0)
  100606:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  100609:	85 c0                	test   %eax,%eax
  10060b:	75 0a                	jne    100617 <debuginfo_eip+0xd4>
        return -1;
  10060d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  100612:	e9 67 02 00 00       	jmp    10087e <debuginfo_eip+0x33b>

    // Search within that file's stabs for the function definition
    // (N_FUN).
    int lfun = lfile, rfun = rfile;
  100617:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  10061a:	89 45 dc             	mov    %eax,-0x24(%ebp)
  10061d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  100620:	89 45 d8             	mov    %eax,-0x28(%ebp)
    int lline, rline;
    stab_binsearch(stabs, &lfun, &rfun, N_FUN, addr);
  100623:	8b 45 08             	mov    0x8(%ebp),%eax
  100626:	89 44 24 10          	mov    %eax,0x10(%esp)
  10062a:	c7 44 24 0c 24 00 00 	movl   $0x24,0xc(%esp)
  100631:	00 
  100632:	8d 45 d8             	lea    -0x28(%ebp),%eax
  100635:	89 44 24 08          	mov    %eax,0x8(%esp)
  100639:	8d 45 dc             	lea    -0x24(%ebp),%eax
  10063c:	89 44 24 04          	mov    %eax,0x4(%esp)
  100640:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100643:	89 04 24             	mov    %eax,(%esp)
  100646:	e8 a2 fd ff ff       	call   1003ed <stab_binsearch>

    if (lfun <= rfun) {
  10064b:	8b 55 dc             	mov    -0x24(%ebp),%edx
  10064e:	8b 45 d8             	mov    -0x28(%ebp),%eax
  100651:	39 c2                	cmp    %eax,%edx
  100653:	7f 7c                	jg     1006d1 <debuginfo_eip+0x18e>
        // stabs[lfun] points to the function name
        // in the string table, but check bounds just in case.
        if (stabs[lfun].n_strx < stabstr_end - stabstr) {
  100655:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100658:	89 c2                	mov    %eax,%edx
  10065a:	89 d0                	mov    %edx,%eax
  10065c:	01 c0                	add    %eax,%eax
  10065e:	01 d0                	add    %edx,%eax
  100660:	c1 e0 02             	shl    $0x2,%eax
  100663:	89 c2                	mov    %eax,%edx
  100665:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100668:	01 d0                	add    %edx,%eax
  10066a:	8b 10                	mov    (%eax),%edx
  10066c:	8b 4d e8             	mov    -0x18(%ebp),%ecx
  10066f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100672:	29 c1                	sub    %eax,%ecx
  100674:	89 c8                	mov    %ecx,%eax
  100676:	39 c2                	cmp    %eax,%edx
  100678:	73 22                	jae    10069c <debuginfo_eip+0x159>
            info->eip_fn_name = stabstr + stabs[lfun].n_strx;
  10067a:	8b 45 dc             	mov    -0x24(%ebp),%eax
  10067d:	89 c2                	mov    %eax,%edx
  10067f:	89 d0                	mov    %edx,%eax
  100681:	01 c0                	add    %eax,%eax
  100683:	01 d0                	add    %edx,%eax
  100685:	c1 e0 02             	shl    $0x2,%eax
  100688:	89 c2                	mov    %eax,%edx
  10068a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10068d:	01 d0                	add    %edx,%eax
  10068f:	8b 10                	mov    (%eax),%edx
  100691:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100694:	01 c2                	add    %eax,%edx
  100696:	8b 45 0c             	mov    0xc(%ebp),%eax
  100699:	89 50 08             	mov    %edx,0x8(%eax)
        }
        info->eip_fn_addr = stabs[lfun].n_value;
  10069c:	8b 45 dc             	mov    -0x24(%ebp),%eax
  10069f:	89 c2                	mov    %eax,%edx
  1006a1:	89 d0                	mov    %edx,%eax
  1006a3:	01 c0                	add    %eax,%eax
  1006a5:	01 d0                	add    %edx,%eax
  1006a7:	c1 e0 02             	shl    $0x2,%eax
  1006aa:	89 c2                	mov    %eax,%edx
  1006ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1006af:	01 d0                	add    %edx,%eax
  1006b1:	8b 50 08             	mov    0x8(%eax),%edx
  1006b4:	8b 45 0c             	mov    0xc(%ebp),%eax
  1006b7:	89 50 10             	mov    %edx,0x10(%eax)
        addr -= info->eip_fn_addr;
  1006ba:	8b 45 0c             	mov    0xc(%ebp),%eax
  1006bd:	8b 40 10             	mov    0x10(%eax),%eax
  1006c0:	29 45 08             	sub    %eax,0x8(%ebp)
        // Search within the function definition for the line number.
        lline = lfun;
  1006c3:	8b 45 dc             	mov    -0x24(%ebp),%eax
  1006c6:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        rline = rfun;
  1006c9:	8b 45 d8             	mov    -0x28(%ebp),%eax
  1006cc:	89 45 d0             	mov    %eax,-0x30(%ebp)
  1006cf:	eb 15                	jmp    1006e6 <debuginfo_eip+0x1a3>
    } else {
        // Couldn't find function stab!  Maybe we're in an assembly
        // file.  Search the whole file for the line number.
        info->eip_fn_addr = addr;
  1006d1:	8b 45 0c             	mov    0xc(%ebp),%eax
  1006d4:	8b 55 08             	mov    0x8(%ebp),%edx
  1006d7:	89 50 10             	mov    %edx,0x10(%eax)
        lline = lfile;
  1006da:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1006dd:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        rline = rfile;
  1006e0:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1006e3:	89 45 d0             	mov    %eax,-0x30(%ebp)
    }
    info->eip_fn_namelen = strfind(info->eip_fn_name, ':') - info->eip_fn_name;
  1006e6:	8b 45 0c             	mov    0xc(%ebp),%eax
  1006e9:	8b 40 08             	mov    0x8(%eax),%eax
  1006ec:	c7 44 24 04 3a 00 00 	movl   $0x3a,0x4(%esp)
  1006f3:	00 
  1006f4:	89 04 24             	mov    %eax,(%esp)
  1006f7:	e8 b0 56 00 00       	call   105dac <strfind>
  1006fc:	89 c2                	mov    %eax,%edx
  1006fe:	8b 45 0c             	mov    0xc(%ebp),%eax
  100701:	8b 40 08             	mov    0x8(%eax),%eax
  100704:	29 c2                	sub    %eax,%edx
  100706:	8b 45 0c             	mov    0xc(%ebp),%eax
  100709:	89 50 0c             	mov    %edx,0xc(%eax)

    // Search within [lline, rline] for the line number stab.
    // If found, set info->eip_line to the right line number.
    // If not found, return -1.
    stab_binsearch(stabs, &lline, &rline, N_SLINE, addr);
  10070c:	8b 45 08             	mov    0x8(%ebp),%eax
  10070f:	89 44 24 10          	mov    %eax,0x10(%esp)
  100713:	c7 44 24 0c 44 00 00 	movl   $0x44,0xc(%esp)
  10071a:	00 
  10071b:	8d 45 d0             	lea    -0x30(%ebp),%eax
  10071e:	89 44 24 08          	mov    %eax,0x8(%esp)
  100722:	8d 45 d4             	lea    -0x2c(%ebp),%eax
  100725:	89 44 24 04          	mov    %eax,0x4(%esp)
  100729:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10072c:	89 04 24             	mov    %eax,(%esp)
  10072f:	e8 b9 fc ff ff       	call   1003ed <stab_binsearch>
    if (lline <= rline) {
  100734:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  100737:	8b 45 d0             	mov    -0x30(%ebp),%eax
  10073a:	39 c2                	cmp    %eax,%edx
  10073c:	7f 24                	jg     100762 <debuginfo_eip+0x21f>
        info->eip_line = stabs[rline].n_desc;
  10073e:	8b 45 d0             	mov    -0x30(%ebp),%eax
  100741:	89 c2                	mov    %eax,%edx
  100743:	89 d0                	mov    %edx,%eax
  100745:	01 c0                	add    %eax,%eax
  100747:	01 d0                	add    %edx,%eax
  100749:	c1 e0 02             	shl    $0x2,%eax
  10074c:	89 c2                	mov    %eax,%edx
  10074e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100751:	01 d0                	add    %edx,%eax
  100753:	0f b7 40 06          	movzwl 0x6(%eax),%eax
  100757:	0f b7 d0             	movzwl %ax,%edx
  10075a:	8b 45 0c             	mov    0xc(%ebp),%eax
  10075d:	89 50 04             	mov    %edx,0x4(%eax)

    // Search backwards from the line number for the relevant filename stab.
    // We can't just use the "lfile" stab because inlined functions
    // can interpolate code from a different file!
    // Such included source files use the N_SOL stab type.
    while (lline >= lfile
  100760:	eb 13                	jmp    100775 <debuginfo_eip+0x232>
    // If not found, return -1.
    stab_binsearch(stabs, &lline, &rline, N_SLINE, addr);
    if (lline <= rline) {
        info->eip_line = stabs[rline].n_desc;
    } else {
        return -1;
  100762:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  100767:	e9 12 01 00 00       	jmp    10087e <debuginfo_eip+0x33b>
    // can interpolate code from a different file!
    // Such included source files use the N_SOL stab type.
    while (lline >= lfile
           && stabs[lline].n_type != N_SOL
           && (stabs[lline].n_type != N_SO || !stabs[lline].n_value)) {
        lline --;
  10076c:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  10076f:	83 e8 01             	sub    $0x1,%eax
  100772:	89 45 d4             	mov    %eax,-0x2c(%ebp)

    // Search backwards from the line number for the relevant filename stab.
    // We can't just use the "lfile" stab because inlined functions
    // can interpolate code from a different file!
    // Such included source files use the N_SOL stab type.
    while (lline >= lfile
  100775:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  100778:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  10077b:	39 c2                	cmp    %eax,%edx
  10077d:	7c 56                	jl     1007d5 <debuginfo_eip+0x292>
           && stabs[lline].n_type != N_SOL
  10077f:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100782:	89 c2                	mov    %eax,%edx
  100784:	89 d0                	mov    %edx,%eax
  100786:	01 c0                	add    %eax,%eax
  100788:	01 d0                	add    %edx,%eax
  10078a:	c1 e0 02             	shl    $0x2,%eax
  10078d:	89 c2                	mov    %eax,%edx
  10078f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100792:	01 d0                	add    %edx,%eax
  100794:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  100798:	3c 84                	cmp    $0x84,%al
  10079a:	74 39                	je     1007d5 <debuginfo_eip+0x292>
           && (stabs[lline].n_type != N_SO || !stabs[lline].n_value)) {
  10079c:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  10079f:	89 c2                	mov    %eax,%edx
  1007a1:	89 d0                	mov    %edx,%eax
  1007a3:	01 c0                	add    %eax,%eax
  1007a5:	01 d0                	add    %edx,%eax
  1007a7:	c1 e0 02             	shl    $0x2,%eax
  1007aa:	89 c2                	mov    %eax,%edx
  1007ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1007af:	01 d0                	add    %edx,%eax
  1007b1:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  1007b5:	3c 64                	cmp    $0x64,%al
  1007b7:	75 b3                	jne    10076c <debuginfo_eip+0x229>
  1007b9:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1007bc:	89 c2                	mov    %eax,%edx
  1007be:	89 d0                	mov    %edx,%eax
  1007c0:	01 c0                	add    %eax,%eax
  1007c2:	01 d0                	add    %edx,%eax
  1007c4:	c1 e0 02             	shl    $0x2,%eax
  1007c7:	89 c2                	mov    %eax,%edx
  1007c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1007cc:	01 d0                	add    %edx,%eax
  1007ce:	8b 40 08             	mov    0x8(%eax),%eax
  1007d1:	85 c0                	test   %eax,%eax
  1007d3:	74 97                	je     10076c <debuginfo_eip+0x229>
        lline --;
    }
    if (lline >= lfile && stabs[lline].n_strx < stabstr_end - stabstr) {
  1007d5:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  1007d8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1007db:	39 c2                	cmp    %eax,%edx
  1007dd:	7c 46                	jl     100825 <debuginfo_eip+0x2e2>
  1007df:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1007e2:	89 c2                	mov    %eax,%edx
  1007e4:	89 d0                	mov    %edx,%eax
  1007e6:	01 c0                	add    %eax,%eax
  1007e8:	01 d0                	add    %edx,%eax
  1007ea:	c1 e0 02             	shl    $0x2,%eax
  1007ed:	89 c2                	mov    %eax,%edx
  1007ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1007f2:	01 d0                	add    %edx,%eax
  1007f4:	8b 10                	mov    (%eax),%edx
  1007f6:	8b 4d e8             	mov    -0x18(%ebp),%ecx
  1007f9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1007fc:	29 c1                	sub    %eax,%ecx
  1007fe:	89 c8                	mov    %ecx,%eax
  100800:	39 c2                	cmp    %eax,%edx
  100802:	73 21                	jae    100825 <debuginfo_eip+0x2e2>
        info->eip_file = stabstr + stabs[lline].n_strx;
  100804:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100807:	89 c2                	mov    %eax,%edx
  100809:	89 d0                	mov    %edx,%eax
  10080b:	01 c0                	add    %eax,%eax
  10080d:	01 d0                	add    %edx,%eax
  10080f:	c1 e0 02             	shl    $0x2,%eax
  100812:	89 c2                	mov    %eax,%edx
  100814:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100817:	01 d0                	add    %edx,%eax
  100819:	8b 10                	mov    (%eax),%edx
  10081b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10081e:	01 c2                	add    %eax,%edx
  100820:	8b 45 0c             	mov    0xc(%ebp),%eax
  100823:	89 10                	mov    %edx,(%eax)
    }

    // Set eip_fn_narg to the number of arguments taken by the function,
    // or 0 if there was no containing function.
    if (lfun < rfun) {
  100825:	8b 55 dc             	mov    -0x24(%ebp),%edx
  100828:	8b 45 d8             	mov    -0x28(%ebp),%eax
  10082b:	39 c2                	cmp    %eax,%edx
  10082d:	7d 4a                	jge    100879 <debuginfo_eip+0x336>
        for (lline = lfun + 1;
  10082f:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100832:	83 c0 01             	add    $0x1,%eax
  100835:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  100838:	eb 18                	jmp    100852 <debuginfo_eip+0x30f>
             lline < rfun && stabs[lline].n_type == N_PSYM;
             lline ++) {
            info->eip_fn_narg ++;
  10083a:	8b 45 0c             	mov    0xc(%ebp),%eax
  10083d:	8b 40 14             	mov    0x14(%eax),%eax
  100840:	8d 50 01             	lea    0x1(%eax),%edx
  100843:	8b 45 0c             	mov    0xc(%ebp),%eax
  100846:	89 50 14             	mov    %edx,0x14(%eax)
    // Set eip_fn_narg to the number of arguments taken by the function,
    // or 0 if there was no containing function.
    if (lfun < rfun) {
        for (lline = lfun + 1;
             lline < rfun && stabs[lline].n_type == N_PSYM;
             lline ++) {
  100849:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  10084c:	83 c0 01             	add    $0x1,%eax
  10084f:	89 45 d4             	mov    %eax,-0x2c(%ebp)

    // Set eip_fn_narg to the number of arguments taken by the function,
    // or 0 if there was no containing function.
    if (lfun < rfun) {
        for (lline = lfun + 1;
             lline < rfun && stabs[lline].n_type == N_PSYM;
  100852:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  100855:	8b 45 d8             	mov    -0x28(%ebp),%eax
    }

    // Set eip_fn_narg to the number of arguments taken by the function,
    // or 0 if there was no containing function.
    if (lfun < rfun) {
        for (lline = lfun + 1;
  100858:	39 c2                	cmp    %eax,%edx
  10085a:	7d 1d                	jge    100879 <debuginfo_eip+0x336>
             lline < rfun && stabs[lline].n_type == N_PSYM;
  10085c:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  10085f:	89 c2                	mov    %eax,%edx
  100861:	89 d0                	mov    %edx,%eax
  100863:	01 c0                	add    %eax,%eax
  100865:	01 d0                	add    %edx,%eax
  100867:	c1 e0 02             	shl    $0x2,%eax
  10086a:	89 c2                	mov    %eax,%edx
  10086c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10086f:	01 d0                	add    %edx,%eax
  100871:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  100875:	3c a0                	cmp    $0xa0,%al
  100877:	74 c1                	je     10083a <debuginfo_eip+0x2f7>
             lline ++) {
            info->eip_fn_narg ++;
        }
    }
    return 0;
  100879:	b8 00 00 00 00       	mov    $0x0,%eax
}
  10087e:	c9                   	leave  
  10087f:	c3                   	ret    

00100880 <print_kerninfo>:
 * print_kerninfo - print the information about kernel, including the location
 * of kernel entry, the start addresses of data and text segements, the start
 * address of free memory and how many memory that kernel has used.
 * */
void
print_kerninfo(void) {
  100880:	55                   	push   %ebp
  100881:	89 e5                	mov    %esp,%ebp
  100883:	83 ec 18             	sub    $0x18,%esp
    extern char etext[], edata[], end[], kern_init[];
    cprintf("Special kernel symbols:\n");
  100886:	c7 04 24 96 61 10 00 	movl   $0x106196,(%esp)
  10088d:	e8 ba fa ff ff       	call   10034c <cprintf>
    cprintf("  entry  0x%08x (phys)\n", kern_init);
  100892:	c7 44 24 04 2a 00 10 	movl   $0x10002a,0x4(%esp)
  100899:	00 
  10089a:	c7 04 24 af 61 10 00 	movl   $0x1061af,(%esp)
  1008a1:	e8 a6 fa ff ff       	call   10034c <cprintf>
    cprintf("  etext  0x%08x (phys)\n", etext);
  1008a6:	c7 44 24 04 c1 60 10 	movl   $0x1060c1,0x4(%esp)
  1008ad:	00 
  1008ae:	c7 04 24 c7 61 10 00 	movl   $0x1061c7,(%esp)
  1008b5:	e8 92 fa ff ff       	call   10034c <cprintf>
    cprintf("  edata  0x%08x (phys)\n", edata);
  1008ba:	c7 44 24 04 36 7a 11 	movl   $0x117a36,0x4(%esp)
  1008c1:	00 
  1008c2:	c7 04 24 df 61 10 00 	movl   $0x1061df,(%esp)
  1008c9:	e8 7e fa ff ff       	call   10034c <cprintf>
    cprintf("  end    0x%08x (phys)\n", end);
  1008ce:	c7 44 24 04 c8 89 11 	movl   $0x1189c8,0x4(%esp)
  1008d5:	00 
  1008d6:	c7 04 24 f7 61 10 00 	movl   $0x1061f7,(%esp)
  1008dd:	e8 6a fa ff ff       	call   10034c <cprintf>
    cprintf("Kernel executable memory footprint: %dKB\n", (end - kern_init + 1023)/1024);
  1008e2:	b8 c8 89 11 00       	mov    $0x1189c8,%eax
  1008e7:	8d 90 ff 03 00 00    	lea    0x3ff(%eax),%edx
  1008ed:	b8 2a 00 10 00       	mov    $0x10002a,%eax
  1008f2:	29 c2                	sub    %eax,%edx
  1008f4:	89 d0                	mov    %edx,%eax
  1008f6:	8d 90 ff 03 00 00    	lea    0x3ff(%eax),%edx
  1008fc:	85 c0                	test   %eax,%eax
  1008fe:	0f 48 c2             	cmovs  %edx,%eax
  100901:	c1 f8 0a             	sar    $0xa,%eax
  100904:	89 44 24 04          	mov    %eax,0x4(%esp)
  100908:	c7 04 24 10 62 10 00 	movl   $0x106210,(%esp)
  10090f:	e8 38 fa ff ff       	call   10034c <cprintf>
}
  100914:	c9                   	leave  
  100915:	c3                   	ret    

00100916 <print_debuginfo>:
/* *
 * print_debuginfo - read and print the stat information for the address @eip,
 * and info.eip_fn_addr should be the first address of the related function.
 * */
void
print_debuginfo(uintptr_t eip) {
  100916:	55                   	push   %ebp
  100917:	89 e5                	mov    %esp,%ebp
  100919:	81 ec 48 01 00 00    	sub    $0x148,%esp
    struct eipdebuginfo info;
    if (debuginfo_eip(eip, &info) != 0) {
  10091f:	8d 45 dc             	lea    -0x24(%ebp),%eax
  100922:	89 44 24 04          	mov    %eax,0x4(%esp)
  100926:	8b 45 08             	mov    0x8(%ebp),%eax
  100929:	89 04 24             	mov    %eax,(%esp)
  10092c:	e8 12 fc ff ff       	call   100543 <debuginfo_eip>
  100931:	85 c0                	test   %eax,%eax
  100933:	74 15                	je     10094a <print_debuginfo+0x34>
        cprintf("    <unknow>: -- 0x%08x --\n", eip);
  100935:	8b 45 08             	mov    0x8(%ebp),%eax
  100938:	89 44 24 04          	mov    %eax,0x4(%esp)
  10093c:	c7 04 24 3a 62 10 00 	movl   $0x10623a,(%esp)
  100943:	e8 04 fa ff ff       	call   10034c <cprintf>
  100948:	eb 6d                	jmp    1009b7 <print_debuginfo+0xa1>
    }
    else {
        char fnname[256];
        int j;
        for (j = 0; j < info.eip_fn_namelen; j ++) {
  10094a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100951:	eb 1c                	jmp    10096f <print_debuginfo+0x59>
            fnname[j] = info.eip_fn_name[j];
  100953:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  100956:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100959:	01 d0                	add    %edx,%eax
  10095b:	0f b6 00             	movzbl (%eax),%eax
  10095e:	8d 8d dc fe ff ff    	lea    -0x124(%ebp),%ecx
  100964:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100967:	01 ca                	add    %ecx,%edx
  100969:	88 02                	mov    %al,(%edx)
        cprintf("    <unknow>: -- 0x%08x --\n", eip);
    }
    else {
        char fnname[256];
        int j;
        for (j = 0; j < info.eip_fn_namelen; j ++) {
  10096b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  10096f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100972:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  100975:	7f dc                	jg     100953 <print_debuginfo+0x3d>
            fnname[j] = info.eip_fn_name[j];
        }
        fnname[j] = '\0';
  100977:	8d 95 dc fe ff ff    	lea    -0x124(%ebp),%edx
  10097d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100980:	01 d0                	add    %edx,%eax
  100982:	c6 00 00             	movb   $0x0,(%eax)
        cprintf("    %s:%d: %s+%d\n", info.eip_file, info.eip_line,
                fnname, eip - info.eip_fn_addr);
  100985:	8b 45 ec             	mov    -0x14(%ebp),%eax
        int j;
        for (j = 0; j < info.eip_fn_namelen; j ++) {
            fnname[j] = info.eip_fn_name[j];
        }
        fnname[j] = '\0';
        cprintf("    %s:%d: %s+%d\n", info.eip_file, info.eip_line,
  100988:	8b 55 08             	mov    0x8(%ebp),%edx
  10098b:	89 d1                	mov    %edx,%ecx
  10098d:	29 c1                	sub    %eax,%ecx
  10098f:	8b 55 e0             	mov    -0x20(%ebp),%edx
  100992:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100995:	89 4c 24 10          	mov    %ecx,0x10(%esp)
  100999:	8d 8d dc fe ff ff    	lea    -0x124(%ebp),%ecx
  10099f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  1009a3:	89 54 24 08          	mov    %edx,0x8(%esp)
  1009a7:	89 44 24 04          	mov    %eax,0x4(%esp)
  1009ab:	c7 04 24 56 62 10 00 	movl   $0x106256,(%esp)
  1009b2:	e8 95 f9 ff ff       	call   10034c <cprintf>
                fnname, eip - info.eip_fn_addr);
    }
}
  1009b7:	c9                   	leave  
  1009b8:	c3                   	ret    

001009b9 <read_eip>:

static __noinline uint32_t
read_eip(void) {
  1009b9:	55                   	push   %ebp
  1009ba:	89 e5                	mov    %esp,%ebp
  1009bc:	83 ec 10             	sub    $0x10,%esp
    uint32_t eip;
    asm volatile("movl 4(%%ebp), %0" : "=r" (eip));
  1009bf:	8b 45 04             	mov    0x4(%ebp),%eax
  1009c2:	89 45 fc             	mov    %eax,-0x4(%ebp)
    return eip;
  1009c5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  1009c8:	c9                   	leave  
  1009c9:	c3                   	ret    

001009ca <print_stackframe>:
 *
 * Note that, the length of ebp-chain is limited. In boot/bootasm.S, before jumping
 * to the kernel entry, the value of ebp has been set to zero, that's the boundary.
 * */
void
print_stackframe(void) {
  1009ca:	55                   	push   %ebp
  1009cb:	89 e5                	mov    %esp,%ebp
  1009cd:	53                   	push   %ebx
  1009ce:	83 ec 44             	sub    $0x44,%esp
}

static inline uint32_t
read_ebp(void) {
    uint32_t ebp;
    asm volatile ("movl %%ebp, %0" : "=r" (ebp));
  1009d1:	89 e8                	mov    %ebp,%eax
  1009d3:	89 45 e8             	mov    %eax,-0x18(%ebp)
    return ebp;
  1009d6:	8b 45 e8             	mov    -0x18(%ebp),%eax
      *    (3.5) popup a calling stackframe
      *           NOTICE: the calling funciton's return addr eip  = ss:[ebp+4]
      *                   the calling funciton's ebp = ss:[ebp]
      */

	uint32_t ebp= read_ebp(), eip= read_eip();
  1009d9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1009dc:	e8 d8 ff ff ff       	call   1009b9 <read_eip>
  1009e1:	89 45 f0             	mov    %eax,-0x10(%ebp)

	int i=0;
  1009e4:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
	while (ebp!=0 && (i++)<STACKFRAME_DEPTH )
  1009eb:	e9 b9 00 00 00       	jmp    100aa9 <print_stackframe+0xdf>
	{
		uint32_t args[4]={0};
  1009f0:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
  1009f7:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  1009fe:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  100a05:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
		asm volatile ("movl 8(%1), %0" : "=r" (args[0])  : "r"(ebp));
  100a0c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a0f:	8b 40 08             	mov    0x8(%eax),%eax
  100a12:	89 45 d8             	mov    %eax,-0x28(%ebp)
		asm volatile ("movl 12(%1), %0" : "=r" (args[1])  : "r"(ebp));
  100a15:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a18:	8b 40 0c             	mov    0xc(%eax),%eax
  100a1b:	89 45 dc             	mov    %eax,-0x24(%ebp)
		asm volatile ("movl 16(%1), %0" : "=r" (args[2])  : "r"(ebp));
  100a1e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a21:	8b 40 10             	mov    0x10(%eax),%eax
  100a24:	89 45 e0             	mov    %eax,-0x20(%ebp)
		asm volatile ("movl 20(%1), %0" : "=r" (args[3])  : "r"(ebp));
  100a27:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a2a:	8b 40 14             	mov    0x14(%eax),%eax
  100a2d:	89 45 e4             	mov    %eax,-0x1c(%ebp)

		cprintf("ebp:0x%08x", ebp);
  100a30:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a33:	89 44 24 04          	mov    %eax,0x4(%esp)
  100a37:	c7 04 24 68 62 10 00 	movl   $0x106268,(%esp)
  100a3e:	e8 09 f9 ff ff       	call   10034c <cprintf>
		cprintf(" eip:0x%08x", eip);
  100a43:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100a46:	89 44 24 04          	mov    %eax,0x4(%esp)
  100a4a:	c7 04 24 73 62 10 00 	movl   $0x106273,(%esp)
  100a51:	e8 f6 f8 ff ff       	call   10034c <cprintf>
		cprintf(" args:0x%08x 0x%08x 0x%08x 0x%08x", args[0], args[1], args[2], args[3]);
  100a56:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  100a59:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  100a5c:	8b 55 dc             	mov    -0x24(%ebp),%edx
  100a5f:	8b 45 d8             	mov    -0x28(%ebp),%eax
  100a62:	89 5c 24 10          	mov    %ebx,0x10(%esp)
  100a66:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  100a6a:	89 54 24 08          	mov    %edx,0x8(%esp)
  100a6e:	89 44 24 04          	mov    %eax,0x4(%esp)
  100a72:	c7 04 24 80 62 10 00 	movl   $0x106280,(%esp)
  100a79:	e8 ce f8 ff ff       	call   10034c <cprintf>
		cprintf("\n");
  100a7e:	c7 04 24 a2 62 10 00 	movl   $0x1062a2,(%esp)
  100a85:	e8 c2 f8 ff ff       	call   10034c <cprintf>
		print_debuginfo(eip-1);
  100a8a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100a8d:	83 e8 01             	sub    $0x1,%eax
  100a90:	89 04 24             	mov    %eax,(%esp)
  100a93:	e8 7e fe ff ff       	call   100916 <print_debuginfo>

		asm volatile ("movl 4(%1), %0" : "=r" (eip) : "r"(ebp));
  100a98:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a9b:	8b 40 04             	mov    0x4(%eax),%eax
  100a9e:	89 45 f0             	mov    %eax,-0x10(%ebp)
		asm volatile ("movl 0(%1), %0" : "=r" (ebp) : "r"(ebp));
  100aa1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100aa4:	8b 00                	mov    (%eax),%eax
  100aa6:	89 45 f4             	mov    %eax,-0xc(%ebp)
      */

	uint32_t ebp= read_ebp(), eip= read_eip();

	int i=0;
	while (ebp!=0 && (i++)<STACKFRAME_DEPTH )
  100aa9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100aad:	74 12                	je     100ac1 <print_stackframe+0xf7>
  100aaf:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100ab2:	8d 50 01             	lea    0x1(%eax),%edx
  100ab5:	89 55 ec             	mov    %edx,-0x14(%ebp)
  100ab8:	83 f8 13             	cmp    $0x13,%eax
  100abb:	0f 8e 2f ff ff ff    	jle    1009f0 <print_stackframe+0x26>
		print_debuginfo(eip-1);

		asm volatile ("movl 4(%1), %0" : "=r" (eip) : "r"(ebp));
		asm volatile ("movl 0(%1), %0" : "=r" (ebp) : "r"(ebp));
	}
}
  100ac1:	83 c4 44             	add    $0x44,%esp
  100ac4:	5b                   	pop    %ebx
  100ac5:	5d                   	pop    %ebp
  100ac6:	c3                   	ret    

00100ac7 <parse>:
#define MAXARGS         16
#define WHITESPACE      " \t\n\r"

/* parse - parse the command buffer into whitespace-separated arguments */
static int
parse(char *buf, char **argv) {
  100ac7:	55                   	push   %ebp
  100ac8:	89 e5                	mov    %esp,%ebp
  100aca:	83 ec 28             	sub    $0x28,%esp
    int argc = 0;
  100acd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while (1) {
        // find global whitespace
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100ad4:	eb 0c                	jmp    100ae2 <parse+0x1b>
            *buf ++ = '\0';
  100ad6:	8b 45 08             	mov    0x8(%ebp),%eax
  100ad9:	8d 50 01             	lea    0x1(%eax),%edx
  100adc:	89 55 08             	mov    %edx,0x8(%ebp)
  100adf:	c6 00 00             	movb   $0x0,(%eax)
static int
parse(char *buf, char **argv) {
    int argc = 0;
    while (1) {
        // find global whitespace
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100ae2:	8b 45 08             	mov    0x8(%ebp),%eax
  100ae5:	0f b6 00             	movzbl (%eax),%eax
  100ae8:	84 c0                	test   %al,%al
  100aea:	74 1d                	je     100b09 <parse+0x42>
  100aec:	8b 45 08             	mov    0x8(%ebp),%eax
  100aef:	0f b6 00             	movzbl (%eax),%eax
  100af2:	0f be c0             	movsbl %al,%eax
  100af5:	89 44 24 04          	mov    %eax,0x4(%esp)
  100af9:	c7 04 24 24 63 10 00 	movl   $0x106324,(%esp)
  100b00:	e8 74 52 00 00       	call   105d79 <strchr>
  100b05:	85 c0                	test   %eax,%eax
  100b07:	75 cd                	jne    100ad6 <parse+0xf>
            *buf ++ = '\0';
        }
        if (*buf == '\0') {
  100b09:	8b 45 08             	mov    0x8(%ebp),%eax
  100b0c:	0f b6 00             	movzbl (%eax),%eax
  100b0f:	84 c0                	test   %al,%al
  100b11:	75 02                	jne    100b15 <parse+0x4e>
            break;
  100b13:	eb 67                	jmp    100b7c <parse+0xb5>
        }

        // save and scan past next arg
        if (argc == MAXARGS - 1) {
  100b15:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
  100b19:	75 14                	jne    100b2f <parse+0x68>
            cprintf("Too many arguments (max %d).\n", MAXARGS);
  100b1b:	c7 44 24 04 10 00 00 	movl   $0x10,0x4(%esp)
  100b22:	00 
  100b23:	c7 04 24 29 63 10 00 	movl   $0x106329,(%esp)
  100b2a:	e8 1d f8 ff ff       	call   10034c <cprintf>
        }
        argv[argc ++] = buf;
  100b2f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100b32:	8d 50 01             	lea    0x1(%eax),%edx
  100b35:	89 55 f4             	mov    %edx,-0xc(%ebp)
  100b38:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  100b3f:	8b 45 0c             	mov    0xc(%ebp),%eax
  100b42:	01 c2                	add    %eax,%edx
  100b44:	8b 45 08             	mov    0x8(%ebp),%eax
  100b47:	89 02                	mov    %eax,(%edx)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
  100b49:	eb 04                	jmp    100b4f <parse+0x88>
            buf ++;
  100b4b:	83 45 08 01          	addl   $0x1,0x8(%ebp)
        // save and scan past next arg
        if (argc == MAXARGS - 1) {
            cprintf("Too many arguments (max %d).\n", MAXARGS);
        }
        argv[argc ++] = buf;
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
  100b4f:	8b 45 08             	mov    0x8(%ebp),%eax
  100b52:	0f b6 00             	movzbl (%eax),%eax
  100b55:	84 c0                	test   %al,%al
  100b57:	74 1d                	je     100b76 <parse+0xaf>
  100b59:	8b 45 08             	mov    0x8(%ebp),%eax
  100b5c:	0f b6 00             	movzbl (%eax),%eax
  100b5f:	0f be c0             	movsbl %al,%eax
  100b62:	89 44 24 04          	mov    %eax,0x4(%esp)
  100b66:	c7 04 24 24 63 10 00 	movl   $0x106324,(%esp)
  100b6d:	e8 07 52 00 00       	call   105d79 <strchr>
  100b72:	85 c0                	test   %eax,%eax
  100b74:	74 d5                	je     100b4b <parse+0x84>
            buf ++;
        }
    }
  100b76:	90                   	nop
static int
parse(char *buf, char **argv) {
    int argc = 0;
    while (1) {
        // find global whitespace
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100b77:	e9 66 ff ff ff       	jmp    100ae2 <parse+0x1b>
        argv[argc ++] = buf;
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
            buf ++;
        }
    }
    return argc;
  100b7c:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  100b7f:	c9                   	leave  
  100b80:	c3                   	ret    

00100b81 <runcmd>:
/* *
 * runcmd - parse the input string, split it into separated arguments
 * and then lookup and invoke some related commands/
 * */
static int
runcmd(char *buf, struct trapframe *tf) {
  100b81:	55                   	push   %ebp
  100b82:	89 e5                	mov    %esp,%ebp
  100b84:	83 ec 68             	sub    $0x68,%esp
    char *argv[MAXARGS];
    int argc = parse(buf, argv);
  100b87:	8d 45 b0             	lea    -0x50(%ebp),%eax
  100b8a:	89 44 24 04          	mov    %eax,0x4(%esp)
  100b8e:	8b 45 08             	mov    0x8(%ebp),%eax
  100b91:	89 04 24             	mov    %eax,(%esp)
  100b94:	e8 2e ff ff ff       	call   100ac7 <parse>
  100b99:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if (argc == 0) {
  100b9c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  100ba0:	75 0a                	jne    100bac <runcmd+0x2b>
        return 0;
  100ba2:	b8 00 00 00 00       	mov    $0x0,%eax
  100ba7:	e9 85 00 00 00       	jmp    100c31 <runcmd+0xb0>
    }
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
  100bac:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100bb3:	eb 5c                	jmp    100c11 <runcmd+0x90>
        if (strcmp(commands[i].name, argv[0]) == 0) {
  100bb5:	8b 4d b0             	mov    -0x50(%ebp),%ecx
  100bb8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100bbb:	89 d0                	mov    %edx,%eax
  100bbd:	01 c0                	add    %eax,%eax
  100bbf:	01 d0                	add    %edx,%eax
  100bc1:	c1 e0 02             	shl    $0x2,%eax
  100bc4:	05 20 70 11 00       	add    $0x117020,%eax
  100bc9:	8b 00                	mov    (%eax),%eax
  100bcb:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  100bcf:	89 04 24             	mov    %eax,(%esp)
  100bd2:	e8 03 51 00 00       	call   105cda <strcmp>
  100bd7:	85 c0                	test   %eax,%eax
  100bd9:	75 32                	jne    100c0d <runcmd+0x8c>
            return commands[i].func(argc - 1, argv + 1, tf);
  100bdb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100bde:	89 d0                	mov    %edx,%eax
  100be0:	01 c0                	add    %eax,%eax
  100be2:	01 d0                	add    %edx,%eax
  100be4:	c1 e0 02             	shl    $0x2,%eax
  100be7:	05 20 70 11 00       	add    $0x117020,%eax
  100bec:	8b 40 08             	mov    0x8(%eax),%eax
  100bef:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100bf2:	8d 4a ff             	lea    -0x1(%edx),%ecx
  100bf5:	8b 55 0c             	mov    0xc(%ebp),%edx
  100bf8:	89 54 24 08          	mov    %edx,0x8(%esp)
  100bfc:	8d 55 b0             	lea    -0x50(%ebp),%edx
  100bff:	83 c2 04             	add    $0x4,%edx
  100c02:	89 54 24 04          	mov    %edx,0x4(%esp)
  100c06:	89 0c 24             	mov    %ecx,(%esp)
  100c09:	ff d0                	call   *%eax
  100c0b:	eb 24                	jmp    100c31 <runcmd+0xb0>
    int argc = parse(buf, argv);
    if (argc == 0) {
        return 0;
    }
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
  100c0d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  100c11:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100c14:	83 f8 02             	cmp    $0x2,%eax
  100c17:	76 9c                	jbe    100bb5 <runcmd+0x34>
        if (strcmp(commands[i].name, argv[0]) == 0) {
            return commands[i].func(argc - 1, argv + 1, tf);
        }
    }
    cprintf("Unknown command '%s'\n", argv[0]);
  100c19:	8b 45 b0             	mov    -0x50(%ebp),%eax
  100c1c:	89 44 24 04          	mov    %eax,0x4(%esp)
  100c20:	c7 04 24 47 63 10 00 	movl   $0x106347,(%esp)
  100c27:	e8 20 f7 ff ff       	call   10034c <cprintf>
    return 0;
  100c2c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100c31:	c9                   	leave  
  100c32:	c3                   	ret    

00100c33 <kmonitor>:

/***** Implementations of basic kernel monitor commands *****/

void
kmonitor(struct trapframe *tf) {
  100c33:	55                   	push   %ebp
  100c34:	89 e5                	mov    %esp,%ebp
  100c36:	83 ec 28             	sub    $0x28,%esp
    cprintf("Welcome to the kernel debug monitor!!\n");
  100c39:	c7 04 24 60 63 10 00 	movl   $0x106360,(%esp)
  100c40:	e8 07 f7 ff ff       	call   10034c <cprintf>
    cprintf("Type 'help' for a list of commands.\n");
  100c45:	c7 04 24 88 63 10 00 	movl   $0x106388,(%esp)
  100c4c:	e8 fb f6 ff ff       	call   10034c <cprintf>

    if (tf != NULL) {
  100c51:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  100c55:	74 0b                	je     100c62 <kmonitor+0x2f>
        print_trapframe(tf);
  100c57:	8b 45 08             	mov    0x8(%ebp),%eax
  100c5a:	89 04 24             	mov    %eax,(%esp)
  100c5d:	e8 58 0e 00 00       	call   101aba <print_trapframe>
    }

    char *buf;
    while (1) {
        if ((buf = readline("K> ")) != NULL) {
  100c62:	c7 04 24 ad 63 10 00 	movl   $0x1063ad,(%esp)
  100c69:	e8 d5 f5 ff ff       	call   100243 <readline>
  100c6e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  100c71:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100c75:	74 18                	je     100c8f <kmonitor+0x5c>
            if (runcmd(buf, tf) < 0) {
  100c77:	8b 45 08             	mov    0x8(%ebp),%eax
  100c7a:	89 44 24 04          	mov    %eax,0x4(%esp)
  100c7e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100c81:	89 04 24             	mov    %eax,(%esp)
  100c84:	e8 f8 fe ff ff       	call   100b81 <runcmd>
  100c89:	85 c0                	test   %eax,%eax
  100c8b:	79 02                	jns    100c8f <kmonitor+0x5c>
                break;
  100c8d:	eb 02                	jmp    100c91 <kmonitor+0x5e>
            }
        }
    }
  100c8f:	eb d1                	jmp    100c62 <kmonitor+0x2f>
}
  100c91:	c9                   	leave  
  100c92:	c3                   	ret    

00100c93 <mon_help>:

/* mon_help - print the information about mon_* functions */
int
mon_help(int argc, char **argv, struct trapframe *tf) {
  100c93:	55                   	push   %ebp
  100c94:	89 e5                	mov    %esp,%ebp
  100c96:	83 ec 28             	sub    $0x28,%esp
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
  100c99:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100ca0:	eb 3f                	jmp    100ce1 <mon_help+0x4e>
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
  100ca2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100ca5:	89 d0                	mov    %edx,%eax
  100ca7:	01 c0                	add    %eax,%eax
  100ca9:	01 d0                	add    %edx,%eax
  100cab:	c1 e0 02             	shl    $0x2,%eax
  100cae:	05 20 70 11 00       	add    $0x117020,%eax
  100cb3:	8b 48 04             	mov    0x4(%eax),%ecx
  100cb6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100cb9:	89 d0                	mov    %edx,%eax
  100cbb:	01 c0                	add    %eax,%eax
  100cbd:	01 d0                	add    %edx,%eax
  100cbf:	c1 e0 02             	shl    $0x2,%eax
  100cc2:	05 20 70 11 00       	add    $0x117020,%eax
  100cc7:	8b 00                	mov    (%eax),%eax
  100cc9:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  100ccd:	89 44 24 04          	mov    %eax,0x4(%esp)
  100cd1:	c7 04 24 b1 63 10 00 	movl   $0x1063b1,(%esp)
  100cd8:	e8 6f f6 ff ff       	call   10034c <cprintf>

/* mon_help - print the information about mon_* functions */
int
mon_help(int argc, char **argv, struct trapframe *tf) {
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
  100cdd:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  100ce1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100ce4:	83 f8 02             	cmp    $0x2,%eax
  100ce7:	76 b9                	jbe    100ca2 <mon_help+0xf>
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
    }
    return 0;
  100ce9:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100cee:	c9                   	leave  
  100cef:	c3                   	ret    

00100cf0 <mon_kerninfo>:
/* *
 * mon_kerninfo - call print_kerninfo in kern/debug/kdebug.c to
 * print the memory occupancy in kernel.
 * */
int
mon_kerninfo(int argc, char **argv, struct trapframe *tf) {
  100cf0:	55                   	push   %ebp
  100cf1:	89 e5                	mov    %esp,%ebp
  100cf3:	83 ec 08             	sub    $0x8,%esp
    print_kerninfo();
  100cf6:	e8 85 fb ff ff       	call   100880 <print_kerninfo>
    return 0;
  100cfb:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100d00:	c9                   	leave  
  100d01:	c3                   	ret    

00100d02 <mon_backtrace>:
/* *
 * mon_backtrace - call print_stackframe in kern/debug/kdebug.c to
 * print a backtrace of the stack.
 * */
int
mon_backtrace(int argc, char **argv, struct trapframe *tf) {
  100d02:	55                   	push   %ebp
  100d03:	89 e5                	mov    %esp,%ebp
  100d05:	83 ec 08             	sub    $0x8,%esp
    print_stackframe();
  100d08:	e8 bd fc ff ff       	call   1009ca <print_stackframe>
    return 0;
  100d0d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100d12:	c9                   	leave  
  100d13:	c3                   	ret    

00100d14 <__panic>:
/* *
 * __panic - __panic is called on unresolvable fatal errors. it prints
 * "panic: 'message'", and then enters the kernel monitor.
 * */
void
__panic(const char *file, int line, const char *fmt, ...) {
  100d14:	55                   	push   %ebp
  100d15:	89 e5                	mov    %esp,%ebp
  100d17:	83 ec 28             	sub    $0x28,%esp
    if (is_panic) {
  100d1a:	a1 60 7e 11 00       	mov    0x117e60,%eax
  100d1f:	85 c0                	test   %eax,%eax
  100d21:	74 02                	je     100d25 <__panic+0x11>
        goto panic_dead;
  100d23:	eb 48                	jmp    100d6d <__panic+0x59>
    }
    is_panic = 1;
  100d25:	c7 05 60 7e 11 00 01 	movl   $0x1,0x117e60
  100d2c:	00 00 00 

    // print the 'message'
    va_list ap;
    va_start(ap, fmt);
  100d2f:	8d 45 14             	lea    0x14(%ebp),%eax
  100d32:	89 45 f4             	mov    %eax,-0xc(%ebp)
    cprintf("kernel panic at %s:%d:\n    ", file, line);
  100d35:	8b 45 0c             	mov    0xc(%ebp),%eax
  100d38:	89 44 24 08          	mov    %eax,0x8(%esp)
  100d3c:	8b 45 08             	mov    0x8(%ebp),%eax
  100d3f:	89 44 24 04          	mov    %eax,0x4(%esp)
  100d43:	c7 04 24 ba 63 10 00 	movl   $0x1063ba,(%esp)
  100d4a:	e8 fd f5 ff ff       	call   10034c <cprintf>
    vcprintf(fmt, ap);
  100d4f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100d52:	89 44 24 04          	mov    %eax,0x4(%esp)
  100d56:	8b 45 10             	mov    0x10(%ebp),%eax
  100d59:	89 04 24             	mov    %eax,(%esp)
  100d5c:	e8 b8 f5 ff ff       	call   100319 <vcprintf>
    cprintf("\n");
  100d61:	c7 04 24 d6 63 10 00 	movl   $0x1063d6,(%esp)
  100d68:	e8 df f5 ff ff       	call   10034c <cprintf>
    va_end(ap);

panic_dead:
    intr_disable();
  100d6d:	e8 85 09 00 00       	call   1016f7 <intr_disable>
    while (1) {
        kmonitor(NULL);
  100d72:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100d79:	e8 b5 fe ff ff       	call   100c33 <kmonitor>
    }
  100d7e:	eb f2                	jmp    100d72 <__panic+0x5e>

00100d80 <__warn>:
}

/* __warn - like panic, but don't */
void
__warn(const char *file, int line, const char *fmt, ...) {
  100d80:	55                   	push   %ebp
  100d81:	89 e5                	mov    %esp,%ebp
  100d83:	83 ec 28             	sub    $0x28,%esp
    va_list ap;
    va_start(ap, fmt);
  100d86:	8d 45 14             	lea    0x14(%ebp),%eax
  100d89:	89 45 f4             	mov    %eax,-0xc(%ebp)
    cprintf("kernel warning at %s:%d:\n    ", file, line);
  100d8c:	8b 45 0c             	mov    0xc(%ebp),%eax
  100d8f:	89 44 24 08          	mov    %eax,0x8(%esp)
  100d93:	8b 45 08             	mov    0x8(%ebp),%eax
  100d96:	89 44 24 04          	mov    %eax,0x4(%esp)
  100d9a:	c7 04 24 d8 63 10 00 	movl   $0x1063d8,(%esp)
  100da1:	e8 a6 f5 ff ff       	call   10034c <cprintf>
    vcprintf(fmt, ap);
  100da6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100da9:	89 44 24 04          	mov    %eax,0x4(%esp)
  100dad:	8b 45 10             	mov    0x10(%ebp),%eax
  100db0:	89 04 24             	mov    %eax,(%esp)
  100db3:	e8 61 f5 ff ff       	call   100319 <vcprintf>
    cprintf("\n");
  100db8:	c7 04 24 d6 63 10 00 	movl   $0x1063d6,(%esp)
  100dbf:	e8 88 f5 ff ff       	call   10034c <cprintf>
    va_end(ap);
}
  100dc4:	c9                   	leave  
  100dc5:	c3                   	ret    

00100dc6 <is_kernel_panic>:

bool
is_kernel_panic(void) {
  100dc6:	55                   	push   %ebp
  100dc7:	89 e5                	mov    %esp,%ebp
    return is_panic;
  100dc9:	a1 60 7e 11 00       	mov    0x117e60,%eax
}
  100dce:	5d                   	pop    %ebp
  100dcf:	c3                   	ret    

00100dd0 <clock_init>:
/* *
 * clock_init - initialize 8253 clock to interrupt 100 times per second,
 * and then enable IRQ_TIMER.
 * */
void
clock_init(void) {
  100dd0:	55                   	push   %ebp
  100dd1:	89 e5                	mov    %esp,%ebp
  100dd3:	83 ec 28             	sub    $0x28,%esp
  100dd6:	66 c7 45 f6 43 00    	movw   $0x43,-0xa(%ebp)
  100ddc:	c6 45 f5 34          	movb   $0x34,-0xb(%ebp)
        : "memory", "cc");
}

static inline void
outb(uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  100de0:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  100de4:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  100de8:	ee                   	out    %al,(%dx)
  100de9:	66 c7 45 f2 40 00    	movw   $0x40,-0xe(%ebp)
  100def:	c6 45 f1 9c          	movb   $0x9c,-0xf(%ebp)
  100df3:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  100df7:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  100dfb:	ee                   	out    %al,(%dx)
  100dfc:	66 c7 45 ee 40 00    	movw   $0x40,-0x12(%ebp)
  100e02:	c6 45 ed 2e          	movb   $0x2e,-0x13(%ebp)
  100e06:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  100e0a:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  100e0e:	ee                   	out    %al,(%dx)
    outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
    outb(IO_TIMER1, TIMER_DIV(100) % 256);
    outb(IO_TIMER1, TIMER_DIV(100) / 256);

    // initialize time counter 'ticks' to zero
    ticks = 0;
  100e0f:	c7 05 4c 89 11 00 00 	movl   $0x0,0x11894c
  100e16:	00 00 00 

    cprintf("++ setup timer interrupts\n");
  100e19:	c7 04 24 f6 63 10 00 	movl   $0x1063f6,(%esp)
  100e20:	e8 27 f5 ff ff       	call   10034c <cprintf>
    pic_enable(IRQ_TIMER);
  100e25:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100e2c:	e8 24 09 00 00       	call   101755 <pic_enable>
}
  100e31:	c9                   	leave  
  100e32:	c3                   	ret    

00100e33 <__intr_save>:
#include <x86.h>
#include <intr.h>
#include <mmu.h>

static inline bool
__intr_save(void) {
  100e33:	55                   	push   %ebp
  100e34:	89 e5                	mov    %esp,%ebp
  100e36:	83 ec 18             	sub    $0x18,%esp
}

static inline uint32_t
read_eflags(void) {
    uint32_t eflags;
    asm volatile ("pushfl; popl %0" : "=r" (eflags));
  100e39:	9c                   	pushf  
  100e3a:	58                   	pop    %eax
  100e3b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    return eflags;
  100e3e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    if (read_eflags() & FL_IF) {
  100e41:	25 00 02 00 00       	and    $0x200,%eax
  100e46:	85 c0                	test   %eax,%eax
  100e48:	74 0c                	je     100e56 <__intr_save+0x23>
        intr_disable();
  100e4a:	e8 a8 08 00 00       	call   1016f7 <intr_disable>
        return 1;
  100e4f:	b8 01 00 00 00       	mov    $0x1,%eax
  100e54:	eb 05                	jmp    100e5b <__intr_save+0x28>
    }
    return 0;
  100e56:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100e5b:	c9                   	leave  
  100e5c:	c3                   	ret    

00100e5d <__intr_restore>:

static inline void
__intr_restore(bool flag) {
  100e5d:	55                   	push   %ebp
  100e5e:	89 e5                	mov    %esp,%ebp
  100e60:	83 ec 08             	sub    $0x8,%esp
    if (flag) {
  100e63:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  100e67:	74 05                	je     100e6e <__intr_restore+0x11>
        intr_enable();
  100e69:	e8 83 08 00 00       	call   1016f1 <intr_enable>
    }
}
  100e6e:	c9                   	leave  
  100e6f:	c3                   	ret    

00100e70 <delay>:
#include <memlayout.h>
#include <sync.h>

/* stupid I/O delay routine necessitated by historical PC design flaws */
static void
delay(void) {
  100e70:	55                   	push   %ebp
  100e71:	89 e5                	mov    %esp,%ebp
  100e73:	83 ec 10             	sub    $0x10,%esp
  100e76:	66 c7 45 fe 84 00    	movw   $0x84,-0x2(%ebp)
static inline void invlpg(void *addr) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
  100e7c:	0f b7 45 fe          	movzwl -0x2(%ebp),%eax
  100e80:	89 c2                	mov    %eax,%edx
  100e82:	ec                   	in     (%dx),%al
  100e83:	88 45 fd             	mov    %al,-0x3(%ebp)
  100e86:	66 c7 45 fa 84 00    	movw   $0x84,-0x6(%ebp)
  100e8c:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  100e90:	89 c2                	mov    %eax,%edx
  100e92:	ec                   	in     (%dx),%al
  100e93:	88 45 f9             	mov    %al,-0x7(%ebp)
  100e96:	66 c7 45 f6 84 00    	movw   $0x84,-0xa(%ebp)
  100e9c:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  100ea0:	89 c2                	mov    %eax,%edx
  100ea2:	ec                   	in     (%dx),%al
  100ea3:	88 45 f5             	mov    %al,-0xb(%ebp)
  100ea6:	66 c7 45 f2 84 00    	movw   $0x84,-0xe(%ebp)
  100eac:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  100eb0:	89 c2                	mov    %eax,%edx
  100eb2:	ec                   	in     (%dx),%al
  100eb3:	88 45 f1             	mov    %al,-0xf(%ebp)
    inb(0x84);
    inb(0x84);
    inb(0x84);
    inb(0x84);
}
  100eb6:	c9                   	leave  
  100eb7:	c3                   	ret    

00100eb8 <cga_init>:
static uint16_t addr_6845;

/* TEXT-mode CGA/VGA display output */

static void
cga_init(void) {
  100eb8:	55                   	push   %ebp
  100eb9:	89 e5                	mov    %esp,%ebp
  100ebb:	83 ec 20             	sub    $0x20,%esp
    volatile uint16_t *cp = (uint16_t *)(CGA_BUF + KERNBASE);
  100ebe:	c7 45 fc 00 80 0b c0 	movl   $0xc00b8000,-0x4(%ebp)
    uint16_t was = *cp;
  100ec5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100ec8:	0f b7 00             	movzwl (%eax),%eax
  100ecb:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
    *cp = (uint16_t) 0xA55A;
  100ecf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100ed2:	66 c7 00 5a a5       	movw   $0xa55a,(%eax)
    if (*cp != 0xA55A) {
  100ed7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100eda:	0f b7 00             	movzwl (%eax),%eax
  100edd:	66 3d 5a a5          	cmp    $0xa55a,%ax
  100ee1:	74 12                	je     100ef5 <cga_init+0x3d>
        cp = (uint16_t*)(MONO_BUF + KERNBASE);
  100ee3:	c7 45 fc 00 00 0b c0 	movl   $0xc00b0000,-0x4(%ebp)
        addr_6845 = MONO_BASE;
  100eea:	66 c7 05 86 7e 11 00 	movw   $0x3b4,0x117e86
  100ef1:	b4 03 
  100ef3:	eb 13                	jmp    100f08 <cga_init+0x50>
    } else {
        *cp = was;
  100ef5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100ef8:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  100efc:	66 89 10             	mov    %dx,(%eax)
        addr_6845 = CGA_BASE;
  100eff:	66 c7 05 86 7e 11 00 	movw   $0x3d4,0x117e86
  100f06:	d4 03 
    }

    // Extract cursor location
    uint32_t pos;
    outb(addr_6845, 14);
  100f08:	0f b7 05 86 7e 11 00 	movzwl 0x117e86,%eax
  100f0f:	0f b7 c0             	movzwl %ax,%eax
  100f12:	66 89 45 f2          	mov    %ax,-0xe(%ebp)
  100f16:	c6 45 f1 0e          	movb   $0xe,-0xf(%ebp)
        : "memory", "cc");
}

static inline void
outb(uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  100f1a:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  100f1e:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  100f22:	ee                   	out    %al,(%dx)
    pos = inb(addr_6845 + 1) << 8;
  100f23:	0f b7 05 86 7e 11 00 	movzwl 0x117e86,%eax
  100f2a:	83 c0 01             	add    $0x1,%eax
  100f2d:	0f b7 c0             	movzwl %ax,%eax
  100f30:	66 89 45 ee          	mov    %ax,-0x12(%ebp)
static inline void invlpg(void *addr) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
  100f34:	0f b7 45 ee          	movzwl -0x12(%ebp),%eax
  100f38:	89 c2                	mov    %eax,%edx
  100f3a:	ec                   	in     (%dx),%al
  100f3b:	88 45 ed             	mov    %al,-0x13(%ebp)
    return data;
  100f3e:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  100f42:	0f b6 c0             	movzbl %al,%eax
  100f45:	c1 e0 08             	shl    $0x8,%eax
  100f48:	89 45 f4             	mov    %eax,-0xc(%ebp)
    outb(addr_6845, 15);
  100f4b:	0f b7 05 86 7e 11 00 	movzwl 0x117e86,%eax
  100f52:	0f b7 c0             	movzwl %ax,%eax
  100f55:	66 89 45 ea          	mov    %ax,-0x16(%ebp)
  100f59:	c6 45 e9 0f          	movb   $0xf,-0x17(%ebp)
        : "memory", "cc");
}

static inline void
outb(uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  100f5d:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  100f61:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  100f65:	ee                   	out    %al,(%dx)
    pos |= inb(addr_6845 + 1);
  100f66:	0f b7 05 86 7e 11 00 	movzwl 0x117e86,%eax
  100f6d:	83 c0 01             	add    $0x1,%eax
  100f70:	0f b7 c0             	movzwl %ax,%eax
  100f73:	66 89 45 e6          	mov    %ax,-0x1a(%ebp)
static inline void invlpg(void *addr) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
  100f77:	0f b7 45 e6          	movzwl -0x1a(%ebp),%eax
  100f7b:	89 c2                	mov    %eax,%edx
  100f7d:	ec                   	in     (%dx),%al
  100f7e:	88 45 e5             	mov    %al,-0x1b(%ebp)
    return data;
  100f81:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  100f85:	0f b6 c0             	movzbl %al,%eax
  100f88:	09 45 f4             	or     %eax,-0xc(%ebp)

    crt_buf = (uint16_t*) cp;
  100f8b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100f8e:	a3 80 7e 11 00       	mov    %eax,0x117e80
    crt_pos = pos;
  100f93:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100f96:	66 a3 84 7e 11 00    	mov    %ax,0x117e84
}
  100f9c:	c9                   	leave  
  100f9d:	c3                   	ret    

00100f9e <serial_init>:

static bool serial_exists = 0;

static void
serial_init(void) {
  100f9e:	55                   	push   %ebp
  100f9f:	89 e5                	mov    %esp,%ebp
  100fa1:	83 ec 48             	sub    $0x48,%esp
  100fa4:	66 c7 45 f6 fa 03    	movw   $0x3fa,-0xa(%ebp)
  100faa:	c6 45 f5 00          	movb   $0x0,-0xb(%ebp)
        : "memory", "cc");
}

static inline void
outb(uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  100fae:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  100fb2:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  100fb6:	ee                   	out    %al,(%dx)
  100fb7:	66 c7 45 f2 fb 03    	movw   $0x3fb,-0xe(%ebp)
  100fbd:	c6 45 f1 80          	movb   $0x80,-0xf(%ebp)
  100fc1:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  100fc5:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  100fc9:	ee                   	out    %al,(%dx)
  100fca:	66 c7 45 ee f8 03    	movw   $0x3f8,-0x12(%ebp)
  100fd0:	c6 45 ed 0c          	movb   $0xc,-0x13(%ebp)
  100fd4:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  100fd8:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  100fdc:	ee                   	out    %al,(%dx)
  100fdd:	66 c7 45 ea f9 03    	movw   $0x3f9,-0x16(%ebp)
  100fe3:	c6 45 e9 00          	movb   $0x0,-0x17(%ebp)
  100fe7:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  100feb:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  100fef:	ee                   	out    %al,(%dx)
  100ff0:	66 c7 45 e6 fb 03    	movw   $0x3fb,-0x1a(%ebp)
  100ff6:	c6 45 e5 03          	movb   $0x3,-0x1b(%ebp)
  100ffa:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  100ffe:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  101002:	ee                   	out    %al,(%dx)
  101003:	66 c7 45 e2 fc 03    	movw   $0x3fc,-0x1e(%ebp)
  101009:	c6 45 e1 00          	movb   $0x0,-0x1f(%ebp)
  10100d:	0f b6 45 e1          	movzbl -0x1f(%ebp),%eax
  101011:	0f b7 55 e2          	movzwl -0x1e(%ebp),%edx
  101015:	ee                   	out    %al,(%dx)
  101016:	66 c7 45 de f9 03    	movw   $0x3f9,-0x22(%ebp)
  10101c:	c6 45 dd 01          	movb   $0x1,-0x23(%ebp)
  101020:	0f b6 45 dd          	movzbl -0x23(%ebp),%eax
  101024:	0f b7 55 de          	movzwl -0x22(%ebp),%edx
  101028:	ee                   	out    %al,(%dx)
  101029:	66 c7 45 da fd 03    	movw   $0x3fd,-0x26(%ebp)
static inline void invlpg(void *addr) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
  10102f:	0f b7 45 da          	movzwl -0x26(%ebp),%eax
  101033:	89 c2                	mov    %eax,%edx
  101035:	ec                   	in     (%dx),%al
  101036:	88 45 d9             	mov    %al,-0x27(%ebp)
    return data;
  101039:	0f b6 45 d9          	movzbl -0x27(%ebp),%eax
    // Enable rcv interrupts
    outb(COM1 + COM_IER, COM_IER_RDI);

    // Clear any preexisting overrun indications and interrupts
    // Serial port doesn't exist if COM_LSR returns 0xFF
    serial_exists = (inb(COM1 + COM_LSR) != 0xFF);
  10103d:	3c ff                	cmp    $0xff,%al
  10103f:	0f 95 c0             	setne  %al
  101042:	0f b6 c0             	movzbl %al,%eax
  101045:	a3 88 7e 11 00       	mov    %eax,0x117e88
  10104a:	66 c7 45 d6 fa 03    	movw   $0x3fa,-0x2a(%ebp)
static inline void invlpg(void *addr) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
  101050:	0f b7 45 d6          	movzwl -0x2a(%ebp),%eax
  101054:	89 c2                	mov    %eax,%edx
  101056:	ec                   	in     (%dx),%al
  101057:	88 45 d5             	mov    %al,-0x2b(%ebp)
  10105a:	66 c7 45 d2 f8 03    	movw   $0x3f8,-0x2e(%ebp)
  101060:	0f b7 45 d2          	movzwl -0x2e(%ebp),%eax
  101064:	89 c2                	mov    %eax,%edx
  101066:	ec                   	in     (%dx),%al
  101067:	88 45 d1             	mov    %al,-0x2f(%ebp)
    (void) inb(COM1+COM_IIR);
    (void) inb(COM1+COM_RX);

    if (serial_exists) {
  10106a:	a1 88 7e 11 00       	mov    0x117e88,%eax
  10106f:	85 c0                	test   %eax,%eax
  101071:	74 0c                	je     10107f <serial_init+0xe1>
        pic_enable(IRQ_COM1);
  101073:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
  10107a:	e8 d6 06 00 00       	call   101755 <pic_enable>
    }
}
  10107f:	c9                   	leave  
  101080:	c3                   	ret    

00101081 <lpt_putc_sub>:

static void
lpt_putc_sub(int c) {
  101081:	55                   	push   %ebp
  101082:	89 e5                	mov    %esp,%ebp
  101084:	83 ec 20             	sub    $0x20,%esp
    int i;
    for (i = 0; !(inb(LPTPORT + 1) & 0x80) && i < 12800; i ++) {
  101087:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  10108e:	eb 09                	jmp    101099 <lpt_putc_sub+0x18>
        delay();
  101090:	e8 db fd ff ff       	call   100e70 <delay>
}

static void
lpt_putc_sub(int c) {
    int i;
    for (i = 0; !(inb(LPTPORT + 1) & 0x80) && i < 12800; i ++) {
  101095:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  101099:	66 c7 45 fa 79 03    	movw   $0x379,-0x6(%ebp)
  10109f:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  1010a3:	89 c2                	mov    %eax,%edx
  1010a5:	ec                   	in     (%dx),%al
  1010a6:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  1010a9:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  1010ad:	84 c0                	test   %al,%al
  1010af:	78 09                	js     1010ba <lpt_putc_sub+0x39>
  1010b1:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%ebp)
  1010b8:	7e d6                	jle    101090 <lpt_putc_sub+0xf>
        delay();
    }
    outb(LPTPORT + 0, c);
  1010ba:	8b 45 08             	mov    0x8(%ebp),%eax
  1010bd:	0f b6 c0             	movzbl %al,%eax
  1010c0:	66 c7 45 f6 78 03    	movw   $0x378,-0xa(%ebp)
  1010c6:	88 45 f5             	mov    %al,-0xb(%ebp)
        : "memory", "cc");
}

static inline void
outb(uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  1010c9:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  1010cd:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  1010d1:	ee                   	out    %al,(%dx)
  1010d2:	66 c7 45 f2 7a 03    	movw   $0x37a,-0xe(%ebp)
  1010d8:	c6 45 f1 0d          	movb   $0xd,-0xf(%ebp)
  1010dc:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  1010e0:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  1010e4:	ee                   	out    %al,(%dx)
  1010e5:	66 c7 45 ee 7a 03    	movw   $0x37a,-0x12(%ebp)
  1010eb:	c6 45 ed 08          	movb   $0x8,-0x13(%ebp)
  1010ef:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  1010f3:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  1010f7:	ee                   	out    %al,(%dx)
    outb(LPTPORT + 2, 0x08 | 0x04 | 0x01);
    outb(LPTPORT + 2, 0x08);
}
  1010f8:	c9                   	leave  
  1010f9:	c3                   	ret    

001010fa <lpt_putc>:

/* lpt_putc - copy console output to parallel port */
static void
lpt_putc(int c) {
  1010fa:	55                   	push   %ebp
  1010fb:	89 e5                	mov    %esp,%ebp
  1010fd:	83 ec 04             	sub    $0x4,%esp
    if (c != '\b') {
  101100:	83 7d 08 08          	cmpl   $0x8,0x8(%ebp)
  101104:	74 0d                	je     101113 <lpt_putc+0x19>
        lpt_putc_sub(c);
  101106:	8b 45 08             	mov    0x8(%ebp),%eax
  101109:	89 04 24             	mov    %eax,(%esp)
  10110c:	e8 70 ff ff ff       	call   101081 <lpt_putc_sub>
  101111:	eb 24                	jmp    101137 <lpt_putc+0x3d>
    }
    else {
        lpt_putc_sub('\b');
  101113:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  10111a:	e8 62 ff ff ff       	call   101081 <lpt_putc_sub>
        lpt_putc_sub(' ');
  10111f:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  101126:	e8 56 ff ff ff       	call   101081 <lpt_putc_sub>
        lpt_putc_sub('\b');
  10112b:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  101132:	e8 4a ff ff ff       	call   101081 <lpt_putc_sub>
    }
}
  101137:	c9                   	leave  
  101138:	c3                   	ret    

00101139 <cga_putc>:

/* cga_putc - print character to console */
static void
cga_putc(int c) {
  101139:	55                   	push   %ebp
  10113a:	89 e5                	mov    %esp,%ebp
  10113c:	53                   	push   %ebx
  10113d:	83 ec 34             	sub    $0x34,%esp
    // set black on white
    if (!(c & ~0xFF)) {
  101140:	8b 45 08             	mov    0x8(%ebp),%eax
  101143:	b0 00                	mov    $0x0,%al
  101145:	85 c0                	test   %eax,%eax
  101147:	75 07                	jne    101150 <cga_putc+0x17>
        c |= 0x0700;
  101149:	81 4d 08 00 07 00 00 	orl    $0x700,0x8(%ebp)
    }

    switch (c & 0xff) {
  101150:	8b 45 08             	mov    0x8(%ebp),%eax
  101153:	0f b6 c0             	movzbl %al,%eax
  101156:	83 f8 0a             	cmp    $0xa,%eax
  101159:	74 4c                	je     1011a7 <cga_putc+0x6e>
  10115b:	83 f8 0d             	cmp    $0xd,%eax
  10115e:	74 57                	je     1011b7 <cga_putc+0x7e>
  101160:	83 f8 08             	cmp    $0x8,%eax
  101163:	0f 85 88 00 00 00    	jne    1011f1 <cga_putc+0xb8>
    case '\b':
        if (crt_pos > 0) {
  101169:	0f b7 05 84 7e 11 00 	movzwl 0x117e84,%eax
  101170:	66 85 c0             	test   %ax,%ax
  101173:	74 30                	je     1011a5 <cga_putc+0x6c>
            crt_pos --;
  101175:	0f b7 05 84 7e 11 00 	movzwl 0x117e84,%eax
  10117c:	83 e8 01             	sub    $0x1,%eax
  10117f:	66 a3 84 7e 11 00    	mov    %ax,0x117e84
            crt_buf[crt_pos] = (c & ~0xff) | ' ';
  101185:	a1 80 7e 11 00       	mov    0x117e80,%eax
  10118a:	0f b7 15 84 7e 11 00 	movzwl 0x117e84,%edx
  101191:	0f b7 d2             	movzwl %dx,%edx
  101194:	01 d2                	add    %edx,%edx
  101196:	01 c2                	add    %eax,%edx
  101198:	8b 45 08             	mov    0x8(%ebp),%eax
  10119b:	b0 00                	mov    $0x0,%al
  10119d:	83 c8 20             	or     $0x20,%eax
  1011a0:	66 89 02             	mov    %ax,(%edx)
        }
        break;
  1011a3:	eb 72                	jmp    101217 <cga_putc+0xde>
  1011a5:	eb 70                	jmp    101217 <cga_putc+0xde>
    case '\n':
        crt_pos += CRT_COLS;
  1011a7:	0f b7 05 84 7e 11 00 	movzwl 0x117e84,%eax
  1011ae:	83 c0 50             	add    $0x50,%eax
  1011b1:	66 a3 84 7e 11 00    	mov    %ax,0x117e84
    case '\r':
        crt_pos -= (crt_pos % CRT_COLS);
  1011b7:	0f b7 1d 84 7e 11 00 	movzwl 0x117e84,%ebx
  1011be:	0f b7 0d 84 7e 11 00 	movzwl 0x117e84,%ecx
  1011c5:	0f b7 c1             	movzwl %cx,%eax
  1011c8:	69 c0 cd cc 00 00    	imul   $0xcccd,%eax,%eax
  1011ce:	c1 e8 10             	shr    $0x10,%eax
  1011d1:	89 c2                	mov    %eax,%edx
  1011d3:	66 c1 ea 06          	shr    $0x6,%dx
  1011d7:	89 d0                	mov    %edx,%eax
  1011d9:	c1 e0 02             	shl    $0x2,%eax
  1011dc:	01 d0                	add    %edx,%eax
  1011de:	c1 e0 04             	shl    $0x4,%eax
  1011e1:	29 c1                	sub    %eax,%ecx
  1011e3:	89 ca                	mov    %ecx,%edx
  1011e5:	89 d8                	mov    %ebx,%eax
  1011e7:	29 d0                	sub    %edx,%eax
  1011e9:	66 a3 84 7e 11 00    	mov    %ax,0x117e84
        break;
  1011ef:	eb 26                	jmp    101217 <cga_putc+0xde>
    default:
        crt_buf[crt_pos ++] = c;     // write the character
  1011f1:	8b 0d 80 7e 11 00    	mov    0x117e80,%ecx
  1011f7:	0f b7 05 84 7e 11 00 	movzwl 0x117e84,%eax
  1011fe:	8d 50 01             	lea    0x1(%eax),%edx
  101201:	66 89 15 84 7e 11 00 	mov    %dx,0x117e84
  101208:	0f b7 c0             	movzwl %ax,%eax
  10120b:	01 c0                	add    %eax,%eax
  10120d:	8d 14 01             	lea    (%ecx,%eax,1),%edx
  101210:	8b 45 08             	mov    0x8(%ebp),%eax
  101213:	66 89 02             	mov    %ax,(%edx)
        break;
  101216:	90                   	nop
    }

    // What is the purpose of this?
    if (crt_pos >= CRT_SIZE) {
  101217:	0f b7 05 84 7e 11 00 	movzwl 0x117e84,%eax
  10121e:	66 3d cf 07          	cmp    $0x7cf,%ax
  101222:	76 5b                	jbe    10127f <cga_putc+0x146>
        int i;
        memmove(crt_buf, crt_buf + CRT_COLS, (CRT_SIZE - CRT_COLS) * sizeof(uint16_t));
  101224:	a1 80 7e 11 00       	mov    0x117e80,%eax
  101229:	8d 90 a0 00 00 00    	lea    0xa0(%eax),%edx
  10122f:	a1 80 7e 11 00       	mov    0x117e80,%eax
  101234:	c7 44 24 08 00 0f 00 	movl   $0xf00,0x8(%esp)
  10123b:	00 
  10123c:	89 54 24 04          	mov    %edx,0x4(%esp)
  101240:	89 04 24             	mov    %eax,(%esp)
  101243:	e8 2f 4d 00 00       	call   105f77 <memmove>
        for (i = CRT_SIZE - CRT_COLS; i < CRT_SIZE; i ++) {
  101248:	c7 45 f4 80 07 00 00 	movl   $0x780,-0xc(%ebp)
  10124f:	eb 15                	jmp    101266 <cga_putc+0x12d>
            crt_buf[i] = 0x0700 | ' ';
  101251:	a1 80 7e 11 00       	mov    0x117e80,%eax
  101256:	8b 55 f4             	mov    -0xc(%ebp),%edx
  101259:	01 d2                	add    %edx,%edx
  10125b:	01 d0                	add    %edx,%eax
  10125d:	66 c7 00 20 07       	movw   $0x720,(%eax)

    // What is the purpose of this?
    if (crt_pos >= CRT_SIZE) {
        int i;
        memmove(crt_buf, crt_buf + CRT_COLS, (CRT_SIZE - CRT_COLS) * sizeof(uint16_t));
        for (i = CRT_SIZE - CRT_COLS; i < CRT_SIZE; i ++) {
  101262:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  101266:	81 7d f4 cf 07 00 00 	cmpl   $0x7cf,-0xc(%ebp)
  10126d:	7e e2                	jle    101251 <cga_putc+0x118>
            crt_buf[i] = 0x0700 | ' ';
        }
        crt_pos -= CRT_COLS;
  10126f:	0f b7 05 84 7e 11 00 	movzwl 0x117e84,%eax
  101276:	83 e8 50             	sub    $0x50,%eax
  101279:	66 a3 84 7e 11 00    	mov    %ax,0x117e84
    }

    // move that little blinky thing
    outb(addr_6845, 14);
  10127f:	0f b7 05 86 7e 11 00 	movzwl 0x117e86,%eax
  101286:	0f b7 c0             	movzwl %ax,%eax
  101289:	66 89 45 f2          	mov    %ax,-0xe(%ebp)
  10128d:	c6 45 f1 0e          	movb   $0xe,-0xf(%ebp)
  101291:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  101295:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  101299:	ee                   	out    %al,(%dx)
    outb(addr_6845 + 1, crt_pos >> 8);
  10129a:	0f b7 05 84 7e 11 00 	movzwl 0x117e84,%eax
  1012a1:	66 c1 e8 08          	shr    $0x8,%ax
  1012a5:	0f b6 c0             	movzbl %al,%eax
  1012a8:	0f b7 15 86 7e 11 00 	movzwl 0x117e86,%edx
  1012af:	83 c2 01             	add    $0x1,%edx
  1012b2:	0f b7 d2             	movzwl %dx,%edx
  1012b5:	66 89 55 ee          	mov    %dx,-0x12(%ebp)
  1012b9:	88 45 ed             	mov    %al,-0x13(%ebp)
  1012bc:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  1012c0:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  1012c4:	ee                   	out    %al,(%dx)
    outb(addr_6845, 15);
  1012c5:	0f b7 05 86 7e 11 00 	movzwl 0x117e86,%eax
  1012cc:	0f b7 c0             	movzwl %ax,%eax
  1012cf:	66 89 45 ea          	mov    %ax,-0x16(%ebp)
  1012d3:	c6 45 e9 0f          	movb   $0xf,-0x17(%ebp)
  1012d7:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  1012db:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  1012df:	ee                   	out    %al,(%dx)
    outb(addr_6845 + 1, crt_pos);
  1012e0:	0f b7 05 84 7e 11 00 	movzwl 0x117e84,%eax
  1012e7:	0f b6 c0             	movzbl %al,%eax
  1012ea:	0f b7 15 86 7e 11 00 	movzwl 0x117e86,%edx
  1012f1:	83 c2 01             	add    $0x1,%edx
  1012f4:	0f b7 d2             	movzwl %dx,%edx
  1012f7:	66 89 55 e6          	mov    %dx,-0x1a(%ebp)
  1012fb:	88 45 e5             	mov    %al,-0x1b(%ebp)
  1012fe:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  101302:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  101306:	ee                   	out    %al,(%dx)
}
  101307:	83 c4 34             	add    $0x34,%esp
  10130a:	5b                   	pop    %ebx
  10130b:	5d                   	pop    %ebp
  10130c:	c3                   	ret    

0010130d <serial_putc_sub>:

static void
serial_putc_sub(int c) {
  10130d:	55                   	push   %ebp
  10130e:	89 e5                	mov    %esp,%ebp
  101310:	83 ec 10             	sub    $0x10,%esp
    int i;
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i ++) {
  101313:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  10131a:	eb 09                	jmp    101325 <serial_putc_sub+0x18>
        delay();
  10131c:	e8 4f fb ff ff       	call   100e70 <delay>
}

static void
serial_putc_sub(int c) {
    int i;
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i ++) {
  101321:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  101325:	66 c7 45 fa fd 03    	movw   $0x3fd,-0x6(%ebp)
static inline void invlpg(void *addr) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
  10132b:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  10132f:	89 c2                	mov    %eax,%edx
  101331:	ec                   	in     (%dx),%al
  101332:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  101335:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  101339:	0f b6 c0             	movzbl %al,%eax
  10133c:	83 e0 20             	and    $0x20,%eax
  10133f:	85 c0                	test   %eax,%eax
  101341:	75 09                	jne    10134c <serial_putc_sub+0x3f>
  101343:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%ebp)
  10134a:	7e d0                	jle    10131c <serial_putc_sub+0xf>
        delay();
    }
    outb(COM1 + COM_TX, c);
  10134c:	8b 45 08             	mov    0x8(%ebp),%eax
  10134f:	0f b6 c0             	movzbl %al,%eax
  101352:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
  101358:	88 45 f5             	mov    %al,-0xb(%ebp)
        : "memory", "cc");
}

static inline void
outb(uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  10135b:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  10135f:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  101363:	ee                   	out    %al,(%dx)
}
  101364:	c9                   	leave  
  101365:	c3                   	ret    

00101366 <serial_putc>:

/* serial_putc - print character to serial port */
static void
serial_putc(int c) {
  101366:	55                   	push   %ebp
  101367:	89 e5                	mov    %esp,%ebp
  101369:	83 ec 04             	sub    $0x4,%esp
    if (c != '\b') {
  10136c:	83 7d 08 08          	cmpl   $0x8,0x8(%ebp)
  101370:	74 0d                	je     10137f <serial_putc+0x19>
        serial_putc_sub(c);
  101372:	8b 45 08             	mov    0x8(%ebp),%eax
  101375:	89 04 24             	mov    %eax,(%esp)
  101378:	e8 90 ff ff ff       	call   10130d <serial_putc_sub>
  10137d:	eb 24                	jmp    1013a3 <serial_putc+0x3d>
    }
    else {
        serial_putc_sub('\b');
  10137f:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  101386:	e8 82 ff ff ff       	call   10130d <serial_putc_sub>
        serial_putc_sub(' ');
  10138b:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  101392:	e8 76 ff ff ff       	call   10130d <serial_putc_sub>
        serial_putc_sub('\b');
  101397:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  10139e:	e8 6a ff ff ff       	call   10130d <serial_putc_sub>
    }
}
  1013a3:	c9                   	leave  
  1013a4:	c3                   	ret    

001013a5 <cons_intr>:
/* *
 * cons_intr - called by device interrupt routines to feed input
 * characters into the circular console input buffer.
 * */
static void
cons_intr(int (*proc)(void)) {
  1013a5:	55                   	push   %ebp
  1013a6:	89 e5                	mov    %esp,%ebp
  1013a8:	83 ec 18             	sub    $0x18,%esp
    int c;
    while ((c = (*proc)()) != -1) {
  1013ab:	eb 33                	jmp    1013e0 <cons_intr+0x3b>
        if (c != 0) {
  1013ad:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1013b1:	74 2d                	je     1013e0 <cons_intr+0x3b>
            cons.buf[cons.wpos ++] = c;
  1013b3:	a1 a4 80 11 00       	mov    0x1180a4,%eax
  1013b8:	8d 50 01             	lea    0x1(%eax),%edx
  1013bb:	89 15 a4 80 11 00    	mov    %edx,0x1180a4
  1013c1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1013c4:	88 90 a0 7e 11 00    	mov    %dl,0x117ea0(%eax)
            if (cons.wpos == CONSBUFSIZE) {
  1013ca:	a1 a4 80 11 00       	mov    0x1180a4,%eax
  1013cf:	3d 00 02 00 00       	cmp    $0x200,%eax
  1013d4:	75 0a                	jne    1013e0 <cons_intr+0x3b>
                cons.wpos = 0;
  1013d6:	c7 05 a4 80 11 00 00 	movl   $0x0,0x1180a4
  1013dd:	00 00 00 
 * characters into the circular console input buffer.
 * */
static void
cons_intr(int (*proc)(void)) {
    int c;
    while ((c = (*proc)()) != -1) {
  1013e0:	8b 45 08             	mov    0x8(%ebp),%eax
  1013e3:	ff d0                	call   *%eax
  1013e5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1013e8:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
  1013ec:	75 bf                	jne    1013ad <cons_intr+0x8>
            if (cons.wpos == CONSBUFSIZE) {
                cons.wpos = 0;
            }
        }
    }
}
  1013ee:	c9                   	leave  
  1013ef:	c3                   	ret    

001013f0 <serial_proc_data>:

/* serial_proc_data - get data from serial port */
static int
serial_proc_data(void) {
  1013f0:	55                   	push   %ebp
  1013f1:	89 e5                	mov    %esp,%ebp
  1013f3:	83 ec 10             	sub    $0x10,%esp
  1013f6:	66 c7 45 fa fd 03    	movw   $0x3fd,-0x6(%ebp)
static inline void invlpg(void *addr) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
  1013fc:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  101400:	89 c2                	mov    %eax,%edx
  101402:	ec                   	in     (%dx),%al
  101403:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  101406:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
    if (!(inb(COM1 + COM_LSR) & COM_LSR_DATA)) {
  10140a:	0f b6 c0             	movzbl %al,%eax
  10140d:	83 e0 01             	and    $0x1,%eax
  101410:	85 c0                	test   %eax,%eax
  101412:	75 07                	jne    10141b <serial_proc_data+0x2b>
        return -1;
  101414:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  101419:	eb 2a                	jmp    101445 <serial_proc_data+0x55>
  10141b:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
static inline void invlpg(void *addr) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
  101421:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  101425:	89 c2                	mov    %eax,%edx
  101427:	ec                   	in     (%dx),%al
  101428:	88 45 f5             	mov    %al,-0xb(%ebp)
    return data;
  10142b:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
    }
    int c = inb(COM1 + COM_RX);
  10142f:	0f b6 c0             	movzbl %al,%eax
  101432:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (c == 127) {
  101435:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%ebp)
  101439:	75 07                	jne    101442 <serial_proc_data+0x52>
        c = '\b';
  10143b:	c7 45 fc 08 00 00 00 	movl   $0x8,-0x4(%ebp)
    }
    return c;
  101442:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  101445:	c9                   	leave  
  101446:	c3                   	ret    

00101447 <serial_intr>:

/* serial_intr - try to feed input characters from serial port */
void
serial_intr(void) {
  101447:	55                   	push   %ebp
  101448:	89 e5                	mov    %esp,%ebp
  10144a:	83 ec 18             	sub    $0x18,%esp
    if (serial_exists) {
  10144d:	a1 88 7e 11 00       	mov    0x117e88,%eax
  101452:	85 c0                	test   %eax,%eax
  101454:	74 0c                	je     101462 <serial_intr+0x1b>
        cons_intr(serial_proc_data);
  101456:	c7 04 24 f0 13 10 00 	movl   $0x1013f0,(%esp)
  10145d:	e8 43 ff ff ff       	call   1013a5 <cons_intr>
    }
}
  101462:	c9                   	leave  
  101463:	c3                   	ret    

00101464 <kbd_proc_data>:
 *
 * The kbd_proc_data() function gets data from the keyboard.
 * If we finish a character, return it, else 0. And return -1 if no data.
 * */
static int
kbd_proc_data(void) {
  101464:	55                   	push   %ebp
  101465:	89 e5                	mov    %esp,%ebp
  101467:	83 ec 38             	sub    $0x38,%esp
  10146a:	66 c7 45 f0 64 00    	movw   $0x64,-0x10(%ebp)
static inline void invlpg(void *addr) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
  101470:	0f b7 45 f0          	movzwl -0x10(%ebp),%eax
  101474:	89 c2                	mov    %eax,%edx
  101476:	ec                   	in     (%dx),%al
  101477:	88 45 ef             	mov    %al,-0x11(%ebp)
    return data;
  10147a:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    int c;
    uint8_t data;
    static uint32_t shift;

    if ((inb(KBSTATP) & KBS_DIB) == 0) {
  10147e:	0f b6 c0             	movzbl %al,%eax
  101481:	83 e0 01             	and    $0x1,%eax
  101484:	85 c0                	test   %eax,%eax
  101486:	75 0a                	jne    101492 <kbd_proc_data+0x2e>
        return -1;
  101488:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10148d:	e9 59 01 00 00       	jmp    1015eb <kbd_proc_data+0x187>
  101492:	66 c7 45 ec 60 00    	movw   $0x60,-0x14(%ebp)
static inline void invlpg(void *addr) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
  101498:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  10149c:	89 c2                	mov    %eax,%edx
  10149e:	ec                   	in     (%dx),%al
  10149f:	88 45 eb             	mov    %al,-0x15(%ebp)
    return data;
  1014a2:	0f b6 45 eb          	movzbl -0x15(%ebp),%eax
    }

    data = inb(KBDATAP);
  1014a6:	88 45 f3             	mov    %al,-0xd(%ebp)

    if (data == 0xE0) {
  1014a9:	80 7d f3 e0          	cmpb   $0xe0,-0xd(%ebp)
  1014ad:	75 17                	jne    1014c6 <kbd_proc_data+0x62>
        // E0 escape character
        shift |= E0ESC;
  1014af:	a1 a8 80 11 00       	mov    0x1180a8,%eax
  1014b4:	83 c8 40             	or     $0x40,%eax
  1014b7:	a3 a8 80 11 00       	mov    %eax,0x1180a8
        return 0;
  1014bc:	b8 00 00 00 00       	mov    $0x0,%eax
  1014c1:	e9 25 01 00 00       	jmp    1015eb <kbd_proc_data+0x187>
    } else if (data & 0x80) {
  1014c6:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1014ca:	84 c0                	test   %al,%al
  1014cc:	79 47                	jns    101515 <kbd_proc_data+0xb1>
        // Key released
        data = (shift & E0ESC ? data : data & 0x7F);
  1014ce:	a1 a8 80 11 00       	mov    0x1180a8,%eax
  1014d3:	83 e0 40             	and    $0x40,%eax
  1014d6:	85 c0                	test   %eax,%eax
  1014d8:	75 09                	jne    1014e3 <kbd_proc_data+0x7f>
  1014da:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1014de:	83 e0 7f             	and    $0x7f,%eax
  1014e1:	eb 04                	jmp    1014e7 <kbd_proc_data+0x83>
  1014e3:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1014e7:	88 45 f3             	mov    %al,-0xd(%ebp)
        shift &= ~(shiftcode[data] | E0ESC);
  1014ea:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1014ee:	0f b6 80 60 70 11 00 	movzbl 0x117060(%eax),%eax
  1014f5:	83 c8 40             	or     $0x40,%eax
  1014f8:	0f b6 c0             	movzbl %al,%eax
  1014fb:	f7 d0                	not    %eax
  1014fd:	89 c2                	mov    %eax,%edx
  1014ff:	a1 a8 80 11 00       	mov    0x1180a8,%eax
  101504:	21 d0                	and    %edx,%eax
  101506:	a3 a8 80 11 00       	mov    %eax,0x1180a8
        return 0;
  10150b:	b8 00 00 00 00       	mov    $0x0,%eax
  101510:	e9 d6 00 00 00       	jmp    1015eb <kbd_proc_data+0x187>
    } else if (shift & E0ESC) {
  101515:	a1 a8 80 11 00       	mov    0x1180a8,%eax
  10151a:	83 e0 40             	and    $0x40,%eax
  10151d:	85 c0                	test   %eax,%eax
  10151f:	74 11                	je     101532 <kbd_proc_data+0xce>
        // Last character was an E0 escape; or with 0x80
        data |= 0x80;
  101521:	80 4d f3 80          	orb    $0x80,-0xd(%ebp)
        shift &= ~E0ESC;
  101525:	a1 a8 80 11 00       	mov    0x1180a8,%eax
  10152a:	83 e0 bf             	and    $0xffffffbf,%eax
  10152d:	a3 a8 80 11 00       	mov    %eax,0x1180a8
    }

    shift |= shiftcode[data];
  101532:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101536:	0f b6 80 60 70 11 00 	movzbl 0x117060(%eax),%eax
  10153d:	0f b6 d0             	movzbl %al,%edx
  101540:	a1 a8 80 11 00       	mov    0x1180a8,%eax
  101545:	09 d0                	or     %edx,%eax
  101547:	a3 a8 80 11 00       	mov    %eax,0x1180a8
    shift ^= togglecode[data];
  10154c:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101550:	0f b6 80 60 71 11 00 	movzbl 0x117160(%eax),%eax
  101557:	0f b6 d0             	movzbl %al,%edx
  10155a:	a1 a8 80 11 00       	mov    0x1180a8,%eax
  10155f:	31 d0                	xor    %edx,%eax
  101561:	a3 a8 80 11 00       	mov    %eax,0x1180a8

    c = charcode[shift & (CTL | SHIFT)][data];
  101566:	a1 a8 80 11 00       	mov    0x1180a8,%eax
  10156b:	83 e0 03             	and    $0x3,%eax
  10156e:	8b 14 85 60 75 11 00 	mov    0x117560(,%eax,4),%edx
  101575:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101579:	01 d0                	add    %edx,%eax
  10157b:	0f b6 00             	movzbl (%eax),%eax
  10157e:	0f b6 c0             	movzbl %al,%eax
  101581:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (shift & CAPSLOCK) {
  101584:	a1 a8 80 11 00       	mov    0x1180a8,%eax
  101589:	83 e0 08             	and    $0x8,%eax
  10158c:	85 c0                	test   %eax,%eax
  10158e:	74 22                	je     1015b2 <kbd_proc_data+0x14e>
        if ('a' <= c && c <= 'z')
  101590:	83 7d f4 60          	cmpl   $0x60,-0xc(%ebp)
  101594:	7e 0c                	jle    1015a2 <kbd_proc_data+0x13e>
  101596:	83 7d f4 7a          	cmpl   $0x7a,-0xc(%ebp)
  10159a:	7f 06                	jg     1015a2 <kbd_proc_data+0x13e>
            c += 'A' - 'a';
  10159c:	83 6d f4 20          	subl   $0x20,-0xc(%ebp)
  1015a0:	eb 10                	jmp    1015b2 <kbd_proc_data+0x14e>
        else if ('A' <= c && c <= 'Z')
  1015a2:	83 7d f4 40          	cmpl   $0x40,-0xc(%ebp)
  1015a6:	7e 0a                	jle    1015b2 <kbd_proc_data+0x14e>
  1015a8:	83 7d f4 5a          	cmpl   $0x5a,-0xc(%ebp)
  1015ac:	7f 04                	jg     1015b2 <kbd_proc_data+0x14e>
            c += 'a' - 'A';
  1015ae:	83 45 f4 20          	addl   $0x20,-0xc(%ebp)
    }

    // Process special keys
    // Ctrl-Alt-Del: reboot
    if (!(~shift & (CTL | ALT)) && c == KEY_DEL) {
  1015b2:	a1 a8 80 11 00       	mov    0x1180a8,%eax
  1015b7:	f7 d0                	not    %eax
  1015b9:	83 e0 06             	and    $0x6,%eax
  1015bc:	85 c0                	test   %eax,%eax
  1015be:	75 28                	jne    1015e8 <kbd_proc_data+0x184>
  1015c0:	81 7d f4 e9 00 00 00 	cmpl   $0xe9,-0xc(%ebp)
  1015c7:	75 1f                	jne    1015e8 <kbd_proc_data+0x184>
        cprintf("Rebooting!\n");
  1015c9:	c7 04 24 11 64 10 00 	movl   $0x106411,(%esp)
  1015d0:	e8 77 ed ff ff       	call   10034c <cprintf>
  1015d5:	66 c7 45 e8 92 00    	movw   $0x92,-0x18(%ebp)
  1015db:	c6 45 e7 03          	movb   $0x3,-0x19(%ebp)
        : "memory", "cc");
}

static inline void
outb(uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  1015df:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
  1015e3:	0f b7 55 e8          	movzwl -0x18(%ebp),%edx
  1015e7:	ee                   	out    %al,(%dx)
        outb(0x92, 0x3); // courtesy of Chris Frost
    }
    return c;
  1015e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  1015eb:	c9                   	leave  
  1015ec:	c3                   	ret    

001015ed <kbd_intr>:

/* kbd_intr - try to feed input characters from keyboard */
static void
kbd_intr(void) {
  1015ed:	55                   	push   %ebp
  1015ee:	89 e5                	mov    %esp,%ebp
  1015f0:	83 ec 18             	sub    $0x18,%esp
    cons_intr(kbd_proc_data);
  1015f3:	c7 04 24 64 14 10 00 	movl   $0x101464,(%esp)
  1015fa:	e8 a6 fd ff ff       	call   1013a5 <cons_intr>
}
  1015ff:	c9                   	leave  
  101600:	c3                   	ret    

00101601 <kbd_init>:

static void
kbd_init(void) {
  101601:	55                   	push   %ebp
  101602:	89 e5                	mov    %esp,%ebp
  101604:	83 ec 18             	sub    $0x18,%esp
    // drain the kbd buffer
    kbd_intr();
  101607:	e8 e1 ff ff ff       	call   1015ed <kbd_intr>
    pic_enable(IRQ_KBD);
  10160c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  101613:	e8 3d 01 00 00       	call   101755 <pic_enable>
}
  101618:	c9                   	leave  
  101619:	c3                   	ret    

0010161a <cons_init>:

/* cons_init - initializes the console devices */
void
cons_init(void) {
  10161a:	55                   	push   %ebp
  10161b:	89 e5                	mov    %esp,%ebp
  10161d:	83 ec 18             	sub    $0x18,%esp
    cga_init();
  101620:	e8 93 f8 ff ff       	call   100eb8 <cga_init>
    serial_init();
  101625:	e8 74 f9 ff ff       	call   100f9e <serial_init>
    kbd_init();
  10162a:	e8 d2 ff ff ff       	call   101601 <kbd_init>
    if (!serial_exists) {
  10162f:	a1 88 7e 11 00       	mov    0x117e88,%eax
  101634:	85 c0                	test   %eax,%eax
  101636:	75 0c                	jne    101644 <cons_init+0x2a>
        cprintf("serial port does not exist!!\n");
  101638:	c7 04 24 1d 64 10 00 	movl   $0x10641d,(%esp)
  10163f:	e8 08 ed ff ff       	call   10034c <cprintf>
    }
}
  101644:	c9                   	leave  
  101645:	c3                   	ret    

00101646 <cons_putc>:

/* cons_putc - print a single character @c to console devices */
void
cons_putc(int c) {
  101646:	55                   	push   %ebp
  101647:	89 e5                	mov    %esp,%ebp
  101649:	83 ec 28             	sub    $0x28,%esp
    bool intr_flag;
    local_intr_save(intr_flag);
  10164c:	e8 e2 f7 ff ff       	call   100e33 <__intr_save>
  101651:	89 45 f4             	mov    %eax,-0xc(%ebp)
    {
        lpt_putc(c);
  101654:	8b 45 08             	mov    0x8(%ebp),%eax
  101657:	89 04 24             	mov    %eax,(%esp)
  10165a:	e8 9b fa ff ff       	call   1010fa <lpt_putc>
        cga_putc(c);
  10165f:	8b 45 08             	mov    0x8(%ebp),%eax
  101662:	89 04 24             	mov    %eax,(%esp)
  101665:	e8 cf fa ff ff       	call   101139 <cga_putc>
        serial_putc(c);
  10166a:	8b 45 08             	mov    0x8(%ebp),%eax
  10166d:	89 04 24             	mov    %eax,(%esp)
  101670:	e8 f1 fc ff ff       	call   101366 <serial_putc>
    }
    local_intr_restore(intr_flag);
  101675:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101678:	89 04 24             	mov    %eax,(%esp)
  10167b:	e8 dd f7 ff ff       	call   100e5d <__intr_restore>
}
  101680:	c9                   	leave  
  101681:	c3                   	ret    

00101682 <cons_getc>:
/* *
 * cons_getc - return the next input character from console,
 * or 0 if none waiting.
 * */
int
cons_getc(void) {
  101682:	55                   	push   %ebp
  101683:	89 e5                	mov    %esp,%ebp
  101685:	83 ec 28             	sub    $0x28,%esp
    int c = 0;
  101688:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    bool intr_flag;
    local_intr_save(intr_flag);
  10168f:	e8 9f f7 ff ff       	call   100e33 <__intr_save>
  101694:	89 45 f0             	mov    %eax,-0x10(%ebp)
    {
        // poll for any pending input characters,
        // so that this function works even when interrupts are disabled
        // (e.g., when called from the kernel monitor).
        serial_intr();
  101697:	e8 ab fd ff ff       	call   101447 <serial_intr>
        kbd_intr();
  10169c:	e8 4c ff ff ff       	call   1015ed <kbd_intr>

        // grab the next character from the input buffer.
        if (cons.rpos != cons.wpos) {
  1016a1:	8b 15 a0 80 11 00    	mov    0x1180a0,%edx
  1016a7:	a1 a4 80 11 00       	mov    0x1180a4,%eax
  1016ac:	39 c2                	cmp    %eax,%edx
  1016ae:	74 31                	je     1016e1 <cons_getc+0x5f>
            c = cons.buf[cons.rpos ++];
  1016b0:	a1 a0 80 11 00       	mov    0x1180a0,%eax
  1016b5:	8d 50 01             	lea    0x1(%eax),%edx
  1016b8:	89 15 a0 80 11 00    	mov    %edx,0x1180a0
  1016be:	0f b6 80 a0 7e 11 00 	movzbl 0x117ea0(%eax),%eax
  1016c5:	0f b6 c0             	movzbl %al,%eax
  1016c8:	89 45 f4             	mov    %eax,-0xc(%ebp)
            if (cons.rpos == CONSBUFSIZE) {
  1016cb:	a1 a0 80 11 00       	mov    0x1180a0,%eax
  1016d0:	3d 00 02 00 00       	cmp    $0x200,%eax
  1016d5:	75 0a                	jne    1016e1 <cons_getc+0x5f>
                cons.rpos = 0;
  1016d7:	c7 05 a0 80 11 00 00 	movl   $0x0,0x1180a0
  1016de:	00 00 00 
            }
        }
    }
    local_intr_restore(intr_flag);
  1016e1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1016e4:	89 04 24             	mov    %eax,(%esp)
  1016e7:	e8 71 f7 ff ff       	call   100e5d <__intr_restore>
    return c;
  1016ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  1016ef:	c9                   	leave  
  1016f0:	c3                   	ret    

001016f1 <intr_enable>:
#include <x86.h>
#include <intr.h>

/* intr_enable - enable irq interrupt */
void
intr_enable(void) {
  1016f1:	55                   	push   %ebp
  1016f2:	89 e5                	mov    %esp,%ebp
    asm volatile ("lidt (%0)" :: "r" (pd) : "memory");
}

static inline void
sti(void) {
    asm volatile ("sti");
  1016f4:	fb                   	sti    
    sti();
}
  1016f5:	5d                   	pop    %ebp
  1016f6:	c3                   	ret    

001016f7 <intr_disable>:

/* intr_disable - disable irq interrupt */
void
intr_disable(void) {
  1016f7:	55                   	push   %ebp
  1016f8:	89 e5                	mov    %esp,%ebp
}

static inline void
cli(void) {
    asm volatile ("cli" ::: "memory");
  1016fa:	fa                   	cli    
    cli();
}
  1016fb:	5d                   	pop    %ebp
  1016fc:	c3                   	ret    

001016fd <pic_setmask>:
// Initial IRQ mask has interrupt 2 enabled (for slave 8259A).
static uint16_t irq_mask = 0xFFFF & ~(1 << IRQ_SLAVE);
static bool did_init = 0;

static void
pic_setmask(uint16_t mask) {
  1016fd:	55                   	push   %ebp
  1016fe:	89 e5                	mov    %esp,%ebp
  101700:	83 ec 14             	sub    $0x14,%esp
  101703:	8b 45 08             	mov    0x8(%ebp),%eax
  101706:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
    irq_mask = mask;
  10170a:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  10170e:	66 a3 70 75 11 00    	mov    %ax,0x117570
    if (did_init) {
  101714:	a1 ac 80 11 00       	mov    0x1180ac,%eax
  101719:	85 c0                	test   %eax,%eax
  10171b:	74 36                	je     101753 <pic_setmask+0x56>
        outb(IO_PIC1 + 1, mask);
  10171d:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  101721:	0f b6 c0             	movzbl %al,%eax
  101724:	66 c7 45 fe 21 00    	movw   $0x21,-0x2(%ebp)
  10172a:	88 45 fd             	mov    %al,-0x3(%ebp)
        : "memory", "cc");
}

static inline void
outb(uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  10172d:	0f b6 45 fd          	movzbl -0x3(%ebp),%eax
  101731:	0f b7 55 fe          	movzwl -0x2(%ebp),%edx
  101735:	ee                   	out    %al,(%dx)
        outb(IO_PIC2 + 1, mask >> 8);
  101736:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  10173a:	66 c1 e8 08          	shr    $0x8,%ax
  10173e:	0f b6 c0             	movzbl %al,%eax
  101741:	66 c7 45 fa a1 00    	movw   $0xa1,-0x6(%ebp)
  101747:	88 45 f9             	mov    %al,-0x7(%ebp)
  10174a:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  10174e:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  101752:	ee                   	out    %al,(%dx)
    }
}
  101753:	c9                   	leave  
  101754:	c3                   	ret    

00101755 <pic_enable>:

void
pic_enable(unsigned int irq) {
  101755:	55                   	push   %ebp
  101756:	89 e5                	mov    %esp,%ebp
  101758:	83 ec 04             	sub    $0x4,%esp
    pic_setmask(irq_mask & ~(1 << irq));
  10175b:	8b 45 08             	mov    0x8(%ebp),%eax
  10175e:	ba 01 00 00 00       	mov    $0x1,%edx
  101763:	89 c1                	mov    %eax,%ecx
  101765:	d3 e2                	shl    %cl,%edx
  101767:	89 d0                	mov    %edx,%eax
  101769:	f7 d0                	not    %eax
  10176b:	89 c2                	mov    %eax,%edx
  10176d:	0f b7 05 70 75 11 00 	movzwl 0x117570,%eax
  101774:	21 d0                	and    %edx,%eax
  101776:	0f b7 c0             	movzwl %ax,%eax
  101779:	89 04 24             	mov    %eax,(%esp)
  10177c:	e8 7c ff ff ff       	call   1016fd <pic_setmask>
}
  101781:	c9                   	leave  
  101782:	c3                   	ret    

00101783 <pic_init>:

/* pic_init - initialize the 8259A interrupt controllers */
void
pic_init(void) {
  101783:	55                   	push   %ebp
  101784:	89 e5                	mov    %esp,%ebp
  101786:	83 ec 44             	sub    $0x44,%esp
    did_init = 1;
  101789:	c7 05 ac 80 11 00 01 	movl   $0x1,0x1180ac
  101790:	00 00 00 
  101793:	66 c7 45 fe 21 00    	movw   $0x21,-0x2(%ebp)
  101799:	c6 45 fd ff          	movb   $0xff,-0x3(%ebp)
  10179d:	0f b6 45 fd          	movzbl -0x3(%ebp),%eax
  1017a1:	0f b7 55 fe          	movzwl -0x2(%ebp),%edx
  1017a5:	ee                   	out    %al,(%dx)
  1017a6:	66 c7 45 fa a1 00    	movw   $0xa1,-0x6(%ebp)
  1017ac:	c6 45 f9 ff          	movb   $0xff,-0x7(%ebp)
  1017b0:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  1017b4:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  1017b8:	ee                   	out    %al,(%dx)
  1017b9:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%ebp)
  1017bf:	c6 45 f5 11          	movb   $0x11,-0xb(%ebp)
  1017c3:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  1017c7:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  1017cb:	ee                   	out    %al,(%dx)
  1017cc:	66 c7 45 f2 21 00    	movw   $0x21,-0xe(%ebp)
  1017d2:	c6 45 f1 20          	movb   $0x20,-0xf(%ebp)
  1017d6:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  1017da:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  1017de:	ee                   	out    %al,(%dx)
  1017df:	66 c7 45 ee 21 00    	movw   $0x21,-0x12(%ebp)
  1017e5:	c6 45 ed 04          	movb   $0x4,-0x13(%ebp)
  1017e9:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  1017ed:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  1017f1:	ee                   	out    %al,(%dx)
  1017f2:	66 c7 45 ea 21 00    	movw   $0x21,-0x16(%ebp)
  1017f8:	c6 45 e9 03          	movb   $0x3,-0x17(%ebp)
  1017fc:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  101800:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  101804:	ee                   	out    %al,(%dx)
  101805:	66 c7 45 e6 a0 00    	movw   $0xa0,-0x1a(%ebp)
  10180b:	c6 45 e5 11          	movb   $0x11,-0x1b(%ebp)
  10180f:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  101813:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  101817:	ee                   	out    %al,(%dx)
  101818:	66 c7 45 e2 a1 00    	movw   $0xa1,-0x1e(%ebp)
  10181e:	c6 45 e1 28          	movb   $0x28,-0x1f(%ebp)
  101822:	0f b6 45 e1          	movzbl -0x1f(%ebp),%eax
  101826:	0f b7 55 e2          	movzwl -0x1e(%ebp),%edx
  10182a:	ee                   	out    %al,(%dx)
  10182b:	66 c7 45 de a1 00    	movw   $0xa1,-0x22(%ebp)
  101831:	c6 45 dd 02          	movb   $0x2,-0x23(%ebp)
  101835:	0f b6 45 dd          	movzbl -0x23(%ebp),%eax
  101839:	0f b7 55 de          	movzwl -0x22(%ebp),%edx
  10183d:	ee                   	out    %al,(%dx)
  10183e:	66 c7 45 da a1 00    	movw   $0xa1,-0x26(%ebp)
  101844:	c6 45 d9 03          	movb   $0x3,-0x27(%ebp)
  101848:	0f b6 45 d9          	movzbl -0x27(%ebp),%eax
  10184c:	0f b7 55 da          	movzwl -0x26(%ebp),%edx
  101850:	ee                   	out    %al,(%dx)
  101851:	66 c7 45 d6 20 00    	movw   $0x20,-0x2a(%ebp)
  101857:	c6 45 d5 68          	movb   $0x68,-0x2b(%ebp)
  10185b:	0f b6 45 d5          	movzbl -0x2b(%ebp),%eax
  10185f:	0f b7 55 d6          	movzwl -0x2a(%ebp),%edx
  101863:	ee                   	out    %al,(%dx)
  101864:	66 c7 45 d2 20 00    	movw   $0x20,-0x2e(%ebp)
  10186a:	c6 45 d1 0a          	movb   $0xa,-0x2f(%ebp)
  10186e:	0f b6 45 d1          	movzbl -0x2f(%ebp),%eax
  101872:	0f b7 55 d2          	movzwl -0x2e(%ebp),%edx
  101876:	ee                   	out    %al,(%dx)
  101877:	66 c7 45 ce a0 00    	movw   $0xa0,-0x32(%ebp)
  10187d:	c6 45 cd 68          	movb   $0x68,-0x33(%ebp)
  101881:	0f b6 45 cd          	movzbl -0x33(%ebp),%eax
  101885:	0f b7 55 ce          	movzwl -0x32(%ebp),%edx
  101889:	ee                   	out    %al,(%dx)
  10188a:	66 c7 45 ca a0 00    	movw   $0xa0,-0x36(%ebp)
  101890:	c6 45 c9 0a          	movb   $0xa,-0x37(%ebp)
  101894:	0f b6 45 c9          	movzbl -0x37(%ebp),%eax
  101898:	0f b7 55 ca          	movzwl -0x36(%ebp),%edx
  10189c:	ee                   	out    %al,(%dx)
    outb(IO_PIC1, 0x0a);    // read IRR by default

    outb(IO_PIC2, 0x68);    // OCW3
    outb(IO_PIC2, 0x0a);    // OCW3

    if (irq_mask != 0xFFFF) {
  10189d:	0f b7 05 70 75 11 00 	movzwl 0x117570,%eax
  1018a4:	66 83 f8 ff          	cmp    $0xffff,%ax
  1018a8:	74 12                	je     1018bc <pic_init+0x139>
        pic_setmask(irq_mask);
  1018aa:	0f b7 05 70 75 11 00 	movzwl 0x117570,%eax
  1018b1:	0f b7 c0             	movzwl %ax,%eax
  1018b4:	89 04 24             	mov    %eax,(%esp)
  1018b7:	e8 41 fe ff ff       	call   1016fd <pic_setmask>
    }
}
  1018bc:	c9                   	leave  
  1018bd:	c3                   	ret    

001018be <print_ticks>:
#include <console.h>
#include <kdebug.h>

#define TICK_NUM 100

static void print_ticks() {
  1018be:	55                   	push   %ebp
  1018bf:	89 e5                	mov    %esp,%ebp
  1018c1:	83 ec 18             	sub    $0x18,%esp
    cprintf("%d ticks\n",TICK_NUM);
  1018c4:	c7 44 24 04 64 00 00 	movl   $0x64,0x4(%esp)
  1018cb:	00 
  1018cc:	c7 04 24 40 64 10 00 	movl   $0x106440,(%esp)
  1018d3:	e8 74 ea ff ff       	call   10034c <cprintf>
#ifdef DEBUG_GRADE
    cprintf("End of Test.\n");
  1018d8:	c7 04 24 4a 64 10 00 	movl   $0x10644a,(%esp)
  1018df:	e8 68 ea ff ff       	call   10034c <cprintf>
    panic("EOT: kernel seems ok.");
  1018e4:	c7 44 24 08 58 64 10 	movl   $0x106458,0x8(%esp)
  1018eb:	00 
  1018ec:	c7 44 24 04 12 00 00 	movl   $0x12,0x4(%esp)
  1018f3:	00 
  1018f4:	c7 04 24 6e 64 10 00 	movl   $0x10646e,(%esp)
  1018fb:	e8 14 f4 ff ff       	call   100d14 <__panic>

00101900 <idt_init>:
    sizeof(idt) - 1, (uintptr_t)idt
};

/* idt_init - initialize IDT to each of the entry points in kern/trap/vectors.S */
void
idt_init(void) {
  101900:	55                   	push   %ebp
  101901:	89 e5                	mov    %esp,%ebp
  101903:	83 ec 10             	sub    $0x10,%esp
      *     You don't know the meaning of this instruction? just google it! and check the libs/x86.h to know more.
      *     Notice: the argument of lidt is idt_pd. try to find it!
      */
	extern uintptr_t __vectors[];

	int i=0, num=sizeof(idt)/sizeof(idt[0]);
  101906:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  10190d:	c7 45 f8 00 01 00 00 	movl   $0x100,-0x8(%ebp)
	for (; i<num; ++i)
  101914:	e9 c3 00 00 00       	jmp    1019dc <idt_init+0xdc>
		SETGATE(idt[i], 0, GD_KTEXT, __vectors[i], DPL_KERNEL);
  101919:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10191c:	8b 04 85 00 76 11 00 	mov    0x117600(,%eax,4),%eax
  101923:	89 c2                	mov    %eax,%edx
  101925:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101928:	66 89 14 c5 c0 80 11 	mov    %dx,0x1180c0(,%eax,8)
  10192f:	00 
  101930:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101933:	66 c7 04 c5 c2 80 11 	movw   $0x8,0x1180c2(,%eax,8)
  10193a:	00 08 00 
  10193d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101940:	0f b6 14 c5 c4 80 11 	movzbl 0x1180c4(,%eax,8),%edx
  101947:	00 
  101948:	83 e2 e0             	and    $0xffffffe0,%edx
  10194b:	88 14 c5 c4 80 11 00 	mov    %dl,0x1180c4(,%eax,8)
  101952:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101955:	0f b6 14 c5 c4 80 11 	movzbl 0x1180c4(,%eax,8),%edx
  10195c:	00 
  10195d:	83 e2 1f             	and    $0x1f,%edx
  101960:	88 14 c5 c4 80 11 00 	mov    %dl,0x1180c4(,%eax,8)
  101967:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10196a:	0f b6 14 c5 c5 80 11 	movzbl 0x1180c5(,%eax,8),%edx
  101971:	00 
  101972:	83 e2 f0             	and    $0xfffffff0,%edx
  101975:	83 ca 0e             	or     $0xe,%edx
  101978:	88 14 c5 c5 80 11 00 	mov    %dl,0x1180c5(,%eax,8)
  10197f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101982:	0f b6 14 c5 c5 80 11 	movzbl 0x1180c5(,%eax,8),%edx
  101989:	00 
  10198a:	83 e2 ef             	and    $0xffffffef,%edx
  10198d:	88 14 c5 c5 80 11 00 	mov    %dl,0x1180c5(,%eax,8)
  101994:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101997:	0f b6 14 c5 c5 80 11 	movzbl 0x1180c5(,%eax,8),%edx
  10199e:	00 
  10199f:	83 e2 9f             	and    $0xffffff9f,%edx
  1019a2:	88 14 c5 c5 80 11 00 	mov    %dl,0x1180c5(,%eax,8)
  1019a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1019ac:	0f b6 14 c5 c5 80 11 	movzbl 0x1180c5(,%eax,8),%edx
  1019b3:	00 
  1019b4:	83 ca 80             	or     $0xffffff80,%edx
  1019b7:	88 14 c5 c5 80 11 00 	mov    %dl,0x1180c5(,%eax,8)
  1019be:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1019c1:	8b 04 85 00 76 11 00 	mov    0x117600(,%eax,4),%eax
  1019c8:	c1 e8 10             	shr    $0x10,%eax
  1019cb:	89 c2                	mov    %eax,%edx
  1019cd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1019d0:	66 89 14 c5 c6 80 11 	mov    %dx,0x1180c6(,%eax,8)
  1019d7:	00 
      *     Notice: the argument of lidt is idt_pd. try to find it!
      */
	extern uintptr_t __vectors[];

	int i=0, num=sizeof(idt)/sizeof(idt[0]);
	for (; i<num; ++i)
  1019d8:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  1019dc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1019df:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  1019e2:	0f 8c 31 ff ff ff    	jl     101919 <idt_init+0x19>
		SETGATE(idt[i], 0, GD_KTEXT, __vectors[i], DPL_KERNEL);

	SETGATE(idt[T_SWITCH_TOK], 1, GD_KTEXT, __vectors[T_SWITCH_TOK], DPL_USER);
  1019e8:	a1 e4 77 11 00       	mov    0x1177e4,%eax
  1019ed:	66 a3 88 84 11 00    	mov    %ax,0x118488
  1019f3:	66 c7 05 8a 84 11 00 	movw   $0x8,0x11848a
  1019fa:	08 00 
  1019fc:	0f b6 05 8c 84 11 00 	movzbl 0x11848c,%eax
  101a03:	83 e0 e0             	and    $0xffffffe0,%eax
  101a06:	a2 8c 84 11 00       	mov    %al,0x11848c
  101a0b:	0f b6 05 8c 84 11 00 	movzbl 0x11848c,%eax
  101a12:	83 e0 1f             	and    $0x1f,%eax
  101a15:	a2 8c 84 11 00       	mov    %al,0x11848c
  101a1a:	0f b6 05 8d 84 11 00 	movzbl 0x11848d,%eax
  101a21:	83 c8 0f             	or     $0xf,%eax
  101a24:	a2 8d 84 11 00       	mov    %al,0x11848d
  101a29:	0f b6 05 8d 84 11 00 	movzbl 0x11848d,%eax
  101a30:	83 e0 ef             	and    $0xffffffef,%eax
  101a33:	a2 8d 84 11 00       	mov    %al,0x11848d
  101a38:	0f b6 05 8d 84 11 00 	movzbl 0x11848d,%eax
  101a3f:	83 c8 60             	or     $0x60,%eax
  101a42:	a2 8d 84 11 00       	mov    %al,0x11848d
  101a47:	0f b6 05 8d 84 11 00 	movzbl 0x11848d,%eax
  101a4e:	83 c8 80             	or     $0xffffff80,%eax
  101a51:	a2 8d 84 11 00       	mov    %al,0x11848d
  101a56:	a1 e4 77 11 00       	mov    0x1177e4,%eax
  101a5b:	c1 e8 10             	shr    $0x10,%eax
  101a5e:	66 a3 8e 84 11 00    	mov    %ax,0x11848e
  101a64:	c7 45 f4 80 75 11 00 	movl   $0x117580,-0xc(%ebp)
    }
}

static inline void
lidt(struct pseudodesc *pd) {
    asm volatile ("lidt (%0)" :: "r" (pd) : "memory");
  101a6b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101a6e:	0f 01 18             	lidtl  (%eax)

	lidt(&idt_pd);
}
  101a71:	c9                   	leave  
  101a72:	c3                   	ret    

00101a73 <trapname>:

static const char *
trapname(int trapno) {
  101a73:	55                   	push   %ebp
  101a74:	89 e5                	mov    %esp,%ebp
        "Alignment Check",
        "Machine-Check",
        "SIMD Floating-Point Exception"
    };

    if (trapno < sizeof(excnames)/sizeof(const char * const)) {
  101a76:	8b 45 08             	mov    0x8(%ebp),%eax
  101a79:	83 f8 13             	cmp    $0x13,%eax
  101a7c:	77 0c                	ja     101a8a <trapname+0x17>
        return excnames[trapno];
  101a7e:	8b 45 08             	mov    0x8(%ebp),%eax
  101a81:	8b 04 85 c0 67 10 00 	mov    0x1067c0(,%eax,4),%eax
  101a88:	eb 18                	jmp    101aa2 <trapname+0x2f>
    }
    if (trapno >= IRQ_OFFSET && trapno < IRQ_OFFSET + 16) {
  101a8a:	83 7d 08 1f          	cmpl   $0x1f,0x8(%ebp)
  101a8e:	7e 0d                	jle    101a9d <trapname+0x2a>
  101a90:	83 7d 08 2f          	cmpl   $0x2f,0x8(%ebp)
  101a94:	7f 07                	jg     101a9d <trapname+0x2a>
        return "Hardware Interrupt";
  101a96:	b8 7f 64 10 00       	mov    $0x10647f,%eax
  101a9b:	eb 05                	jmp    101aa2 <trapname+0x2f>
    }
    return "(unknown trap)";
  101a9d:	b8 92 64 10 00       	mov    $0x106492,%eax
}
  101aa2:	5d                   	pop    %ebp
  101aa3:	c3                   	ret    

00101aa4 <trap_in_kernel>:

/* trap_in_kernel - test if trap happened in kernel */
bool
trap_in_kernel(struct trapframe *tf) {
  101aa4:	55                   	push   %ebp
  101aa5:	89 e5                	mov    %esp,%ebp
    return (tf->tf_cs == (uint16_t)KERNEL_CS);
  101aa7:	8b 45 08             	mov    0x8(%ebp),%eax
  101aaa:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101aae:	66 83 f8 08          	cmp    $0x8,%ax
  101ab2:	0f 94 c0             	sete   %al
  101ab5:	0f b6 c0             	movzbl %al,%eax
}
  101ab8:	5d                   	pop    %ebp
  101ab9:	c3                   	ret    

00101aba <print_trapframe>:
    "TF", "IF", "DF", "OF", NULL, NULL, "NT", NULL,
    "RF", "VM", "AC", "VIF", "VIP", "ID", NULL, NULL,
};

void
print_trapframe(struct trapframe *tf) {
  101aba:	55                   	push   %ebp
  101abb:	89 e5                	mov    %esp,%ebp
  101abd:	83 ec 28             	sub    $0x28,%esp
    cprintf("trapframe at %p\n", tf);
  101ac0:	8b 45 08             	mov    0x8(%ebp),%eax
  101ac3:	89 44 24 04          	mov    %eax,0x4(%esp)
  101ac7:	c7 04 24 d3 64 10 00 	movl   $0x1064d3,(%esp)
  101ace:	e8 79 e8 ff ff       	call   10034c <cprintf>
    print_regs(&tf->tf_regs);
  101ad3:	8b 45 08             	mov    0x8(%ebp),%eax
  101ad6:	89 04 24             	mov    %eax,(%esp)
  101ad9:	e8 a1 01 00 00       	call   101c7f <print_regs>
    cprintf("  ds   0x----%04x\n", tf->tf_ds);
  101ade:	8b 45 08             	mov    0x8(%ebp),%eax
  101ae1:	0f b7 40 2c          	movzwl 0x2c(%eax),%eax
  101ae5:	0f b7 c0             	movzwl %ax,%eax
  101ae8:	89 44 24 04          	mov    %eax,0x4(%esp)
  101aec:	c7 04 24 e4 64 10 00 	movl   $0x1064e4,(%esp)
  101af3:	e8 54 e8 ff ff       	call   10034c <cprintf>
    cprintf("  es   0x----%04x\n", tf->tf_es);
  101af8:	8b 45 08             	mov    0x8(%ebp),%eax
  101afb:	0f b7 40 28          	movzwl 0x28(%eax),%eax
  101aff:	0f b7 c0             	movzwl %ax,%eax
  101b02:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b06:	c7 04 24 f7 64 10 00 	movl   $0x1064f7,(%esp)
  101b0d:	e8 3a e8 ff ff       	call   10034c <cprintf>
    cprintf("  fs   0x----%04x\n", tf->tf_fs);
  101b12:	8b 45 08             	mov    0x8(%ebp),%eax
  101b15:	0f b7 40 24          	movzwl 0x24(%eax),%eax
  101b19:	0f b7 c0             	movzwl %ax,%eax
  101b1c:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b20:	c7 04 24 0a 65 10 00 	movl   $0x10650a,(%esp)
  101b27:	e8 20 e8 ff ff       	call   10034c <cprintf>
    cprintf("  gs   0x----%04x\n", tf->tf_gs);
  101b2c:	8b 45 08             	mov    0x8(%ebp),%eax
  101b2f:	0f b7 40 20          	movzwl 0x20(%eax),%eax
  101b33:	0f b7 c0             	movzwl %ax,%eax
  101b36:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b3a:	c7 04 24 1d 65 10 00 	movl   $0x10651d,(%esp)
  101b41:	e8 06 e8 ff ff       	call   10034c <cprintf>
    cprintf("  trap 0x%08x %s\n", tf->tf_trapno, trapname(tf->tf_trapno));
  101b46:	8b 45 08             	mov    0x8(%ebp),%eax
  101b49:	8b 40 30             	mov    0x30(%eax),%eax
  101b4c:	89 04 24             	mov    %eax,(%esp)
  101b4f:	e8 1f ff ff ff       	call   101a73 <trapname>
  101b54:	8b 55 08             	mov    0x8(%ebp),%edx
  101b57:	8b 52 30             	mov    0x30(%edx),%edx
  101b5a:	89 44 24 08          	mov    %eax,0x8(%esp)
  101b5e:	89 54 24 04          	mov    %edx,0x4(%esp)
  101b62:	c7 04 24 30 65 10 00 	movl   $0x106530,(%esp)
  101b69:	e8 de e7 ff ff       	call   10034c <cprintf>
    cprintf("  err  0x%08x\n", tf->tf_err);
  101b6e:	8b 45 08             	mov    0x8(%ebp),%eax
  101b71:	8b 40 34             	mov    0x34(%eax),%eax
  101b74:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b78:	c7 04 24 42 65 10 00 	movl   $0x106542,(%esp)
  101b7f:	e8 c8 e7 ff ff       	call   10034c <cprintf>
    cprintf("  eip  0x%08x\n", tf->tf_eip);
  101b84:	8b 45 08             	mov    0x8(%ebp),%eax
  101b87:	8b 40 38             	mov    0x38(%eax),%eax
  101b8a:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b8e:	c7 04 24 51 65 10 00 	movl   $0x106551,(%esp)
  101b95:	e8 b2 e7 ff ff       	call   10034c <cprintf>
    cprintf("  cs   0x----%04x\n", tf->tf_cs);
  101b9a:	8b 45 08             	mov    0x8(%ebp),%eax
  101b9d:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101ba1:	0f b7 c0             	movzwl %ax,%eax
  101ba4:	89 44 24 04          	mov    %eax,0x4(%esp)
  101ba8:	c7 04 24 60 65 10 00 	movl   $0x106560,(%esp)
  101baf:	e8 98 e7 ff ff       	call   10034c <cprintf>
    cprintf("  flag 0x%08x ", tf->tf_eflags);
  101bb4:	8b 45 08             	mov    0x8(%ebp),%eax
  101bb7:	8b 40 40             	mov    0x40(%eax),%eax
  101bba:	89 44 24 04          	mov    %eax,0x4(%esp)
  101bbe:	c7 04 24 73 65 10 00 	movl   $0x106573,(%esp)
  101bc5:	e8 82 e7 ff ff       	call   10034c <cprintf>

    int i, j;
    for (i = 0, j = 1; i < sizeof(IA32flags) / sizeof(IA32flags[0]); i ++, j <<= 1) {
  101bca:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  101bd1:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
  101bd8:	eb 3e                	jmp    101c18 <print_trapframe+0x15e>
        if ((tf->tf_eflags & j) && IA32flags[i] != NULL) {
  101bda:	8b 45 08             	mov    0x8(%ebp),%eax
  101bdd:	8b 50 40             	mov    0x40(%eax),%edx
  101be0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  101be3:	21 d0                	and    %edx,%eax
  101be5:	85 c0                	test   %eax,%eax
  101be7:	74 28                	je     101c11 <print_trapframe+0x157>
  101be9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101bec:	8b 04 85 a0 75 11 00 	mov    0x1175a0(,%eax,4),%eax
  101bf3:	85 c0                	test   %eax,%eax
  101bf5:	74 1a                	je     101c11 <print_trapframe+0x157>
            cprintf("%s,", IA32flags[i]);
  101bf7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101bfa:	8b 04 85 a0 75 11 00 	mov    0x1175a0(,%eax,4),%eax
  101c01:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c05:	c7 04 24 82 65 10 00 	movl   $0x106582,(%esp)
  101c0c:	e8 3b e7 ff ff       	call   10034c <cprintf>
    cprintf("  eip  0x%08x\n", tf->tf_eip);
    cprintf("  cs   0x----%04x\n", tf->tf_cs);
    cprintf("  flag 0x%08x ", tf->tf_eflags);

    int i, j;
    for (i = 0, j = 1; i < sizeof(IA32flags) / sizeof(IA32flags[0]); i ++, j <<= 1) {
  101c11:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  101c15:	d1 65 f0             	shll   -0x10(%ebp)
  101c18:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101c1b:	83 f8 17             	cmp    $0x17,%eax
  101c1e:	76 ba                	jbe    101bda <print_trapframe+0x120>
        if ((tf->tf_eflags & j) && IA32flags[i] != NULL) {
            cprintf("%s,", IA32flags[i]);
        }
    }
    cprintf("IOPL=%d\n", (tf->tf_eflags & FL_IOPL_MASK) >> 12);
  101c20:	8b 45 08             	mov    0x8(%ebp),%eax
  101c23:	8b 40 40             	mov    0x40(%eax),%eax
  101c26:	25 00 30 00 00       	and    $0x3000,%eax
  101c2b:	c1 e8 0c             	shr    $0xc,%eax
  101c2e:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c32:	c7 04 24 86 65 10 00 	movl   $0x106586,(%esp)
  101c39:	e8 0e e7 ff ff       	call   10034c <cprintf>

    if (!trap_in_kernel(tf)) {
  101c3e:	8b 45 08             	mov    0x8(%ebp),%eax
  101c41:	89 04 24             	mov    %eax,(%esp)
  101c44:	e8 5b fe ff ff       	call   101aa4 <trap_in_kernel>
  101c49:	85 c0                	test   %eax,%eax
  101c4b:	75 30                	jne    101c7d <print_trapframe+0x1c3>
        cprintf("  esp  0x%08x\n", tf->tf_esp);
  101c4d:	8b 45 08             	mov    0x8(%ebp),%eax
  101c50:	8b 40 44             	mov    0x44(%eax),%eax
  101c53:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c57:	c7 04 24 8f 65 10 00 	movl   $0x10658f,(%esp)
  101c5e:	e8 e9 e6 ff ff       	call   10034c <cprintf>
        cprintf("  ss   0x----%04x\n", tf->tf_ss);
  101c63:	8b 45 08             	mov    0x8(%ebp),%eax
  101c66:	0f b7 40 48          	movzwl 0x48(%eax),%eax
  101c6a:	0f b7 c0             	movzwl %ax,%eax
  101c6d:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c71:	c7 04 24 9e 65 10 00 	movl   $0x10659e,(%esp)
  101c78:	e8 cf e6 ff ff       	call   10034c <cprintf>
    }
}
  101c7d:	c9                   	leave  
  101c7e:	c3                   	ret    

00101c7f <print_regs>:

void
print_regs(struct pushregs *regs) {
  101c7f:	55                   	push   %ebp
  101c80:	89 e5                	mov    %esp,%ebp
  101c82:	83 ec 18             	sub    $0x18,%esp
    cprintf("  edi  0x%08x\n", regs->reg_edi);
  101c85:	8b 45 08             	mov    0x8(%ebp),%eax
  101c88:	8b 00                	mov    (%eax),%eax
  101c8a:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c8e:	c7 04 24 b1 65 10 00 	movl   $0x1065b1,(%esp)
  101c95:	e8 b2 e6 ff ff       	call   10034c <cprintf>
    cprintf("  esi  0x%08x\n", regs->reg_esi);
  101c9a:	8b 45 08             	mov    0x8(%ebp),%eax
  101c9d:	8b 40 04             	mov    0x4(%eax),%eax
  101ca0:	89 44 24 04          	mov    %eax,0x4(%esp)
  101ca4:	c7 04 24 c0 65 10 00 	movl   $0x1065c0,(%esp)
  101cab:	e8 9c e6 ff ff       	call   10034c <cprintf>
    cprintf("  ebp  0x%08x\n", regs->reg_ebp);
  101cb0:	8b 45 08             	mov    0x8(%ebp),%eax
  101cb3:	8b 40 08             	mov    0x8(%eax),%eax
  101cb6:	89 44 24 04          	mov    %eax,0x4(%esp)
  101cba:	c7 04 24 cf 65 10 00 	movl   $0x1065cf,(%esp)
  101cc1:	e8 86 e6 ff ff       	call   10034c <cprintf>
    cprintf("  oesp 0x%08x\n", regs->reg_oesp);
  101cc6:	8b 45 08             	mov    0x8(%ebp),%eax
  101cc9:	8b 40 0c             	mov    0xc(%eax),%eax
  101ccc:	89 44 24 04          	mov    %eax,0x4(%esp)
  101cd0:	c7 04 24 de 65 10 00 	movl   $0x1065de,(%esp)
  101cd7:	e8 70 e6 ff ff       	call   10034c <cprintf>
    cprintf("  ebx  0x%08x\n", regs->reg_ebx);
  101cdc:	8b 45 08             	mov    0x8(%ebp),%eax
  101cdf:	8b 40 10             	mov    0x10(%eax),%eax
  101ce2:	89 44 24 04          	mov    %eax,0x4(%esp)
  101ce6:	c7 04 24 ed 65 10 00 	movl   $0x1065ed,(%esp)
  101ced:	e8 5a e6 ff ff       	call   10034c <cprintf>
    cprintf("  edx  0x%08x\n", regs->reg_edx);
  101cf2:	8b 45 08             	mov    0x8(%ebp),%eax
  101cf5:	8b 40 14             	mov    0x14(%eax),%eax
  101cf8:	89 44 24 04          	mov    %eax,0x4(%esp)
  101cfc:	c7 04 24 fc 65 10 00 	movl   $0x1065fc,(%esp)
  101d03:	e8 44 e6 ff ff       	call   10034c <cprintf>
    cprintf("  ecx  0x%08x\n", regs->reg_ecx);
  101d08:	8b 45 08             	mov    0x8(%ebp),%eax
  101d0b:	8b 40 18             	mov    0x18(%eax),%eax
  101d0e:	89 44 24 04          	mov    %eax,0x4(%esp)
  101d12:	c7 04 24 0b 66 10 00 	movl   $0x10660b,(%esp)
  101d19:	e8 2e e6 ff ff       	call   10034c <cprintf>
    cprintf("  eax  0x%08x\n", regs->reg_eax);
  101d1e:	8b 45 08             	mov    0x8(%ebp),%eax
  101d21:	8b 40 1c             	mov    0x1c(%eax),%eax
  101d24:	89 44 24 04          	mov    %eax,0x4(%esp)
  101d28:	c7 04 24 1a 66 10 00 	movl   $0x10661a,(%esp)
  101d2f:	e8 18 e6 ff ff       	call   10034c <cprintf>
}
  101d34:	c9                   	leave  
  101d35:	c3                   	ret    

00101d36 <trap_dispatch>:

struct trapframe switchk2u, *switchu2k;

/* trap_dispatch - dispatch based on what type of trap occurred */
static void
trap_dispatch(struct trapframe *tf) {
  101d36:	55                   	push   %ebp
  101d37:	89 e5                	mov    %esp,%ebp
  101d39:	57                   	push   %edi
  101d3a:	56                   	push   %esi
  101d3b:	53                   	push   %ebx
  101d3c:	83 ec 2c             	sub    $0x2c,%esp
    char c;

    switch (tf->tf_trapno) {
  101d3f:	8b 45 08             	mov    0x8(%ebp),%eax
  101d42:	8b 40 30             	mov    0x30(%eax),%eax
  101d45:	83 f8 2f             	cmp    $0x2f,%eax
  101d48:	77 1d                	ja     101d67 <trap_dispatch+0x31>
  101d4a:	83 f8 2e             	cmp    $0x2e,%eax
  101d4d:	0f 83 d0 01 00 00    	jae    101f23 <trap_dispatch+0x1ed>
  101d53:	83 f8 21             	cmp    $0x21,%eax
  101d56:	74 7f                	je     101dd7 <trap_dispatch+0xa1>
  101d58:	83 f8 24             	cmp    $0x24,%eax
  101d5b:	74 51                	je     101dae <trap_dispatch+0x78>
  101d5d:	83 f8 20             	cmp    $0x20,%eax
  101d60:	74 1c                	je     101d7e <trap_dispatch+0x48>
  101d62:	e9 84 01 00 00       	jmp    101eeb <trap_dispatch+0x1b5>
  101d67:	83 f8 78             	cmp    $0x78,%eax
  101d6a:	0f 84 90 00 00 00    	je     101e00 <trap_dispatch+0xca>
  101d70:	83 f8 79             	cmp    $0x79,%eax
  101d73:	0f 84 fe 00 00 00    	je     101e77 <trap_dispatch+0x141>
  101d79:	e9 6d 01 00 00       	jmp    101eeb <trap_dispatch+0x1b5>
        /* handle the timer interrupt */
        /* (1) After a timer interrupt, you should record this event using a global variable (increase it), such as ticks in kern/driver/clock.c
         * (2) Every TICK_NUM cycle, you can print some info using a funciton, such as print_ticks().
         * (3) Too Simple? Yes, I think so!
         */
    	ticks++;
  101d7e:	a1 4c 89 11 00       	mov    0x11894c,%eax
  101d83:	83 c0 01             	add    $0x1,%eax
  101d86:	a3 4c 89 11 00       	mov    %eax,0x11894c
    	if (ticks == TICK_NUM)
  101d8b:	a1 4c 89 11 00       	mov    0x11894c,%eax
  101d90:	83 f8 64             	cmp    $0x64,%eax
  101d93:	75 14                	jne    101da9 <trap_dispatch+0x73>
    	{
    		print_ticks();
  101d95:	e8 24 fb ff ff       	call   1018be <print_ticks>
    		ticks= 0;
  101d9a:	c7 05 4c 89 11 00 00 	movl   $0x0,0x11894c
  101da1:	00 00 00 
    	}
        break;
  101da4:	e9 7b 01 00 00       	jmp    101f24 <trap_dispatch+0x1ee>
  101da9:	e9 76 01 00 00       	jmp    101f24 <trap_dispatch+0x1ee>
    case IRQ_OFFSET + IRQ_COM1:
        c = cons_getc();
  101dae:	e8 cf f8 ff ff       	call   101682 <cons_getc>
  101db3:	88 45 e7             	mov    %al,-0x19(%ebp)
        cprintf("serial [%03d] %c\n", c, c);
  101db6:	0f be 55 e7          	movsbl -0x19(%ebp),%edx
  101dba:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
  101dbe:	89 54 24 08          	mov    %edx,0x8(%esp)
  101dc2:	89 44 24 04          	mov    %eax,0x4(%esp)
  101dc6:	c7 04 24 29 66 10 00 	movl   $0x106629,(%esp)
  101dcd:	e8 7a e5 ff ff       	call   10034c <cprintf>
        break;
  101dd2:	e9 4d 01 00 00       	jmp    101f24 <trap_dispatch+0x1ee>
    case IRQ_OFFSET + IRQ_KBD:
        c = cons_getc();
  101dd7:	e8 a6 f8 ff ff       	call   101682 <cons_getc>
  101ddc:	88 45 e7             	mov    %al,-0x19(%ebp)
        cprintf("kbd [%03d] %c\n", c, c);
  101ddf:	0f be 55 e7          	movsbl -0x19(%ebp),%edx
  101de3:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
  101de7:	89 54 24 08          	mov    %edx,0x8(%esp)
  101deb:	89 44 24 04          	mov    %eax,0x4(%esp)
  101def:	c7 04 24 3b 66 10 00 	movl   $0x10663b,(%esp)
  101df6:	e8 51 e5 ff ff       	call   10034c <cprintf>
        break;
  101dfb:	e9 24 01 00 00       	jmp    101f24 <trap_dispatch+0x1ee>
    //LAB1 CHALLENGE 1 : 2012011274 you should modify below codes.
    case T_SWITCH_TOU:
    	if (tf->tf_cs != USER_CS)
  101e00:	8b 45 08             	mov    0x8(%ebp),%eax
  101e03:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101e07:	66 83 f8 1b          	cmp    $0x1b,%ax
  101e0b:	74 65                	je     101e72 <trap_dispatch+0x13c>
    	{
    		switchk2u = *tf;
  101e0d:	8b 45 08             	mov    0x8(%ebp),%eax
  101e10:	ba 60 89 11 00       	mov    $0x118960,%edx
  101e15:	89 c3                	mov    %eax,%ebx
  101e17:	b8 13 00 00 00       	mov    $0x13,%eax
  101e1c:	89 d7                	mov    %edx,%edi
  101e1e:	89 de                	mov    %ebx,%esi
  101e20:	89 c1                	mov    %eax,%ecx
  101e22:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    		switchk2u.tf_cs = USER_CS;
  101e24:	66 c7 05 9c 89 11 00 	movw   $0x1b,0x11899c
  101e2b:	1b 00 
    	    switchk2u.tf_ds = USER_DS;
  101e2d:	66 c7 05 8c 89 11 00 	movw   $0x23,0x11898c
  101e34:	23 00 
    	    switchk2u.tf_es = USER_DS;
  101e36:	66 c7 05 88 89 11 00 	movw   $0x23,0x118988
  101e3d:	23 00 
    	    switchk2u.tf_ss = USER_DS;
  101e3f:	66 c7 05 a8 89 11 00 	movw   $0x23,0x1189a8
  101e46:	23 00 
    	    switchk2u.tf_esp = (uint32_t)tf + sizeof(struct trapframe) - 8;
  101e48:	8b 45 08             	mov    0x8(%ebp),%eax
  101e4b:	83 c0 44             	add    $0x44,%eax
  101e4e:	a3 a4 89 11 00       	mov    %eax,0x1189a4

    	    switchk2u.tf_eflags |= FL_IOPL_MASK;
  101e53:	a1 a0 89 11 00       	mov    0x1189a0,%eax
  101e58:	80 cc 30             	or     $0x30,%ah
  101e5b:	a3 a0 89 11 00       	mov    %eax,0x1189a0

			*((uint32_t *)tf - 1) = (uint32_t)&switchk2u;
  101e60:	8b 45 08             	mov    0x8(%ebp),%eax
  101e63:	8d 50 fc             	lea    -0x4(%eax),%edx
  101e66:	b8 60 89 11 00       	mov    $0x118960,%eax
  101e6b:	89 02                	mov    %eax,(%edx)
		}
		break;
  101e6d:	e9 b2 00 00 00       	jmp    101f24 <trap_dispatch+0x1ee>
  101e72:	e9 ad 00 00 00       	jmp    101f24 <trap_dispatch+0x1ee>
    case T_SWITCH_TOK:
    	if (tf->tf_cs != KERNEL_CS)
  101e77:	8b 45 08             	mov    0x8(%ebp),%eax
  101e7a:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101e7e:	66 83 f8 08          	cmp    $0x8,%ax
  101e82:	74 65                	je     101ee9 <trap_dispatch+0x1b3>
    	{
			tf->tf_cs = KERNEL_CS;
  101e84:	8b 45 08             	mov    0x8(%ebp),%eax
  101e87:	66 c7 40 3c 08 00    	movw   $0x8,0x3c(%eax)
			tf->tf_ds = KERNEL_DS;
  101e8d:	8b 45 08             	mov    0x8(%ebp),%eax
  101e90:	66 c7 40 2c 10 00    	movw   $0x10,0x2c(%eax)
			tf->tf_es = KERNEL_DS;
  101e96:	8b 45 08             	mov    0x8(%ebp),%eax
  101e99:	66 c7 40 28 10 00    	movw   $0x10,0x28(%eax)
			tf->tf_eflags &= ~FL_IOPL_MASK;
  101e9f:	8b 45 08             	mov    0x8(%ebp),%eax
  101ea2:	8b 40 40             	mov    0x40(%eax),%eax
  101ea5:	80 e4 cf             	and    $0xcf,%ah
  101ea8:	89 c2                	mov    %eax,%edx
  101eaa:	8b 45 08             	mov    0x8(%ebp),%eax
  101ead:	89 50 40             	mov    %edx,0x40(%eax)
			switchu2k = (struct trapframe *)(tf->tf_esp - (sizeof(struct trapframe) - 8));
  101eb0:	8b 45 08             	mov    0x8(%ebp),%eax
  101eb3:	8b 40 44             	mov    0x44(%eax),%eax
  101eb6:	83 e8 44             	sub    $0x44,%eax
  101eb9:	a3 ac 89 11 00       	mov    %eax,0x1189ac
			memmove(switchu2k, tf, sizeof(struct trapframe) - 8);
  101ebe:	a1 ac 89 11 00       	mov    0x1189ac,%eax
  101ec3:	c7 44 24 08 44 00 00 	movl   $0x44,0x8(%esp)
  101eca:	00 
  101ecb:	8b 55 08             	mov    0x8(%ebp),%edx
  101ece:	89 54 24 04          	mov    %edx,0x4(%esp)
  101ed2:	89 04 24             	mov    %eax,(%esp)
  101ed5:	e8 9d 40 00 00       	call   105f77 <memmove>
			*((uint32_t *)tf - 1) = (uint32_t)switchu2k;
  101eda:	8b 45 08             	mov    0x8(%ebp),%eax
  101edd:	8d 50 fc             	lea    -0x4(%eax),%edx
  101ee0:	a1 ac 89 11 00       	mov    0x1189ac,%eax
  101ee5:	89 02                	mov    %eax,(%edx)
		}
        break;
  101ee7:	eb 3b                	jmp    101f24 <trap_dispatch+0x1ee>
  101ee9:	eb 39                	jmp    101f24 <trap_dispatch+0x1ee>
    case IRQ_OFFSET + IRQ_IDE2:
        /* do nothing */
        break;
    default:
        // in kernel, it must be a mistake
        if ((tf->tf_cs & 3) == 0) {
  101eeb:	8b 45 08             	mov    0x8(%ebp),%eax
  101eee:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101ef2:	0f b7 c0             	movzwl %ax,%eax
  101ef5:	83 e0 03             	and    $0x3,%eax
  101ef8:	85 c0                	test   %eax,%eax
  101efa:	75 28                	jne    101f24 <trap_dispatch+0x1ee>
            print_trapframe(tf);
  101efc:	8b 45 08             	mov    0x8(%ebp),%eax
  101eff:	89 04 24             	mov    %eax,(%esp)
  101f02:	e8 b3 fb ff ff       	call   101aba <print_trapframe>
            panic("unexpected trap in kernel.\n");
  101f07:	c7 44 24 08 4a 66 10 	movl   $0x10664a,0x8(%esp)
  101f0e:	00 
  101f0f:	c7 44 24 04 d4 00 00 	movl   $0xd4,0x4(%esp)
  101f16:	00 
  101f17:	c7 04 24 6e 64 10 00 	movl   $0x10646e,(%esp)
  101f1e:	e8 f1 ed ff ff       	call   100d14 <__panic>
		}
        break;
    case IRQ_OFFSET + IRQ_IDE1:
    case IRQ_OFFSET + IRQ_IDE2:
        /* do nothing */
        break;
  101f23:	90                   	nop
        if ((tf->tf_cs & 3) == 0) {
            print_trapframe(tf);
            panic("unexpected trap in kernel.\n");
        }
    }
}
  101f24:	83 c4 2c             	add    $0x2c,%esp
  101f27:	5b                   	pop    %ebx
  101f28:	5e                   	pop    %esi
  101f29:	5f                   	pop    %edi
  101f2a:	5d                   	pop    %ebp
  101f2b:	c3                   	ret    

00101f2c <trap>:
 * trap - handles or dispatches an exception/interrupt. if and when trap() returns,
 * the code in kern/trap/trapentry.S restores the old CPU state saved in the
 * trapframe and then uses the iret instruction to return from the exception.
 * */
void
trap(struct trapframe *tf) {
  101f2c:	55                   	push   %ebp
  101f2d:	89 e5                	mov    %esp,%ebp
  101f2f:	83 ec 18             	sub    $0x18,%esp
    // dispatch based on what type of trap occurred
    trap_dispatch(tf);
  101f32:	8b 45 08             	mov    0x8(%ebp),%eax
  101f35:	89 04 24             	mov    %eax,(%esp)
  101f38:	e8 f9 fd ff ff       	call   101d36 <trap_dispatch>
}
  101f3d:	c9                   	leave  
  101f3e:	c3                   	ret    

00101f3f <__alltraps>:
.text
.globl __alltraps
__alltraps:
    # push registers to build a trap frame
    # therefore make the stack look like a struct trapframe
    pushl %ds
  101f3f:	1e                   	push   %ds
    pushl %es
  101f40:	06                   	push   %es
    pushl %fs
  101f41:	0f a0                	push   %fs
    pushl %gs
  101f43:	0f a8                	push   %gs
    pushal
  101f45:	60                   	pusha  

    # load GD_KDATA into %ds and %es to set up data segments for kernel
    movl $GD_KDATA, %eax
  101f46:	b8 10 00 00 00       	mov    $0x10,%eax
    movw %ax, %ds
  101f4b:	8e d8                	mov    %eax,%ds
    movw %ax, %es
  101f4d:	8e c0                	mov    %eax,%es

    # push %esp to pass a pointer to the trapframe as an argument to trap()
    pushl %esp
  101f4f:	54                   	push   %esp

    # call trap(tf), where tf=%esp
    call trap
  101f50:	e8 d7 ff ff ff       	call   101f2c <trap>

    # pop the pushed stack pointer
    popl %esp
  101f55:	5c                   	pop    %esp

00101f56 <__trapret>:

    # return falls through to trapret...
.globl __trapret
__trapret:
    # restore registers from stack
    popal
  101f56:	61                   	popa   

    # restore %ds, %es, %fs and %gs
    popl %gs
  101f57:	0f a9                	pop    %gs
    popl %fs
  101f59:	0f a1                	pop    %fs
    popl %es
  101f5b:	07                   	pop    %es
    popl %ds
  101f5c:	1f                   	pop    %ds

    # get rid of the trap number and error code
    addl $0x8, %esp
  101f5d:	83 c4 08             	add    $0x8,%esp
    iret
  101f60:	cf                   	iret   

00101f61 <vector0>:
# handler
.text
.globl __alltraps
.globl vector0
vector0:
  pushl $0
  101f61:	6a 00                	push   $0x0
  pushl $0
  101f63:	6a 00                	push   $0x0
  jmp __alltraps
  101f65:	e9 d5 ff ff ff       	jmp    101f3f <__alltraps>

00101f6a <vector1>:
.globl vector1
vector1:
  pushl $0
  101f6a:	6a 00                	push   $0x0
  pushl $1
  101f6c:	6a 01                	push   $0x1
  jmp __alltraps
  101f6e:	e9 cc ff ff ff       	jmp    101f3f <__alltraps>

00101f73 <vector2>:
.globl vector2
vector2:
  pushl $0
  101f73:	6a 00                	push   $0x0
  pushl $2
  101f75:	6a 02                	push   $0x2
  jmp __alltraps
  101f77:	e9 c3 ff ff ff       	jmp    101f3f <__alltraps>

00101f7c <vector3>:
.globl vector3
vector3:
  pushl $0
  101f7c:	6a 00                	push   $0x0
  pushl $3
  101f7e:	6a 03                	push   $0x3
  jmp __alltraps
  101f80:	e9 ba ff ff ff       	jmp    101f3f <__alltraps>

00101f85 <vector4>:
.globl vector4
vector4:
  pushl $0
  101f85:	6a 00                	push   $0x0
  pushl $4
  101f87:	6a 04                	push   $0x4
  jmp __alltraps
  101f89:	e9 b1 ff ff ff       	jmp    101f3f <__alltraps>

00101f8e <vector5>:
.globl vector5
vector5:
  pushl $0
  101f8e:	6a 00                	push   $0x0
  pushl $5
  101f90:	6a 05                	push   $0x5
  jmp __alltraps
  101f92:	e9 a8 ff ff ff       	jmp    101f3f <__alltraps>

00101f97 <vector6>:
.globl vector6
vector6:
  pushl $0
  101f97:	6a 00                	push   $0x0
  pushl $6
  101f99:	6a 06                	push   $0x6
  jmp __alltraps
  101f9b:	e9 9f ff ff ff       	jmp    101f3f <__alltraps>

00101fa0 <vector7>:
.globl vector7
vector7:
  pushl $0
  101fa0:	6a 00                	push   $0x0
  pushl $7
  101fa2:	6a 07                	push   $0x7
  jmp __alltraps
  101fa4:	e9 96 ff ff ff       	jmp    101f3f <__alltraps>

00101fa9 <vector8>:
.globl vector8
vector8:
  pushl $8
  101fa9:	6a 08                	push   $0x8
  jmp __alltraps
  101fab:	e9 8f ff ff ff       	jmp    101f3f <__alltraps>

00101fb0 <vector9>:
.globl vector9
vector9:
  pushl $9
  101fb0:	6a 09                	push   $0x9
  jmp __alltraps
  101fb2:	e9 88 ff ff ff       	jmp    101f3f <__alltraps>

00101fb7 <vector10>:
.globl vector10
vector10:
  pushl $10
  101fb7:	6a 0a                	push   $0xa
  jmp __alltraps
  101fb9:	e9 81 ff ff ff       	jmp    101f3f <__alltraps>

00101fbe <vector11>:
.globl vector11
vector11:
  pushl $11
  101fbe:	6a 0b                	push   $0xb
  jmp __alltraps
  101fc0:	e9 7a ff ff ff       	jmp    101f3f <__alltraps>

00101fc5 <vector12>:
.globl vector12
vector12:
  pushl $12
  101fc5:	6a 0c                	push   $0xc
  jmp __alltraps
  101fc7:	e9 73 ff ff ff       	jmp    101f3f <__alltraps>

00101fcc <vector13>:
.globl vector13
vector13:
  pushl $13
  101fcc:	6a 0d                	push   $0xd
  jmp __alltraps
  101fce:	e9 6c ff ff ff       	jmp    101f3f <__alltraps>

00101fd3 <vector14>:
.globl vector14
vector14:
  pushl $14
  101fd3:	6a 0e                	push   $0xe
  jmp __alltraps
  101fd5:	e9 65 ff ff ff       	jmp    101f3f <__alltraps>

00101fda <vector15>:
.globl vector15
vector15:
  pushl $0
  101fda:	6a 00                	push   $0x0
  pushl $15
  101fdc:	6a 0f                	push   $0xf
  jmp __alltraps
  101fde:	e9 5c ff ff ff       	jmp    101f3f <__alltraps>

00101fe3 <vector16>:
.globl vector16
vector16:
  pushl $0
  101fe3:	6a 00                	push   $0x0
  pushl $16
  101fe5:	6a 10                	push   $0x10
  jmp __alltraps
  101fe7:	e9 53 ff ff ff       	jmp    101f3f <__alltraps>

00101fec <vector17>:
.globl vector17
vector17:
  pushl $17
  101fec:	6a 11                	push   $0x11
  jmp __alltraps
  101fee:	e9 4c ff ff ff       	jmp    101f3f <__alltraps>

00101ff3 <vector18>:
.globl vector18
vector18:
  pushl $0
  101ff3:	6a 00                	push   $0x0
  pushl $18
  101ff5:	6a 12                	push   $0x12
  jmp __alltraps
  101ff7:	e9 43 ff ff ff       	jmp    101f3f <__alltraps>

00101ffc <vector19>:
.globl vector19
vector19:
  pushl $0
  101ffc:	6a 00                	push   $0x0
  pushl $19
  101ffe:	6a 13                	push   $0x13
  jmp __alltraps
  102000:	e9 3a ff ff ff       	jmp    101f3f <__alltraps>

00102005 <vector20>:
.globl vector20
vector20:
  pushl $0
  102005:	6a 00                	push   $0x0
  pushl $20
  102007:	6a 14                	push   $0x14
  jmp __alltraps
  102009:	e9 31 ff ff ff       	jmp    101f3f <__alltraps>

0010200e <vector21>:
.globl vector21
vector21:
  pushl $0
  10200e:	6a 00                	push   $0x0
  pushl $21
  102010:	6a 15                	push   $0x15
  jmp __alltraps
  102012:	e9 28 ff ff ff       	jmp    101f3f <__alltraps>

00102017 <vector22>:
.globl vector22
vector22:
  pushl $0
  102017:	6a 00                	push   $0x0
  pushl $22
  102019:	6a 16                	push   $0x16
  jmp __alltraps
  10201b:	e9 1f ff ff ff       	jmp    101f3f <__alltraps>

00102020 <vector23>:
.globl vector23
vector23:
  pushl $0
  102020:	6a 00                	push   $0x0
  pushl $23
  102022:	6a 17                	push   $0x17
  jmp __alltraps
  102024:	e9 16 ff ff ff       	jmp    101f3f <__alltraps>

00102029 <vector24>:
.globl vector24
vector24:
  pushl $0
  102029:	6a 00                	push   $0x0
  pushl $24
  10202b:	6a 18                	push   $0x18
  jmp __alltraps
  10202d:	e9 0d ff ff ff       	jmp    101f3f <__alltraps>

00102032 <vector25>:
.globl vector25
vector25:
  pushl $0
  102032:	6a 00                	push   $0x0
  pushl $25
  102034:	6a 19                	push   $0x19
  jmp __alltraps
  102036:	e9 04 ff ff ff       	jmp    101f3f <__alltraps>

0010203b <vector26>:
.globl vector26
vector26:
  pushl $0
  10203b:	6a 00                	push   $0x0
  pushl $26
  10203d:	6a 1a                	push   $0x1a
  jmp __alltraps
  10203f:	e9 fb fe ff ff       	jmp    101f3f <__alltraps>

00102044 <vector27>:
.globl vector27
vector27:
  pushl $0
  102044:	6a 00                	push   $0x0
  pushl $27
  102046:	6a 1b                	push   $0x1b
  jmp __alltraps
  102048:	e9 f2 fe ff ff       	jmp    101f3f <__alltraps>

0010204d <vector28>:
.globl vector28
vector28:
  pushl $0
  10204d:	6a 00                	push   $0x0
  pushl $28
  10204f:	6a 1c                	push   $0x1c
  jmp __alltraps
  102051:	e9 e9 fe ff ff       	jmp    101f3f <__alltraps>

00102056 <vector29>:
.globl vector29
vector29:
  pushl $0
  102056:	6a 00                	push   $0x0
  pushl $29
  102058:	6a 1d                	push   $0x1d
  jmp __alltraps
  10205a:	e9 e0 fe ff ff       	jmp    101f3f <__alltraps>

0010205f <vector30>:
.globl vector30
vector30:
  pushl $0
  10205f:	6a 00                	push   $0x0
  pushl $30
  102061:	6a 1e                	push   $0x1e
  jmp __alltraps
  102063:	e9 d7 fe ff ff       	jmp    101f3f <__alltraps>

00102068 <vector31>:
.globl vector31
vector31:
  pushl $0
  102068:	6a 00                	push   $0x0
  pushl $31
  10206a:	6a 1f                	push   $0x1f
  jmp __alltraps
  10206c:	e9 ce fe ff ff       	jmp    101f3f <__alltraps>

00102071 <vector32>:
.globl vector32
vector32:
  pushl $0
  102071:	6a 00                	push   $0x0
  pushl $32
  102073:	6a 20                	push   $0x20
  jmp __alltraps
  102075:	e9 c5 fe ff ff       	jmp    101f3f <__alltraps>

0010207a <vector33>:
.globl vector33
vector33:
  pushl $0
  10207a:	6a 00                	push   $0x0
  pushl $33
  10207c:	6a 21                	push   $0x21
  jmp __alltraps
  10207e:	e9 bc fe ff ff       	jmp    101f3f <__alltraps>

00102083 <vector34>:
.globl vector34
vector34:
  pushl $0
  102083:	6a 00                	push   $0x0
  pushl $34
  102085:	6a 22                	push   $0x22
  jmp __alltraps
  102087:	e9 b3 fe ff ff       	jmp    101f3f <__alltraps>

0010208c <vector35>:
.globl vector35
vector35:
  pushl $0
  10208c:	6a 00                	push   $0x0
  pushl $35
  10208e:	6a 23                	push   $0x23
  jmp __alltraps
  102090:	e9 aa fe ff ff       	jmp    101f3f <__alltraps>

00102095 <vector36>:
.globl vector36
vector36:
  pushl $0
  102095:	6a 00                	push   $0x0
  pushl $36
  102097:	6a 24                	push   $0x24
  jmp __alltraps
  102099:	e9 a1 fe ff ff       	jmp    101f3f <__alltraps>

0010209e <vector37>:
.globl vector37
vector37:
  pushl $0
  10209e:	6a 00                	push   $0x0
  pushl $37
  1020a0:	6a 25                	push   $0x25
  jmp __alltraps
  1020a2:	e9 98 fe ff ff       	jmp    101f3f <__alltraps>

001020a7 <vector38>:
.globl vector38
vector38:
  pushl $0
  1020a7:	6a 00                	push   $0x0
  pushl $38
  1020a9:	6a 26                	push   $0x26
  jmp __alltraps
  1020ab:	e9 8f fe ff ff       	jmp    101f3f <__alltraps>

001020b0 <vector39>:
.globl vector39
vector39:
  pushl $0
  1020b0:	6a 00                	push   $0x0
  pushl $39
  1020b2:	6a 27                	push   $0x27
  jmp __alltraps
  1020b4:	e9 86 fe ff ff       	jmp    101f3f <__alltraps>

001020b9 <vector40>:
.globl vector40
vector40:
  pushl $0
  1020b9:	6a 00                	push   $0x0
  pushl $40
  1020bb:	6a 28                	push   $0x28
  jmp __alltraps
  1020bd:	e9 7d fe ff ff       	jmp    101f3f <__alltraps>

001020c2 <vector41>:
.globl vector41
vector41:
  pushl $0
  1020c2:	6a 00                	push   $0x0
  pushl $41
  1020c4:	6a 29                	push   $0x29
  jmp __alltraps
  1020c6:	e9 74 fe ff ff       	jmp    101f3f <__alltraps>

001020cb <vector42>:
.globl vector42
vector42:
  pushl $0
  1020cb:	6a 00                	push   $0x0
  pushl $42
  1020cd:	6a 2a                	push   $0x2a
  jmp __alltraps
  1020cf:	e9 6b fe ff ff       	jmp    101f3f <__alltraps>

001020d4 <vector43>:
.globl vector43
vector43:
  pushl $0
  1020d4:	6a 00                	push   $0x0
  pushl $43
  1020d6:	6a 2b                	push   $0x2b
  jmp __alltraps
  1020d8:	e9 62 fe ff ff       	jmp    101f3f <__alltraps>

001020dd <vector44>:
.globl vector44
vector44:
  pushl $0
  1020dd:	6a 00                	push   $0x0
  pushl $44
  1020df:	6a 2c                	push   $0x2c
  jmp __alltraps
  1020e1:	e9 59 fe ff ff       	jmp    101f3f <__alltraps>

001020e6 <vector45>:
.globl vector45
vector45:
  pushl $0
  1020e6:	6a 00                	push   $0x0
  pushl $45
  1020e8:	6a 2d                	push   $0x2d
  jmp __alltraps
  1020ea:	e9 50 fe ff ff       	jmp    101f3f <__alltraps>

001020ef <vector46>:
.globl vector46
vector46:
  pushl $0
  1020ef:	6a 00                	push   $0x0
  pushl $46
  1020f1:	6a 2e                	push   $0x2e
  jmp __alltraps
  1020f3:	e9 47 fe ff ff       	jmp    101f3f <__alltraps>

001020f8 <vector47>:
.globl vector47
vector47:
  pushl $0
  1020f8:	6a 00                	push   $0x0
  pushl $47
  1020fa:	6a 2f                	push   $0x2f
  jmp __alltraps
  1020fc:	e9 3e fe ff ff       	jmp    101f3f <__alltraps>

00102101 <vector48>:
.globl vector48
vector48:
  pushl $0
  102101:	6a 00                	push   $0x0
  pushl $48
  102103:	6a 30                	push   $0x30
  jmp __alltraps
  102105:	e9 35 fe ff ff       	jmp    101f3f <__alltraps>

0010210a <vector49>:
.globl vector49
vector49:
  pushl $0
  10210a:	6a 00                	push   $0x0
  pushl $49
  10210c:	6a 31                	push   $0x31
  jmp __alltraps
  10210e:	e9 2c fe ff ff       	jmp    101f3f <__alltraps>

00102113 <vector50>:
.globl vector50
vector50:
  pushl $0
  102113:	6a 00                	push   $0x0
  pushl $50
  102115:	6a 32                	push   $0x32
  jmp __alltraps
  102117:	e9 23 fe ff ff       	jmp    101f3f <__alltraps>

0010211c <vector51>:
.globl vector51
vector51:
  pushl $0
  10211c:	6a 00                	push   $0x0
  pushl $51
  10211e:	6a 33                	push   $0x33
  jmp __alltraps
  102120:	e9 1a fe ff ff       	jmp    101f3f <__alltraps>

00102125 <vector52>:
.globl vector52
vector52:
  pushl $0
  102125:	6a 00                	push   $0x0
  pushl $52
  102127:	6a 34                	push   $0x34
  jmp __alltraps
  102129:	e9 11 fe ff ff       	jmp    101f3f <__alltraps>

0010212e <vector53>:
.globl vector53
vector53:
  pushl $0
  10212e:	6a 00                	push   $0x0
  pushl $53
  102130:	6a 35                	push   $0x35
  jmp __alltraps
  102132:	e9 08 fe ff ff       	jmp    101f3f <__alltraps>

00102137 <vector54>:
.globl vector54
vector54:
  pushl $0
  102137:	6a 00                	push   $0x0
  pushl $54
  102139:	6a 36                	push   $0x36
  jmp __alltraps
  10213b:	e9 ff fd ff ff       	jmp    101f3f <__alltraps>

00102140 <vector55>:
.globl vector55
vector55:
  pushl $0
  102140:	6a 00                	push   $0x0
  pushl $55
  102142:	6a 37                	push   $0x37
  jmp __alltraps
  102144:	e9 f6 fd ff ff       	jmp    101f3f <__alltraps>

00102149 <vector56>:
.globl vector56
vector56:
  pushl $0
  102149:	6a 00                	push   $0x0
  pushl $56
  10214b:	6a 38                	push   $0x38
  jmp __alltraps
  10214d:	e9 ed fd ff ff       	jmp    101f3f <__alltraps>

00102152 <vector57>:
.globl vector57
vector57:
  pushl $0
  102152:	6a 00                	push   $0x0
  pushl $57
  102154:	6a 39                	push   $0x39
  jmp __alltraps
  102156:	e9 e4 fd ff ff       	jmp    101f3f <__alltraps>

0010215b <vector58>:
.globl vector58
vector58:
  pushl $0
  10215b:	6a 00                	push   $0x0
  pushl $58
  10215d:	6a 3a                	push   $0x3a
  jmp __alltraps
  10215f:	e9 db fd ff ff       	jmp    101f3f <__alltraps>

00102164 <vector59>:
.globl vector59
vector59:
  pushl $0
  102164:	6a 00                	push   $0x0
  pushl $59
  102166:	6a 3b                	push   $0x3b
  jmp __alltraps
  102168:	e9 d2 fd ff ff       	jmp    101f3f <__alltraps>

0010216d <vector60>:
.globl vector60
vector60:
  pushl $0
  10216d:	6a 00                	push   $0x0
  pushl $60
  10216f:	6a 3c                	push   $0x3c
  jmp __alltraps
  102171:	e9 c9 fd ff ff       	jmp    101f3f <__alltraps>

00102176 <vector61>:
.globl vector61
vector61:
  pushl $0
  102176:	6a 00                	push   $0x0
  pushl $61
  102178:	6a 3d                	push   $0x3d
  jmp __alltraps
  10217a:	e9 c0 fd ff ff       	jmp    101f3f <__alltraps>

0010217f <vector62>:
.globl vector62
vector62:
  pushl $0
  10217f:	6a 00                	push   $0x0
  pushl $62
  102181:	6a 3e                	push   $0x3e
  jmp __alltraps
  102183:	e9 b7 fd ff ff       	jmp    101f3f <__alltraps>

00102188 <vector63>:
.globl vector63
vector63:
  pushl $0
  102188:	6a 00                	push   $0x0
  pushl $63
  10218a:	6a 3f                	push   $0x3f
  jmp __alltraps
  10218c:	e9 ae fd ff ff       	jmp    101f3f <__alltraps>

00102191 <vector64>:
.globl vector64
vector64:
  pushl $0
  102191:	6a 00                	push   $0x0
  pushl $64
  102193:	6a 40                	push   $0x40
  jmp __alltraps
  102195:	e9 a5 fd ff ff       	jmp    101f3f <__alltraps>

0010219a <vector65>:
.globl vector65
vector65:
  pushl $0
  10219a:	6a 00                	push   $0x0
  pushl $65
  10219c:	6a 41                	push   $0x41
  jmp __alltraps
  10219e:	e9 9c fd ff ff       	jmp    101f3f <__alltraps>

001021a3 <vector66>:
.globl vector66
vector66:
  pushl $0
  1021a3:	6a 00                	push   $0x0
  pushl $66
  1021a5:	6a 42                	push   $0x42
  jmp __alltraps
  1021a7:	e9 93 fd ff ff       	jmp    101f3f <__alltraps>

001021ac <vector67>:
.globl vector67
vector67:
  pushl $0
  1021ac:	6a 00                	push   $0x0
  pushl $67
  1021ae:	6a 43                	push   $0x43
  jmp __alltraps
  1021b0:	e9 8a fd ff ff       	jmp    101f3f <__alltraps>

001021b5 <vector68>:
.globl vector68
vector68:
  pushl $0
  1021b5:	6a 00                	push   $0x0
  pushl $68
  1021b7:	6a 44                	push   $0x44
  jmp __alltraps
  1021b9:	e9 81 fd ff ff       	jmp    101f3f <__alltraps>

001021be <vector69>:
.globl vector69
vector69:
  pushl $0
  1021be:	6a 00                	push   $0x0
  pushl $69
  1021c0:	6a 45                	push   $0x45
  jmp __alltraps
  1021c2:	e9 78 fd ff ff       	jmp    101f3f <__alltraps>

001021c7 <vector70>:
.globl vector70
vector70:
  pushl $0
  1021c7:	6a 00                	push   $0x0
  pushl $70
  1021c9:	6a 46                	push   $0x46
  jmp __alltraps
  1021cb:	e9 6f fd ff ff       	jmp    101f3f <__alltraps>

001021d0 <vector71>:
.globl vector71
vector71:
  pushl $0
  1021d0:	6a 00                	push   $0x0
  pushl $71
  1021d2:	6a 47                	push   $0x47
  jmp __alltraps
  1021d4:	e9 66 fd ff ff       	jmp    101f3f <__alltraps>

001021d9 <vector72>:
.globl vector72
vector72:
  pushl $0
  1021d9:	6a 00                	push   $0x0
  pushl $72
  1021db:	6a 48                	push   $0x48
  jmp __alltraps
  1021dd:	e9 5d fd ff ff       	jmp    101f3f <__alltraps>

001021e2 <vector73>:
.globl vector73
vector73:
  pushl $0
  1021e2:	6a 00                	push   $0x0
  pushl $73
  1021e4:	6a 49                	push   $0x49
  jmp __alltraps
  1021e6:	e9 54 fd ff ff       	jmp    101f3f <__alltraps>

001021eb <vector74>:
.globl vector74
vector74:
  pushl $0
  1021eb:	6a 00                	push   $0x0
  pushl $74
  1021ed:	6a 4a                	push   $0x4a
  jmp __alltraps
  1021ef:	e9 4b fd ff ff       	jmp    101f3f <__alltraps>

001021f4 <vector75>:
.globl vector75
vector75:
  pushl $0
  1021f4:	6a 00                	push   $0x0
  pushl $75
  1021f6:	6a 4b                	push   $0x4b
  jmp __alltraps
  1021f8:	e9 42 fd ff ff       	jmp    101f3f <__alltraps>

001021fd <vector76>:
.globl vector76
vector76:
  pushl $0
  1021fd:	6a 00                	push   $0x0
  pushl $76
  1021ff:	6a 4c                	push   $0x4c
  jmp __alltraps
  102201:	e9 39 fd ff ff       	jmp    101f3f <__alltraps>

00102206 <vector77>:
.globl vector77
vector77:
  pushl $0
  102206:	6a 00                	push   $0x0
  pushl $77
  102208:	6a 4d                	push   $0x4d
  jmp __alltraps
  10220a:	e9 30 fd ff ff       	jmp    101f3f <__alltraps>

0010220f <vector78>:
.globl vector78
vector78:
  pushl $0
  10220f:	6a 00                	push   $0x0
  pushl $78
  102211:	6a 4e                	push   $0x4e
  jmp __alltraps
  102213:	e9 27 fd ff ff       	jmp    101f3f <__alltraps>

00102218 <vector79>:
.globl vector79
vector79:
  pushl $0
  102218:	6a 00                	push   $0x0
  pushl $79
  10221a:	6a 4f                	push   $0x4f
  jmp __alltraps
  10221c:	e9 1e fd ff ff       	jmp    101f3f <__alltraps>

00102221 <vector80>:
.globl vector80
vector80:
  pushl $0
  102221:	6a 00                	push   $0x0
  pushl $80
  102223:	6a 50                	push   $0x50
  jmp __alltraps
  102225:	e9 15 fd ff ff       	jmp    101f3f <__alltraps>

0010222a <vector81>:
.globl vector81
vector81:
  pushl $0
  10222a:	6a 00                	push   $0x0
  pushl $81
  10222c:	6a 51                	push   $0x51
  jmp __alltraps
  10222e:	e9 0c fd ff ff       	jmp    101f3f <__alltraps>

00102233 <vector82>:
.globl vector82
vector82:
  pushl $0
  102233:	6a 00                	push   $0x0
  pushl $82
  102235:	6a 52                	push   $0x52
  jmp __alltraps
  102237:	e9 03 fd ff ff       	jmp    101f3f <__alltraps>

0010223c <vector83>:
.globl vector83
vector83:
  pushl $0
  10223c:	6a 00                	push   $0x0
  pushl $83
  10223e:	6a 53                	push   $0x53
  jmp __alltraps
  102240:	e9 fa fc ff ff       	jmp    101f3f <__alltraps>

00102245 <vector84>:
.globl vector84
vector84:
  pushl $0
  102245:	6a 00                	push   $0x0
  pushl $84
  102247:	6a 54                	push   $0x54
  jmp __alltraps
  102249:	e9 f1 fc ff ff       	jmp    101f3f <__alltraps>

0010224e <vector85>:
.globl vector85
vector85:
  pushl $0
  10224e:	6a 00                	push   $0x0
  pushl $85
  102250:	6a 55                	push   $0x55
  jmp __alltraps
  102252:	e9 e8 fc ff ff       	jmp    101f3f <__alltraps>

00102257 <vector86>:
.globl vector86
vector86:
  pushl $0
  102257:	6a 00                	push   $0x0
  pushl $86
  102259:	6a 56                	push   $0x56
  jmp __alltraps
  10225b:	e9 df fc ff ff       	jmp    101f3f <__alltraps>

00102260 <vector87>:
.globl vector87
vector87:
  pushl $0
  102260:	6a 00                	push   $0x0
  pushl $87
  102262:	6a 57                	push   $0x57
  jmp __alltraps
  102264:	e9 d6 fc ff ff       	jmp    101f3f <__alltraps>

00102269 <vector88>:
.globl vector88
vector88:
  pushl $0
  102269:	6a 00                	push   $0x0
  pushl $88
  10226b:	6a 58                	push   $0x58
  jmp __alltraps
  10226d:	e9 cd fc ff ff       	jmp    101f3f <__alltraps>

00102272 <vector89>:
.globl vector89
vector89:
  pushl $0
  102272:	6a 00                	push   $0x0
  pushl $89
  102274:	6a 59                	push   $0x59
  jmp __alltraps
  102276:	e9 c4 fc ff ff       	jmp    101f3f <__alltraps>

0010227b <vector90>:
.globl vector90
vector90:
  pushl $0
  10227b:	6a 00                	push   $0x0
  pushl $90
  10227d:	6a 5a                	push   $0x5a
  jmp __alltraps
  10227f:	e9 bb fc ff ff       	jmp    101f3f <__alltraps>

00102284 <vector91>:
.globl vector91
vector91:
  pushl $0
  102284:	6a 00                	push   $0x0
  pushl $91
  102286:	6a 5b                	push   $0x5b
  jmp __alltraps
  102288:	e9 b2 fc ff ff       	jmp    101f3f <__alltraps>

0010228d <vector92>:
.globl vector92
vector92:
  pushl $0
  10228d:	6a 00                	push   $0x0
  pushl $92
  10228f:	6a 5c                	push   $0x5c
  jmp __alltraps
  102291:	e9 a9 fc ff ff       	jmp    101f3f <__alltraps>

00102296 <vector93>:
.globl vector93
vector93:
  pushl $0
  102296:	6a 00                	push   $0x0
  pushl $93
  102298:	6a 5d                	push   $0x5d
  jmp __alltraps
  10229a:	e9 a0 fc ff ff       	jmp    101f3f <__alltraps>

0010229f <vector94>:
.globl vector94
vector94:
  pushl $0
  10229f:	6a 00                	push   $0x0
  pushl $94
  1022a1:	6a 5e                	push   $0x5e
  jmp __alltraps
  1022a3:	e9 97 fc ff ff       	jmp    101f3f <__alltraps>

001022a8 <vector95>:
.globl vector95
vector95:
  pushl $0
  1022a8:	6a 00                	push   $0x0
  pushl $95
  1022aa:	6a 5f                	push   $0x5f
  jmp __alltraps
  1022ac:	e9 8e fc ff ff       	jmp    101f3f <__alltraps>

001022b1 <vector96>:
.globl vector96
vector96:
  pushl $0
  1022b1:	6a 00                	push   $0x0
  pushl $96
  1022b3:	6a 60                	push   $0x60
  jmp __alltraps
  1022b5:	e9 85 fc ff ff       	jmp    101f3f <__alltraps>

001022ba <vector97>:
.globl vector97
vector97:
  pushl $0
  1022ba:	6a 00                	push   $0x0
  pushl $97
  1022bc:	6a 61                	push   $0x61
  jmp __alltraps
  1022be:	e9 7c fc ff ff       	jmp    101f3f <__alltraps>

001022c3 <vector98>:
.globl vector98
vector98:
  pushl $0
  1022c3:	6a 00                	push   $0x0
  pushl $98
  1022c5:	6a 62                	push   $0x62
  jmp __alltraps
  1022c7:	e9 73 fc ff ff       	jmp    101f3f <__alltraps>

001022cc <vector99>:
.globl vector99
vector99:
  pushl $0
  1022cc:	6a 00                	push   $0x0
  pushl $99
  1022ce:	6a 63                	push   $0x63
  jmp __alltraps
  1022d0:	e9 6a fc ff ff       	jmp    101f3f <__alltraps>

001022d5 <vector100>:
.globl vector100
vector100:
  pushl $0
  1022d5:	6a 00                	push   $0x0
  pushl $100
  1022d7:	6a 64                	push   $0x64
  jmp __alltraps
  1022d9:	e9 61 fc ff ff       	jmp    101f3f <__alltraps>

001022de <vector101>:
.globl vector101
vector101:
  pushl $0
  1022de:	6a 00                	push   $0x0
  pushl $101
  1022e0:	6a 65                	push   $0x65
  jmp __alltraps
  1022e2:	e9 58 fc ff ff       	jmp    101f3f <__alltraps>

001022e7 <vector102>:
.globl vector102
vector102:
  pushl $0
  1022e7:	6a 00                	push   $0x0
  pushl $102
  1022e9:	6a 66                	push   $0x66
  jmp __alltraps
  1022eb:	e9 4f fc ff ff       	jmp    101f3f <__alltraps>

001022f0 <vector103>:
.globl vector103
vector103:
  pushl $0
  1022f0:	6a 00                	push   $0x0
  pushl $103
  1022f2:	6a 67                	push   $0x67
  jmp __alltraps
  1022f4:	e9 46 fc ff ff       	jmp    101f3f <__alltraps>

001022f9 <vector104>:
.globl vector104
vector104:
  pushl $0
  1022f9:	6a 00                	push   $0x0
  pushl $104
  1022fb:	6a 68                	push   $0x68
  jmp __alltraps
  1022fd:	e9 3d fc ff ff       	jmp    101f3f <__alltraps>

00102302 <vector105>:
.globl vector105
vector105:
  pushl $0
  102302:	6a 00                	push   $0x0
  pushl $105
  102304:	6a 69                	push   $0x69
  jmp __alltraps
  102306:	e9 34 fc ff ff       	jmp    101f3f <__alltraps>

0010230b <vector106>:
.globl vector106
vector106:
  pushl $0
  10230b:	6a 00                	push   $0x0
  pushl $106
  10230d:	6a 6a                	push   $0x6a
  jmp __alltraps
  10230f:	e9 2b fc ff ff       	jmp    101f3f <__alltraps>

00102314 <vector107>:
.globl vector107
vector107:
  pushl $0
  102314:	6a 00                	push   $0x0
  pushl $107
  102316:	6a 6b                	push   $0x6b
  jmp __alltraps
  102318:	e9 22 fc ff ff       	jmp    101f3f <__alltraps>

0010231d <vector108>:
.globl vector108
vector108:
  pushl $0
  10231d:	6a 00                	push   $0x0
  pushl $108
  10231f:	6a 6c                	push   $0x6c
  jmp __alltraps
  102321:	e9 19 fc ff ff       	jmp    101f3f <__alltraps>

00102326 <vector109>:
.globl vector109
vector109:
  pushl $0
  102326:	6a 00                	push   $0x0
  pushl $109
  102328:	6a 6d                	push   $0x6d
  jmp __alltraps
  10232a:	e9 10 fc ff ff       	jmp    101f3f <__alltraps>

0010232f <vector110>:
.globl vector110
vector110:
  pushl $0
  10232f:	6a 00                	push   $0x0
  pushl $110
  102331:	6a 6e                	push   $0x6e
  jmp __alltraps
  102333:	e9 07 fc ff ff       	jmp    101f3f <__alltraps>

00102338 <vector111>:
.globl vector111
vector111:
  pushl $0
  102338:	6a 00                	push   $0x0
  pushl $111
  10233a:	6a 6f                	push   $0x6f
  jmp __alltraps
  10233c:	e9 fe fb ff ff       	jmp    101f3f <__alltraps>

00102341 <vector112>:
.globl vector112
vector112:
  pushl $0
  102341:	6a 00                	push   $0x0
  pushl $112
  102343:	6a 70                	push   $0x70
  jmp __alltraps
  102345:	e9 f5 fb ff ff       	jmp    101f3f <__alltraps>

0010234a <vector113>:
.globl vector113
vector113:
  pushl $0
  10234a:	6a 00                	push   $0x0
  pushl $113
  10234c:	6a 71                	push   $0x71
  jmp __alltraps
  10234e:	e9 ec fb ff ff       	jmp    101f3f <__alltraps>

00102353 <vector114>:
.globl vector114
vector114:
  pushl $0
  102353:	6a 00                	push   $0x0
  pushl $114
  102355:	6a 72                	push   $0x72
  jmp __alltraps
  102357:	e9 e3 fb ff ff       	jmp    101f3f <__alltraps>

0010235c <vector115>:
.globl vector115
vector115:
  pushl $0
  10235c:	6a 00                	push   $0x0
  pushl $115
  10235e:	6a 73                	push   $0x73
  jmp __alltraps
  102360:	e9 da fb ff ff       	jmp    101f3f <__alltraps>

00102365 <vector116>:
.globl vector116
vector116:
  pushl $0
  102365:	6a 00                	push   $0x0
  pushl $116
  102367:	6a 74                	push   $0x74
  jmp __alltraps
  102369:	e9 d1 fb ff ff       	jmp    101f3f <__alltraps>

0010236e <vector117>:
.globl vector117
vector117:
  pushl $0
  10236e:	6a 00                	push   $0x0
  pushl $117
  102370:	6a 75                	push   $0x75
  jmp __alltraps
  102372:	e9 c8 fb ff ff       	jmp    101f3f <__alltraps>

00102377 <vector118>:
.globl vector118
vector118:
  pushl $0
  102377:	6a 00                	push   $0x0
  pushl $118
  102379:	6a 76                	push   $0x76
  jmp __alltraps
  10237b:	e9 bf fb ff ff       	jmp    101f3f <__alltraps>

00102380 <vector119>:
.globl vector119
vector119:
  pushl $0
  102380:	6a 00                	push   $0x0
  pushl $119
  102382:	6a 77                	push   $0x77
  jmp __alltraps
  102384:	e9 b6 fb ff ff       	jmp    101f3f <__alltraps>

00102389 <vector120>:
.globl vector120
vector120:
  pushl $0
  102389:	6a 00                	push   $0x0
  pushl $120
  10238b:	6a 78                	push   $0x78
  jmp __alltraps
  10238d:	e9 ad fb ff ff       	jmp    101f3f <__alltraps>

00102392 <vector121>:
.globl vector121
vector121:
  pushl $0
  102392:	6a 00                	push   $0x0
  pushl $121
  102394:	6a 79                	push   $0x79
  jmp __alltraps
  102396:	e9 a4 fb ff ff       	jmp    101f3f <__alltraps>

0010239b <vector122>:
.globl vector122
vector122:
  pushl $0
  10239b:	6a 00                	push   $0x0
  pushl $122
  10239d:	6a 7a                	push   $0x7a
  jmp __alltraps
  10239f:	e9 9b fb ff ff       	jmp    101f3f <__alltraps>

001023a4 <vector123>:
.globl vector123
vector123:
  pushl $0
  1023a4:	6a 00                	push   $0x0
  pushl $123
  1023a6:	6a 7b                	push   $0x7b
  jmp __alltraps
  1023a8:	e9 92 fb ff ff       	jmp    101f3f <__alltraps>

001023ad <vector124>:
.globl vector124
vector124:
  pushl $0
  1023ad:	6a 00                	push   $0x0
  pushl $124
  1023af:	6a 7c                	push   $0x7c
  jmp __alltraps
  1023b1:	e9 89 fb ff ff       	jmp    101f3f <__alltraps>

001023b6 <vector125>:
.globl vector125
vector125:
  pushl $0
  1023b6:	6a 00                	push   $0x0
  pushl $125
  1023b8:	6a 7d                	push   $0x7d
  jmp __alltraps
  1023ba:	e9 80 fb ff ff       	jmp    101f3f <__alltraps>

001023bf <vector126>:
.globl vector126
vector126:
  pushl $0
  1023bf:	6a 00                	push   $0x0
  pushl $126
  1023c1:	6a 7e                	push   $0x7e
  jmp __alltraps
  1023c3:	e9 77 fb ff ff       	jmp    101f3f <__alltraps>

001023c8 <vector127>:
.globl vector127
vector127:
  pushl $0
  1023c8:	6a 00                	push   $0x0
  pushl $127
  1023ca:	6a 7f                	push   $0x7f
  jmp __alltraps
  1023cc:	e9 6e fb ff ff       	jmp    101f3f <__alltraps>

001023d1 <vector128>:
.globl vector128
vector128:
  pushl $0
  1023d1:	6a 00                	push   $0x0
  pushl $128
  1023d3:	68 80 00 00 00       	push   $0x80
  jmp __alltraps
  1023d8:	e9 62 fb ff ff       	jmp    101f3f <__alltraps>

001023dd <vector129>:
.globl vector129
vector129:
  pushl $0
  1023dd:	6a 00                	push   $0x0
  pushl $129
  1023df:	68 81 00 00 00       	push   $0x81
  jmp __alltraps
  1023e4:	e9 56 fb ff ff       	jmp    101f3f <__alltraps>

001023e9 <vector130>:
.globl vector130
vector130:
  pushl $0
  1023e9:	6a 00                	push   $0x0
  pushl $130
  1023eb:	68 82 00 00 00       	push   $0x82
  jmp __alltraps
  1023f0:	e9 4a fb ff ff       	jmp    101f3f <__alltraps>

001023f5 <vector131>:
.globl vector131
vector131:
  pushl $0
  1023f5:	6a 00                	push   $0x0
  pushl $131
  1023f7:	68 83 00 00 00       	push   $0x83
  jmp __alltraps
  1023fc:	e9 3e fb ff ff       	jmp    101f3f <__alltraps>

00102401 <vector132>:
.globl vector132
vector132:
  pushl $0
  102401:	6a 00                	push   $0x0
  pushl $132
  102403:	68 84 00 00 00       	push   $0x84
  jmp __alltraps
  102408:	e9 32 fb ff ff       	jmp    101f3f <__alltraps>

0010240d <vector133>:
.globl vector133
vector133:
  pushl $0
  10240d:	6a 00                	push   $0x0
  pushl $133
  10240f:	68 85 00 00 00       	push   $0x85
  jmp __alltraps
  102414:	e9 26 fb ff ff       	jmp    101f3f <__alltraps>

00102419 <vector134>:
.globl vector134
vector134:
  pushl $0
  102419:	6a 00                	push   $0x0
  pushl $134
  10241b:	68 86 00 00 00       	push   $0x86
  jmp __alltraps
  102420:	e9 1a fb ff ff       	jmp    101f3f <__alltraps>

00102425 <vector135>:
.globl vector135
vector135:
  pushl $0
  102425:	6a 00                	push   $0x0
  pushl $135
  102427:	68 87 00 00 00       	push   $0x87
  jmp __alltraps
  10242c:	e9 0e fb ff ff       	jmp    101f3f <__alltraps>

00102431 <vector136>:
.globl vector136
vector136:
  pushl $0
  102431:	6a 00                	push   $0x0
  pushl $136
  102433:	68 88 00 00 00       	push   $0x88
  jmp __alltraps
  102438:	e9 02 fb ff ff       	jmp    101f3f <__alltraps>

0010243d <vector137>:
.globl vector137
vector137:
  pushl $0
  10243d:	6a 00                	push   $0x0
  pushl $137
  10243f:	68 89 00 00 00       	push   $0x89
  jmp __alltraps
  102444:	e9 f6 fa ff ff       	jmp    101f3f <__alltraps>

00102449 <vector138>:
.globl vector138
vector138:
  pushl $0
  102449:	6a 00                	push   $0x0
  pushl $138
  10244b:	68 8a 00 00 00       	push   $0x8a
  jmp __alltraps
  102450:	e9 ea fa ff ff       	jmp    101f3f <__alltraps>

00102455 <vector139>:
.globl vector139
vector139:
  pushl $0
  102455:	6a 00                	push   $0x0
  pushl $139
  102457:	68 8b 00 00 00       	push   $0x8b
  jmp __alltraps
  10245c:	e9 de fa ff ff       	jmp    101f3f <__alltraps>

00102461 <vector140>:
.globl vector140
vector140:
  pushl $0
  102461:	6a 00                	push   $0x0
  pushl $140
  102463:	68 8c 00 00 00       	push   $0x8c
  jmp __alltraps
  102468:	e9 d2 fa ff ff       	jmp    101f3f <__alltraps>

0010246d <vector141>:
.globl vector141
vector141:
  pushl $0
  10246d:	6a 00                	push   $0x0
  pushl $141
  10246f:	68 8d 00 00 00       	push   $0x8d
  jmp __alltraps
  102474:	e9 c6 fa ff ff       	jmp    101f3f <__alltraps>

00102479 <vector142>:
.globl vector142
vector142:
  pushl $0
  102479:	6a 00                	push   $0x0
  pushl $142
  10247b:	68 8e 00 00 00       	push   $0x8e
  jmp __alltraps
  102480:	e9 ba fa ff ff       	jmp    101f3f <__alltraps>

00102485 <vector143>:
.globl vector143
vector143:
  pushl $0
  102485:	6a 00                	push   $0x0
  pushl $143
  102487:	68 8f 00 00 00       	push   $0x8f
  jmp __alltraps
  10248c:	e9 ae fa ff ff       	jmp    101f3f <__alltraps>

00102491 <vector144>:
.globl vector144
vector144:
  pushl $0
  102491:	6a 00                	push   $0x0
  pushl $144
  102493:	68 90 00 00 00       	push   $0x90
  jmp __alltraps
  102498:	e9 a2 fa ff ff       	jmp    101f3f <__alltraps>

0010249d <vector145>:
.globl vector145
vector145:
  pushl $0
  10249d:	6a 00                	push   $0x0
  pushl $145
  10249f:	68 91 00 00 00       	push   $0x91
  jmp __alltraps
  1024a4:	e9 96 fa ff ff       	jmp    101f3f <__alltraps>

001024a9 <vector146>:
.globl vector146
vector146:
  pushl $0
  1024a9:	6a 00                	push   $0x0
  pushl $146
  1024ab:	68 92 00 00 00       	push   $0x92
  jmp __alltraps
  1024b0:	e9 8a fa ff ff       	jmp    101f3f <__alltraps>

001024b5 <vector147>:
.globl vector147
vector147:
  pushl $0
  1024b5:	6a 00                	push   $0x0
  pushl $147
  1024b7:	68 93 00 00 00       	push   $0x93
  jmp __alltraps
  1024bc:	e9 7e fa ff ff       	jmp    101f3f <__alltraps>

001024c1 <vector148>:
.globl vector148
vector148:
  pushl $0
  1024c1:	6a 00                	push   $0x0
  pushl $148
  1024c3:	68 94 00 00 00       	push   $0x94
  jmp __alltraps
  1024c8:	e9 72 fa ff ff       	jmp    101f3f <__alltraps>

001024cd <vector149>:
.globl vector149
vector149:
  pushl $0
  1024cd:	6a 00                	push   $0x0
  pushl $149
  1024cf:	68 95 00 00 00       	push   $0x95
  jmp __alltraps
  1024d4:	e9 66 fa ff ff       	jmp    101f3f <__alltraps>

001024d9 <vector150>:
.globl vector150
vector150:
  pushl $0
  1024d9:	6a 00                	push   $0x0
  pushl $150
  1024db:	68 96 00 00 00       	push   $0x96
  jmp __alltraps
  1024e0:	e9 5a fa ff ff       	jmp    101f3f <__alltraps>

001024e5 <vector151>:
.globl vector151
vector151:
  pushl $0
  1024e5:	6a 00                	push   $0x0
  pushl $151
  1024e7:	68 97 00 00 00       	push   $0x97
  jmp __alltraps
  1024ec:	e9 4e fa ff ff       	jmp    101f3f <__alltraps>

001024f1 <vector152>:
.globl vector152
vector152:
  pushl $0
  1024f1:	6a 00                	push   $0x0
  pushl $152
  1024f3:	68 98 00 00 00       	push   $0x98
  jmp __alltraps
  1024f8:	e9 42 fa ff ff       	jmp    101f3f <__alltraps>

001024fd <vector153>:
.globl vector153
vector153:
  pushl $0
  1024fd:	6a 00                	push   $0x0
  pushl $153
  1024ff:	68 99 00 00 00       	push   $0x99
  jmp __alltraps
  102504:	e9 36 fa ff ff       	jmp    101f3f <__alltraps>

00102509 <vector154>:
.globl vector154
vector154:
  pushl $0
  102509:	6a 00                	push   $0x0
  pushl $154
  10250b:	68 9a 00 00 00       	push   $0x9a
  jmp __alltraps
  102510:	e9 2a fa ff ff       	jmp    101f3f <__alltraps>

00102515 <vector155>:
.globl vector155
vector155:
  pushl $0
  102515:	6a 00                	push   $0x0
  pushl $155
  102517:	68 9b 00 00 00       	push   $0x9b
  jmp __alltraps
  10251c:	e9 1e fa ff ff       	jmp    101f3f <__alltraps>

00102521 <vector156>:
.globl vector156
vector156:
  pushl $0
  102521:	6a 00                	push   $0x0
  pushl $156
  102523:	68 9c 00 00 00       	push   $0x9c
  jmp __alltraps
  102528:	e9 12 fa ff ff       	jmp    101f3f <__alltraps>

0010252d <vector157>:
.globl vector157
vector157:
  pushl $0
  10252d:	6a 00                	push   $0x0
  pushl $157
  10252f:	68 9d 00 00 00       	push   $0x9d
  jmp __alltraps
  102534:	e9 06 fa ff ff       	jmp    101f3f <__alltraps>

00102539 <vector158>:
.globl vector158
vector158:
  pushl $0
  102539:	6a 00                	push   $0x0
  pushl $158
  10253b:	68 9e 00 00 00       	push   $0x9e
  jmp __alltraps
  102540:	e9 fa f9 ff ff       	jmp    101f3f <__alltraps>

00102545 <vector159>:
.globl vector159
vector159:
  pushl $0
  102545:	6a 00                	push   $0x0
  pushl $159
  102547:	68 9f 00 00 00       	push   $0x9f
  jmp __alltraps
  10254c:	e9 ee f9 ff ff       	jmp    101f3f <__alltraps>

00102551 <vector160>:
.globl vector160
vector160:
  pushl $0
  102551:	6a 00                	push   $0x0
  pushl $160
  102553:	68 a0 00 00 00       	push   $0xa0
  jmp __alltraps
  102558:	e9 e2 f9 ff ff       	jmp    101f3f <__alltraps>

0010255d <vector161>:
.globl vector161
vector161:
  pushl $0
  10255d:	6a 00                	push   $0x0
  pushl $161
  10255f:	68 a1 00 00 00       	push   $0xa1
  jmp __alltraps
  102564:	e9 d6 f9 ff ff       	jmp    101f3f <__alltraps>

00102569 <vector162>:
.globl vector162
vector162:
  pushl $0
  102569:	6a 00                	push   $0x0
  pushl $162
  10256b:	68 a2 00 00 00       	push   $0xa2
  jmp __alltraps
  102570:	e9 ca f9 ff ff       	jmp    101f3f <__alltraps>

00102575 <vector163>:
.globl vector163
vector163:
  pushl $0
  102575:	6a 00                	push   $0x0
  pushl $163
  102577:	68 a3 00 00 00       	push   $0xa3
  jmp __alltraps
  10257c:	e9 be f9 ff ff       	jmp    101f3f <__alltraps>

00102581 <vector164>:
.globl vector164
vector164:
  pushl $0
  102581:	6a 00                	push   $0x0
  pushl $164
  102583:	68 a4 00 00 00       	push   $0xa4
  jmp __alltraps
  102588:	e9 b2 f9 ff ff       	jmp    101f3f <__alltraps>

0010258d <vector165>:
.globl vector165
vector165:
  pushl $0
  10258d:	6a 00                	push   $0x0
  pushl $165
  10258f:	68 a5 00 00 00       	push   $0xa5
  jmp __alltraps
  102594:	e9 a6 f9 ff ff       	jmp    101f3f <__alltraps>

00102599 <vector166>:
.globl vector166
vector166:
  pushl $0
  102599:	6a 00                	push   $0x0
  pushl $166
  10259b:	68 a6 00 00 00       	push   $0xa6
  jmp __alltraps
  1025a0:	e9 9a f9 ff ff       	jmp    101f3f <__alltraps>

001025a5 <vector167>:
.globl vector167
vector167:
  pushl $0
  1025a5:	6a 00                	push   $0x0
  pushl $167
  1025a7:	68 a7 00 00 00       	push   $0xa7
  jmp __alltraps
  1025ac:	e9 8e f9 ff ff       	jmp    101f3f <__alltraps>

001025b1 <vector168>:
.globl vector168
vector168:
  pushl $0
  1025b1:	6a 00                	push   $0x0
  pushl $168
  1025b3:	68 a8 00 00 00       	push   $0xa8
  jmp __alltraps
  1025b8:	e9 82 f9 ff ff       	jmp    101f3f <__alltraps>

001025bd <vector169>:
.globl vector169
vector169:
  pushl $0
  1025bd:	6a 00                	push   $0x0
  pushl $169
  1025bf:	68 a9 00 00 00       	push   $0xa9
  jmp __alltraps
  1025c4:	e9 76 f9 ff ff       	jmp    101f3f <__alltraps>

001025c9 <vector170>:
.globl vector170
vector170:
  pushl $0
  1025c9:	6a 00                	push   $0x0
  pushl $170
  1025cb:	68 aa 00 00 00       	push   $0xaa
  jmp __alltraps
  1025d0:	e9 6a f9 ff ff       	jmp    101f3f <__alltraps>

001025d5 <vector171>:
.globl vector171
vector171:
  pushl $0
  1025d5:	6a 00                	push   $0x0
  pushl $171
  1025d7:	68 ab 00 00 00       	push   $0xab
  jmp __alltraps
  1025dc:	e9 5e f9 ff ff       	jmp    101f3f <__alltraps>

001025e1 <vector172>:
.globl vector172
vector172:
  pushl $0
  1025e1:	6a 00                	push   $0x0
  pushl $172
  1025e3:	68 ac 00 00 00       	push   $0xac
  jmp __alltraps
  1025e8:	e9 52 f9 ff ff       	jmp    101f3f <__alltraps>

001025ed <vector173>:
.globl vector173
vector173:
  pushl $0
  1025ed:	6a 00                	push   $0x0
  pushl $173
  1025ef:	68 ad 00 00 00       	push   $0xad
  jmp __alltraps
  1025f4:	e9 46 f9 ff ff       	jmp    101f3f <__alltraps>

001025f9 <vector174>:
.globl vector174
vector174:
  pushl $0
  1025f9:	6a 00                	push   $0x0
  pushl $174
  1025fb:	68 ae 00 00 00       	push   $0xae
  jmp __alltraps
  102600:	e9 3a f9 ff ff       	jmp    101f3f <__alltraps>

00102605 <vector175>:
.globl vector175
vector175:
  pushl $0
  102605:	6a 00                	push   $0x0
  pushl $175
  102607:	68 af 00 00 00       	push   $0xaf
  jmp __alltraps
  10260c:	e9 2e f9 ff ff       	jmp    101f3f <__alltraps>

00102611 <vector176>:
.globl vector176
vector176:
  pushl $0
  102611:	6a 00                	push   $0x0
  pushl $176
  102613:	68 b0 00 00 00       	push   $0xb0
  jmp __alltraps
  102618:	e9 22 f9 ff ff       	jmp    101f3f <__alltraps>

0010261d <vector177>:
.globl vector177
vector177:
  pushl $0
  10261d:	6a 00                	push   $0x0
  pushl $177
  10261f:	68 b1 00 00 00       	push   $0xb1
  jmp __alltraps
  102624:	e9 16 f9 ff ff       	jmp    101f3f <__alltraps>

00102629 <vector178>:
.globl vector178
vector178:
  pushl $0
  102629:	6a 00                	push   $0x0
  pushl $178
  10262b:	68 b2 00 00 00       	push   $0xb2
  jmp __alltraps
  102630:	e9 0a f9 ff ff       	jmp    101f3f <__alltraps>

00102635 <vector179>:
.globl vector179
vector179:
  pushl $0
  102635:	6a 00                	push   $0x0
  pushl $179
  102637:	68 b3 00 00 00       	push   $0xb3
  jmp __alltraps
  10263c:	e9 fe f8 ff ff       	jmp    101f3f <__alltraps>

00102641 <vector180>:
.globl vector180
vector180:
  pushl $0
  102641:	6a 00                	push   $0x0
  pushl $180
  102643:	68 b4 00 00 00       	push   $0xb4
  jmp __alltraps
  102648:	e9 f2 f8 ff ff       	jmp    101f3f <__alltraps>

0010264d <vector181>:
.globl vector181
vector181:
  pushl $0
  10264d:	6a 00                	push   $0x0
  pushl $181
  10264f:	68 b5 00 00 00       	push   $0xb5
  jmp __alltraps
  102654:	e9 e6 f8 ff ff       	jmp    101f3f <__alltraps>

00102659 <vector182>:
.globl vector182
vector182:
  pushl $0
  102659:	6a 00                	push   $0x0
  pushl $182
  10265b:	68 b6 00 00 00       	push   $0xb6
  jmp __alltraps
  102660:	e9 da f8 ff ff       	jmp    101f3f <__alltraps>

00102665 <vector183>:
.globl vector183
vector183:
  pushl $0
  102665:	6a 00                	push   $0x0
  pushl $183
  102667:	68 b7 00 00 00       	push   $0xb7
  jmp __alltraps
  10266c:	e9 ce f8 ff ff       	jmp    101f3f <__alltraps>

00102671 <vector184>:
.globl vector184
vector184:
  pushl $0
  102671:	6a 00                	push   $0x0
  pushl $184
  102673:	68 b8 00 00 00       	push   $0xb8
  jmp __alltraps
  102678:	e9 c2 f8 ff ff       	jmp    101f3f <__alltraps>

0010267d <vector185>:
.globl vector185
vector185:
  pushl $0
  10267d:	6a 00                	push   $0x0
  pushl $185
  10267f:	68 b9 00 00 00       	push   $0xb9
  jmp __alltraps
  102684:	e9 b6 f8 ff ff       	jmp    101f3f <__alltraps>

00102689 <vector186>:
.globl vector186
vector186:
  pushl $0
  102689:	6a 00                	push   $0x0
  pushl $186
  10268b:	68 ba 00 00 00       	push   $0xba
  jmp __alltraps
  102690:	e9 aa f8 ff ff       	jmp    101f3f <__alltraps>

00102695 <vector187>:
.globl vector187
vector187:
  pushl $0
  102695:	6a 00                	push   $0x0
  pushl $187
  102697:	68 bb 00 00 00       	push   $0xbb
  jmp __alltraps
  10269c:	e9 9e f8 ff ff       	jmp    101f3f <__alltraps>

001026a1 <vector188>:
.globl vector188
vector188:
  pushl $0
  1026a1:	6a 00                	push   $0x0
  pushl $188
  1026a3:	68 bc 00 00 00       	push   $0xbc
  jmp __alltraps
  1026a8:	e9 92 f8 ff ff       	jmp    101f3f <__alltraps>

001026ad <vector189>:
.globl vector189
vector189:
  pushl $0
  1026ad:	6a 00                	push   $0x0
  pushl $189
  1026af:	68 bd 00 00 00       	push   $0xbd
  jmp __alltraps
  1026b4:	e9 86 f8 ff ff       	jmp    101f3f <__alltraps>

001026b9 <vector190>:
.globl vector190
vector190:
  pushl $0
  1026b9:	6a 00                	push   $0x0
  pushl $190
  1026bb:	68 be 00 00 00       	push   $0xbe
  jmp __alltraps
  1026c0:	e9 7a f8 ff ff       	jmp    101f3f <__alltraps>

001026c5 <vector191>:
.globl vector191
vector191:
  pushl $0
  1026c5:	6a 00                	push   $0x0
  pushl $191
  1026c7:	68 bf 00 00 00       	push   $0xbf
  jmp __alltraps
  1026cc:	e9 6e f8 ff ff       	jmp    101f3f <__alltraps>

001026d1 <vector192>:
.globl vector192
vector192:
  pushl $0
  1026d1:	6a 00                	push   $0x0
  pushl $192
  1026d3:	68 c0 00 00 00       	push   $0xc0
  jmp __alltraps
  1026d8:	e9 62 f8 ff ff       	jmp    101f3f <__alltraps>

001026dd <vector193>:
.globl vector193
vector193:
  pushl $0
  1026dd:	6a 00                	push   $0x0
  pushl $193
  1026df:	68 c1 00 00 00       	push   $0xc1
  jmp __alltraps
  1026e4:	e9 56 f8 ff ff       	jmp    101f3f <__alltraps>

001026e9 <vector194>:
.globl vector194
vector194:
  pushl $0
  1026e9:	6a 00                	push   $0x0
  pushl $194
  1026eb:	68 c2 00 00 00       	push   $0xc2
  jmp __alltraps
  1026f0:	e9 4a f8 ff ff       	jmp    101f3f <__alltraps>

001026f5 <vector195>:
.globl vector195
vector195:
  pushl $0
  1026f5:	6a 00                	push   $0x0
  pushl $195
  1026f7:	68 c3 00 00 00       	push   $0xc3
  jmp __alltraps
  1026fc:	e9 3e f8 ff ff       	jmp    101f3f <__alltraps>

00102701 <vector196>:
.globl vector196
vector196:
  pushl $0
  102701:	6a 00                	push   $0x0
  pushl $196
  102703:	68 c4 00 00 00       	push   $0xc4
  jmp __alltraps
  102708:	e9 32 f8 ff ff       	jmp    101f3f <__alltraps>

0010270d <vector197>:
.globl vector197
vector197:
  pushl $0
  10270d:	6a 00                	push   $0x0
  pushl $197
  10270f:	68 c5 00 00 00       	push   $0xc5
  jmp __alltraps
  102714:	e9 26 f8 ff ff       	jmp    101f3f <__alltraps>

00102719 <vector198>:
.globl vector198
vector198:
  pushl $0
  102719:	6a 00                	push   $0x0
  pushl $198
  10271b:	68 c6 00 00 00       	push   $0xc6
  jmp __alltraps
  102720:	e9 1a f8 ff ff       	jmp    101f3f <__alltraps>

00102725 <vector199>:
.globl vector199
vector199:
  pushl $0
  102725:	6a 00                	push   $0x0
  pushl $199
  102727:	68 c7 00 00 00       	push   $0xc7
  jmp __alltraps
  10272c:	e9 0e f8 ff ff       	jmp    101f3f <__alltraps>

00102731 <vector200>:
.globl vector200
vector200:
  pushl $0
  102731:	6a 00                	push   $0x0
  pushl $200
  102733:	68 c8 00 00 00       	push   $0xc8
  jmp __alltraps
  102738:	e9 02 f8 ff ff       	jmp    101f3f <__alltraps>

0010273d <vector201>:
.globl vector201
vector201:
  pushl $0
  10273d:	6a 00                	push   $0x0
  pushl $201
  10273f:	68 c9 00 00 00       	push   $0xc9
  jmp __alltraps
  102744:	e9 f6 f7 ff ff       	jmp    101f3f <__alltraps>

00102749 <vector202>:
.globl vector202
vector202:
  pushl $0
  102749:	6a 00                	push   $0x0
  pushl $202
  10274b:	68 ca 00 00 00       	push   $0xca
  jmp __alltraps
  102750:	e9 ea f7 ff ff       	jmp    101f3f <__alltraps>

00102755 <vector203>:
.globl vector203
vector203:
  pushl $0
  102755:	6a 00                	push   $0x0
  pushl $203
  102757:	68 cb 00 00 00       	push   $0xcb
  jmp __alltraps
  10275c:	e9 de f7 ff ff       	jmp    101f3f <__alltraps>

00102761 <vector204>:
.globl vector204
vector204:
  pushl $0
  102761:	6a 00                	push   $0x0
  pushl $204
  102763:	68 cc 00 00 00       	push   $0xcc
  jmp __alltraps
  102768:	e9 d2 f7 ff ff       	jmp    101f3f <__alltraps>

0010276d <vector205>:
.globl vector205
vector205:
  pushl $0
  10276d:	6a 00                	push   $0x0
  pushl $205
  10276f:	68 cd 00 00 00       	push   $0xcd
  jmp __alltraps
  102774:	e9 c6 f7 ff ff       	jmp    101f3f <__alltraps>

00102779 <vector206>:
.globl vector206
vector206:
  pushl $0
  102779:	6a 00                	push   $0x0
  pushl $206
  10277b:	68 ce 00 00 00       	push   $0xce
  jmp __alltraps
  102780:	e9 ba f7 ff ff       	jmp    101f3f <__alltraps>

00102785 <vector207>:
.globl vector207
vector207:
  pushl $0
  102785:	6a 00                	push   $0x0
  pushl $207
  102787:	68 cf 00 00 00       	push   $0xcf
  jmp __alltraps
  10278c:	e9 ae f7 ff ff       	jmp    101f3f <__alltraps>

00102791 <vector208>:
.globl vector208
vector208:
  pushl $0
  102791:	6a 00                	push   $0x0
  pushl $208
  102793:	68 d0 00 00 00       	push   $0xd0
  jmp __alltraps
  102798:	e9 a2 f7 ff ff       	jmp    101f3f <__alltraps>

0010279d <vector209>:
.globl vector209
vector209:
  pushl $0
  10279d:	6a 00                	push   $0x0
  pushl $209
  10279f:	68 d1 00 00 00       	push   $0xd1
  jmp __alltraps
  1027a4:	e9 96 f7 ff ff       	jmp    101f3f <__alltraps>

001027a9 <vector210>:
.globl vector210
vector210:
  pushl $0
  1027a9:	6a 00                	push   $0x0
  pushl $210
  1027ab:	68 d2 00 00 00       	push   $0xd2
  jmp __alltraps
  1027b0:	e9 8a f7 ff ff       	jmp    101f3f <__alltraps>

001027b5 <vector211>:
.globl vector211
vector211:
  pushl $0
  1027b5:	6a 00                	push   $0x0
  pushl $211
  1027b7:	68 d3 00 00 00       	push   $0xd3
  jmp __alltraps
  1027bc:	e9 7e f7 ff ff       	jmp    101f3f <__alltraps>

001027c1 <vector212>:
.globl vector212
vector212:
  pushl $0
  1027c1:	6a 00                	push   $0x0
  pushl $212
  1027c3:	68 d4 00 00 00       	push   $0xd4
  jmp __alltraps
  1027c8:	e9 72 f7 ff ff       	jmp    101f3f <__alltraps>

001027cd <vector213>:
.globl vector213
vector213:
  pushl $0
  1027cd:	6a 00                	push   $0x0
  pushl $213
  1027cf:	68 d5 00 00 00       	push   $0xd5
  jmp __alltraps
  1027d4:	e9 66 f7 ff ff       	jmp    101f3f <__alltraps>

001027d9 <vector214>:
.globl vector214
vector214:
  pushl $0
  1027d9:	6a 00                	push   $0x0
  pushl $214
  1027db:	68 d6 00 00 00       	push   $0xd6
  jmp __alltraps
  1027e0:	e9 5a f7 ff ff       	jmp    101f3f <__alltraps>

001027e5 <vector215>:
.globl vector215
vector215:
  pushl $0
  1027e5:	6a 00                	push   $0x0
  pushl $215
  1027e7:	68 d7 00 00 00       	push   $0xd7
  jmp __alltraps
  1027ec:	e9 4e f7 ff ff       	jmp    101f3f <__alltraps>

001027f1 <vector216>:
.globl vector216
vector216:
  pushl $0
  1027f1:	6a 00                	push   $0x0
  pushl $216
  1027f3:	68 d8 00 00 00       	push   $0xd8
  jmp __alltraps
  1027f8:	e9 42 f7 ff ff       	jmp    101f3f <__alltraps>

001027fd <vector217>:
.globl vector217
vector217:
  pushl $0
  1027fd:	6a 00                	push   $0x0
  pushl $217
  1027ff:	68 d9 00 00 00       	push   $0xd9
  jmp __alltraps
  102804:	e9 36 f7 ff ff       	jmp    101f3f <__alltraps>

00102809 <vector218>:
.globl vector218
vector218:
  pushl $0
  102809:	6a 00                	push   $0x0
  pushl $218
  10280b:	68 da 00 00 00       	push   $0xda
  jmp __alltraps
  102810:	e9 2a f7 ff ff       	jmp    101f3f <__alltraps>

00102815 <vector219>:
.globl vector219
vector219:
  pushl $0
  102815:	6a 00                	push   $0x0
  pushl $219
  102817:	68 db 00 00 00       	push   $0xdb
  jmp __alltraps
  10281c:	e9 1e f7 ff ff       	jmp    101f3f <__alltraps>

00102821 <vector220>:
.globl vector220
vector220:
  pushl $0
  102821:	6a 00                	push   $0x0
  pushl $220
  102823:	68 dc 00 00 00       	push   $0xdc
  jmp __alltraps
  102828:	e9 12 f7 ff ff       	jmp    101f3f <__alltraps>

0010282d <vector221>:
.globl vector221
vector221:
  pushl $0
  10282d:	6a 00                	push   $0x0
  pushl $221
  10282f:	68 dd 00 00 00       	push   $0xdd
  jmp __alltraps
  102834:	e9 06 f7 ff ff       	jmp    101f3f <__alltraps>

00102839 <vector222>:
.globl vector222
vector222:
  pushl $0
  102839:	6a 00                	push   $0x0
  pushl $222
  10283b:	68 de 00 00 00       	push   $0xde
  jmp __alltraps
  102840:	e9 fa f6 ff ff       	jmp    101f3f <__alltraps>

00102845 <vector223>:
.globl vector223
vector223:
  pushl $0
  102845:	6a 00                	push   $0x0
  pushl $223
  102847:	68 df 00 00 00       	push   $0xdf
  jmp __alltraps
  10284c:	e9 ee f6 ff ff       	jmp    101f3f <__alltraps>

00102851 <vector224>:
.globl vector224
vector224:
  pushl $0
  102851:	6a 00                	push   $0x0
  pushl $224
  102853:	68 e0 00 00 00       	push   $0xe0
  jmp __alltraps
  102858:	e9 e2 f6 ff ff       	jmp    101f3f <__alltraps>

0010285d <vector225>:
.globl vector225
vector225:
  pushl $0
  10285d:	6a 00                	push   $0x0
  pushl $225
  10285f:	68 e1 00 00 00       	push   $0xe1
  jmp __alltraps
  102864:	e9 d6 f6 ff ff       	jmp    101f3f <__alltraps>

00102869 <vector226>:
.globl vector226
vector226:
  pushl $0
  102869:	6a 00                	push   $0x0
  pushl $226
  10286b:	68 e2 00 00 00       	push   $0xe2
  jmp __alltraps
  102870:	e9 ca f6 ff ff       	jmp    101f3f <__alltraps>

00102875 <vector227>:
.globl vector227
vector227:
  pushl $0
  102875:	6a 00                	push   $0x0
  pushl $227
  102877:	68 e3 00 00 00       	push   $0xe3
  jmp __alltraps
  10287c:	e9 be f6 ff ff       	jmp    101f3f <__alltraps>

00102881 <vector228>:
.globl vector228
vector228:
  pushl $0
  102881:	6a 00                	push   $0x0
  pushl $228
  102883:	68 e4 00 00 00       	push   $0xe4
  jmp __alltraps
  102888:	e9 b2 f6 ff ff       	jmp    101f3f <__alltraps>

0010288d <vector229>:
.globl vector229
vector229:
  pushl $0
  10288d:	6a 00                	push   $0x0
  pushl $229
  10288f:	68 e5 00 00 00       	push   $0xe5
  jmp __alltraps
  102894:	e9 a6 f6 ff ff       	jmp    101f3f <__alltraps>

00102899 <vector230>:
.globl vector230
vector230:
  pushl $0
  102899:	6a 00                	push   $0x0
  pushl $230
  10289b:	68 e6 00 00 00       	push   $0xe6
  jmp __alltraps
  1028a0:	e9 9a f6 ff ff       	jmp    101f3f <__alltraps>

001028a5 <vector231>:
.globl vector231
vector231:
  pushl $0
  1028a5:	6a 00                	push   $0x0
  pushl $231
  1028a7:	68 e7 00 00 00       	push   $0xe7
  jmp __alltraps
  1028ac:	e9 8e f6 ff ff       	jmp    101f3f <__alltraps>

001028b1 <vector232>:
.globl vector232
vector232:
  pushl $0
  1028b1:	6a 00                	push   $0x0
  pushl $232
  1028b3:	68 e8 00 00 00       	push   $0xe8
  jmp __alltraps
  1028b8:	e9 82 f6 ff ff       	jmp    101f3f <__alltraps>

001028bd <vector233>:
.globl vector233
vector233:
  pushl $0
  1028bd:	6a 00                	push   $0x0
  pushl $233
  1028bf:	68 e9 00 00 00       	push   $0xe9
  jmp __alltraps
  1028c4:	e9 76 f6 ff ff       	jmp    101f3f <__alltraps>

001028c9 <vector234>:
.globl vector234
vector234:
  pushl $0
  1028c9:	6a 00                	push   $0x0
  pushl $234
  1028cb:	68 ea 00 00 00       	push   $0xea
  jmp __alltraps
  1028d0:	e9 6a f6 ff ff       	jmp    101f3f <__alltraps>

001028d5 <vector235>:
.globl vector235
vector235:
  pushl $0
  1028d5:	6a 00                	push   $0x0
  pushl $235
  1028d7:	68 eb 00 00 00       	push   $0xeb
  jmp __alltraps
  1028dc:	e9 5e f6 ff ff       	jmp    101f3f <__alltraps>

001028e1 <vector236>:
.globl vector236
vector236:
  pushl $0
  1028e1:	6a 00                	push   $0x0
  pushl $236
  1028e3:	68 ec 00 00 00       	push   $0xec
  jmp __alltraps
  1028e8:	e9 52 f6 ff ff       	jmp    101f3f <__alltraps>

001028ed <vector237>:
.globl vector237
vector237:
  pushl $0
  1028ed:	6a 00                	push   $0x0
  pushl $237
  1028ef:	68 ed 00 00 00       	push   $0xed
  jmp __alltraps
  1028f4:	e9 46 f6 ff ff       	jmp    101f3f <__alltraps>

001028f9 <vector238>:
.globl vector238
vector238:
  pushl $0
  1028f9:	6a 00                	push   $0x0
  pushl $238
  1028fb:	68 ee 00 00 00       	push   $0xee
  jmp __alltraps
  102900:	e9 3a f6 ff ff       	jmp    101f3f <__alltraps>

00102905 <vector239>:
.globl vector239
vector239:
  pushl $0
  102905:	6a 00                	push   $0x0
  pushl $239
  102907:	68 ef 00 00 00       	push   $0xef
  jmp __alltraps
  10290c:	e9 2e f6 ff ff       	jmp    101f3f <__alltraps>

00102911 <vector240>:
.globl vector240
vector240:
  pushl $0
  102911:	6a 00                	push   $0x0
  pushl $240
  102913:	68 f0 00 00 00       	push   $0xf0
  jmp __alltraps
  102918:	e9 22 f6 ff ff       	jmp    101f3f <__alltraps>

0010291d <vector241>:
.globl vector241
vector241:
  pushl $0
  10291d:	6a 00                	push   $0x0
  pushl $241
  10291f:	68 f1 00 00 00       	push   $0xf1
  jmp __alltraps
  102924:	e9 16 f6 ff ff       	jmp    101f3f <__alltraps>

00102929 <vector242>:
.globl vector242
vector242:
  pushl $0
  102929:	6a 00                	push   $0x0
  pushl $242
  10292b:	68 f2 00 00 00       	push   $0xf2
  jmp __alltraps
  102930:	e9 0a f6 ff ff       	jmp    101f3f <__alltraps>

00102935 <vector243>:
.globl vector243
vector243:
  pushl $0
  102935:	6a 00                	push   $0x0
  pushl $243
  102937:	68 f3 00 00 00       	push   $0xf3
  jmp __alltraps
  10293c:	e9 fe f5 ff ff       	jmp    101f3f <__alltraps>

00102941 <vector244>:
.globl vector244
vector244:
  pushl $0
  102941:	6a 00                	push   $0x0
  pushl $244
  102943:	68 f4 00 00 00       	push   $0xf4
  jmp __alltraps
  102948:	e9 f2 f5 ff ff       	jmp    101f3f <__alltraps>

0010294d <vector245>:
.globl vector245
vector245:
  pushl $0
  10294d:	6a 00                	push   $0x0
  pushl $245
  10294f:	68 f5 00 00 00       	push   $0xf5
  jmp __alltraps
  102954:	e9 e6 f5 ff ff       	jmp    101f3f <__alltraps>

00102959 <vector246>:
.globl vector246
vector246:
  pushl $0
  102959:	6a 00                	push   $0x0
  pushl $246
  10295b:	68 f6 00 00 00       	push   $0xf6
  jmp __alltraps
  102960:	e9 da f5 ff ff       	jmp    101f3f <__alltraps>

00102965 <vector247>:
.globl vector247
vector247:
  pushl $0
  102965:	6a 00                	push   $0x0
  pushl $247
  102967:	68 f7 00 00 00       	push   $0xf7
  jmp __alltraps
  10296c:	e9 ce f5 ff ff       	jmp    101f3f <__alltraps>

00102971 <vector248>:
.globl vector248
vector248:
  pushl $0
  102971:	6a 00                	push   $0x0
  pushl $248
  102973:	68 f8 00 00 00       	push   $0xf8
  jmp __alltraps
  102978:	e9 c2 f5 ff ff       	jmp    101f3f <__alltraps>

0010297d <vector249>:
.globl vector249
vector249:
  pushl $0
  10297d:	6a 00                	push   $0x0
  pushl $249
  10297f:	68 f9 00 00 00       	push   $0xf9
  jmp __alltraps
  102984:	e9 b6 f5 ff ff       	jmp    101f3f <__alltraps>

00102989 <vector250>:
.globl vector250
vector250:
  pushl $0
  102989:	6a 00                	push   $0x0
  pushl $250
  10298b:	68 fa 00 00 00       	push   $0xfa
  jmp __alltraps
  102990:	e9 aa f5 ff ff       	jmp    101f3f <__alltraps>

00102995 <vector251>:
.globl vector251
vector251:
  pushl $0
  102995:	6a 00                	push   $0x0
  pushl $251
  102997:	68 fb 00 00 00       	push   $0xfb
  jmp __alltraps
  10299c:	e9 9e f5 ff ff       	jmp    101f3f <__alltraps>

001029a1 <vector252>:
.globl vector252
vector252:
  pushl $0
  1029a1:	6a 00                	push   $0x0
  pushl $252
  1029a3:	68 fc 00 00 00       	push   $0xfc
  jmp __alltraps
  1029a8:	e9 92 f5 ff ff       	jmp    101f3f <__alltraps>

001029ad <vector253>:
.globl vector253
vector253:
  pushl $0
  1029ad:	6a 00                	push   $0x0
  pushl $253
  1029af:	68 fd 00 00 00       	push   $0xfd
  jmp __alltraps
  1029b4:	e9 86 f5 ff ff       	jmp    101f3f <__alltraps>

001029b9 <vector254>:
.globl vector254
vector254:
  pushl $0
  1029b9:	6a 00                	push   $0x0
  pushl $254
  1029bb:	68 fe 00 00 00       	push   $0xfe
  jmp __alltraps
  1029c0:	e9 7a f5 ff ff       	jmp    101f3f <__alltraps>

001029c5 <vector255>:
.globl vector255
vector255:
  pushl $0
  1029c5:	6a 00                	push   $0x0
  pushl $255
  1029c7:	68 ff 00 00 00       	push   $0xff
  jmp __alltraps
  1029cc:	e9 6e f5 ff ff       	jmp    101f3f <__alltraps>

001029d1 <page2ppn>:

extern struct Page *pages;
extern size_t npage;

static inline ppn_t
page2ppn(struct Page *page) {
  1029d1:	55                   	push   %ebp
  1029d2:	89 e5                	mov    %esp,%ebp
    return page - pages;
  1029d4:	8b 55 08             	mov    0x8(%ebp),%edx
  1029d7:	a1 c4 89 11 00       	mov    0x1189c4,%eax
  1029dc:	29 c2                	sub    %eax,%edx
  1029de:	89 d0                	mov    %edx,%eax
  1029e0:	c1 f8 02             	sar    $0x2,%eax
  1029e3:	69 c0 cd cc cc cc    	imul   $0xcccccccd,%eax,%eax
}
  1029e9:	5d                   	pop    %ebp
  1029ea:	c3                   	ret    

001029eb <page2pa>:

static inline uintptr_t
page2pa(struct Page *page) {
  1029eb:	55                   	push   %ebp
  1029ec:	89 e5                	mov    %esp,%ebp
  1029ee:	83 ec 04             	sub    $0x4,%esp
    return page2ppn(page) << PGSHIFT;
  1029f1:	8b 45 08             	mov    0x8(%ebp),%eax
  1029f4:	89 04 24             	mov    %eax,(%esp)
  1029f7:	e8 d5 ff ff ff       	call   1029d1 <page2ppn>
  1029fc:	c1 e0 0c             	shl    $0xc,%eax
}
  1029ff:	c9                   	leave  
  102a00:	c3                   	ret    

00102a01 <page_ref>:
pde2page(pde_t pde) {
    return pa2page(PDE_ADDR(pde));
}

static inline int
page_ref(struct Page *page) {
  102a01:	55                   	push   %ebp
  102a02:	89 e5                	mov    %esp,%ebp
    return page->ref;
  102a04:	8b 45 08             	mov    0x8(%ebp),%eax
  102a07:	8b 00                	mov    (%eax),%eax
}
  102a09:	5d                   	pop    %ebp
  102a0a:	c3                   	ret    

00102a0b <set_page_ref>:

static inline void
set_page_ref(struct Page *page, int val) {
  102a0b:	55                   	push   %ebp
  102a0c:	89 e5                	mov    %esp,%ebp
    page->ref = val;
  102a0e:	8b 45 08             	mov    0x8(%ebp),%eax
  102a11:	8b 55 0c             	mov    0xc(%ebp),%edx
  102a14:	89 10                	mov    %edx,(%eax)
}
  102a16:	5d                   	pop    %ebp
  102a17:	c3                   	ret    

00102a18 <default_init>:

#define free_list (free_area.free_list)
#define nr_free (free_area.nr_free)

static void
default_init(void) {
  102a18:	55                   	push   %ebp
  102a19:	89 e5                	mov    %esp,%ebp
  102a1b:	83 ec 10             	sub    $0x10,%esp
  102a1e:	c7 45 fc b0 89 11 00 	movl   $0x1189b0,-0x4(%ebp)
 * list_init - initialize a new entry
 * @elm:        new entry to be initialized
 * */
static inline void
list_init(list_entry_t *elm) {
    elm->prev = elm->next = elm;
  102a25:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102a28:	8b 55 fc             	mov    -0x4(%ebp),%edx
  102a2b:	89 50 04             	mov    %edx,0x4(%eax)
  102a2e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102a31:	8b 50 04             	mov    0x4(%eax),%edx
  102a34:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102a37:	89 10                	mov    %edx,(%eax)
    list_init(&free_list);
    nr_free = 0;
  102a39:	c7 05 b8 89 11 00 00 	movl   $0x0,0x1189b8
  102a40:	00 00 00 
}
  102a43:	c9                   	leave  
  102a44:	c3                   	ret    

00102a45 <default_init_memmap>:

static void
default_free_pages(struct Page *base, size_t n);

static void
default_init_memmap(struct Page *base, size_t n) {
  102a45:	55                   	push   %ebp
  102a46:	89 e5                	mov    %esp,%ebp
  102a48:	83 ec 28             	sub    $0x28,%esp
    assert(n > 0);
  102a4b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  102a4f:	75 24                	jne    102a75 <default_init_memmap+0x30>
  102a51:	c7 44 24 0c 10 68 10 	movl   $0x106810,0xc(%esp)
  102a58:	00 
  102a59:	c7 44 24 08 16 68 10 	movl   $0x106816,0x8(%esp)
  102a60:	00 
  102a61:	c7 44 24 04 49 00 00 	movl   $0x49,0x4(%esp)
  102a68:	00 
  102a69:	c7 04 24 2b 68 10 00 	movl   $0x10682b,(%esp)
  102a70:	e8 9f e2 ff ff       	call   100d14 <__panic>
    struct Page *p = base;
  102a75:	8b 45 08             	mov    0x8(%ebp),%eax
  102a78:	89 45 f4             	mov    %eax,-0xc(%ebp)
    for (; p != base + n; p ++) {
  102a7b:	eb 7d                	jmp    102afa <default_init_memmap+0xb5>
        assert(PageReserved(p));
  102a7d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102a80:	83 c0 04             	add    $0x4,%eax
  102a83:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  102a8a:	89 45 ec             	mov    %eax,-0x14(%ebp)
 * @addr:   the address to count from
 * */
static inline bool
test_bit(int nr, volatile void *addr) {
    int oldbit;
    asm volatile ("btl %2, %1; sbbl %0,%0" : "=r" (oldbit) : "m" (*(volatile long *)addr), "Ir" (nr));
  102a8d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  102a90:	8b 55 f0             	mov    -0x10(%ebp),%edx
  102a93:	0f a3 10             	bt     %edx,(%eax)
  102a96:	19 c0                	sbb    %eax,%eax
  102a98:	89 45 e8             	mov    %eax,-0x18(%ebp)
    return oldbit != 0;
  102a9b:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  102a9f:	0f 95 c0             	setne  %al
  102aa2:	0f b6 c0             	movzbl %al,%eax
  102aa5:	85 c0                	test   %eax,%eax
  102aa7:	75 24                	jne    102acd <default_init_memmap+0x88>
  102aa9:	c7 44 24 0c 41 68 10 	movl   $0x106841,0xc(%esp)
  102ab0:	00 
  102ab1:	c7 44 24 08 16 68 10 	movl   $0x106816,0x8(%esp)
  102ab8:	00 
  102ab9:	c7 44 24 04 4c 00 00 	movl   $0x4c,0x4(%esp)
  102ac0:	00 
  102ac1:	c7 04 24 2b 68 10 00 	movl   $0x10682b,(%esp)
  102ac8:	e8 47 e2 ff ff       	call   100d14 <__panic>
        p->flags = p->property = 0;
  102acd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102ad0:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  102ad7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102ada:	8b 50 08             	mov    0x8(%eax),%edx
  102add:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102ae0:	89 50 04             	mov    %edx,0x4(%eax)
        set_page_ref(p, 0);
  102ae3:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  102aea:	00 
  102aeb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102aee:	89 04 24             	mov    %eax,(%esp)
  102af1:	e8 15 ff ff ff       	call   102a0b <set_page_ref>

static void
default_init_memmap(struct Page *base, size_t n) {
    assert(n > 0);
    struct Page *p = base;
    for (; p != base + n; p ++) {
  102af6:	83 45 f4 14          	addl   $0x14,-0xc(%ebp)
  102afa:	8b 55 0c             	mov    0xc(%ebp),%edx
  102afd:	89 d0                	mov    %edx,%eax
  102aff:	c1 e0 02             	shl    $0x2,%eax
  102b02:	01 d0                	add    %edx,%eax
  102b04:	c1 e0 02             	shl    $0x2,%eax
  102b07:	89 c2                	mov    %eax,%edx
  102b09:	8b 45 08             	mov    0x8(%ebp),%eax
  102b0c:	01 d0                	add    %edx,%eax
  102b0e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  102b11:	0f 85 66 ff ff ff    	jne    102a7d <default_init_memmap+0x38>
        assert(PageReserved(p));
        p->flags = p->property = 0;
        set_page_ref(p, 0);
    }

    default_free_pages(base, n);
  102b17:	8b 45 0c             	mov    0xc(%ebp),%eax
  102b1a:	89 44 24 04          	mov    %eax,0x4(%esp)
  102b1e:	8b 45 08             	mov    0x8(%ebp),%eax
  102b21:	89 04 24             	mov    %eax,(%esp)
  102b24:	e8 c5 01 00 00       	call   102cee <default_free_pages>
}
  102b29:	c9                   	leave  
  102b2a:	c3                   	ret    

00102b2b <default_alloc_pages>:

static struct Page *
default_alloc_pages(size_t n) {
  102b2b:	55                   	push   %ebp
  102b2c:	89 e5                	mov    %esp,%ebp
  102b2e:	83 ec 68             	sub    $0x68,%esp
    assert(n > 0);
  102b31:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  102b35:	75 24                	jne    102b5b <default_alloc_pages+0x30>
  102b37:	c7 44 24 0c 10 68 10 	movl   $0x106810,0xc(%esp)
  102b3e:	00 
  102b3f:	c7 44 24 08 16 68 10 	movl   $0x106816,0x8(%esp)
  102b46:	00 
  102b47:	c7 44 24 04 56 00 00 	movl   $0x56,0x4(%esp)
  102b4e:	00 
  102b4f:	c7 04 24 2b 68 10 00 	movl   $0x10682b,(%esp)
  102b56:	e8 b9 e1 ff ff       	call   100d14 <__panic>
    if (n > nr_free) {
  102b5b:	a1 b8 89 11 00       	mov    0x1189b8,%eax
  102b60:	3b 45 08             	cmp    0x8(%ebp),%eax
  102b63:	73 0a                	jae    102b6f <default_alloc_pages+0x44>
        return NULL;
  102b65:	b8 00 00 00 00       	mov    $0x0,%eax
  102b6a:	e9 7d 01 00 00       	jmp    102cec <default_alloc_pages+0x1c1>
    }

    //find the first fit block('page')
    struct Page *page = NULL;
  102b6f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    list_entry_t *le = &free_list;
  102b76:	c7 45 f0 b0 89 11 00 	movl   $0x1189b0,-0x10(%ebp)
    while ((le = list_next(le)) != &free_list) {
  102b7d:	eb 1c                	jmp    102b9b <default_alloc_pages+0x70>
        struct Page *p = le2page(le, page_link);
  102b7f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102b82:	83 e8 0c             	sub    $0xc,%eax
  102b85:	89 45 ec             	mov    %eax,-0x14(%ebp)
        if (p->property >= n) {
  102b88:	8b 45 ec             	mov    -0x14(%ebp),%eax
  102b8b:	8b 40 08             	mov    0x8(%eax),%eax
  102b8e:	3b 45 08             	cmp    0x8(%ebp),%eax
  102b91:	72 08                	jb     102b9b <default_alloc_pages+0x70>
            page = p;
  102b93:	8b 45 ec             	mov    -0x14(%ebp),%eax
  102b96:	89 45 f4             	mov    %eax,-0xc(%ebp)
            break;
  102b99:	eb 18                	jmp    102bb3 <default_alloc_pages+0x88>
  102b9b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102b9e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 * list_next - get the next entry
 * @listelm:    the list head
 **/
static inline list_entry_t *
list_next(list_entry_t *listelm) {
    return listelm->next;
  102ba1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  102ba4:	8b 40 04             	mov    0x4(%eax),%eax
    }

    //find the first fit block('page')
    struct Page *page = NULL;
    list_entry_t *le = &free_list;
    while ((le = list_next(le)) != &free_list) {
  102ba7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102baa:	81 7d f0 b0 89 11 00 	cmpl   $0x1189b0,-0x10(%ebp)
  102bb1:	75 cc                	jne    102b7f <default_alloc_pages+0x54>
            page = p;
            break;
        }
    }

    if (page != NULL)
  102bb3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  102bb7:	0f 84 2c 01 00 00    	je     102ce9 <default_alloc_pages+0x1be>
    {
    	if (page->property == n) //if it fits exactly, then alloc.
  102bbd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102bc0:	8b 40 08             	mov    0x8(%eax),%eax
  102bc3:	3b 45 08             	cmp    0x8(%ebp),%eax
  102bc6:	75 30                	jne    102bf8 <default_alloc_pages+0xcd>
    		list_del(&(page->page_link));
  102bc8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102bcb:	83 c0 0c             	add    $0xc,%eax
  102bce:	89 45 e0             	mov    %eax,-0x20(%ebp)
 * Note: list_empty() on @listelm does not return true after this, the entry is
 * in an undefined state.
 * */
static inline void
list_del(list_entry_t *listelm) {
    __list_del(listelm->prev, listelm->next);
  102bd1:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102bd4:	8b 40 04             	mov    0x4(%eax),%eax
  102bd7:	8b 55 e0             	mov    -0x20(%ebp),%edx
  102bda:	8b 12                	mov    (%edx),%edx
  102bdc:	89 55 dc             	mov    %edx,-0x24(%ebp)
  102bdf:	89 45 d8             	mov    %eax,-0x28(%ebp)
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 * */
static inline void
__list_del(list_entry_t *prev, list_entry_t *next) {
    prev->next = next;
  102be2:	8b 45 dc             	mov    -0x24(%ebp),%eax
  102be5:	8b 55 d8             	mov    -0x28(%ebp),%edx
  102be8:	89 50 04             	mov    %edx,0x4(%eax)
    next->prev = prev;
  102beb:	8b 45 d8             	mov    -0x28(%ebp),%eax
  102bee:	8b 55 dc             	mov    -0x24(%ebp),%edx
  102bf1:	89 10                	mov    %edx,(%eax)
  102bf3:	e9 c2 00 00 00       	jmp    102cba <default_alloc_pages+0x18f>
    	else if (page->property > n) //if it's too large, split it.
  102bf8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102bfb:	8b 40 08             	mov    0x8(%eax),%eax
  102bfe:	3b 45 08             	cmp    0x8(%ebp),%eax
  102c01:	0f 86 b3 00 00 00    	jbe    102cba <default_alloc_pages+0x18f>
    	{
            struct Page *p = page + n;
  102c07:	8b 55 08             	mov    0x8(%ebp),%edx
  102c0a:	89 d0                	mov    %edx,%eax
  102c0c:	c1 e0 02             	shl    $0x2,%eax
  102c0f:	01 d0                	add    %edx,%eax
  102c11:	c1 e0 02             	shl    $0x2,%eax
  102c14:	89 c2                	mov    %eax,%edx
  102c16:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102c19:	01 d0                	add    %edx,%eax
  102c1b:	89 45 e8             	mov    %eax,-0x18(%ebp)
            p->property = page->property - n;
  102c1e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102c21:	8b 40 08             	mov    0x8(%eax),%eax
  102c24:	2b 45 08             	sub    0x8(%ebp),%eax
  102c27:	89 c2                	mov    %eax,%edx
  102c29:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102c2c:	89 50 08             	mov    %edx,0x8(%eax)
            SetPageProperty(p);
  102c2f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102c32:	83 c0 04             	add    $0x4,%eax
  102c35:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
  102c3c:	89 45 d0             	mov    %eax,-0x30(%ebp)
 * Note that @nr may be almost arbitrarily large; this function is not
 * restricted to acting on a single-word quantity.
 * */
static inline void
set_bit(int nr, volatile void *addr) {
    asm volatile ("btsl %1, %0" :"=m" (*(volatile long *)addr) : "Ir" (nr));
  102c3f:	8b 45 d0             	mov    -0x30(%ebp),%eax
  102c42:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  102c45:	0f ab 10             	bts    %edx,(%eax)
            list_add_before(le, &(p->page_link));
  102c48:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102c4b:	8d 50 0c             	lea    0xc(%eax),%edx
  102c4e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102c51:	89 45 cc             	mov    %eax,-0x34(%ebp)
  102c54:	89 55 c8             	mov    %edx,-0x38(%ebp)
 * Insert the new element @elm *before* the element @listelm which
 * is already in the list.
 * */
static inline void
list_add_before(list_entry_t *listelm, list_entry_t *elm) {
    __list_add(elm, listelm->prev, listelm);
  102c57:	8b 45 cc             	mov    -0x34(%ebp),%eax
  102c5a:	8b 00                	mov    (%eax),%eax
  102c5c:	8b 55 c8             	mov    -0x38(%ebp),%edx
  102c5f:	89 55 c4             	mov    %edx,-0x3c(%ebp)
  102c62:	89 45 c0             	mov    %eax,-0x40(%ebp)
  102c65:	8b 45 cc             	mov    -0x34(%ebp),%eax
  102c68:	89 45 bc             	mov    %eax,-0x44(%ebp)
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 * */
static inline void
__list_add(list_entry_t *elm, list_entry_t *prev, list_entry_t *next) {
    prev->next = next->prev = elm;
  102c6b:	8b 45 bc             	mov    -0x44(%ebp),%eax
  102c6e:	8b 55 c4             	mov    -0x3c(%ebp),%edx
  102c71:	89 10                	mov    %edx,(%eax)
  102c73:	8b 45 bc             	mov    -0x44(%ebp),%eax
  102c76:	8b 10                	mov    (%eax),%edx
  102c78:	8b 45 c0             	mov    -0x40(%ebp),%eax
  102c7b:	89 50 04             	mov    %edx,0x4(%eax)
    elm->next = next;
  102c7e:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  102c81:	8b 55 bc             	mov    -0x44(%ebp),%edx
  102c84:	89 50 04             	mov    %edx,0x4(%eax)
    elm->prev = prev;
  102c87:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  102c8a:	8b 55 c0             	mov    -0x40(%ebp),%edx
  102c8d:	89 10                	mov    %edx,(%eax)
            list_del(&(page->page_link));
  102c8f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102c92:	83 c0 0c             	add    $0xc,%eax
  102c95:	89 45 b8             	mov    %eax,-0x48(%ebp)
 * Note: list_empty() on @listelm does not return true after this, the entry is
 * in an undefined state.
 * */
static inline void
list_del(list_entry_t *listelm) {
    __list_del(listelm->prev, listelm->next);
  102c98:	8b 45 b8             	mov    -0x48(%ebp),%eax
  102c9b:	8b 40 04             	mov    0x4(%eax),%eax
  102c9e:	8b 55 b8             	mov    -0x48(%ebp),%edx
  102ca1:	8b 12                	mov    (%edx),%edx
  102ca3:	89 55 b4             	mov    %edx,-0x4c(%ebp)
  102ca6:	89 45 b0             	mov    %eax,-0x50(%ebp)
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 * */
static inline void
__list_del(list_entry_t *prev, list_entry_t *next) {
    prev->next = next;
  102ca9:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  102cac:	8b 55 b0             	mov    -0x50(%ebp),%edx
  102caf:	89 50 04             	mov    %edx,0x4(%eax)
    next->prev = prev;
  102cb2:	8b 45 b0             	mov    -0x50(%ebp),%eax
  102cb5:	8b 55 b4             	mov    -0x4c(%ebp),%edx
  102cb8:	89 10                	mov    %edx,(%eax)
    	}

    	//allocate
    	page->property= n;
  102cba:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102cbd:	8b 55 08             	mov    0x8(%ebp),%edx
  102cc0:	89 50 08             	mov    %edx,0x8(%eax)
        nr_free -= n;
  102cc3:	a1 b8 89 11 00       	mov    0x1189b8,%eax
  102cc8:	2b 45 08             	sub    0x8(%ebp),%eax
  102ccb:	a3 b8 89 11 00       	mov    %eax,0x1189b8
        ClearPageProperty(page);
  102cd0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102cd3:	83 c0 04             	add    $0x4,%eax
  102cd6:	c7 45 ac 01 00 00 00 	movl   $0x1,-0x54(%ebp)
  102cdd:	89 45 a8             	mov    %eax,-0x58(%ebp)
 * @nr:     the bit to clear
 * @addr:   the address to start counting from
 * */
static inline void
clear_bit(int nr, volatile void *addr) {
    asm volatile ("btrl %1, %0" :"=m" (*(volatile long *)addr) : "Ir" (nr));
  102ce0:	8b 45 a8             	mov    -0x58(%ebp),%eax
  102ce3:	8b 55 ac             	mov    -0x54(%ebp),%edx
  102ce6:	0f b3 10             	btr    %edx,(%eax)
    }
    return page;
  102ce9:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  102cec:	c9                   	leave  
  102ced:	c3                   	ret    

00102cee <default_free_pages>:

static void
default_free_pages(struct Page *base, size_t n) {
  102cee:	55                   	push   %ebp
  102cef:	89 e5                	mov    %esp,%ebp
  102cf1:	83 ec 78             	sub    $0x78,%esp
    assert(n > 0);
  102cf4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  102cf8:	75 24                	jne    102d1e <default_free_pages+0x30>
  102cfa:	c7 44 24 0c 10 68 10 	movl   $0x106810,0xc(%esp)
  102d01:	00 
  102d02:	c7 44 24 08 16 68 10 	movl   $0x106816,0x8(%esp)
  102d09:	00 
  102d0a:	c7 44 24 04 7d 00 00 	movl   $0x7d,0x4(%esp)
  102d11:	00 
  102d12:	c7 04 24 2b 68 10 00 	movl   $0x10682b,(%esp)
  102d19:	e8 f6 df ff ff       	call   100d14 <__panic>

    struct Page *p = base;
  102d1e:	8b 45 08             	mov    0x8(%ebp),%eax
  102d21:	89 45 f4             	mov    %eax,-0xc(%ebp)
    for (; p != base + n; p ++) {
  102d24:	eb 21                	jmp    102d47 <default_free_pages+0x59>
        p->flags = 0;
  102d26:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102d29:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
        set_page_ref(p, 0);
  102d30:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  102d37:	00 
  102d38:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102d3b:	89 04 24             	mov    %eax,(%esp)
  102d3e:	e8 c8 fc ff ff       	call   102a0b <set_page_ref>
static void
default_free_pages(struct Page *base, size_t n) {
    assert(n > 0);

    struct Page *p = base;
    for (; p != base + n; p ++) {
  102d43:	83 45 f4 14          	addl   $0x14,-0xc(%ebp)
  102d47:	8b 55 0c             	mov    0xc(%ebp),%edx
  102d4a:	89 d0                	mov    %edx,%eax
  102d4c:	c1 e0 02             	shl    $0x2,%eax
  102d4f:	01 d0                	add    %edx,%eax
  102d51:	c1 e0 02             	shl    $0x2,%eax
  102d54:	89 c2                	mov    %eax,%edx
  102d56:	8b 45 08             	mov    0x8(%ebp),%eax
  102d59:	01 d0                	add    %edx,%eax
  102d5b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  102d5e:	75 c6                	jne    102d26 <default_free_pages+0x38>
        p->flags = 0;
        set_page_ref(p, 0);
    }

    base->property= n;
  102d60:	8b 45 08             	mov    0x8(%ebp),%eax
  102d63:	8b 55 0c             	mov    0xc(%ebp),%edx
  102d66:	89 50 08             	mov    %edx,0x8(%eax)
    SetPageProperty(base);
  102d69:	8b 45 08             	mov    0x8(%ebp),%eax
  102d6c:	83 c0 04             	add    $0x4,%eax
  102d6f:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
  102d76:	89 45 e8             	mov    %eax,-0x18(%ebp)
 * Note that @nr may be almost arbitrarily large; this function is not
 * restricted to acting on a single-word quantity.
 * */
static inline void
set_bit(int nr, volatile void *addr) {
    asm volatile ("btsl %1, %0" :"=m" (*(volatile long *)addr) : "Ir" (nr));
  102d79:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102d7c:	8b 55 ec             	mov    -0x14(%ebp),%edx
  102d7f:	0f ab 10             	bts    %edx,(%eax)
  102d82:	c7 45 e4 b0 89 11 00 	movl   $0x1189b0,-0x1c(%ebp)
 * list_next - get the next entry
 * @listelm:    the list head
 **/
static inline list_entry_t *
list_next(list_entry_t *listelm) {
    return listelm->next;
  102d89:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  102d8c:	8b 40 04             	mov    0x4(%eax),%eax

    //find the block who should exactly follow the new free one in free list(sorted by address)
    list_entry_t *le = list_next(&free_list);
  102d8f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    while (le != &free_list)
  102d92:	eb 22                	jmp    102db6 <default_free_pages+0xc8>
    {
    	p = le2page(le, page_link);
  102d94:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102d97:	83 e8 0c             	sub    $0xc,%eax
  102d9a:	89 45 f4             	mov    %eax,-0xc(%ebp)

    	if (p > base)
  102d9d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102da0:	3b 45 08             	cmp    0x8(%ebp),%eax
  102da3:	76 02                	jbe    102da7 <default_free_pages+0xb9>
    		break ;
  102da5:	eb 18                	jmp    102dbf <default_free_pages+0xd1>
  102da7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102daa:	89 45 e0             	mov    %eax,-0x20(%ebp)
  102dad:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102db0:	8b 40 04             	mov    0x4(%eax),%eax

    	le = list_next(le);
  102db3:	89 45 f0             	mov    %eax,-0x10(%ebp)
    base->property= n;
    SetPageProperty(base);

    //find the block who should exactly follow the new free one in free list(sorted by address)
    list_entry_t *le = list_next(&free_list);
    while (le != &free_list)
  102db6:	81 7d f0 b0 89 11 00 	cmpl   $0x1189b0,-0x10(%ebp)
  102dbd:	75 d5                	jne    102d94 <default_free_pages+0xa6>

    	le = list_next(le);
    }

    //insert the new free block
    p = le2page(le, page_link);
  102dbf:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102dc2:	83 e8 0c             	sub    $0xc,%eax
  102dc5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	list_add_before(le, &(base->page_link));
  102dc8:	8b 45 08             	mov    0x8(%ebp),%eax
  102dcb:	8d 50 0c             	lea    0xc(%eax),%edx
  102dce:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102dd1:	89 45 dc             	mov    %eax,-0x24(%ebp)
  102dd4:	89 55 d8             	mov    %edx,-0x28(%ebp)
 * Insert the new element @elm *before* the element @listelm which
 * is already in the list.
 * */
static inline void
list_add_before(list_entry_t *listelm, list_entry_t *elm) {
    __list_add(elm, listelm->prev, listelm);
  102dd7:	8b 45 dc             	mov    -0x24(%ebp),%eax
  102dda:	8b 00                	mov    (%eax),%eax
  102ddc:	8b 55 d8             	mov    -0x28(%ebp),%edx
  102ddf:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  102de2:	89 45 d0             	mov    %eax,-0x30(%ebp)
  102de5:	8b 45 dc             	mov    -0x24(%ebp),%eax
  102de8:	89 45 cc             	mov    %eax,-0x34(%ebp)
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 * */
static inline void
__list_add(list_entry_t *elm, list_entry_t *prev, list_entry_t *next) {
    prev->next = next->prev = elm;
  102deb:	8b 45 cc             	mov    -0x34(%ebp),%eax
  102dee:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  102df1:	89 10                	mov    %edx,(%eax)
  102df3:	8b 45 cc             	mov    -0x34(%ebp),%eax
  102df6:	8b 10                	mov    (%eax),%edx
  102df8:	8b 45 d0             	mov    -0x30(%ebp),%eax
  102dfb:	89 50 04             	mov    %edx,0x4(%eax)
    elm->next = next;
  102dfe:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  102e01:	8b 55 cc             	mov    -0x34(%ebp),%edx
  102e04:	89 50 04             	mov    %edx,0x4(%eax)
    elm->prev = prev;
  102e07:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  102e0a:	8b 55 d0             	mov    -0x30(%ebp),%edx
  102e0d:	89 10                	mov    %edx,(%eax)

	//merged with the follow one if possible
	if (base + base->property == p) {
  102e0f:	8b 45 08             	mov    0x8(%ebp),%eax
  102e12:	8b 50 08             	mov    0x8(%eax),%edx
  102e15:	89 d0                	mov    %edx,%eax
  102e17:	c1 e0 02             	shl    $0x2,%eax
  102e1a:	01 d0                	add    %edx,%eax
  102e1c:	c1 e0 02             	shl    $0x2,%eax
  102e1f:	89 c2                	mov    %eax,%edx
  102e21:	8b 45 08             	mov    0x8(%ebp),%eax
  102e24:	01 d0                	add    %edx,%eax
  102e26:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  102e29:	75 58                	jne    102e83 <default_free_pages+0x195>
		base->property += p->property;
  102e2b:	8b 45 08             	mov    0x8(%ebp),%eax
  102e2e:	8b 50 08             	mov    0x8(%eax),%edx
  102e31:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102e34:	8b 40 08             	mov    0x8(%eax),%eax
  102e37:	01 c2                	add    %eax,%edx
  102e39:	8b 45 08             	mov    0x8(%ebp),%eax
  102e3c:	89 50 08             	mov    %edx,0x8(%eax)
		ClearPageProperty(p);
  102e3f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102e42:	83 c0 04             	add    $0x4,%eax
  102e45:	c7 45 c8 01 00 00 00 	movl   $0x1,-0x38(%ebp)
  102e4c:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 * @nr:     the bit to clear
 * @addr:   the address to start counting from
 * */
static inline void
clear_bit(int nr, volatile void *addr) {
    asm volatile ("btrl %1, %0" :"=m" (*(volatile long *)addr) : "Ir" (nr));
  102e4f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  102e52:	8b 55 c8             	mov    -0x38(%ebp),%edx
  102e55:	0f b3 10             	btr    %edx,(%eax)
		list_del(&(p->page_link));
  102e58:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102e5b:	83 c0 0c             	add    $0xc,%eax
  102e5e:	89 45 c0             	mov    %eax,-0x40(%ebp)
 * Note: list_empty() on @listelm does not return true after this, the entry is
 * in an undefined state.
 * */
static inline void
list_del(list_entry_t *listelm) {
    __list_del(listelm->prev, listelm->next);
  102e61:	8b 45 c0             	mov    -0x40(%ebp),%eax
  102e64:	8b 40 04             	mov    0x4(%eax),%eax
  102e67:	8b 55 c0             	mov    -0x40(%ebp),%edx
  102e6a:	8b 12                	mov    (%edx),%edx
  102e6c:	89 55 bc             	mov    %edx,-0x44(%ebp)
  102e6f:	89 45 b8             	mov    %eax,-0x48(%ebp)
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 * */
static inline void
__list_del(list_entry_t *prev, list_entry_t *next) {
    prev->next = next;
  102e72:	8b 45 bc             	mov    -0x44(%ebp),%eax
  102e75:	8b 55 b8             	mov    -0x48(%ebp),%edx
  102e78:	89 50 04             	mov    %edx,0x4(%eax)
    next->prev = prev;
  102e7b:	8b 45 b8             	mov    -0x48(%ebp),%eax
  102e7e:	8b 55 bc             	mov    -0x44(%ebp),%edx
  102e81:	89 10                	mov    %edx,(%eax)
	}

	//merged with the ahead one if possible
	le = list_prev(&(base->page_link));
  102e83:	8b 45 08             	mov    0x8(%ebp),%eax
  102e86:	83 c0 0c             	add    $0xc,%eax
  102e89:	89 45 b4             	mov    %eax,-0x4c(%ebp)
 * list_prev - get the previous entry
 * @listelm:    the list head
 **/
static inline list_entry_t *
list_prev(list_entry_t *listelm) {
    return listelm->prev;
  102e8c:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  102e8f:	8b 00                	mov    (%eax),%eax
  102e91:	89 45 f0             	mov    %eax,-0x10(%ebp)
	p = le2page(le, page_link);
  102e94:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102e97:	83 e8 0c             	sub    $0xc,%eax
  102e9a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	if (p + p->property == base) {
  102e9d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102ea0:	8b 50 08             	mov    0x8(%eax),%edx
  102ea3:	89 d0                	mov    %edx,%eax
  102ea5:	c1 e0 02             	shl    $0x2,%eax
  102ea8:	01 d0                	add    %edx,%eax
  102eaa:	c1 e0 02             	shl    $0x2,%eax
  102ead:	89 c2                	mov    %eax,%edx
  102eaf:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102eb2:	01 d0                	add    %edx,%eax
  102eb4:	3b 45 08             	cmp    0x8(%ebp),%eax
  102eb7:	75 5e                	jne    102f17 <default_free_pages+0x229>
		p->property += base->property;
  102eb9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102ebc:	8b 50 08             	mov    0x8(%eax),%edx
  102ebf:	8b 45 08             	mov    0x8(%ebp),%eax
  102ec2:	8b 40 08             	mov    0x8(%eax),%eax
  102ec5:	01 c2                	add    %eax,%edx
  102ec7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102eca:	89 50 08             	mov    %edx,0x8(%eax)

		ClearPageProperty(base);
  102ecd:	8b 45 08             	mov    0x8(%ebp),%eax
  102ed0:	83 c0 04             	add    $0x4,%eax
  102ed3:	c7 45 b0 01 00 00 00 	movl   $0x1,-0x50(%ebp)
  102eda:	89 45 ac             	mov    %eax,-0x54(%ebp)
  102edd:	8b 45 ac             	mov    -0x54(%ebp),%eax
  102ee0:	8b 55 b0             	mov    -0x50(%ebp),%edx
  102ee3:	0f b3 10             	btr    %edx,(%eax)
		list_del(&(base->page_link));
  102ee6:	8b 45 08             	mov    0x8(%ebp),%eax
  102ee9:	83 c0 0c             	add    $0xc,%eax
  102eec:	89 45 a8             	mov    %eax,-0x58(%ebp)
 * Note: list_empty() on @listelm does not return true after this, the entry is
 * in an undefined state.
 * */
static inline void
list_del(list_entry_t *listelm) {
    __list_del(listelm->prev, listelm->next);
  102eef:	8b 45 a8             	mov    -0x58(%ebp),%eax
  102ef2:	8b 40 04             	mov    0x4(%eax),%eax
  102ef5:	8b 55 a8             	mov    -0x58(%ebp),%edx
  102ef8:	8b 12                	mov    (%edx),%edx
  102efa:	89 55 a4             	mov    %edx,-0x5c(%ebp)
  102efd:	89 45 a0             	mov    %eax,-0x60(%ebp)
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 * */
static inline void
__list_del(list_entry_t *prev, list_entry_t *next) {
    prev->next = next;
  102f00:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  102f03:	8b 55 a0             	mov    -0x60(%ebp),%edx
  102f06:	89 50 04             	mov    %edx,0x4(%eax)
    next->prev = prev;
  102f09:	8b 45 a0             	mov    -0x60(%ebp),%eax
  102f0c:	8b 55 a4             	mov    -0x5c(%ebp),%edx
  102f0f:	89 10                	mov    %edx,(%eax)
		base = p;
  102f11:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102f14:	89 45 08             	mov    %eax,0x8(%ebp)
	}

	nr_free += n;
  102f17:	8b 15 b8 89 11 00    	mov    0x1189b8,%edx
  102f1d:	8b 45 0c             	mov    0xc(%ebp),%eax
  102f20:	01 d0                	add    %edx,%eax
  102f22:	a3 b8 89 11 00       	mov    %eax,0x1189b8
	return ;
  102f27:	90                   	nop
}
  102f28:	c9                   	leave  
  102f29:	c3                   	ret    

00102f2a <print_free_list>:

//print free list, used for debug
static void print_free_list()
{
  102f2a:	55                   	push   %ebp
  102f2b:	89 e5                	mov    %esp,%ebp
  102f2d:	83 ec 28             	sub    $0x28,%esp
  102f30:	c7 45 ec b0 89 11 00 	movl   $0x1189b0,-0x14(%ebp)
 * list_next - get the next entry
 * @listelm:    the list head
 **/
static inline list_entry_t *
list_next(list_entry_t *listelm) {
    return listelm->next;
  102f37:	8b 45 ec             	mov    -0x14(%ebp),%eax
  102f3a:	8b 40 04             	mov    0x4(%eax),%eax
	list_entry_t *le = list_next(&free_list);
  102f3d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	struct Page *p;
	while (le != &free_list)
  102f40:	eb 35                	jmp    102f77 <print_free_list+0x4d>
	{
		p = le2page(le, page_link);
  102f42:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102f45:	83 e8 0c             	sub    $0xc,%eax
  102f48:	89 45 f0             	mov    %eax,-0x10(%ebp)

		cprintf("	%08x %d\n", p, p->property);
  102f4b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102f4e:	8b 40 08             	mov    0x8(%eax),%eax
  102f51:	89 44 24 08          	mov    %eax,0x8(%esp)
  102f55:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102f58:	89 44 24 04          	mov    %eax,0x4(%esp)
  102f5c:	c7 04 24 51 68 10 00 	movl   $0x106851,(%esp)
  102f63:	e8 e4 d3 ff ff       	call   10034c <cprintf>
  102f68:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102f6b:	89 45 e8             	mov    %eax,-0x18(%ebp)
  102f6e:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102f71:	8b 40 04             	mov    0x4(%eax),%eax

		le = list_next(le);
  102f74:	89 45 f4             	mov    %eax,-0xc(%ebp)
//print free list, used for debug
static void print_free_list()
{
	list_entry_t *le = list_next(&free_list);
	struct Page *p;
	while (le != &free_list)
  102f77:	81 7d f4 b0 89 11 00 	cmpl   $0x1189b0,-0xc(%ebp)
  102f7e:	75 c2                	jne    102f42 <print_free_list+0x18>

		cprintf("	%08x %d\n", p, p->property);

		le = list_next(le);
	}
}
  102f80:	c9                   	leave  
  102f81:	c3                   	ret    

00102f82 <default_nr_free_pages>:

static size_t
default_nr_free_pages(void) {
  102f82:	55                   	push   %ebp
  102f83:	89 e5                	mov    %esp,%ebp
    return nr_free;
  102f85:	a1 b8 89 11 00       	mov    0x1189b8,%eax
}
  102f8a:	5d                   	pop    %ebp
  102f8b:	c3                   	ret    

00102f8c <basic_check>:

static void
basic_check(void) {
  102f8c:	55                   	push   %ebp
  102f8d:	89 e5                	mov    %esp,%ebp
  102f8f:	83 ec 48             	sub    $0x48,%esp
    struct Page *p0, *p1, *p2;
    p0 = p1 = p2 = NULL;
  102f92:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  102f99:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102f9c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102f9f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102fa2:	89 45 ec             	mov    %eax,-0x14(%ebp)
    assert((p0 = alloc_page()) != NULL);
  102fa5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  102fac:	e8 85 0e 00 00       	call   103e36 <alloc_pages>
  102fb1:	89 45 ec             	mov    %eax,-0x14(%ebp)
  102fb4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  102fb8:	75 24                	jne    102fde <basic_check+0x52>
  102fba:	c7 44 24 0c 5b 68 10 	movl   $0x10685b,0xc(%esp)
  102fc1:	00 
  102fc2:	c7 44 24 08 16 68 10 	movl   $0x106816,0x8(%esp)
  102fc9:	00 
  102fca:	c7 44 24 04 c6 00 00 	movl   $0xc6,0x4(%esp)
  102fd1:	00 
  102fd2:	c7 04 24 2b 68 10 00 	movl   $0x10682b,(%esp)
  102fd9:	e8 36 dd ff ff       	call   100d14 <__panic>
    assert((p1 = alloc_page()) != NULL);
  102fde:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  102fe5:	e8 4c 0e 00 00       	call   103e36 <alloc_pages>
  102fea:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102fed:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  102ff1:	75 24                	jne    103017 <basic_check+0x8b>
  102ff3:	c7 44 24 0c 77 68 10 	movl   $0x106877,0xc(%esp)
  102ffa:	00 
  102ffb:	c7 44 24 08 16 68 10 	movl   $0x106816,0x8(%esp)
  103002:	00 
  103003:	c7 44 24 04 c7 00 00 	movl   $0xc7,0x4(%esp)
  10300a:	00 
  10300b:	c7 04 24 2b 68 10 00 	movl   $0x10682b,(%esp)
  103012:	e8 fd dc ff ff       	call   100d14 <__panic>
    assert((p2 = alloc_page()) != NULL);
  103017:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  10301e:	e8 13 0e 00 00       	call   103e36 <alloc_pages>
  103023:	89 45 f4             	mov    %eax,-0xc(%ebp)
  103026:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  10302a:	75 24                	jne    103050 <basic_check+0xc4>
  10302c:	c7 44 24 0c 93 68 10 	movl   $0x106893,0xc(%esp)
  103033:	00 
  103034:	c7 44 24 08 16 68 10 	movl   $0x106816,0x8(%esp)
  10303b:	00 
  10303c:	c7 44 24 04 c8 00 00 	movl   $0xc8,0x4(%esp)
  103043:	00 
  103044:	c7 04 24 2b 68 10 00 	movl   $0x10682b,(%esp)
  10304b:	e8 c4 dc ff ff       	call   100d14 <__panic>

    assert(p0 != p1 && p0 != p2 && p1 != p2);
  103050:	8b 45 ec             	mov    -0x14(%ebp),%eax
  103053:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  103056:	74 10                	je     103068 <basic_check+0xdc>
  103058:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10305b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  10305e:	74 08                	je     103068 <basic_check+0xdc>
  103060:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103063:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  103066:	75 24                	jne    10308c <basic_check+0x100>
  103068:	c7 44 24 0c b0 68 10 	movl   $0x1068b0,0xc(%esp)
  10306f:	00 
  103070:	c7 44 24 08 16 68 10 	movl   $0x106816,0x8(%esp)
  103077:	00 
  103078:	c7 44 24 04 ca 00 00 	movl   $0xca,0x4(%esp)
  10307f:	00 
  103080:	c7 04 24 2b 68 10 00 	movl   $0x10682b,(%esp)
  103087:	e8 88 dc ff ff       	call   100d14 <__panic>
    assert(page_ref(p0) == 0 && page_ref(p1) == 0 && page_ref(p2) == 0);
  10308c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10308f:	89 04 24             	mov    %eax,(%esp)
  103092:	e8 6a f9 ff ff       	call   102a01 <page_ref>
  103097:	85 c0                	test   %eax,%eax
  103099:	75 1e                	jne    1030b9 <basic_check+0x12d>
  10309b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10309e:	89 04 24             	mov    %eax,(%esp)
  1030a1:	e8 5b f9 ff ff       	call   102a01 <page_ref>
  1030a6:	85 c0                	test   %eax,%eax
  1030a8:	75 0f                	jne    1030b9 <basic_check+0x12d>
  1030aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1030ad:	89 04 24             	mov    %eax,(%esp)
  1030b0:	e8 4c f9 ff ff       	call   102a01 <page_ref>
  1030b5:	85 c0                	test   %eax,%eax
  1030b7:	74 24                	je     1030dd <basic_check+0x151>
  1030b9:	c7 44 24 0c d4 68 10 	movl   $0x1068d4,0xc(%esp)
  1030c0:	00 
  1030c1:	c7 44 24 08 16 68 10 	movl   $0x106816,0x8(%esp)
  1030c8:	00 
  1030c9:	c7 44 24 04 cb 00 00 	movl   $0xcb,0x4(%esp)
  1030d0:	00 
  1030d1:	c7 04 24 2b 68 10 00 	movl   $0x10682b,(%esp)
  1030d8:	e8 37 dc ff ff       	call   100d14 <__panic>

    assert(page2pa(p0) < npage * PGSIZE);
  1030dd:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1030e0:	89 04 24             	mov    %eax,(%esp)
  1030e3:	e8 03 f9 ff ff       	call   1029eb <page2pa>
  1030e8:	8b 15 c0 88 11 00    	mov    0x1188c0,%edx
  1030ee:	c1 e2 0c             	shl    $0xc,%edx
  1030f1:	39 d0                	cmp    %edx,%eax
  1030f3:	72 24                	jb     103119 <basic_check+0x18d>
  1030f5:	c7 44 24 0c 10 69 10 	movl   $0x106910,0xc(%esp)
  1030fc:	00 
  1030fd:	c7 44 24 08 16 68 10 	movl   $0x106816,0x8(%esp)
  103104:	00 
  103105:	c7 44 24 04 cd 00 00 	movl   $0xcd,0x4(%esp)
  10310c:	00 
  10310d:	c7 04 24 2b 68 10 00 	movl   $0x10682b,(%esp)
  103114:	e8 fb db ff ff       	call   100d14 <__panic>
    assert(page2pa(p1) < npage * PGSIZE);
  103119:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10311c:	89 04 24             	mov    %eax,(%esp)
  10311f:	e8 c7 f8 ff ff       	call   1029eb <page2pa>
  103124:	8b 15 c0 88 11 00    	mov    0x1188c0,%edx
  10312a:	c1 e2 0c             	shl    $0xc,%edx
  10312d:	39 d0                	cmp    %edx,%eax
  10312f:	72 24                	jb     103155 <basic_check+0x1c9>
  103131:	c7 44 24 0c 2d 69 10 	movl   $0x10692d,0xc(%esp)
  103138:	00 
  103139:	c7 44 24 08 16 68 10 	movl   $0x106816,0x8(%esp)
  103140:	00 
  103141:	c7 44 24 04 ce 00 00 	movl   $0xce,0x4(%esp)
  103148:	00 
  103149:	c7 04 24 2b 68 10 00 	movl   $0x10682b,(%esp)
  103150:	e8 bf db ff ff       	call   100d14 <__panic>
    assert(page2pa(p2) < npage * PGSIZE);
  103155:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103158:	89 04 24             	mov    %eax,(%esp)
  10315b:	e8 8b f8 ff ff       	call   1029eb <page2pa>
  103160:	8b 15 c0 88 11 00    	mov    0x1188c0,%edx
  103166:	c1 e2 0c             	shl    $0xc,%edx
  103169:	39 d0                	cmp    %edx,%eax
  10316b:	72 24                	jb     103191 <basic_check+0x205>
  10316d:	c7 44 24 0c 4a 69 10 	movl   $0x10694a,0xc(%esp)
  103174:	00 
  103175:	c7 44 24 08 16 68 10 	movl   $0x106816,0x8(%esp)
  10317c:	00 
  10317d:	c7 44 24 04 cf 00 00 	movl   $0xcf,0x4(%esp)
  103184:	00 
  103185:	c7 04 24 2b 68 10 00 	movl   $0x10682b,(%esp)
  10318c:	e8 83 db ff ff       	call   100d14 <__panic>

    list_entry_t free_list_store = free_list;
  103191:	a1 b0 89 11 00       	mov    0x1189b0,%eax
  103196:	8b 15 b4 89 11 00    	mov    0x1189b4,%edx
  10319c:	89 45 d0             	mov    %eax,-0x30(%ebp)
  10319f:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  1031a2:	c7 45 e0 b0 89 11 00 	movl   $0x1189b0,-0x20(%ebp)
 * list_init - initialize a new entry
 * @elm:        new entry to be initialized
 * */
static inline void
list_init(list_entry_t *elm) {
    elm->prev = elm->next = elm;
  1031a9:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1031ac:	8b 55 e0             	mov    -0x20(%ebp),%edx
  1031af:	89 50 04             	mov    %edx,0x4(%eax)
  1031b2:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1031b5:	8b 50 04             	mov    0x4(%eax),%edx
  1031b8:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1031bb:	89 10                	mov    %edx,(%eax)
  1031bd:	c7 45 dc b0 89 11 00 	movl   $0x1189b0,-0x24(%ebp)
 * list_empty - tests whether a list is empty
 * @list:       the list to test.
 * */
static inline bool
list_empty(list_entry_t *list) {
    return list->next == list;
  1031c4:	8b 45 dc             	mov    -0x24(%ebp),%eax
  1031c7:	8b 40 04             	mov    0x4(%eax),%eax
  1031ca:	39 45 dc             	cmp    %eax,-0x24(%ebp)
  1031cd:	0f 94 c0             	sete   %al
  1031d0:	0f b6 c0             	movzbl %al,%eax
    list_init(&free_list);
    assert(list_empty(&free_list));
  1031d3:	85 c0                	test   %eax,%eax
  1031d5:	75 24                	jne    1031fb <basic_check+0x26f>
  1031d7:	c7 44 24 0c 67 69 10 	movl   $0x106967,0xc(%esp)
  1031de:	00 
  1031df:	c7 44 24 08 16 68 10 	movl   $0x106816,0x8(%esp)
  1031e6:	00 
  1031e7:	c7 44 24 04 d3 00 00 	movl   $0xd3,0x4(%esp)
  1031ee:	00 
  1031ef:	c7 04 24 2b 68 10 00 	movl   $0x10682b,(%esp)
  1031f6:	e8 19 db ff ff       	call   100d14 <__panic>

    unsigned int nr_free_store = nr_free;
  1031fb:	a1 b8 89 11 00       	mov    0x1189b8,%eax
  103200:	89 45 e8             	mov    %eax,-0x18(%ebp)
    nr_free = 0;
  103203:	c7 05 b8 89 11 00 00 	movl   $0x0,0x1189b8
  10320a:	00 00 00 

    assert(alloc_page() == NULL);
  10320d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  103214:	e8 1d 0c 00 00       	call   103e36 <alloc_pages>
  103219:	85 c0                	test   %eax,%eax
  10321b:	74 24                	je     103241 <basic_check+0x2b5>
  10321d:	c7 44 24 0c 7e 69 10 	movl   $0x10697e,0xc(%esp)
  103224:	00 
  103225:	c7 44 24 08 16 68 10 	movl   $0x106816,0x8(%esp)
  10322c:	00 
  10322d:	c7 44 24 04 d8 00 00 	movl   $0xd8,0x4(%esp)
  103234:	00 
  103235:	c7 04 24 2b 68 10 00 	movl   $0x10682b,(%esp)
  10323c:	e8 d3 da ff ff       	call   100d14 <__panic>

    free_page(p0);
  103241:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  103248:	00 
  103249:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10324c:	89 04 24             	mov    %eax,(%esp)
  10324f:	e8 1a 0c 00 00       	call   103e6e <free_pages>
    free_page(p1);
  103254:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  10325b:	00 
  10325c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10325f:	89 04 24             	mov    %eax,(%esp)
  103262:	e8 07 0c 00 00       	call   103e6e <free_pages>
    free_page(p2);
  103267:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  10326e:	00 
  10326f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103272:	89 04 24             	mov    %eax,(%esp)
  103275:	e8 f4 0b 00 00       	call   103e6e <free_pages>
    assert(nr_free == 3);
  10327a:	a1 b8 89 11 00       	mov    0x1189b8,%eax
  10327f:	83 f8 03             	cmp    $0x3,%eax
  103282:	74 24                	je     1032a8 <basic_check+0x31c>
  103284:	c7 44 24 0c 93 69 10 	movl   $0x106993,0xc(%esp)
  10328b:	00 
  10328c:	c7 44 24 08 16 68 10 	movl   $0x106816,0x8(%esp)
  103293:	00 
  103294:	c7 44 24 04 dd 00 00 	movl   $0xdd,0x4(%esp)
  10329b:	00 
  10329c:	c7 04 24 2b 68 10 00 	movl   $0x10682b,(%esp)
  1032a3:	e8 6c da ff ff       	call   100d14 <__panic>

    assert((p0 = alloc_page()) != NULL);
  1032a8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  1032af:	e8 82 0b 00 00       	call   103e36 <alloc_pages>
  1032b4:	89 45 ec             	mov    %eax,-0x14(%ebp)
  1032b7:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  1032bb:	75 24                	jne    1032e1 <basic_check+0x355>
  1032bd:	c7 44 24 0c 5b 68 10 	movl   $0x10685b,0xc(%esp)
  1032c4:	00 
  1032c5:	c7 44 24 08 16 68 10 	movl   $0x106816,0x8(%esp)
  1032cc:	00 
  1032cd:	c7 44 24 04 df 00 00 	movl   $0xdf,0x4(%esp)
  1032d4:	00 
  1032d5:	c7 04 24 2b 68 10 00 	movl   $0x10682b,(%esp)
  1032dc:	e8 33 da ff ff       	call   100d14 <__panic>
    assert((p1 = alloc_page()) != NULL);
  1032e1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  1032e8:	e8 49 0b 00 00       	call   103e36 <alloc_pages>
  1032ed:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1032f0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  1032f4:	75 24                	jne    10331a <basic_check+0x38e>
  1032f6:	c7 44 24 0c 77 68 10 	movl   $0x106877,0xc(%esp)
  1032fd:	00 
  1032fe:	c7 44 24 08 16 68 10 	movl   $0x106816,0x8(%esp)
  103305:	00 
  103306:	c7 44 24 04 e0 00 00 	movl   $0xe0,0x4(%esp)
  10330d:	00 
  10330e:	c7 04 24 2b 68 10 00 	movl   $0x10682b,(%esp)
  103315:	e8 fa d9 ff ff       	call   100d14 <__panic>
    assert((p2 = alloc_page()) != NULL);
  10331a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  103321:	e8 10 0b 00 00       	call   103e36 <alloc_pages>
  103326:	89 45 f4             	mov    %eax,-0xc(%ebp)
  103329:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  10332d:	75 24                	jne    103353 <basic_check+0x3c7>
  10332f:	c7 44 24 0c 93 68 10 	movl   $0x106893,0xc(%esp)
  103336:	00 
  103337:	c7 44 24 08 16 68 10 	movl   $0x106816,0x8(%esp)
  10333e:	00 
  10333f:	c7 44 24 04 e1 00 00 	movl   $0xe1,0x4(%esp)
  103346:	00 
  103347:	c7 04 24 2b 68 10 00 	movl   $0x10682b,(%esp)
  10334e:	e8 c1 d9 ff ff       	call   100d14 <__panic>

    assert(alloc_page() == NULL);
  103353:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  10335a:	e8 d7 0a 00 00       	call   103e36 <alloc_pages>
  10335f:	85 c0                	test   %eax,%eax
  103361:	74 24                	je     103387 <basic_check+0x3fb>
  103363:	c7 44 24 0c 7e 69 10 	movl   $0x10697e,0xc(%esp)
  10336a:	00 
  10336b:	c7 44 24 08 16 68 10 	movl   $0x106816,0x8(%esp)
  103372:	00 
  103373:	c7 44 24 04 e3 00 00 	movl   $0xe3,0x4(%esp)
  10337a:	00 
  10337b:	c7 04 24 2b 68 10 00 	movl   $0x10682b,(%esp)
  103382:	e8 8d d9 ff ff       	call   100d14 <__panic>

    free_page(p0);
  103387:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  10338e:	00 
  10338f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  103392:	89 04 24             	mov    %eax,(%esp)
  103395:	e8 d4 0a 00 00       	call   103e6e <free_pages>
  10339a:	c7 45 d8 b0 89 11 00 	movl   $0x1189b0,-0x28(%ebp)
  1033a1:	8b 45 d8             	mov    -0x28(%ebp),%eax
  1033a4:	8b 40 04             	mov    0x4(%eax),%eax
  1033a7:	39 45 d8             	cmp    %eax,-0x28(%ebp)
  1033aa:	0f 94 c0             	sete   %al
  1033ad:	0f b6 c0             	movzbl %al,%eax
    assert(!list_empty(&free_list));
  1033b0:	85 c0                	test   %eax,%eax
  1033b2:	74 24                	je     1033d8 <basic_check+0x44c>
  1033b4:	c7 44 24 0c a0 69 10 	movl   $0x1069a0,0xc(%esp)
  1033bb:	00 
  1033bc:	c7 44 24 08 16 68 10 	movl   $0x106816,0x8(%esp)
  1033c3:	00 
  1033c4:	c7 44 24 04 e6 00 00 	movl   $0xe6,0x4(%esp)
  1033cb:	00 
  1033cc:	c7 04 24 2b 68 10 00 	movl   $0x10682b,(%esp)
  1033d3:	e8 3c d9 ff ff       	call   100d14 <__panic>

    struct Page *p;
    assert((p = alloc_page()) == p0);
  1033d8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  1033df:	e8 52 0a 00 00       	call   103e36 <alloc_pages>
  1033e4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  1033e7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1033ea:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  1033ed:	74 24                	je     103413 <basic_check+0x487>
  1033ef:	c7 44 24 0c b8 69 10 	movl   $0x1069b8,0xc(%esp)
  1033f6:	00 
  1033f7:	c7 44 24 08 16 68 10 	movl   $0x106816,0x8(%esp)
  1033fe:	00 
  1033ff:	c7 44 24 04 e9 00 00 	movl   $0xe9,0x4(%esp)
  103406:	00 
  103407:	c7 04 24 2b 68 10 00 	movl   $0x10682b,(%esp)
  10340e:	e8 01 d9 ff ff       	call   100d14 <__panic>
    assert(alloc_page() == NULL);
  103413:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  10341a:	e8 17 0a 00 00       	call   103e36 <alloc_pages>
  10341f:	85 c0                	test   %eax,%eax
  103421:	74 24                	je     103447 <basic_check+0x4bb>
  103423:	c7 44 24 0c 7e 69 10 	movl   $0x10697e,0xc(%esp)
  10342a:	00 
  10342b:	c7 44 24 08 16 68 10 	movl   $0x106816,0x8(%esp)
  103432:	00 
  103433:	c7 44 24 04 ea 00 00 	movl   $0xea,0x4(%esp)
  10343a:	00 
  10343b:	c7 04 24 2b 68 10 00 	movl   $0x10682b,(%esp)
  103442:	e8 cd d8 ff ff       	call   100d14 <__panic>

    assert(nr_free == 0);
  103447:	a1 b8 89 11 00       	mov    0x1189b8,%eax
  10344c:	85 c0                	test   %eax,%eax
  10344e:	74 24                	je     103474 <basic_check+0x4e8>
  103450:	c7 44 24 0c d1 69 10 	movl   $0x1069d1,0xc(%esp)
  103457:	00 
  103458:	c7 44 24 08 16 68 10 	movl   $0x106816,0x8(%esp)
  10345f:	00 
  103460:	c7 44 24 04 ec 00 00 	movl   $0xec,0x4(%esp)
  103467:	00 
  103468:	c7 04 24 2b 68 10 00 	movl   $0x10682b,(%esp)
  10346f:	e8 a0 d8 ff ff       	call   100d14 <__panic>
    free_list = free_list_store;
  103474:	8b 45 d0             	mov    -0x30(%ebp),%eax
  103477:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  10347a:	a3 b0 89 11 00       	mov    %eax,0x1189b0
  10347f:	89 15 b4 89 11 00    	mov    %edx,0x1189b4
    nr_free = nr_free_store;
  103485:	8b 45 e8             	mov    -0x18(%ebp),%eax
  103488:	a3 b8 89 11 00       	mov    %eax,0x1189b8

    free_page(p);
  10348d:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  103494:	00 
  103495:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  103498:	89 04 24             	mov    %eax,(%esp)
  10349b:	e8 ce 09 00 00       	call   103e6e <free_pages>
    free_page(p1);
  1034a0:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  1034a7:	00 
  1034a8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1034ab:	89 04 24             	mov    %eax,(%esp)
  1034ae:	e8 bb 09 00 00       	call   103e6e <free_pages>
    free_page(p2);
  1034b3:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  1034ba:	00 
  1034bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1034be:	89 04 24             	mov    %eax,(%esp)
  1034c1:	e8 a8 09 00 00       	call   103e6e <free_pages>
}
  1034c6:	c9                   	leave  
  1034c7:	c3                   	ret    

001034c8 <default_check>:

// LAB2: below code is used to check the first fit allocation algorithm (your EXERCISE 1) 
// NOTICE: You SHOULD NOT CHANGE basic_check, default_check functions!
static void
default_check(void) {
  1034c8:	55                   	push   %ebp
  1034c9:	89 e5                	mov    %esp,%ebp
  1034cb:	53                   	push   %ebx
  1034cc:	81 ec 94 00 00 00    	sub    $0x94,%esp
    int count = 0, total = 0;
  1034d2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  1034d9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    list_entry_t *le = &free_list;
  1034e0:	c7 45 ec b0 89 11 00 	movl   $0x1189b0,-0x14(%ebp)
    while ((le = list_next(le)) != &free_list) {
  1034e7:	eb 6b                	jmp    103554 <default_check+0x8c>
        struct Page *p = le2page(le, page_link);
  1034e9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1034ec:	83 e8 0c             	sub    $0xc,%eax
  1034ef:	89 45 e8             	mov    %eax,-0x18(%ebp)
        assert(PageProperty(p));
  1034f2:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1034f5:	83 c0 04             	add    $0x4,%eax
  1034f8:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
  1034ff:	89 45 cc             	mov    %eax,-0x34(%ebp)
 * @addr:   the address to count from
 * */
static inline bool
test_bit(int nr, volatile void *addr) {
    int oldbit;
    asm volatile ("btl %2, %1; sbbl %0,%0" : "=r" (oldbit) : "m" (*(volatile long *)addr), "Ir" (nr));
  103502:	8b 45 cc             	mov    -0x34(%ebp),%eax
  103505:	8b 55 d0             	mov    -0x30(%ebp),%edx
  103508:	0f a3 10             	bt     %edx,(%eax)
  10350b:	19 c0                	sbb    %eax,%eax
  10350d:	89 45 c8             	mov    %eax,-0x38(%ebp)
    return oldbit != 0;
  103510:	83 7d c8 00          	cmpl   $0x0,-0x38(%ebp)
  103514:	0f 95 c0             	setne  %al
  103517:	0f b6 c0             	movzbl %al,%eax
  10351a:	85 c0                	test   %eax,%eax
  10351c:	75 24                	jne    103542 <default_check+0x7a>
  10351e:	c7 44 24 0c de 69 10 	movl   $0x1069de,0xc(%esp)
  103525:	00 
  103526:	c7 44 24 08 16 68 10 	movl   $0x106816,0x8(%esp)
  10352d:	00 
  10352e:	c7 44 24 04 fd 00 00 	movl   $0xfd,0x4(%esp)
  103535:	00 
  103536:	c7 04 24 2b 68 10 00 	movl   $0x10682b,(%esp)
  10353d:	e8 d2 d7 ff ff       	call   100d14 <__panic>
        count ++, total += p->property;
  103542:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  103546:	8b 45 e8             	mov    -0x18(%ebp),%eax
  103549:	8b 50 08             	mov    0x8(%eax),%edx
  10354c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10354f:	01 d0                	add    %edx,%eax
  103551:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103554:	8b 45 ec             	mov    -0x14(%ebp),%eax
  103557:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 * list_next - get the next entry
 * @listelm:    the list head
 **/
static inline list_entry_t *
list_next(list_entry_t *listelm) {
    return listelm->next;
  10355a:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  10355d:	8b 40 04             	mov    0x4(%eax),%eax
// NOTICE: You SHOULD NOT CHANGE basic_check, default_check functions!
static void
default_check(void) {
    int count = 0, total = 0;
    list_entry_t *le = &free_list;
    while ((le = list_next(le)) != &free_list) {
  103560:	89 45 ec             	mov    %eax,-0x14(%ebp)
  103563:	81 7d ec b0 89 11 00 	cmpl   $0x1189b0,-0x14(%ebp)
  10356a:	0f 85 79 ff ff ff    	jne    1034e9 <default_check+0x21>
        struct Page *p = le2page(le, page_link);
        assert(PageProperty(p));
        count ++, total += p->property;
    }
    assert(total == nr_free_pages());
  103570:	8b 5d f0             	mov    -0x10(%ebp),%ebx
  103573:	e8 28 09 00 00       	call   103ea0 <nr_free_pages>
  103578:	39 c3                	cmp    %eax,%ebx
  10357a:	74 24                	je     1035a0 <default_check+0xd8>
  10357c:	c7 44 24 0c ee 69 10 	movl   $0x1069ee,0xc(%esp)
  103583:	00 
  103584:	c7 44 24 08 16 68 10 	movl   $0x106816,0x8(%esp)
  10358b:	00 
  10358c:	c7 44 24 04 00 01 00 	movl   $0x100,0x4(%esp)
  103593:	00 
  103594:	c7 04 24 2b 68 10 00 	movl   $0x10682b,(%esp)
  10359b:	e8 74 d7 ff ff       	call   100d14 <__panic>

    basic_check();
  1035a0:	e8 e7 f9 ff ff       	call   102f8c <basic_check>

    struct Page *p0 = alloc_pages(5), *p1, *p2;
  1035a5:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
  1035ac:	e8 85 08 00 00       	call   103e36 <alloc_pages>
  1035b1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    assert(p0 != NULL);
  1035b4:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  1035b8:	75 24                	jne    1035de <default_check+0x116>
  1035ba:	c7 44 24 0c 07 6a 10 	movl   $0x106a07,0xc(%esp)
  1035c1:	00 
  1035c2:	c7 44 24 08 16 68 10 	movl   $0x106816,0x8(%esp)
  1035c9:	00 
  1035ca:	c7 44 24 04 05 01 00 	movl   $0x105,0x4(%esp)
  1035d1:	00 
  1035d2:	c7 04 24 2b 68 10 00 	movl   $0x10682b,(%esp)
  1035d9:	e8 36 d7 ff ff       	call   100d14 <__panic>
    assert(!PageProperty(p0));
  1035de:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1035e1:	83 c0 04             	add    $0x4,%eax
  1035e4:	c7 45 c0 01 00 00 00 	movl   $0x1,-0x40(%ebp)
  1035eb:	89 45 bc             	mov    %eax,-0x44(%ebp)
 * @addr:   the address to count from
 * */
static inline bool
test_bit(int nr, volatile void *addr) {
    int oldbit;
    asm volatile ("btl %2, %1; sbbl %0,%0" : "=r" (oldbit) : "m" (*(volatile long *)addr), "Ir" (nr));
  1035ee:	8b 45 bc             	mov    -0x44(%ebp),%eax
  1035f1:	8b 55 c0             	mov    -0x40(%ebp),%edx
  1035f4:	0f a3 10             	bt     %edx,(%eax)
  1035f7:	19 c0                	sbb    %eax,%eax
  1035f9:	89 45 b8             	mov    %eax,-0x48(%ebp)
    return oldbit != 0;
  1035fc:	83 7d b8 00          	cmpl   $0x0,-0x48(%ebp)
  103600:	0f 95 c0             	setne  %al
  103603:	0f b6 c0             	movzbl %al,%eax
  103606:	85 c0                	test   %eax,%eax
  103608:	74 24                	je     10362e <default_check+0x166>
  10360a:	c7 44 24 0c 12 6a 10 	movl   $0x106a12,0xc(%esp)
  103611:	00 
  103612:	c7 44 24 08 16 68 10 	movl   $0x106816,0x8(%esp)
  103619:	00 
  10361a:	c7 44 24 04 06 01 00 	movl   $0x106,0x4(%esp)
  103621:	00 
  103622:	c7 04 24 2b 68 10 00 	movl   $0x10682b,(%esp)
  103629:	e8 e6 d6 ff ff       	call   100d14 <__panic>

    list_entry_t free_list_store = free_list;
  10362e:	a1 b0 89 11 00       	mov    0x1189b0,%eax
  103633:	8b 15 b4 89 11 00    	mov    0x1189b4,%edx
  103639:	89 45 80             	mov    %eax,-0x80(%ebp)
  10363c:	89 55 84             	mov    %edx,-0x7c(%ebp)
  10363f:	c7 45 b4 b0 89 11 00 	movl   $0x1189b0,-0x4c(%ebp)
 * list_init - initialize a new entry
 * @elm:        new entry to be initialized
 * */
static inline void
list_init(list_entry_t *elm) {
    elm->prev = elm->next = elm;
  103646:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  103649:	8b 55 b4             	mov    -0x4c(%ebp),%edx
  10364c:	89 50 04             	mov    %edx,0x4(%eax)
  10364f:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  103652:	8b 50 04             	mov    0x4(%eax),%edx
  103655:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  103658:	89 10                	mov    %edx,(%eax)
  10365a:	c7 45 b0 b0 89 11 00 	movl   $0x1189b0,-0x50(%ebp)
 * list_empty - tests whether a list is empty
 * @list:       the list to test.
 * */
static inline bool
list_empty(list_entry_t *list) {
    return list->next == list;
  103661:	8b 45 b0             	mov    -0x50(%ebp),%eax
  103664:	8b 40 04             	mov    0x4(%eax),%eax
  103667:	39 45 b0             	cmp    %eax,-0x50(%ebp)
  10366a:	0f 94 c0             	sete   %al
  10366d:	0f b6 c0             	movzbl %al,%eax
    list_init(&free_list);
    assert(list_empty(&free_list));
  103670:	85 c0                	test   %eax,%eax
  103672:	75 24                	jne    103698 <default_check+0x1d0>
  103674:	c7 44 24 0c 67 69 10 	movl   $0x106967,0xc(%esp)
  10367b:	00 
  10367c:	c7 44 24 08 16 68 10 	movl   $0x106816,0x8(%esp)
  103683:	00 
  103684:	c7 44 24 04 0a 01 00 	movl   $0x10a,0x4(%esp)
  10368b:	00 
  10368c:	c7 04 24 2b 68 10 00 	movl   $0x10682b,(%esp)
  103693:	e8 7c d6 ff ff       	call   100d14 <__panic>
    assert(alloc_page() == NULL);
  103698:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  10369f:	e8 92 07 00 00       	call   103e36 <alloc_pages>
  1036a4:	85 c0                	test   %eax,%eax
  1036a6:	74 24                	je     1036cc <default_check+0x204>
  1036a8:	c7 44 24 0c 7e 69 10 	movl   $0x10697e,0xc(%esp)
  1036af:	00 
  1036b0:	c7 44 24 08 16 68 10 	movl   $0x106816,0x8(%esp)
  1036b7:	00 
  1036b8:	c7 44 24 04 0b 01 00 	movl   $0x10b,0x4(%esp)
  1036bf:	00 
  1036c0:	c7 04 24 2b 68 10 00 	movl   $0x10682b,(%esp)
  1036c7:	e8 48 d6 ff ff       	call   100d14 <__panic>

    unsigned int nr_free_store = nr_free;
  1036cc:	a1 b8 89 11 00       	mov    0x1189b8,%eax
  1036d1:	89 45 e0             	mov    %eax,-0x20(%ebp)
    nr_free = 0;
  1036d4:	c7 05 b8 89 11 00 00 	movl   $0x0,0x1189b8
  1036db:	00 00 00 

    free_pages(p0 + 2, 3);
  1036de:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1036e1:	83 c0 28             	add    $0x28,%eax
  1036e4:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
  1036eb:	00 
  1036ec:	89 04 24             	mov    %eax,(%esp)
  1036ef:	e8 7a 07 00 00       	call   103e6e <free_pages>
    assert(alloc_pages(4) == NULL);
  1036f4:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
  1036fb:	e8 36 07 00 00       	call   103e36 <alloc_pages>
  103700:	85 c0                	test   %eax,%eax
  103702:	74 24                	je     103728 <default_check+0x260>
  103704:	c7 44 24 0c 24 6a 10 	movl   $0x106a24,0xc(%esp)
  10370b:	00 
  10370c:	c7 44 24 08 16 68 10 	movl   $0x106816,0x8(%esp)
  103713:	00 
  103714:	c7 44 24 04 11 01 00 	movl   $0x111,0x4(%esp)
  10371b:	00 
  10371c:	c7 04 24 2b 68 10 00 	movl   $0x10682b,(%esp)
  103723:	e8 ec d5 ff ff       	call   100d14 <__panic>
    assert(PageProperty(p0 + 2) && p0[2].property == 3);
  103728:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  10372b:	83 c0 28             	add    $0x28,%eax
  10372e:	83 c0 04             	add    $0x4,%eax
  103731:	c7 45 ac 01 00 00 00 	movl   $0x1,-0x54(%ebp)
  103738:	89 45 a8             	mov    %eax,-0x58(%ebp)
 * @addr:   the address to count from
 * */
static inline bool
test_bit(int nr, volatile void *addr) {
    int oldbit;
    asm volatile ("btl %2, %1; sbbl %0,%0" : "=r" (oldbit) : "m" (*(volatile long *)addr), "Ir" (nr));
  10373b:	8b 45 a8             	mov    -0x58(%ebp),%eax
  10373e:	8b 55 ac             	mov    -0x54(%ebp),%edx
  103741:	0f a3 10             	bt     %edx,(%eax)
  103744:	19 c0                	sbb    %eax,%eax
  103746:	89 45 a4             	mov    %eax,-0x5c(%ebp)
    return oldbit != 0;
  103749:	83 7d a4 00          	cmpl   $0x0,-0x5c(%ebp)
  10374d:	0f 95 c0             	setne  %al
  103750:	0f b6 c0             	movzbl %al,%eax
  103753:	85 c0                	test   %eax,%eax
  103755:	74 0e                	je     103765 <default_check+0x29d>
  103757:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  10375a:	83 c0 28             	add    $0x28,%eax
  10375d:	8b 40 08             	mov    0x8(%eax),%eax
  103760:	83 f8 03             	cmp    $0x3,%eax
  103763:	74 24                	je     103789 <default_check+0x2c1>
  103765:	c7 44 24 0c 3c 6a 10 	movl   $0x106a3c,0xc(%esp)
  10376c:	00 
  10376d:	c7 44 24 08 16 68 10 	movl   $0x106816,0x8(%esp)
  103774:	00 
  103775:	c7 44 24 04 12 01 00 	movl   $0x112,0x4(%esp)
  10377c:	00 
  10377d:	c7 04 24 2b 68 10 00 	movl   $0x10682b,(%esp)
  103784:	e8 8b d5 ff ff       	call   100d14 <__panic>
    assert((p1 = alloc_pages(3)) != NULL);
  103789:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
  103790:	e8 a1 06 00 00       	call   103e36 <alloc_pages>
  103795:	89 45 dc             	mov    %eax,-0x24(%ebp)
  103798:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  10379c:	75 24                	jne    1037c2 <default_check+0x2fa>
  10379e:	c7 44 24 0c 68 6a 10 	movl   $0x106a68,0xc(%esp)
  1037a5:	00 
  1037a6:	c7 44 24 08 16 68 10 	movl   $0x106816,0x8(%esp)
  1037ad:	00 
  1037ae:	c7 44 24 04 13 01 00 	movl   $0x113,0x4(%esp)
  1037b5:	00 
  1037b6:	c7 04 24 2b 68 10 00 	movl   $0x10682b,(%esp)
  1037bd:	e8 52 d5 ff ff       	call   100d14 <__panic>
    assert(alloc_page() == NULL);
  1037c2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  1037c9:	e8 68 06 00 00       	call   103e36 <alloc_pages>
  1037ce:	85 c0                	test   %eax,%eax
  1037d0:	74 24                	je     1037f6 <default_check+0x32e>
  1037d2:	c7 44 24 0c 7e 69 10 	movl   $0x10697e,0xc(%esp)
  1037d9:	00 
  1037da:	c7 44 24 08 16 68 10 	movl   $0x106816,0x8(%esp)
  1037e1:	00 
  1037e2:	c7 44 24 04 14 01 00 	movl   $0x114,0x4(%esp)
  1037e9:	00 
  1037ea:	c7 04 24 2b 68 10 00 	movl   $0x10682b,(%esp)
  1037f1:	e8 1e d5 ff ff       	call   100d14 <__panic>
    assert(p0 + 2 == p1);
  1037f6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1037f9:	83 c0 28             	add    $0x28,%eax
  1037fc:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  1037ff:	74 24                	je     103825 <default_check+0x35d>
  103801:	c7 44 24 0c 86 6a 10 	movl   $0x106a86,0xc(%esp)
  103808:	00 
  103809:	c7 44 24 08 16 68 10 	movl   $0x106816,0x8(%esp)
  103810:	00 
  103811:	c7 44 24 04 15 01 00 	movl   $0x115,0x4(%esp)
  103818:	00 
  103819:	c7 04 24 2b 68 10 00 	movl   $0x10682b,(%esp)
  103820:	e8 ef d4 ff ff       	call   100d14 <__panic>

    p2 = p0 + 1;
  103825:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  103828:	83 c0 14             	add    $0x14,%eax
  10382b:	89 45 d8             	mov    %eax,-0x28(%ebp)
    free_page(p0);
  10382e:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  103835:	00 
  103836:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  103839:	89 04 24             	mov    %eax,(%esp)
  10383c:	e8 2d 06 00 00       	call   103e6e <free_pages>
    free_pages(p1, 3);
  103841:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
  103848:	00 
  103849:	8b 45 dc             	mov    -0x24(%ebp),%eax
  10384c:	89 04 24             	mov    %eax,(%esp)
  10384f:	e8 1a 06 00 00       	call   103e6e <free_pages>
    assert(PageProperty(p0) && p0->property == 1);
  103854:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  103857:	83 c0 04             	add    $0x4,%eax
  10385a:	c7 45 a0 01 00 00 00 	movl   $0x1,-0x60(%ebp)
  103861:	89 45 9c             	mov    %eax,-0x64(%ebp)
 * @addr:   the address to count from
 * */
static inline bool
test_bit(int nr, volatile void *addr) {
    int oldbit;
    asm volatile ("btl %2, %1; sbbl %0,%0" : "=r" (oldbit) : "m" (*(volatile long *)addr), "Ir" (nr));
  103864:	8b 45 9c             	mov    -0x64(%ebp),%eax
  103867:	8b 55 a0             	mov    -0x60(%ebp),%edx
  10386a:	0f a3 10             	bt     %edx,(%eax)
  10386d:	19 c0                	sbb    %eax,%eax
  10386f:	89 45 98             	mov    %eax,-0x68(%ebp)
    return oldbit != 0;
  103872:	83 7d 98 00          	cmpl   $0x0,-0x68(%ebp)
  103876:	0f 95 c0             	setne  %al
  103879:	0f b6 c0             	movzbl %al,%eax
  10387c:	85 c0                	test   %eax,%eax
  10387e:	74 0b                	je     10388b <default_check+0x3c3>
  103880:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  103883:	8b 40 08             	mov    0x8(%eax),%eax
  103886:	83 f8 01             	cmp    $0x1,%eax
  103889:	74 24                	je     1038af <default_check+0x3e7>
  10388b:	c7 44 24 0c 94 6a 10 	movl   $0x106a94,0xc(%esp)
  103892:	00 
  103893:	c7 44 24 08 16 68 10 	movl   $0x106816,0x8(%esp)
  10389a:	00 
  10389b:	c7 44 24 04 1a 01 00 	movl   $0x11a,0x4(%esp)
  1038a2:	00 
  1038a3:	c7 04 24 2b 68 10 00 	movl   $0x10682b,(%esp)
  1038aa:	e8 65 d4 ff ff       	call   100d14 <__panic>
    assert(PageProperty(p1) && p1->property == 3);
  1038af:	8b 45 dc             	mov    -0x24(%ebp),%eax
  1038b2:	83 c0 04             	add    $0x4,%eax
  1038b5:	c7 45 94 01 00 00 00 	movl   $0x1,-0x6c(%ebp)
  1038bc:	89 45 90             	mov    %eax,-0x70(%ebp)
 * @addr:   the address to count from
 * */
static inline bool
test_bit(int nr, volatile void *addr) {
    int oldbit;
    asm volatile ("btl %2, %1; sbbl %0,%0" : "=r" (oldbit) : "m" (*(volatile long *)addr), "Ir" (nr));
  1038bf:	8b 45 90             	mov    -0x70(%ebp),%eax
  1038c2:	8b 55 94             	mov    -0x6c(%ebp),%edx
  1038c5:	0f a3 10             	bt     %edx,(%eax)
  1038c8:	19 c0                	sbb    %eax,%eax
  1038ca:	89 45 8c             	mov    %eax,-0x74(%ebp)
    return oldbit != 0;
  1038cd:	83 7d 8c 00          	cmpl   $0x0,-0x74(%ebp)
  1038d1:	0f 95 c0             	setne  %al
  1038d4:	0f b6 c0             	movzbl %al,%eax
  1038d7:	85 c0                	test   %eax,%eax
  1038d9:	74 0b                	je     1038e6 <default_check+0x41e>
  1038db:	8b 45 dc             	mov    -0x24(%ebp),%eax
  1038de:	8b 40 08             	mov    0x8(%eax),%eax
  1038e1:	83 f8 03             	cmp    $0x3,%eax
  1038e4:	74 24                	je     10390a <default_check+0x442>
  1038e6:	c7 44 24 0c bc 6a 10 	movl   $0x106abc,0xc(%esp)
  1038ed:	00 
  1038ee:	c7 44 24 08 16 68 10 	movl   $0x106816,0x8(%esp)
  1038f5:	00 
  1038f6:	c7 44 24 04 1b 01 00 	movl   $0x11b,0x4(%esp)
  1038fd:	00 
  1038fe:	c7 04 24 2b 68 10 00 	movl   $0x10682b,(%esp)
  103905:	e8 0a d4 ff ff       	call   100d14 <__panic>

    assert((p0 = alloc_page()) == p2 - 1);
  10390a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  103911:	e8 20 05 00 00       	call   103e36 <alloc_pages>
  103916:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  103919:	8b 45 d8             	mov    -0x28(%ebp),%eax
  10391c:	83 e8 14             	sub    $0x14,%eax
  10391f:	39 45 e4             	cmp    %eax,-0x1c(%ebp)
  103922:	74 24                	je     103948 <default_check+0x480>
  103924:	c7 44 24 0c e2 6a 10 	movl   $0x106ae2,0xc(%esp)
  10392b:	00 
  10392c:	c7 44 24 08 16 68 10 	movl   $0x106816,0x8(%esp)
  103933:	00 
  103934:	c7 44 24 04 1d 01 00 	movl   $0x11d,0x4(%esp)
  10393b:	00 
  10393c:	c7 04 24 2b 68 10 00 	movl   $0x10682b,(%esp)
  103943:	e8 cc d3 ff ff       	call   100d14 <__panic>
    free_page(p0);
  103948:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  10394f:	00 
  103950:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  103953:	89 04 24             	mov    %eax,(%esp)
  103956:	e8 13 05 00 00       	call   103e6e <free_pages>
    assert((p0 = alloc_pages(2)) == p2 + 1);
  10395b:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  103962:	e8 cf 04 00 00       	call   103e36 <alloc_pages>
  103967:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  10396a:	8b 45 d8             	mov    -0x28(%ebp),%eax
  10396d:	83 c0 14             	add    $0x14,%eax
  103970:	39 45 e4             	cmp    %eax,-0x1c(%ebp)
  103973:	74 24                	je     103999 <default_check+0x4d1>
  103975:	c7 44 24 0c 00 6b 10 	movl   $0x106b00,0xc(%esp)
  10397c:	00 
  10397d:	c7 44 24 08 16 68 10 	movl   $0x106816,0x8(%esp)
  103984:	00 
  103985:	c7 44 24 04 1f 01 00 	movl   $0x11f,0x4(%esp)
  10398c:	00 
  10398d:	c7 04 24 2b 68 10 00 	movl   $0x10682b,(%esp)
  103994:	e8 7b d3 ff ff       	call   100d14 <__panic>

    free_pages(p0, 2);
  103999:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
  1039a0:	00 
  1039a1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1039a4:	89 04 24             	mov    %eax,(%esp)
  1039a7:	e8 c2 04 00 00       	call   103e6e <free_pages>
    free_page(p2);
  1039ac:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  1039b3:	00 
  1039b4:	8b 45 d8             	mov    -0x28(%ebp),%eax
  1039b7:	89 04 24             	mov    %eax,(%esp)
  1039ba:	e8 af 04 00 00       	call   103e6e <free_pages>

    assert((p0 = alloc_pages(5)) != NULL);
  1039bf:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
  1039c6:	e8 6b 04 00 00       	call   103e36 <alloc_pages>
  1039cb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  1039ce:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  1039d2:	75 24                	jne    1039f8 <default_check+0x530>
  1039d4:	c7 44 24 0c 20 6b 10 	movl   $0x106b20,0xc(%esp)
  1039db:	00 
  1039dc:	c7 44 24 08 16 68 10 	movl   $0x106816,0x8(%esp)
  1039e3:	00 
  1039e4:	c7 44 24 04 24 01 00 	movl   $0x124,0x4(%esp)
  1039eb:	00 
  1039ec:	c7 04 24 2b 68 10 00 	movl   $0x10682b,(%esp)
  1039f3:	e8 1c d3 ff ff       	call   100d14 <__panic>
    assert(alloc_page() == NULL);
  1039f8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  1039ff:	e8 32 04 00 00       	call   103e36 <alloc_pages>
  103a04:	85 c0                	test   %eax,%eax
  103a06:	74 24                	je     103a2c <default_check+0x564>
  103a08:	c7 44 24 0c 7e 69 10 	movl   $0x10697e,0xc(%esp)
  103a0f:	00 
  103a10:	c7 44 24 08 16 68 10 	movl   $0x106816,0x8(%esp)
  103a17:	00 
  103a18:	c7 44 24 04 25 01 00 	movl   $0x125,0x4(%esp)
  103a1f:	00 
  103a20:	c7 04 24 2b 68 10 00 	movl   $0x10682b,(%esp)
  103a27:	e8 e8 d2 ff ff       	call   100d14 <__panic>

    assert(nr_free == 0);
  103a2c:	a1 b8 89 11 00       	mov    0x1189b8,%eax
  103a31:	85 c0                	test   %eax,%eax
  103a33:	74 24                	je     103a59 <default_check+0x591>
  103a35:	c7 44 24 0c d1 69 10 	movl   $0x1069d1,0xc(%esp)
  103a3c:	00 
  103a3d:	c7 44 24 08 16 68 10 	movl   $0x106816,0x8(%esp)
  103a44:	00 
  103a45:	c7 44 24 04 27 01 00 	movl   $0x127,0x4(%esp)
  103a4c:	00 
  103a4d:	c7 04 24 2b 68 10 00 	movl   $0x10682b,(%esp)
  103a54:	e8 bb d2 ff ff       	call   100d14 <__panic>
    nr_free = nr_free_store;
  103a59:	8b 45 e0             	mov    -0x20(%ebp),%eax
  103a5c:	a3 b8 89 11 00       	mov    %eax,0x1189b8

    free_list = free_list_store;
  103a61:	8b 45 80             	mov    -0x80(%ebp),%eax
  103a64:	8b 55 84             	mov    -0x7c(%ebp),%edx
  103a67:	a3 b0 89 11 00       	mov    %eax,0x1189b0
  103a6c:	89 15 b4 89 11 00    	mov    %edx,0x1189b4
    free_pages(p0, 5);
  103a72:	c7 44 24 04 05 00 00 	movl   $0x5,0x4(%esp)
  103a79:	00 
  103a7a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  103a7d:	89 04 24             	mov    %eax,(%esp)
  103a80:	e8 e9 03 00 00       	call   103e6e <free_pages>

    le = &free_list;
  103a85:	c7 45 ec b0 89 11 00 	movl   $0x1189b0,-0x14(%ebp)
    while ((le = list_next(le)) != &free_list) {
  103a8c:	eb 1d                	jmp    103aab <default_check+0x5e3>
        struct Page *p = le2page(le, page_link);
  103a8e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  103a91:	83 e8 0c             	sub    $0xc,%eax
  103a94:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        count --, total -= p->property;
  103a97:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
  103a9b:	8b 55 f0             	mov    -0x10(%ebp),%edx
  103a9e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  103aa1:	8b 40 08             	mov    0x8(%eax),%eax
  103aa4:	29 c2                	sub    %eax,%edx
  103aa6:	89 d0                	mov    %edx,%eax
  103aa8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103aab:	8b 45 ec             	mov    -0x14(%ebp),%eax
  103aae:	89 45 88             	mov    %eax,-0x78(%ebp)
 * list_next - get the next entry
 * @listelm:    the list head
 **/
static inline list_entry_t *
list_next(list_entry_t *listelm) {
    return listelm->next;
  103ab1:	8b 45 88             	mov    -0x78(%ebp),%eax
  103ab4:	8b 40 04             	mov    0x4(%eax),%eax

    free_list = free_list_store;
    free_pages(p0, 5);

    le = &free_list;
    while ((le = list_next(le)) != &free_list) {
  103ab7:	89 45 ec             	mov    %eax,-0x14(%ebp)
  103aba:	81 7d ec b0 89 11 00 	cmpl   $0x1189b0,-0x14(%ebp)
  103ac1:	75 cb                	jne    103a8e <default_check+0x5c6>
        struct Page *p = le2page(le, page_link);
        count --, total -= p->property;
    }
    assert(count == 0);
  103ac3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  103ac7:	74 24                	je     103aed <default_check+0x625>
  103ac9:	c7 44 24 0c 3e 6b 10 	movl   $0x106b3e,0xc(%esp)
  103ad0:	00 
  103ad1:	c7 44 24 08 16 68 10 	movl   $0x106816,0x8(%esp)
  103ad8:	00 
  103ad9:	c7 44 24 04 32 01 00 	movl   $0x132,0x4(%esp)
  103ae0:	00 
  103ae1:	c7 04 24 2b 68 10 00 	movl   $0x10682b,(%esp)
  103ae8:	e8 27 d2 ff ff       	call   100d14 <__panic>
    assert(total == 0);
  103aed:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  103af1:	74 24                	je     103b17 <default_check+0x64f>
  103af3:	c7 44 24 0c 49 6b 10 	movl   $0x106b49,0xc(%esp)
  103afa:	00 
  103afb:	c7 44 24 08 16 68 10 	movl   $0x106816,0x8(%esp)
  103b02:	00 
  103b03:	c7 44 24 04 33 01 00 	movl   $0x133,0x4(%esp)
  103b0a:	00 
  103b0b:	c7 04 24 2b 68 10 00 	movl   $0x10682b,(%esp)
  103b12:	e8 fd d1 ff ff       	call   100d14 <__panic>
}
  103b17:	81 c4 94 00 00 00    	add    $0x94,%esp
  103b1d:	5b                   	pop    %ebx
  103b1e:	5d                   	pop    %ebp
  103b1f:	c3                   	ret    

00103b20 <page2ppn>:

extern struct Page *pages;
extern size_t npage;

static inline ppn_t
page2ppn(struct Page *page) {
  103b20:	55                   	push   %ebp
  103b21:	89 e5                	mov    %esp,%ebp
    return page - pages;
  103b23:	8b 55 08             	mov    0x8(%ebp),%edx
  103b26:	a1 c4 89 11 00       	mov    0x1189c4,%eax
  103b2b:	29 c2                	sub    %eax,%edx
  103b2d:	89 d0                	mov    %edx,%eax
  103b2f:	c1 f8 02             	sar    $0x2,%eax
  103b32:	69 c0 cd cc cc cc    	imul   $0xcccccccd,%eax,%eax
}
  103b38:	5d                   	pop    %ebp
  103b39:	c3                   	ret    

00103b3a <page2pa>:

static inline uintptr_t
page2pa(struct Page *page) {
  103b3a:	55                   	push   %ebp
  103b3b:	89 e5                	mov    %esp,%ebp
  103b3d:	83 ec 04             	sub    $0x4,%esp
    return page2ppn(page) << PGSHIFT;
  103b40:	8b 45 08             	mov    0x8(%ebp),%eax
  103b43:	89 04 24             	mov    %eax,(%esp)
  103b46:	e8 d5 ff ff ff       	call   103b20 <page2ppn>
  103b4b:	c1 e0 0c             	shl    $0xc,%eax
}
  103b4e:	c9                   	leave  
  103b4f:	c3                   	ret    

00103b50 <pa2page>:

static inline struct Page *
pa2page(uintptr_t pa) {
  103b50:	55                   	push   %ebp
  103b51:	89 e5                	mov    %esp,%ebp
  103b53:	83 ec 18             	sub    $0x18,%esp
    if (PPN(pa) >= npage) {
  103b56:	8b 45 08             	mov    0x8(%ebp),%eax
  103b59:	c1 e8 0c             	shr    $0xc,%eax
  103b5c:	89 c2                	mov    %eax,%edx
  103b5e:	a1 c0 88 11 00       	mov    0x1188c0,%eax
  103b63:	39 c2                	cmp    %eax,%edx
  103b65:	72 1c                	jb     103b83 <pa2page+0x33>
        panic("pa2page called with invalid pa");
  103b67:	c7 44 24 08 84 6b 10 	movl   $0x106b84,0x8(%esp)
  103b6e:	00 
  103b6f:	c7 44 24 04 5a 00 00 	movl   $0x5a,0x4(%esp)
  103b76:	00 
  103b77:	c7 04 24 a3 6b 10 00 	movl   $0x106ba3,(%esp)
  103b7e:	e8 91 d1 ff ff       	call   100d14 <__panic>
    }
    return &pages[PPN(pa)];
  103b83:	8b 0d c4 89 11 00    	mov    0x1189c4,%ecx
  103b89:	8b 45 08             	mov    0x8(%ebp),%eax
  103b8c:	c1 e8 0c             	shr    $0xc,%eax
  103b8f:	89 c2                	mov    %eax,%edx
  103b91:	89 d0                	mov    %edx,%eax
  103b93:	c1 e0 02             	shl    $0x2,%eax
  103b96:	01 d0                	add    %edx,%eax
  103b98:	c1 e0 02             	shl    $0x2,%eax
  103b9b:	01 c8                	add    %ecx,%eax
}
  103b9d:	c9                   	leave  
  103b9e:	c3                   	ret    

00103b9f <page2kva>:

static inline void *
page2kva(struct Page *page) {
  103b9f:	55                   	push   %ebp
  103ba0:	89 e5                	mov    %esp,%ebp
  103ba2:	83 ec 28             	sub    $0x28,%esp
    return KADDR(page2pa(page));
  103ba5:	8b 45 08             	mov    0x8(%ebp),%eax
  103ba8:	89 04 24             	mov    %eax,(%esp)
  103bab:	e8 8a ff ff ff       	call   103b3a <page2pa>
  103bb0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  103bb3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103bb6:	c1 e8 0c             	shr    $0xc,%eax
  103bb9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103bbc:	a1 c0 88 11 00       	mov    0x1188c0,%eax
  103bc1:	39 45 f0             	cmp    %eax,-0x10(%ebp)
  103bc4:	72 23                	jb     103be9 <page2kva+0x4a>
  103bc6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103bc9:	89 44 24 0c          	mov    %eax,0xc(%esp)
  103bcd:	c7 44 24 08 b4 6b 10 	movl   $0x106bb4,0x8(%esp)
  103bd4:	00 
  103bd5:	c7 44 24 04 61 00 00 	movl   $0x61,0x4(%esp)
  103bdc:	00 
  103bdd:	c7 04 24 a3 6b 10 00 	movl   $0x106ba3,(%esp)
  103be4:	e8 2b d1 ff ff       	call   100d14 <__panic>
  103be9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103bec:	2d 00 00 00 40       	sub    $0x40000000,%eax
}
  103bf1:	c9                   	leave  
  103bf2:	c3                   	ret    

00103bf3 <pte2page>:
kva2page(void *kva) {
    return pa2page(PADDR(kva));
}

static inline struct Page *
pte2page(pte_t pte) {
  103bf3:	55                   	push   %ebp
  103bf4:	89 e5                	mov    %esp,%ebp
  103bf6:	83 ec 18             	sub    $0x18,%esp
    if (!(pte & PTE_P)) {
  103bf9:	8b 45 08             	mov    0x8(%ebp),%eax
  103bfc:	83 e0 01             	and    $0x1,%eax
  103bff:	85 c0                	test   %eax,%eax
  103c01:	75 1c                	jne    103c1f <pte2page+0x2c>
        panic("pte2page called with invalid pte");
  103c03:	c7 44 24 08 d8 6b 10 	movl   $0x106bd8,0x8(%esp)
  103c0a:	00 
  103c0b:	c7 44 24 04 6c 00 00 	movl   $0x6c,0x4(%esp)
  103c12:	00 
  103c13:	c7 04 24 a3 6b 10 00 	movl   $0x106ba3,(%esp)
  103c1a:	e8 f5 d0 ff ff       	call   100d14 <__panic>
    }
    return pa2page(PTE_ADDR(pte));
  103c1f:	8b 45 08             	mov    0x8(%ebp),%eax
  103c22:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  103c27:	89 04 24             	mov    %eax,(%esp)
  103c2a:	e8 21 ff ff ff       	call   103b50 <pa2page>
}
  103c2f:	c9                   	leave  
  103c30:	c3                   	ret    

00103c31 <page_ref>:
pde2page(pde_t pde) {
    return pa2page(PDE_ADDR(pde));
}

static inline int
page_ref(struct Page *page) {
  103c31:	55                   	push   %ebp
  103c32:	89 e5                	mov    %esp,%ebp
    return page->ref;
  103c34:	8b 45 08             	mov    0x8(%ebp),%eax
  103c37:	8b 00                	mov    (%eax),%eax
}
  103c39:	5d                   	pop    %ebp
  103c3a:	c3                   	ret    

00103c3b <set_page_ref>:

static inline void
set_page_ref(struct Page *page, int val) {
  103c3b:	55                   	push   %ebp
  103c3c:	89 e5                	mov    %esp,%ebp
    page->ref = val;
  103c3e:	8b 45 08             	mov    0x8(%ebp),%eax
  103c41:	8b 55 0c             	mov    0xc(%ebp),%edx
  103c44:	89 10                	mov    %edx,(%eax)
}
  103c46:	5d                   	pop    %ebp
  103c47:	c3                   	ret    

00103c48 <page_ref_inc>:

static inline int
page_ref_inc(struct Page *page) {
  103c48:	55                   	push   %ebp
  103c49:	89 e5                	mov    %esp,%ebp
    page->ref += 1;
  103c4b:	8b 45 08             	mov    0x8(%ebp),%eax
  103c4e:	8b 00                	mov    (%eax),%eax
  103c50:	8d 50 01             	lea    0x1(%eax),%edx
  103c53:	8b 45 08             	mov    0x8(%ebp),%eax
  103c56:	89 10                	mov    %edx,(%eax)
    return page->ref;
  103c58:	8b 45 08             	mov    0x8(%ebp),%eax
  103c5b:	8b 00                	mov    (%eax),%eax
}
  103c5d:	5d                   	pop    %ebp
  103c5e:	c3                   	ret    

00103c5f <page_ref_dec>:

static inline int
page_ref_dec(struct Page *page) {
  103c5f:	55                   	push   %ebp
  103c60:	89 e5                	mov    %esp,%ebp
    page->ref -= 1;
  103c62:	8b 45 08             	mov    0x8(%ebp),%eax
  103c65:	8b 00                	mov    (%eax),%eax
  103c67:	8d 50 ff             	lea    -0x1(%eax),%edx
  103c6a:	8b 45 08             	mov    0x8(%ebp),%eax
  103c6d:	89 10                	mov    %edx,(%eax)
    return page->ref;
  103c6f:	8b 45 08             	mov    0x8(%ebp),%eax
  103c72:	8b 00                	mov    (%eax),%eax
}
  103c74:	5d                   	pop    %ebp
  103c75:	c3                   	ret    

00103c76 <__intr_save>:
#include <x86.h>
#include <intr.h>
#include <mmu.h>

static inline bool
__intr_save(void) {
  103c76:	55                   	push   %ebp
  103c77:	89 e5                	mov    %esp,%ebp
  103c79:	83 ec 18             	sub    $0x18,%esp
}

static inline uint32_t
read_eflags(void) {
    uint32_t eflags;
    asm volatile ("pushfl; popl %0" : "=r" (eflags));
  103c7c:	9c                   	pushf  
  103c7d:	58                   	pop    %eax
  103c7e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    return eflags;
  103c81:	8b 45 f4             	mov    -0xc(%ebp),%eax
    if (read_eflags() & FL_IF) {
  103c84:	25 00 02 00 00       	and    $0x200,%eax
  103c89:	85 c0                	test   %eax,%eax
  103c8b:	74 0c                	je     103c99 <__intr_save+0x23>
        intr_disable();
  103c8d:	e8 65 da ff ff       	call   1016f7 <intr_disable>
        return 1;
  103c92:	b8 01 00 00 00       	mov    $0x1,%eax
  103c97:	eb 05                	jmp    103c9e <__intr_save+0x28>
    }
    return 0;
  103c99:	b8 00 00 00 00       	mov    $0x0,%eax
}
  103c9e:	c9                   	leave  
  103c9f:	c3                   	ret    

00103ca0 <__intr_restore>:

static inline void
__intr_restore(bool flag) {
  103ca0:	55                   	push   %ebp
  103ca1:	89 e5                	mov    %esp,%ebp
  103ca3:	83 ec 08             	sub    $0x8,%esp
    if (flag) {
  103ca6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  103caa:	74 05                	je     103cb1 <__intr_restore+0x11>
        intr_enable();
  103cac:	e8 40 da ff ff       	call   1016f1 <intr_enable>
    }
}
  103cb1:	c9                   	leave  
  103cb2:	c3                   	ret    

00103cb3 <lgdt>:
/* *
 * lgdt - load the global descriptor table register and reset the
 * data/code segement registers for kernel.
 * */
static inline void
lgdt(struct pseudodesc *pd) {
  103cb3:	55                   	push   %ebp
  103cb4:	89 e5                	mov    %esp,%ebp
    asm volatile ("lgdt (%0)" :: "r" (pd));
  103cb6:	8b 45 08             	mov    0x8(%ebp),%eax
  103cb9:	0f 01 10             	lgdtl  (%eax)
    asm volatile ("movw %%ax, %%gs" :: "a" (USER_DS));
  103cbc:	b8 23 00 00 00       	mov    $0x23,%eax
  103cc1:	8e e8                	mov    %eax,%gs
    asm volatile ("movw %%ax, %%fs" :: "a" (USER_DS));
  103cc3:	b8 23 00 00 00       	mov    $0x23,%eax
  103cc8:	8e e0                	mov    %eax,%fs
    asm volatile ("movw %%ax, %%es" :: "a" (KERNEL_DS));
  103cca:	b8 10 00 00 00       	mov    $0x10,%eax
  103ccf:	8e c0                	mov    %eax,%es
    asm volatile ("movw %%ax, %%ds" :: "a" (KERNEL_DS));
  103cd1:	b8 10 00 00 00       	mov    $0x10,%eax
  103cd6:	8e d8                	mov    %eax,%ds
    asm volatile ("movw %%ax, %%ss" :: "a" (KERNEL_DS));
  103cd8:	b8 10 00 00 00       	mov    $0x10,%eax
  103cdd:	8e d0                	mov    %eax,%ss
    // reload cs
    asm volatile ("ljmp %0, $1f\n 1:\n" :: "i" (KERNEL_CS));
  103cdf:	ea e6 3c 10 00 08 00 	ljmp   $0x8,$0x103ce6
}
  103ce6:	5d                   	pop    %ebp
  103ce7:	c3                   	ret    

00103ce8 <load_esp0>:
 * load_esp0 - change the ESP0 in default task state segment,
 * so that we can use different kernel stack when we trap frame
 * user to kernel.
 * */
void
load_esp0(uintptr_t esp0) {
  103ce8:	55                   	push   %ebp
  103ce9:	89 e5                	mov    %esp,%ebp
    ts.ts_esp0 = esp0;
  103ceb:	8b 45 08             	mov    0x8(%ebp),%eax
  103cee:	a3 e4 88 11 00       	mov    %eax,0x1188e4
}
  103cf3:	5d                   	pop    %ebp
  103cf4:	c3                   	ret    

00103cf5 <gdt_init>:

/* gdt_init - initialize the default GDT and TSS */
static void
gdt_init(void) {
  103cf5:	55                   	push   %ebp
  103cf6:	89 e5                	mov    %esp,%ebp
  103cf8:	83 ec 14             	sub    $0x14,%esp
    // set boot kernel stack and default SS0
    load_esp0((uintptr_t)bootstacktop);
  103cfb:	b8 00 70 11 00       	mov    $0x117000,%eax
  103d00:	89 04 24             	mov    %eax,(%esp)
  103d03:	e8 e0 ff ff ff       	call   103ce8 <load_esp0>
    ts.ts_ss0 = KERNEL_DS;
  103d08:	66 c7 05 e8 88 11 00 	movw   $0x10,0x1188e8
  103d0f:	10 00 

    // initialize the TSS filed of the gdt
    gdt[SEG_TSS] = SEGTSS(STS_T32A, (uintptr_t)&ts, sizeof(ts), DPL_KERNEL);
  103d11:	66 c7 05 28 7a 11 00 	movw   $0x68,0x117a28
  103d18:	68 00 
  103d1a:	b8 e0 88 11 00       	mov    $0x1188e0,%eax
  103d1f:	66 a3 2a 7a 11 00    	mov    %ax,0x117a2a
  103d25:	b8 e0 88 11 00       	mov    $0x1188e0,%eax
  103d2a:	c1 e8 10             	shr    $0x10,%eax
  103d2d:	a2 2c 7a 11 00       	mov    %al,0x117a2c
  103d32:	0f b6 05 2d 7a 11 00 	movzbl 0x117a2d,%eax
  103d39:	83 e0 f0             	and    $0xfffffff0,%eax
  103d3c:	83 c8 09             	or     $0x9,%eax
  103d3f:	a2 2d 7a 11 00       	mov    %al,0x117a2d
  103d44:	0f b6 05 2d 7a 11 00 	movzbl 0x117a2d,%eax
  103d4b:	83 e0 ef             	and    $0xffffffef,%eax
  103d4e:	a2 2d 7a 11 00       	mov    %al,0x117a2d
  103d53:	0f b6 05 2d 7a 11 00 	movzbl 0x117a2d,%eax
  103d5a:	83 e0 9f             	and    $0xffffff9f,%eax
  103d5d:	a2 2d 7a 11 00       	mov    %al,0x117a2d
  103d62:	0f b6 05 2d 7a 11 00 	movzbl 0x117a2d,%eax
  103d69:	83 c8 80             	or     $0xffffff80,%eax
  103d6c:	a2 2d 7a 11 00       	mov    %al,0x117a2d
  103d71:	0f b6 05 2e 7a 11 00 	movzbl 0x117a2e,%eax
  103d78:	83 e0 f0             	and    $0xfffffff0,%eax
  103d7b:	a2 2e 7a 11 00       	mov    %al,0x117a2e
  103d80:	0f b6 05 2e 7a 11 00 	movzbl 0x117a2e,%eax
  103d87:	83 e0 ef             	and    $0xffffffef,%eax
  103d8a:	a2 2e 7a 11 00       	mov    %al,0x117a2e
  103d8f:	0f b6 05 2e 7a 11 00 	movzbl 0x117a2e,%eax
  103d96:	83 e0 df             	and    $0xffffffdf,%eax
  103d99:	a2 2e 7a 11 00       	mov    %al,0x117a2e
  103d9e:	0f b6 05 2e 7a 11 00 	movzbl 0x117a2e,%eax
  103da5:	83 c8 40             	or     $0x40,%eax
  103da8:	a2 2e 7a 11 00       	mov    %al,0x117a2e
  103dad:	0f b6 05 2e 7a 11 00 	movzbl 0x117a2e,%eax
  103db4:	83 e0 7f             	and    $0x7f,%eax
  103db7:	a2 2e 7a 11 00       	mov    %al,0x117a2e
  103dbc:	b8 e0 88 11 00       	mov    $0x1188e0,%eax
  103dc1:	c1 e8 18             	shr    $0x18,%eax
  103dc4:	a2 2f 7a 11 00       	mov    %al,0x117a2f

    // reload all segment registers
    lgdt(&gdt_pd);
  103dc9:	c7 04 24 30 7a 11 00 	movl   $0x117a30,(%esp)
  103dd0:	e8 de fe ff ff       	call   103cb3 <lgdt>
  103dd5:	66 c7 45 fe 28 00    	movw   $0x28,-0x2(%ebp)
    asm volatile ("cli" ::: "memory");
}

static inline void
ltr(uint16_t sel) {
    asm volatile ("ltr %0" :: "r" (sel) : "memory");
  103ddb:	0f b7 45 fe          	movzwl -0x2(%ebp),%eax
  103ddf:	0f 00 d8             	ltr    %ax

    // load the TSS
    ltr(GD_TSS);
}
  103de2:	c9                   	leave  
  103de3:	c3                   	ret    

00103de4 <init_pmm_manager>:

//init_pmm_manager - initialize a pmm_manager instance
static void
init_pmm_manager(void) {
  103de4:	55                   	push   %ebp
  103de5:	89 e5                	mov    %esp,%ebp
  103de7:	83 ec 18             	sub    $0x18,%esp
    pmm_manager = &default_pmm_manager;
  103dea:	c7 05 bc 89 11 00 68 	movl   $0x106b68,0x1189bc
  103df1:	6b 10 00 
    cprintf("memory management: %s\n", pmm_manager->name);
  103df4:	a1 bc 89 11 00       	mov    0x1189bc,%eax
  103df9:	8b 00                	mov    (%eax),%eax
  103dfb:	89 44 24 04          	mov    %eax,0x4(%esp)
  103dff:	c7 04 24 04 6c 10 00 	movl   $0x106c04,(%esp)
  103e06:	e8 41 c5 ff ff       	call   10034c <cprintf>
    pmm_manager->init();
  103e0b:	a1 bc 89 11 00       	mov    0x1189bc,%eax
  103e10:	8b 40 04             	mov    0x4(%eax),%eax
  103e13:	ff d0                	call   *%eax
}
  103e15:	c9                   	leave  
  103e16:	c3                   	ret    

00103e17 <init_memmap>:

//init_memmap - call pmm->init_memmap to build Page struct for free memory  
static void
init_memmap(struct Page *base, size_t n) {
  103e17:	55                   	push   %ebp
  103e18:	89 e5                	mov    %esp,%ebp
  103e1a:	83 ec 18             	sub    $0x18,%esp
    pmm_manager->init_memmap(base, n);
  103e1d:	a1 bc 89 11 00       	mov    0x1189bc,%eax
  103e22:	8b 40 08             	mov    0x8(%eax),%eax
  103e25:	8b 55 0c             	mov    0xc(%ebp),%edx
  103e28:	89 54 24 04          	mov    %edx,0x4(%esp)
  103e2c:	8b 55 08             	mov    0x8(%ebp),%edx
  103e2f:	89 14 24             	mov    %edx,(%esp)
  103e32:	ff d0                	call   *%eax
}
  103e34:	c9                   	leave  
  103e35:	c3                   	ret    

00103e36 <alloc_pages>:

//alloc_pages - call pmm->alloc_pages to allocate a continuous n*PAGESIZE memory 
struct Page *
alloc_pages(size_t n) {
  103e36:	55                   	push   %ebp
  103e37:	89 e5                	mov    %esp,%ebp
  103e39:	83 ec 28             	sub    $0x28,%esp
    struct Page *page=NULL;
  103e3c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    bool intr_flag;
    local_intr_save(intr_flag);
  103e43:	e8 2e fe ff ff       	call   103c76 <__intr_save>
  103e48:	89 45 f0             	mov    %eax,-0x10(%ebp)
    {
        page = pmm_manager->alloc_pages(n);
  103e4b:	a1 bc 89 11 00       	mov    0x1189bc,%eax
  103e50:	8b 40 0c             	mov    0xc(%eax),%eax
  103e53:	8b 55 08             	mov    0x8(%ebp),%edx
  103e56:	89 14 24             	mov    %edx,(%esp)
  103e59:	ff d0                	call   *%eax
  103e5b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    }
    local_intr_restore(intr_flag);
  103e5e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103e61:	89 04 24             	mov    %eax,(%esp)
  103e64:	e8 37 fe ff ff       	call   103ca0 <__intr_restore>
    return page;
  103e69:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  103e6c:	c9                   	leave  
  103e6d:	c3                   	ret    

00103e6e <free_pages>:

//free_pages - call pmm->free_pages to free a continuous n*PAGESIZE memory 
void
free_pages(struct Page *base, size_t n) {
  103e6e:	55                   	push   %ebp
  103e6f:	89 e5                	mov    %esp,%ebp
  103e71:	83 ec 28             	sub    $0x28,%esp
    bool intr_flag;
    local_intr_save(intr_flag);
  103e74:	e8 fd fd ff ff       	call   103c76 <__intr_save>
  103e79:	89 45 f4             	mov    %eax,-0xc(%ebp)
    {
        pmm_manager->free_pages(base, n);
  103e7c:	a1 bc 89 11 00       	mov    0x1189bc,%eax
  103e81:	8b 40 10             	mov    0x10(%eax),%eax
  103e84:	8b 55 0c             	mov    0xc(%ebp),%edx
  103e87:	89 54 24 04          	mov    %edx,0x4(%esp)
  103e8b:	8b 55 08             	mov    0x8(%ebp),%edx
  103e8e:	89 14 24             	mov    %edx,(%esp)
  103e91:	ff d0                	call   *%eax
    }
    local_intr_restore(intr_flag);
  103e93:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103e96:	89 04 24             	mov    %eax,(%esp)
  103e99:	e8 02 fe ff ff       	call   103ca0 <__intr_restore>
}
  103e9e:	c9                   	leave  
  103e9f:	c3                   	ret    

00103ea0 <nr_free_pages>:

//nr_free_pages - call pmm->nr_free_pages to get the size (nr*PAGESIZE) 
//of current free memory
size_t
nr_free_pages(void) {
  103ea0:	55                   	push   %ebp
  103ea1:	89 e5                	mov    %esp,%ebp
  103ea3:	83 ec 28             	sub    $0x28,%esp
    size_t ret;
    bool intr_flag;
    local_intr_save(intr_flag);
  103ea6:	e8 cb fd ff ff       	call   103c76 <__intr_save>
  103eab:	89 45 f4             	mov    %eax,-0xc(%ebp)
    {
        ret = pmm_manager->nr_free_pages();
  103eae:	a1 bc 89 11 00       	mov    0x1189bc,%eax
  103eb3:	8b 40 14             	mov    0x14(%eax),%eax
  103eb6:	ff d0                	call   *%eax
  103eb8:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    local_intr_restore(intr_flag);
  103ebb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103ebe:	89 04 24             	mov    %eax,(%esp)
  103ec1:	e8 da fd ff ff       	call   103ca0 <__intr_restore>
    return ret;
  103ec6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  103ec9:	c9                   	leave  
  103eca:	c3                   	ret    

00103ecb <page_init>:

/* pmm_init - initialize the physical memory management */
static void
page_init(void) {
  103ecb:	55                   	push   %ebp
  103ecc:	89 e5                	mov    %esp,%ebp
  103ece:	57                   	push   %edi
  103ecf:	56                   	push   %esi
  103ed0:	53                   	push   %ebx
  103ed1:	81 ec 9c 00 00 00    	sub    $0x9c,%esp
    struct e820map *memmap = (struct e820map *)(0x8000 + KERNBASE);
  103ed7:	c7 45 c4 00 80 00 c0 	movl   $0xc0008000,-0x3c(%ebp)
    uint64_t maxpa = 0;
  103ede:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  103ee5:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)

    cprintf("e820map:\n");
  103eec:	c7 04 24 1b 6c 10 00 	movl   $0x106c1b,(%esp)
  103ef3:	e8 54 c4 ff ff       	call   10034c <cprintf>
    int i;
    for (i = 0; i < memmap->nr_map; i ++) {
  103ef8:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  103eff:	e9 15 01 00 00       	jmp    104019 <page_init+0x14e>
        uint64_t begin = memmap->map[i].addr, end = begin + memmap->map[i].size;
  103f04:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
  103f07:	8b 55 dc             	mov    -0x24(%ebp),%edx
  103f0a:	89 d0                	mov    %edx,%eax
  103f0c:	c1 e0 02             	shl    $0x2,%eax
  103f0f:	01 d0                	add    %edx,%eax
  103f11:	c1 e0 02             	shl    $0x2,%eax
  103f14:	01 c8                	add    %ecx,%eax
  103f16:	8b 50 08             	mov    0x8(%eax),%edx
  103f19:	8b 40 04             	mov    0x4(%eax),%eax
  103f1c:	89 45 b8             	mov    %eax,-0x48(%ebp)
  103f1f:	89 55 bc             	mov    %edx,-0x44(%ebp)
  103f22:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
  103f25:	8b 55 dc             	mov    -0x24(%ebp),%edx
  103f28:	89 d0                	mov    %edx,%eax
  103f2a:	c1 e0 02             	shl    $0x2,%eax
  103f2d:	01 d0                	add    %edx,%eax
  103f2f:	c1 e0 02             	shl    $0x2,%eax
  103f32:	01 c8                	add    %ecx,%eax
  103f34:	8b 48 0c             	mov    0xc(%eax),%ecx
  103f37:	8b 58 10             	mov    0x10(%eax),%ebx
  103f3a:	8b 45 b8             	mov    -0x48(%ebp),%eax
  103f3d:	8b 55 bc             	mov    -0x44(%ebp),%edx
  103f40:	01 c8                	add    %ecx,%eax
  103f42:	11 da                	adc    %ebx,%edx
  103f44:	89 45 b0             	mov    %eax,-0x50(%ebp)
  103f47:	89 55 b4             	mov    %edx,-0x4c(%ebp)
        cprintf("  memory: %08llx, [%08llx, %08llx], type = %d.\n",
  103f4a:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
  103f4d:	8b 55 dc             	mov    -0x24(%ebp),%edx
  103f50:	89 d0                	mov    %edx,%eax
  103f52:	c1 e0 02             	shl    $0x2,%eax
  103f55:	01 d0                	add    %edx,%eax
  103f57:	c1 e0 02             	shl    $0x2,%eax
  103f5a:	01 c8                	add    %ecx,%eax
  103f5c:	83 c0 14             	add    $0x14,%eax
  103f5f:	8b 00                	mov    (%eax),%eax
  103f61:	89 85 7c ff ff ff    	mov    %eax,-0x84(%ebp)
  103f67:	8b 45 b0             	mov    -0x50(%ebp),%eax
  103f6a:	8b 55 b4             	mov    -0x4c(%ebp),%edx
  103f6d:	83 c0 ff             	add    $0xffffffff,%eax
  103f70:	83 d2 ff             	adc    $0xffffffff,%edx
  103f73:	89 c6                	mov    %eax,%esi
  103f75:	89 d7                	mov    %edx,%edi
  103f77:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
  103f7a:	8b 55 dc             	mov    -0x24(%ebp),%edx
  103f7d:	89 d0                	mov    %edx,%eax
  103f7f:	c1 e0 02             	shl    $0x2,%eax
  103f82:	01 d0                	add    %edx,%eax
  103f84:	c1 e0 02             	shl    $0x2,%eax
  103f87:	01 c8                	add    %ecx,%eax
  103f89:	8b 48 0c             	mov    0xc(%eax),%ecx
  103f8c:	8b 58 10             	mov    0x10(%eax),%ebx
  103f8f:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  103f95:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  103f99:	89 74 24 14          	mov    %esi,0x14(%esp)
  103f9d:	89 7c 24 18          	mov    %edi,0x18(%esp)
  103fa1:	8b 45 b8             	mov    -0x48(%ebp),%eax
  103fa4:	8b 55 bc             	mov    -0x44(%ebp),%edx
  103fa7:	89 44 24 0c          	mov    %eax,0xc(%esp)
  103fab:	89 54 24 10          	mov    %edx,0x10(%esp)
  103faf:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  103fb3:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  103fb7:	c7 04 24 28 6c 10 00 	movl   $0x106c28,(%esp)
  103fbe:	e8 89 c3 ff ff       	call   10034c <cprintf>
                memmap->map[i].size, begin, end - 1, memmap->map[i].type);
        if (memmap->map[i].type == E820_ARM) {
  103fc3:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
  103fc6:	8b 55 dc             	mov    -0x24(%ebp),%edx
  103fc9:	89 d0                	mov    %edx,%eax
  103fcb:	c1 e0 02             	shl    $0x2,%eax
  103fce:	01 d0                	add    %edx,%eax
  103fd0:	c1 e0 02             	shl    $0x2,%eax
  103fd3:	01 c8                	add    %ecx,%eax
  103fd5:	83 c0 14             	add    $0x14,%eax
  103fd8:	8b 00                	mov    (%eax),%eax
  103fda:	83 f8 01             	cmp    $0x1,%eax
  103fdd:	75 36                	jne    104015 <page_init+0x14a>
            if (maxpa < end && begin < KMEMSIZE) {
  103fdf:	8b 45 e0             	mov    -0x20(%ebp),%eax
  103fe2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  103fe5:	3b 55 b4             	cmp    -0x4c(%ebp),%edx
  103fe8:	77 2b                	ja     104015 <page_init+0x14a>
  103fea:	3b 55 b4             	cmp    -0x4c(%ebp),%edx
  103fed:	72 05                	jb     103ff4 <page_init+0x129>
  103fef:	3b 45 b0             	cmp    -0x50(%ebp),%eax
  103ff2:	73 21                	jae    104015 <page_init+0x14a>
  103ff4:	83 7d bc 00          	cmpl   $0x0,-0x44(%ebp)
  103ff8:	77 1b                	ja     104015 <page_init+0x14a>
  103ffa:	83 7d bc 00          	cmpl   $0x0,-0x44(%ebp)
  103ffe:	72 09                	jb     104009 <page_init+0x13e>
  104000:	81 7d b8 ff ff ff 37 	cmpl   $0x37ffffff,-0x48(%ebp)
  104007:	77 0c                	ja     104015 <page_init+0x14a>
                maxpa = end;
  104009:	8b 45 b0             	mov    -0x50(%ebp),%eax
  10400c:	8b 55 b4             	mov    -0x4c(%ebp),%edx
  10400f:	89 45 e0             	mov    %eax,-0x20(%ebp)
  104012:	89 55 e4             	mov    %edx,-0x1c(%ebp)
    struct e820map *memmap = (struct e820map *)(0x8000 + KERNBASE);
    uint64_t maxpa = 0;

    cprintf("e820map:\n");
    int i;
    for (i = 0; i < memmap->nr_map; i ++) {
  104015:	83 45 dc 01          	addl   $0x1,-0x24(%ebp)
  104019:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  10401c:	8b 00                	mov    (%eax),%eax
  10401e:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  104021:	0f 8f dd fe ff ff    	jg     103f04 <page_init+0x39>
            if (maxpa < end && begin < KMEMSIZE) {
                maxpa = end;
            }
        }
    }
    if (maxpa > KMEMSIZE) {
  104027:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  10402b:	72 1d                	jb     10404a <page_init+0x17f>
  10402d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  104031:	77 09                	ja     10403c <page_init+0x171>
  104033:	81 7d e0 00 00 00 38 	cmpl   $0x38000000,-0x20(%ebp)
  10403a:	76 0e                	jbe    10404a <page_init+0x17f>
        maxpa = KMEMSIZE;
  10403c:	c7 45 e0 00 00 00 38 	movl   $0x38000000,-0x20(%ebp)
  104043:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    }

    extern char end[];

    npage = maxpa / PGSIZE;
  10404a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  10404d:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  104050:	0f ac d0 0c          	shrd   $0xc,%edx,%eax
  104054:	c1 ea 0c             	shr    $0xc,%edx
  104057:	a3 c0 88 11 00       	mov    %eax,0x1188c0
    pages = (struct Page *)ROUNDUP((void *)end, PGSIZE);
  10405c:	c7 45 ac 00 10 00 00 	movl   $0x1000,-0x54(%ebp)
  104063:	b8 c8 89 11 00       	mov    $0x1189c8,%eax
  104068:	8d 50 ff             	lea    -0x1(%eax),%edx
  10406b:	8b 45 ac             	mov    -0x54(%ebp),%eax
  10406e:	01 d0                	add    %edx,%eax
  104070:	89 45 a8             	mov    %eax,-0x58(%ebp)
  104073:	8b 45 a8             	mov    -0x58(%ebp),%eax
  104076:	ba 00 00 00 00       	mov    $0x0,%edx
  10407b:	f7 75 ac             	divl   -0x54(%ebp)
  10407e:	89 d0                	mov    %edx,%eax
  104080:	8b 55 a8             	mov    -0x58(%ebp),%edx
  104083:	29 c2                	sub    %eax,%edx
  104085:	89 d0                	mov    %edx,%eax
  104087:	a3 c4 89 11 00       	mov    %eax,0x1189c4

    for (i = 0; i < npage; i ++) {
  10408c:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  104093:	eb 2f                	jmp    1040c4 <page_init+0x1f9>
        SetPageReserved(pages + i);
  104095:	8b 0d c4 89 11 00    	mov    0x1189c4,%ecx
  10409b:	8b 55 dc             	mov    -0x24(%ebp),%edx
  10409e:	89 d0                	mov    %edx,%eax
  1040a0:	c1 e0 02             	shl    $0x2,%eax
  1040a3:	01 d0                	add    %edx,%eax
  1040a5:	c1 e0 02             	shl    $0x2,%eax
  1040a8:	01 c8                	add    %ecx,%eax
  1040aa:	83 c0 04             	add    $0x4,%eax
  1040ad:	c7 45 90 00 00 00 00 	movl   $0x0,-0x70(%ebp)
  1040b4:	89 45 8c             	mov    %eax,-0x74(%ebp)
 * Note that @nr may be almost arbitrarily large; this function is not
 * restricted to acting on a single-word quantity.
 * */
static inline void
set_bit(int nr, volatile void *addr) {
    asm volatile ("btsl %1, %0" :"=m" (*(volatile long *)addr) : "Ir" (nr));
  1040b7:	8b 45 8c             	mov    -0x74(%ebp),%eax
  1040ba:	8b 55 90             	mov    -0x70(%ebp),%edx
  1040bd:	0f ab 10             	bts    %edx,(%eax)
    extern char end[];

    npage = maxpa / PGSIZE;
    pages = (struct Page *)ROUNDUP((void *)end, PGSIZE);

    for (i = 0; i < npage; i ++) {
  1040c0:	83 45 dc 01          	addl   $0x1,-0x24(%ebp)
  1040c4:	8b 55 dc             	mov    -0x24(%ebp),%edx
  1040c7:	a1 c0 88 11 00       	mov    0x1188c0,%eax
  1040cc:	39 c2                	cmp    %eax,%edx
  1040ce:	72 c5                	jb     104095 <page_init+0x1ca>
        SetPageReserved(pages + i);
    }

    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * npage);
  1040d0:	8b 15 c0 88 11 00    	mov    0x1188c0,%edx
  1040d6:	89 d0                	mov    %edx,%eax
  1040d8:	c1 e0 02             	shl    $0x2,%eax
  1040db:	01 d0                	add    %edx,%eax
  1040dd:	c1 e0 02             	shl    $0x2,%eax
  1040e0:	89 c2                	mov    %eax,%edx
  1040e2:	a1 c4 89 11 00       	mov    0x1189c4,%eax
  1040e7:	01 d0                	add    %edx,%eax
  1040e9:	89 45 a4             	mov    %eax,-0x5c(%ebp)
  1040ec:	81 7d a4 ff ff ff bf 	cmpl   $0xbfffffff,-0x5c(%ebp)
  1040f3:	77 23                	ja     104118 <page_init+0x24d>
  1040f5:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  1040f8:	89 44 24 0c          	mov    %eax,0xc(%esp)
  1040fc:	c7 44 24 08 58 6c 10 	movl   $0x106c58,0x8(%esp)
  104103:	00 
  104104:	c7 44 24 04 db 00 00 	movl   $0xdb,0x4(%esp)
  10410b:	00 
  10410c:	c7 04 24 7c 6c 10 00 	movl   $0x106c7c,(%esp)
  104113:	e8 fc cb ff ff       	call   100d14 <__panic>
  104118:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  10411b:	05 00 00 00 40       	add    $0x40000000,%eax
  104120:	89 45 a0             	mov    %eax,-0x60(%ebp)

    for (i = 0; i < memmap->nr_map; i ++) {
  104123:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  10412a:	e9 74 01 00 00       	jmp    1042a3 <page_init+0x3d8>
        uint64_t begin = memmap->map[i].addr, end = begin + memmap->map[i].size;
  10412f:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
  104132:	8b 55 dc             	mov    -0x24(%ebp),%edx
  104135:	89 d0                	mov    %edx,%eax
  104137:	c1 e0 02             	shl    $0x2,%eax
  10413a:	01 d0                	add    %edx,%eax
  10413c:	c1 e0 02             	shl    $0x2,%eax
  10413f:	01 c8                	add    %ecx,%eax
  104141:	8b 50 08             	mov    0x8(%eax),%edx
  104144:	8b 40 04             	mov    0x4(%eax),%eax
  104147:	89 45 d0             	mov    %eax,-0x30(%ebp)
  10414a:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  10414d:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
  104150:	8b 55 dc             	mov    -0x24(%ebp),%edx
  104153:	89 d0                	mov    %edx,%eax
  104155:	c1 e0 02             	shl    $0x2,%eax
  104158:	01 d0                	add    %edx,%eax
  10415a:	c1 e0 02             	shl    $0x2,%eax
  10415d:	01 c8                	add    %ecx,%eax
  10415f:	8b 48 0c             	mov    0xc(%eax),%ecx
  104162:	8b 58 10             	mov    0x10(%eax),%ebx
  104165:	8b 45 d0             	mov    -0x30(%ebp),%eax
  104168:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  10416b:	01 c8                	add    %ecx,%eax
  10416d:	11 da                	adc    %ebx,%edx
  10416f:	89 45 c8             	mov    %eax,-0x38(%ebp)
  104172:	89 55 cc             	mov    %edx,-0x34(%ebp)
        if (memmap->map[i].type == E820_ARM) {
  104175:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
  104178:	8b 55 dc             	mov    -0x24(%ebp),%edx
  10417b:	89 d0                	mov    %edx,%eax
  10417d:	c1 e0 02             	shl    $0x2,%eax
  104180:	01 d0                	add    %edx,%eax
  104182:	c1 e0 02             	shl    $0x2,%eax
  104185:	01 c8                	add    %ecx,%eax
  104187:	83 c0 14             	add    $0x14,%eax
  10418a:	8b 00                	mov    (%eax),%eax
  10418c:	83 f8 01             	cmp    $0x1,%eax
  10418f:	0f 85 0a 01 00 00    	jne    10429f <page_init+0x3d4>
            if (begin < freemem) {
  104195:	8b 45 a0             	mov    -0x60(%ebp),%eax
  104198:	ba 00 00 00 00       	mov    $0x0,%edx
  10419d:	3b 55 d4             	cmp    -0x2c(%ebp),%edx
  1041a0:	72 17                	jb     1041b9 <page_init+0x2ee>
  1041a2:	3b 55 d4             	cmp    -0x2c(%ebp),%edx
  1041a5:	77 05                	ja     1041ac <page_init+0x2e1>
  1041a7:	3b 45 d0             	cmp    -0x30(%ebp),%eax
  1041aa:	76 0d                	jbe    1041b9 <page_init+0x2ee>
                begin = freemem;
  1041ac:	8b 45 a0             	mov    -0x60(%ebp),%eax
  1041af:	89 45 d0             	mov    %eax,-0x30(%ebp)
  1041b2:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
            }
            if (end > KMEMSIZE) {
  1041b9:	83 7d cc 00          	cmpl   $0x0,-0x34(%ebp)
  1041bd:	72 1d                	jb     1041dc <page_init+0x311>
  1041bf:	83 7d cc 00          	cmpl   $0x0,-0x34(%ebp)
  1041c3:	77 09                	ja     1041ce <page_init+0x303>
  1041c5:	81 7d c8 00 00 00 38 	cmpl   $0x38000000,-0x38(%ebp)
  1041cc:	76 0e                	jbe    1041dc <page_init+0x311>
                end = KMEMSIZE;
  1041ce:	c7 45 c8 00 00 00 38 	movl   $0x38000000,-0x38(%ebp)
  1041d5:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
            }
            if (begin < end) {
  1041dc:	8b 45 d0             	mov    -0x30(%ebp),%eax
  1041df:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  1041e2:	3b 55 cc             	cmp    -0x34(%ebp),%edx
  1041e5:	0f 87 b4 00 00 00    	ja     10429f <page_init+0x3d4>
  1041eb:	3b 55 cc             	cmp    -0x34(%ebp),%edx
  1041ee:	72 09                	jb     1041f9 <page_init+0x32e>
  1041f0:	3b 45 c8             	cmp    -0x38(%ebp),%eax
  1041f3:	0f 83 a6 00 00 00    	jae    10429f <page_init+0x3d4>
                begin = ROUNDUP(begin, PGSIZE);
  1041f9:	c7 45 9c 00 10 00 00 	movl   $0x1000,-0x64(%ebp)
  104200:	8b 55 d0             	mov    -0x30(%ebp),%edx
  104203:	8b 45 9c             	mov    -0x64(%ebp),%eax
  104206:	01 d0                	add    %edx,%eax
  104208:	83 e8 01             	sub    $0x1,%eax
  10420b:	89 45 98             	mov    %eax,-0x68(%ebp)
  10420e:	8b 45 98             	mov    -0x68(%ebp),%eax
  104211:	ba 00 00 00 00       	mov    $0x0,%edx
  104216:	f7 75 9c             	divl   -0x64(%ebp)
  104219:	89 d0                	mov    %edx,%eax
  10421b:	8b 55 98             	mov    -0x68(%ebp),%edx
  10421e:	29 c2                	sub    %eax,%edx
  104220:	89 d0                	mov    %edx,%eax
  104222:	ba 00 00 00 00       	mov    $0x0,%edx
  104227:	89 45 d0             	mov    %eax,-0x30(%ebp)
  10422a:	89 55 d4             	mov    %edx,-0x2c(%ebp)
                end = ROUNDDOWN(end, PGSIZE);
  10422d:	8b 45 c8             	mov    -0x38(%ebp),%eax
  104230:	89 45 94             	mov    %eax,-0x6c(%ebp)
  104233:	8b 45 94             	mov    -0x6c(%ebp),%eax
  104236:	ba 00 00 00 00       	mov    $0x0,%edx
  10423b:	89 c7                	mov    %eax,%edi
  10423d:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  104243:	89 7d 80             	mov    %edi,-0x80(%ebp)
  104246:	89 d0                	mov    %edx,%eax
  104248:	83 e0 00             	and    $0x0,%eax
  10424b:	89 45 84             	mov    %eax,-0x7c(%ebp)
  10424e:	8b 45 80             	mov    -0x80(%ebp),%eax
  104251:	8b 55 84             	mov    -0x7c(%ebp),%edx
  104254:	89 45 c8             	mov    %eax,-0x38(%ebp)
  104257:	89 55 cc             	mov    %edx,-0x34(%ebp)
                if (begin < end) {
  10425a:	8b 45 d0             	mov    -0x30(%ebp),%eax
  10425d:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  104260:	3b 55 cc             	cmp    -0x34(%ebp),%edx
  104263:	77 3a                	ja     10429f <page_init+0x3d4>
  104265:	3b 55 cc             	cmp    -0x34(%ebp),%edx
  104268:	72 05                	jb     10426f <page_init+0x3a4>
  10426a:	3b 45 c8             	cmp    -0x38(%ebp),%eax
  10426d:	73 30                	jae    10429f <page_init+0x3d4>
                    init_memmap(pa2page(begin), (end - begin) / PGSIZE);
  10426f:	8b 4d d0             	mov    -0x30(%ebp),%ecx
  104272:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
  104275:	8b 45 c8             	mov    -0x38(%ebp),%eax
  104278:	8b 55 cc             	mov    -0x34(%ebp),%edx
  10427b:	29 c8                	sub    %ecx,%eax
  10427d:	19 da                	sbb    %ebx,%edx
  10427f:	0f ac d0 0c          	shrd   $0xc,%edx,%eax
  104283:	c1 ea 0c             	shr    $0xc,%edx
  104286:	89 c3                	mov    %eax,%ebx
  104288:	8b 45 d0             	mov    -0x30(%ebp),%eax
  10428b:	89 04 24             	mov    %eax,(%esp)
  10428e:	e8 bd f8 ff ff       	call   103b50 <pa2page>
  104293:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  104297:	89 04 24             	mov    %eax,(%esp)
  10429a:	e8 78 fb ff ff       	call   103e17 <init_memmap>
        SetPageReserved(pages + i);
    }

    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * npage);

    for (i = 0; i < memmap->nr_map; i ++) {
  10429f:	83 45 dc 01          	addl   $0x1,-0x24(%ebp)
  1042a3:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  1042a6:	8b 00                	mov    (%eax),%eax
  1042a8:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  1042ab:	0f 8f 7e fe ff ff    	jg     10412f <page_init+0x264>
                    init_memmap(pa2page(begin), (end - begin) / PGSIZE);
                }
            }
        }
    }
}
  1042b1:	81 c4 9c 00 00 00    	add    $0x9c,%esp
  1042b7:	5b                   	pop    %ebx
  1042b8:	5e                   	pop    %esi
  1042b9:	5f                   	pop    %edi
  1042ba:	5d                   	pop    %ebp
  1042bb:	c3                   	ret    

001042bc <enable_paging>:

static void
enable_paging(void) {
  1042bc:	55                   	push   %ebp
  1042bd:	89 e5                	mov    %esp,%ebp
  1042bf:	83 ec 10             	sub    $0x10,%esp
    lcr3(boot_cr3);
  1042c2:	a1 c0 89 11 00       	mov    0x1189c0,%eax
  1042c7:	89 45 f8             	mov    %eax,-0x8(%ebp)
    asm volatile ("mov %0, %%cr0" :: "r" (cr0) : "memory");
}

static inline void
lcr3(uintptr_t cr3) {
    asm volatile ("mov %0, %%cr3" :: "r" (cr3) : "memory");
  1042ca:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1042cd:	0f 22 d8             	mov    %eax,%cr3
}

static inline uintptr_t
rcr0(void) {
    uintptr_t cr0;
    asm volatile ("mov %%cr0, %0" : "=r" (cr0) :: "memory");
  1042d0:	0f 20 c0             	mov    %cr0,%eax
  1042d3:	89 45 f4             	mov    %eax,-0xc(%ebp)
    return cr0;
  1042d6:	8b 45 f4             	mov    -0xc(%ebp),%eax

    // turn on paging
    uint32_t cr0 = rcr0();
  1042d9:	89 45 fc             	mov    %eax,-0x4(%ebp)
    cr0 |= CR0_PE | CR0_PG | CR0_AM | CR0_WP | CR0_NE | CR0_TS | CR0_EM | CR0_MP;
  1042dc:	81 4d fc 2f 00 05 80 	orl    $0x8005002f,-0x4(%ebp)
    cr0 &= ~(CR0_TS | CR0_EM);
  1042e3:	83 65 fc f3          	andl   $0xfffffff3,-0x4(%ebp)
  1042e7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1042ea:	89 45 f0             	mov    %eax,-0x10(%ebp)
    asm volatile ("pushl %0; popfl" :: "r" (eflags));
}

static inline void
lcr0(uintptr_t cr0) {
    asm volatile ("mov %0, %%cr0" :: "r" (cr0) : "memory");
  1042ed:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1042f0:	0f 22 c0             	mov    %eax,%cr0
    lcr0(cr0);
}
  1042f3:	c9                   	leave  
  1042f4:	c3                   	ret    

001042f5 <boot_map_segment>:
//  la:   linear address of this memory need to map (after x86 segment map)
//  size: memory size
//  pa:   physical address of this memory
//  perm: permission of this memory  
static void
boot_map_segment(pde_t *pgdir, uintptr_t la, size_t size, uintptr_t pa, uint32_t perm) {
  1042f5:	55                   	push   %ebp
  1042f6:	89 e5                	mov    %esp,%ebp
  1042f8:	83 ec 38             	sub    $0x38,%esp
    assert(PGOFF(la) == PGOFF(pa));
  1042fb:	8b 45 14             	mov    0x14(%ebp),%eax
  1042fe:	8b 55 0c             	mov    0xc(%ebp),%edx
  104301:	31 d0                	xor    %edx,%eax
  104303:	25 ff 0f 00 00       	and    $0xfff,%eax
  104308:	85 c0                	test   %eax,%eax
  10430a:	74 24                	je     104330 <boot_map_segment+0x3b>
  10430c:	c7 44 24 0c 8a 6c 10 	movl   $0x106c8a,0xc(%esp)
  104313:	00 
  104314:	c7 44 24 08 a1 6c 10 	movl   $0x106ca1,0x8(%esp)
  10431b:	00 
  10431c:	c7 44 24 04 04 01 00 	movl   $0x104,0x4(%esp)
  104323:	00 
  104324:	c7 04 24 7c 6c 10 00 	movl   $0x106c7c,(%esp)
  10432b:	e8 e4 c9 ff ff       	call   100d14 <__panic>
    size_t n = ROUNDUP(size + PGOFF(la), PGSIZE) / PGSIZE;
  104330:	c7 45 f0 00 10 00 00 	movl   $0x1000,-0x10(%ebp)
  104337:	8b 45 0c             	mov    0xc(%ebp),%eax
  10433a:	25 ff 0f 00 00       	and    $0xfff,%eax
  10433f:	89 c2                	mov    %eax,%edx
  104341:	8b 45 10             	mov    0x10(%ebp),%eax
  104344:	01 c2                	add    %eax,%edx
  104346:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104349:	01 d0                	add    %edx,%eax
  10434b:	83 e8 01             	sub    $0x1,%eax
  10434e:	89 45 ec             	mov    %eax,-0x14(%ebp)
  104351:	8b 45 ec             	mov    -0x14(%ebp),%eax
  104354:	ba 00 00 00 00       	mov    $0x0,%edx
  104359:	f7 75 f0             	divl   -0x10(%ebp)
  10435c:	89 d0                	mov    %edx,%eax
  10435e:	8b 55 ec             	mov    -0x14(%ebp),%edx
  104361:	29 c2                	sub    %eax,%edx
  104363:	89 d0                	mov    %edx,%eax
  104365:	c1 e8 0c             	shr    $0xc,%eax
  104368:	89 45 f4             	mov    %eax,-0xc(%ebp)
    la = ROUNDDOWN(la, PGSIZE);
  10436b:	8b 45 0c             	mov    0xc(%ebp),%eax
  10436e:	89 45 e8             	mov    %eax,-0x18(%ebp)
  104371:	8b 45 e8             	mov    -0x18(%ebp),%eax
  104374:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  104379:	89 45 0c             	mov    %eax,0xc(%ebp)
    pa = ROUNDDOWN(pa, PGSIZE);
  10437c:	8b 45 14             	mov    0x14(%ebp),%eax
  10437f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  104382:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  104385:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  10438a:	89 45 14             	mov    %eax,0x14(%ebp)
    for (; n > 0; n --, la += PGSIZE, pa += PGSIZE) {
  10438d:	eb 6b                	jmp    1043fa <boot_map_segment+0x105>
        pte_t *ptep = get_pte(pgdir, la, 1);
  10438f:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
  104396:	00 
  104397:	8b 45 0c             	mov    0xc(%ebp),%eax
  10439a:	89 44 24 04          	mov    %eax,0x4(%esp)
  10439e:	8b 45 08             	mov    0x8(%ebp),%eax
  1043a1:	89 04 24             	mov    %eax,(%esp)
  1043a4:	e8 cc 01 00 00       	call   104575 <get_pte>
  1043a9:	89 45 e0             	mov    %eax,-0x20(%ebp)
        assert(ptep != NULL);
  1043ac:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  1043b0:	75 24                	jne    1043d6 <boot_map_segment+0xe1>
  1043b2:	c7 44 24 0c b6 6c 10 	movl   $0x106cb6,0xc(%esp)
  1043b9:	00 
  1043ba:	c7 44 24 08 a1 6c 10 	movl   $0x106ca1,0x8(%esp)
  1043c1:	00 
  1043c2:	c7 44 24 04 0a 01 00 	movl   $0x10a,0x4(%esp)
  1043c9:	00 
  1043ca:	c7 04 24 7c 6c 10 00 	movl   $0x106c7c,(%esp)
  1043d1:	e8 3e c9 ff ff       	call   100d14 <__panic>
        *ptep = pa | PTE_P | perm;
  1043d6:	8b 45 18             	mov    0x18(%ebp),%eax
  1043d9:	8b 55 14             	mov    0x14(%ebp),%edx
  1043dc:	09 d0                	or     %edx,%eax
  1043de:	83 c8 01             	or     $0x1,%eax
  1043e1:	89 c2                	mov    %eax,%edx
  1043e3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1043e6:	89 10                	mov    %edx,(%eax)
boot_map_segment(pde_t *pgdir, uintptr_t la, size_t size, uintptr_t pa, uint32_t perm) {
    assert(PGOFF(la) == PGOFF(pa));
    size_t n = ROUNDUP(size + PGOFF(la), PGSIZE) / PGSIZE;
    la = ROUNDDOWN(la, PGSIZE);
    pa = ROUNDDOWN(pa, PGSIZE);
    for (; n > 0; n --, la += PGSIZE, pa += PGSIZE) {
  1043e8:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
  1043ec:	81 45 0c 00 10 00 00 	addl   $0x1000,0xc(%ebp)
  1043f3:	81 45 14 00 10 00 00 	addl   $0x1000,0x14(%ebp)
  1043fa:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1043fe:	75 8f                	jne    10438f <boot_map_segment+0x9a>
        pte_t *ptep = get_pte(pgdir, la, 1);
        assert(ptep != NULL);
        *ptep = pa | PTE_P | perm;
    }
}
  104400:	c9                   	leave  
  104401:	c3                   	ret    

00104402 <boot_alloc_page>:

//boot_alloc_page - allocate one page using pmm->alloc_pages(1) 
// return value: the kernel virtual address of this allocated page
//note: this function is used to get the memory for PDT(Page Directory Table)&PT(Page Table)
static void *
boot_alloc_page(void) {
  104402:	55                   	push   %ebp
  104403:	89 e5                	mov    %esp,%ebp
  104405:	83 ec 28             	sub    $0x28,%esp
    struct Page *p = alloc_page();
  104408:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  10440f:	e8 22 fa ff ff       	call   103e36 <alloc_pages>
  104414:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (p == NULL) {
  104417:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  10441b:	75 1c                	jne    104439 <boot_alloc_page+0x37>
        panic("boot_alloc_page failed.\n");
  10441d:	c7 44 24 08 c3 6c 10 	movl   $0x106cc3,0x8(%esp)
  104424:	00 
  104425:	c7 44 24 04 16 01 00 	movl   $0x116,0x4(%esp)
  10442c:	00 
  10442d:	c7 04 24 7c 6c 10 00 	movl   $0x106c7c,(%esp)
  104434:	e8 db c8 ff ff       	call   100d14 <__panic>
    }
    return page2kva(p);
  104439:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10443c:	89 04 24             	mov    %eax,(%esp)
  10443f:	e8 5b f7 ff ff       	call   103b9f <page2kva>
}
  104444:	c9                   	leave  
  104445:	c3                   	ret    

00104446 <pmm_init>:

//pmm_init - setup a pmm to manage physical memory, build PDT&PT to setup paging mechanism 
//         - check the correctness of pmm & paging mechanism, print PDT&PT
void
pmm_init(void) {
  104446:	55                   	push   %ebp
  104447:	89 e5                	mov    %esp,%ebp
  104449:	83 ec 38             	sub    $0x38,%esp
    //We need to alloc/free the physical memory (granularity is 4KB or other size). 
    //So a framework of physical memory manager (struct pmm_manager)is defined in pmm.h
    //First we should init a physical memory manager(pmm) based on the framework.
    //Then pmm can alloc/free the physical memory. 
    //Now the first_fit/best_fit/worst_fit/buddy_system pmm are available.
    init_pmm_manager();
  10444c:	e8 93 f9 ff ff       	call   103de4 <init_pmm_manager>

    // detect physical memory space, reserve already used memory,
    // then use pmm->init_memmap to create free page list
    page_init();
  104451:	e8 75 fa ff ff       	call   103ecb <page_init>

    //use pmm->check to verify the correctness of the alloc/free function in a pmm
    check_alloc_page();
  104456:	e8 74 04 00 00       	call   1048cf <check_alloc_page>

    // create boot_pgdir, an initial page directory(Page Directory Table, PDT)
    boot_pgdir = boot_alloc_page();
  10445b:	e8 a2 ff ff ff       	call   104402 <boot_alloc_page>
  104460:	a3 c4 88 11 00       	mov    %eax,0x1188c4
    memset(boot_pgdir, 0, PGSIZE);
  104465:	a1 c4 88 11 00       	mov    0x1188c4,%eax
  10446a:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
  104471:	00 
  104472:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  104479:	00 
  10447a:	89 04 24             	mov    %eax,(%esp)
  10447d:	e8 b6 1a 00 00       	call   105f38 <memset>
    boot_cr3 = PADDR(boot_pgdir);
  104482:	a1 c4 88 11 00       	mov    0x1188c4,%eax
  104487:	89 45 f4             	mov    %eax,-0xc(%ebp)
  10448a:	81 7d f4 ff ff ff bf 	cmpl   $0xbfffffff,-0xc(%ebp)
  104491:	77 23                	ja     1044b6 <pmm_init+0x70>
  104493:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104496:	89 44 24 0c          	mov    %eax,0xc(%esp)
  10449a:	c7 44 24 08 58 6c 10 	movl   $0x106c58,0x8(%esp)
  1044a1:	00 
  1044a2:	c7 44 24 04 30 01 00 	movl   $0x130,0x4(%esp)
  1044a9:	00 
  1044aa:	c7 04 24 7c 6c 10 00 	movl   $0x106c7c,(%esp)
  1044b1:	e8 5e c8 ff ff       	call   100d14 <__panic>
  1044b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1044b9:	05 00 00 00 40       	add    $0x40000000,%eax
  1044be:	a3 c0 89 11 00       	mov    %eax,0x1189c0

    check_pgdir();
  1044c3:	e8 25 04 00 00       	call   1048ed <check_pgdir>

    static_assert(KERNBASE % PTSIZE == 0 && KERNTOP % PTSIZE == 0);

    // recursively insert boot_pgdir in itself
    // to form a virtual page table at virtual address VPT
    boot_pgdir[PDX(VPT)] = PADDR(boot_pgdir) | PTE_P | PTE_W;
  1044c8:	a1 c4 88 11 00       	mov    0x1188c4,%eax
  1044cd:	8d 90 ac 0f 00 00    	lea    0xfac(%eax),%edx
  1044d3:	a1 c4 88 11 00       	mov    0x1188c4,%eax
  1044d8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1044db:	81 7d f0 ff ff ff bf 	cmpl   $0xbfffffff,-0x10(%ebp)
  1044e2:	77 23                	ja     104507 <pmm_init+0xc1>
  1044e4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1044e7:	89 44 24 0c          	mov    %eax,0xc(%esp)
  1044eb:	c7 44 24 08 58 6c 10 	movl   $0x106c58,0x8(%esp)
  1044f2:	00 
  1044f3:	c7 44 24 04 38 01 00 	movl   $0x138,0x4(%esp)
  1044fa:	00 
  1044fb:	c7 04 24 7c 6c 10 00 	movl   $0x106c7c,(%esp)
  104502:	e8 0d c8 ff ff       	call   100d14 <__panic>
  104507:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10450a:	05 00 00 00 40       	add    $0x40000000,%eax
  10450f:	83 c8 03             	or     $0x3,%eax
  104512:	89 02                	mov    %eax,(%edx)

    // map all physical memory to linear memory with base linear addr KERNBASE
    //linear_addr KERNBASE~KERNBASE+KMEMSIZE = phy_addr 0~KMEMSIZE
    //But shouldn't use this map until enable_paging() & gdt_init() finished.
    boot_map_segment(boot_pgdir, KERNBASE, KMEMSIZE, 0, PTE_W);
  104514:	a1 c4 88 11 00       	mov    0x1188c4,%eax
  104519:	c7 44 24 10 02 00 00 	movl   $0x2,0x10(%esp)
  104520:	00 
  104521:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  104528:	00 
  104529:	c7 44 24 08 00 00 00 	movl   $0x38000000,0x8(%esp)
  104530:	38 
  104531:	c7 44 24 04 00 00 00 	movl   $0xc0000000,0x4(%esp)
  104538:	c0 
  104539:	89 04 24             	mov    %eax,(%esp)
  10453c:	e8 b4 fd ff ff       	call   1042f5 <boot_map_segment>

    //temporary map: 
    //virtual_addr 3G~3G+4M = linear_addr 0~4M = linear_addr 3G~3G+4M = phy_addr 0~4M     
    boot_pgdir[0] = boot_pgdir[PDX(KERNBASE)];
  104541:	a1 c4 88 11 00       	mov    0x1188c4,%eax
  104546:	8b 15 c4 88 11 00    	mov    0x1188c4,%edx
  10454c:	8b 92 00 0c 00 00    	mov    0xc00(%edx),%edx
  104552:	89 10                	mov    %edx,(%eax)

    enable_paging();
  104554:	e8 63 fd ff ff       	call   1042bc <enable_paging>

    //reload gdt(third time,the last time) to map all physical memory
    //virtual_addr 0~4G=liear_addr 0~4G
    //then set kernel stack(ss:esp) in TSS, setup TSS in gdt, load TSS
    gdt_init();
  104559:	e8 97 f7 ff ff       	call   103cf5 <gdt_init>

    //disable the map of virtual_addr 0~4M
    boot_pgdir[0] = 0;
  10455e:	a1 c4 88 11 00       	mov    0x1188c4,%eax
  104563:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

    //now the basic virtual memory map(see memalyout.h) is established.
    //check the correctness of the basic virtual memory map.
    check_boot_pgdir();
  104569:	e8 1a 0a 00 00       	call   104f88 <check_boot_pgdir>

    print_pgdir();
  10456e:	e8 a7 0e 00 00       	call   10541a <print_pgdir>

}
  104573:	c9                   	leave  
  104574:	c3                   	ret    

00104575 <get_pte>:
//  pgdir:  the kernel virtual base address of PDT
//  la:     the linear address need to map
//  create: a logical value to decide if alloc a page for PT
// return vaule: the kernel virtual address of this pte
pte_t *
get_pte(pde_t *pgdir, uintptr_t la, bool create) {
  104575:	55                   	push   %ebp
  104576:	89 e5                	mov    %esp,%ebp
  104578:	83 ec 38             	sub    $0x38,%esp
    }
    return NULL;          // (8) return page table entry
#endif

    // get the page directory entry.
    pde_t *pdep = pgdir + PDX(la);
  10457b:	8b 45 0c             	mov    0xc(%ebp),%eax
  10457e:	c1 e8 16             	shr    $0x16,%eax
  104581:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  104588:	8b 45 08             	mov    0x8(%ebp),%eax
  10458b:	01 d0                	add    %edx,%eax
  10458d:	89 45 f4             	mov    %eax,-0xc(%ebp)

	if (!(*pdep & PTE_P)) //if it's not present, create a page table for it.
  104590:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104593:	8b 00                	mov    (%eax),%eax
  104595:	83 e0 01             	and    $0x1,%eax
  104598:	85 c0                	test   %eax,%eax
  10459a:	0f 85 af 00 00 00    	jne    10464f <get_pte+0xda>
	{
		struct Page *page;
		if (!create || (page = alloc_page()) == NULL)
  1045a0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  1045a4:	74 15                	je     1045bb <get_pte+0x46>
  1045a6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  1045ad:	e8 84 f8 ff ff       	call   103e36 <alloc_pages>
  1045b2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1045b5:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  1045b9:	75 0a                	jne    1045c5 <get_pte+0x50>
			return NULL;
  1045bb:	b8 00 00 00 00       	mov    $0x0,%eax
  1045c0:	e9 ef 00 00 00       	jmp    1046b4 <get_pte+0x13f>

		set_page_ref(page, 1);
  1045c5:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  1045cc:	00 
  1045cd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1045d0:	89 04 24             	mov    %eax,(%esp)
  1045d3:	e8 63 f6 ff ff       	call   103c3b <set_page_ref>
		uintptr_t pa = page2pa(page);
  1045d8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1045db:	89 04 24             	mov    %eax,(%esp)
  1045de:	e8 57 f5 ff ff       	call   103b3a <page2pa>
  1045e3:	89 45 ec             	mov    %eax,-0x14(%ebp)
		memset(KADDR(pa), 0, PGSIZE);
  1045e6:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1045e9:	89 45 e8             	mov    %eax,-0x18(%ebp)
  1045ec:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1045ef:	c1 e8 0c             	shr    $0xc,%eax
  1045f2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  1045f5:	a1 c0 88 11 00       	mov    0x1188c0,%eax
  1045fa:	39 45 e4             	cmp    %eax,-0x1c(%ebp)
  1045fd:	72 23                	jb     104622 <get_pte+0xad>
  1045ff:	8b 45 e8             	mov    -0x18(%ebp),%eax
  104602:	89 44 24 0c          	mov    %eax,0xc(%esp)
  104606:	c7 44 24 08 b4 6b 10 	movl   $0x106bb4,0x8(%esp)
  10460d:	00 
  10460e:	c7 44 24 04 8b 01 00 	movl   $0x18b,0x4(%esp)
  104615:	00 
  104616:	c7 04 24 7c 6c 10 00 	movl   $0x106c7c,(%esp)
  10461d:	e8 f2 c6 ff ff       	call   100d14 <__panic>
  104622:	8b 45 e8             	mov    -0x18(%ebp),%eax
  104625:	2d 00 00 00 40       	sub    $0x40000000,%eax
  10462a:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
  104631:	00 
  104632:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  104639:	00 
  10463a:	89 04 24             	mov    %eax,(%esp)
  10463d:	e8 f6 18 00 00       	call   105f38 <memset>

		*pdep= pa | PTE_P | PTE_W | PTE_U;
  104642:	8b 45 ec             	mov    -0x14(%ebp),%eax
  104645:	83 c8 07             	or     $0x7,%eax
  104648:	89 c2                	mov    %eax,%edx
  10464a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10464d:	89 10                	mov    %edx,(%eax)
	}

	// get the page table base address.
	pte_t *pt_base= (pte_t *)KADDR(PDE_ADDR(*pdep));
  10464f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104652:	8b 00                	mov    (%eax),%eax
  104654:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  104659:	89 45 e0             	mov    %eax,-0x20(%ebp)
  10465c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  10465f:	c1 e8 0c             	shr    $0xc,%eax
  104662:	89 45 dc             	mov    %eax,-0x24(%ebp)
  104665:	a1 c0 88 11 00       	mov    0x1188c0,%eax
  10466a:	39 45 dc             	cmp    %eax,-0x24(%ebp)
  10466d:	72 23                	jb     104692 <get_pte+0x11d>
  10466f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  104672:	89 44 24 0c          	mov    %eax,0xc(%esp)
  104676:	c7 44 24 08 b4 6b 10 	movl   $0x106bb4,0x8(%esp)
  10467d:	00 
  10467e:	c7 44 24 04 91 01 00 	movl   $0x191,0x4(%esp)
  104685:	00 
  104686:	c7 04 24 7c 6c 10 00 	movl   $0x106c7c,(%esp)
  10468d:	e8 82 c6 ff ff       	call   100d14 <__panic>
  104692:	8b 45 e0             	mov    -0x20(%ebp),%eax
  104695:	2d 00 00 00 40       	sub    $0x40000000,%eax
  10469a:	89 45 d8             	mov    %eax,-0x28(%ebp)

	// return the page table entry.
	return pt_base + PTX(la);
  10469d:	8b 45 0c             	mov    0xc(%ebp),%eax
  1046a0:	c1 e8 0c             	shr    $0xc,%eax
  1046a3:	25 ff 03 00 00       	and    $0x3ff,%eax
  1046a8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  1046af:	8b 45 d8             	mov    -0x28(%ebp),%eax
  1046b2:	01 d0                	add    %edx,%eax
}
  1046b4:	c9                   	leave  
  1046b5:	c3                   	ret    

001046b6 <get_page>:

//get_page - get related Page struct for linear address la using PDT pgdir
struct Page *
get_page(pde_t *pgdir, uintptr_t la, pte_t **ptep_store) {
  1046b6:	55                   	push   %ebp
  1046b7:	89 e5                	mov    %esp,%ebp
  1046b9:	83 ec 28             	sub    $0x28,%esp
    pte_t *ptep = get_pte(pgdir, la, 0);
  1046bc:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  1046c3:	00 
  1046c4:	8b 45 0c             	mov    0xc(%ebp),%eax
  1046c7:	89 44 24 04          	mov    %eax,0x4(%esp)
  1046cb:	8b 45 08             	mov    0x8(%ebp),%eax
  1046ce:	89 04 24             	mov    %eax,(%esp)
  1046d1:	e8 9f fe ff ff       	call   104575 <get_pte>
  1046d6:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (ptep_store != NULL) {
  1046d9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  1046dd:	74 08                	je     1046e7 <get_page+0x31>
        *ptep_store = ptep;
  1046df:	8b 45 10             	mov    0x10(%ebp),%eax
  1046e2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1046e5:	89 10                	mov    %edx,(%eax)
    }
    if (ptep != NULL && *ptep & PTE_P) {
  1046e7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1046eb:	74 1b                	je     104708 <get_page+0x52>
  1046ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1046f0:	8b 00                	mov    (%eax),%eax
  1046f2:	83 e0 01             	and    $0x1,%eax
  1046f5:	85 c0                	test   %eax,%eax
  1046f7:	74 0f                	je     104708 <get_page+0x52>
        return pa2page(*ptep);
  1046f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1046fc:	8b 00                	mov    (%eax),%eax
  1046fe:	89 04 24             	mov    %eax,(%esp)
  104701:	e8 4a f4 ff ff       	call   103b50 <pa2page>
  104706:	eb 05                	jmp    10470d <get_page+0x57>
    }
    return NULL;
  104708:	b8 00 00 00 00       	mov    $0x0,%eax
}
  10470d:	c9                   	leave  
  10470e:	c3                   	ret    

0010470f <page_remove_pte>:

//page_remove_pte - free an Page sturct which is related linear address la
//                - and clean(invalidate) pte which is related linear address la
//note: PT is changed, so the TLB need to be invalidate 
static inline void
page_remove_pte(pde_t *pgdir, uintptr_t la, pte_t *ptep) {
  10470f:	55                   	push   %ebp
  104710:	89 e5                	mov    %esp,%ebp
  104712:	83 ec 28             	sub    $0x28,%esp
                                  //(5) clear second page table entry
                                  //(6) flush tlb
    }
#endif

    if (*ptep & PTE_P) //check if this page table entry is present
  104715:	8b 45 10             	mov    0x10(%ebp),%eax
  104718:	8b 00                	mov    (%eax),%eax
  10471a:	83 e0 01             	and    $0x1,%eax
  10471d:	85 c0                	test   %eax,%eax
  10471f:	74 52                	je     104773 <page_remove_pte+0x64>
    {
    	struct Page *page= pte2page(*ptep); //find corresponding page to pte
  104721:	8b 45 10             	mov    0x10(%ebp),%eax
  104724:	8b 00                	mov    (%eax),%eax
  104726:	89 04 24             	mov    %eax,(%esp)
  104729:	e8 c5 f4 ff ff       	call   103bf3 <pte2page>
  10472e:	89 45 f4             	mov    %eax,-0xc(%ebp)

    	page_ref_dec(page); //decrease page reference
  104731:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104734:	89 04 24             	mov    %eax,(%esp)
  104737:	e8 23 f5 ff ff       	call   103c5f <page_ref_dec>
    	if (page->ref == 0) //free this page when page reference reachs 0
  10473c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10473f:	8b 00                	mov    (%eax),%eax
  104741:	85 c0                	test   %eax,%eax
  104743:	75 13                	jne    104758 <page_remove_pte+0x49>
    		free_page(page);
  104745:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  10474c:	00 
  10474d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104750:	89 04 24             	mov    %eax,(%esp)
  104753:	e8 16 f7 ff ff       	call   103e6e <free_pages>

    	*ptep = 0; //clear second page table entry
  104758:	8b 45 10             	mov    0x10(%ebp),%eax
  10475b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    	tlb_invalidate(pgdir, la); //flush tlb
  104761:	8b 45 0c             	mov    0xc(%ebp),%eax
  104764:	89 44 24 04          	mov    %eax,0x4(%esp)
  104768:	8b 45 08             	mov    0x8(%ebp),%eax
  10476b:	89 04 24             	mov    %eax,(%esp)
  10476e:	e8 ff 00 00 00       	call   104872 <tlb_invalidate>
    }
}
  104773:	c9                   	leave  
  104774:	c3                   	ret    

00104775 <page_remove>:

//page_remove - free an Page which is related linear address la and has an validated pte
void
page_remove(pde_t *pgdir, uintptr_t la) {
  104775:	55                   	push   %ebp
  104776:	89 e5                	mov    %esp,%ebp
  104778:	83 ec 28             	sub    $0x28,%esp
    pte_t *ptep = get_pte(pgdir, la, 0);
  10477b:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  104782:	00 
  104783:	8b 45 0c             	mov    0xc(%ebp),%eax
  104786:	89 44 24 04          	mov    %eax,0x4(%esp)
  10478a:	8b 45 08             	mov    0x8(%ebp),%eax
  10478d:	89 04 24             	mov    %eax,(%esp)
  104790:	e8 e0 fd ff ff       	call   104575 <get_pte>
  104795:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (ptep != NULL) {
  104798:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  10479c:	74 19                	je     1047b7 <page_remove+0x42>
        page_remove_pte(pgdir, la, ptep);
  10479e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1047a1:	89 44 24 08          	mov    %eax,0x8(%esp)
  1047a5:	8b 45 0c             	mov    0xc(%ebp),%eax
  1047a8:	89 44 24 04          	mov    %eax,0x4(%esp)
  1047ac:	8b 45 08             	mov    0x8(%ebp),%eax
  1047af:	89 04 24             	mov    %eax,(%esp)
  1047b2:	e8 58 ff ff ff       	call   10470f <page_remove_pte>
    }
}
  1047b7:	c9                   	leave  
  1047b8:	c3                   	ret    

001047b9 <page_insert>:
//  la:    the linear address need to map
//  perm:  the permission of this Page which is setted in related pte
// return value: always 0
//note: PT is changed, so the TLB need to be invalidate 
int
page_insert(pde_t *pgdir, struct Page *page, uintptr_t la, uint32_t perm) {
  1047b9:	55                   	push   %ebp
  1047ba:	89 e5                	mov    %esp,%ebp
  1047bc:	83 ec 28             	sub    $0x28,%esp
    pte_t *ptep = get_pte(pgdir, la, 1);
  1047bf:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
  1047c6:	00 
  1047c7:	8b 45 10             	mov    0x10(%ebp),%eax
  1047ca:	89 44 24 04          	mov    %eax,0x4(%esp)
  1047ce:	8b 45 08             	mov    0x8(%ebp),%eax
  1047d1:	89 04 24             	mov    %eax,(%esp)
  1047d4:	e8 9c fd ff ff       	call   104575 <get_pte>
  1047d9:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (ptep == NULL) {
  1047dc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1047e0:	75 0a                	jne    1047ec <page_insert+0x33>
        return -E_NO_MEM;
  1047e2:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
  1047e7:	e9 84 00 00 00       	jmp    104870 <page_insert+0xb7>
    }
    page_ref_inc(page);
  1047ec:	8b 45 0c             	mov    0xc(%ebp),%eax
  1047ef:	89 04 24             	mov    %eax,(%esp)
  1047f2:	e8 51 f4 ff ff       	call   103c48 <page_ref_inc>
    if (*ptep & PTE_P) {
  1047f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1047fa:	8b 00                	mov    (%eax),%eax
  1047fc:	83 e0 01             	and    $0x1,%eax
  1047ff:	85 c0                	test   %eax,%eax
  104801:	74 3e                	je     104841 <page_insert+0x88>
        struct Page *p = pte2page(*ptep);
  104803:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104806:	8b 00                	mov    (%eax),%eax
  104808:	89 04 24             	mov    %eax,(%esp)
  10480b:	e8 e3 f3 ff ff       	call   103bf3 <pte2page>
  104810:	89 45 f0             	mov    %eax,-0x10(%ebp)
        if (p == page) {
  104813:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104816:	3b 45 0c             	cmp    0xc(%ebp),%eax
  104819:	75 0d                	jne    104828 <page_insert+0x6f>
            page_ref_dec(page);
  10481b:	8b 45 0c             	mov    0xc(%ebp),%eax
  10481e:	89 04 24             	mov    %eax,(%esp)
  104821:	e8 39 f4 ff ff       	call   103c5f <page_ref_dec>
  104826:	eb 19                	jmp    104841 <page_insert+0x88>
        }
        else {
            page_remove_pte(pgdir, la, ptep);
  104828:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10482b:	89 44 24 08          	mov    %eax,0x8(%esp)
  10482f:	8b 45 10             	mov    0x10(%ebp),%eax
  104832:	89 44 24 04          	mov    %eax,0x4(%esp)
  104836:	8b 45 08             	mov    0x8(%ebp),%eax
  104839:	89 04 24             	mov    %eax,(%esp)
  10483c:	e8 ce fe ff ff       	call   10470f <page_remove_pte>
        }
    }
    *ptep = page2pa(page) | PTE_P | perm;
  104841:	8b 45 0c             	mov    0xc(%ebp),%eax
  104844:	89 04 24             	mov    %eax,(%esp)
  104847:	e8 ee f2 ff ff       	call   103b3a <page2pa>
  10484c:	0b 45 14             	or     0x14(%ebp),%eax
  10484f:	83 c8 01             	or     $0x1,%eax
  104852:	89 c2                	mov    %eax,%edx
  104854:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104857:	89 10                	mov    %edx,(%eax)
    tlb_invalidate(pgdir, la);
  104859:	8b 45 10             	mov    0x10(%ebp),%eax
  10485c:	89 44 24 04          	mov    %eax,0x4(%esp)
  104860:	8b 45 08             	mov    0x8(%ebp),%eax
  104863:	89 04 24             	mov    %eax,(%esp)
  104866:	e8 07 00 00 00       	call   104872 <tlb_invalidate>
    return 0;
  10486b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  104870:	c9                   	leave  
  104871:	c3                   	ret    

00104872 <tlb_invalidate>:

// invalidate a TLB entry, but only if the page tables being
// edited are the ones currently in use by the processor.
void
tlb_invalidate(pde_t *pgdir, uintptr_t la) {
  104872:	55                   	push   %ebp
  104873:	89 e5                	mov    %esp,%ebp
  104875:	83 ec 28             	sub    $0x28,%esp
}

static inline uintptr_t
rcr3(void) {
    uintptr_t cr3;
    asm volatile ("mov %%cr3, %0" : "=r" (cr3) :: "memory");
  104878:	0f 20 d8             	mov    %cr3,%eax
  10487b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    return cr3;
  10487e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    if (rcr3() == PADDR(pgdir)) {
  104881:	89 c2                	mov    %eax,%edx
  104883:	8b 45 08             	mov    0x8(%ebp),%eax
  104886:	89 45 f4             	mov    %eax,-0xc(%ebp)
  104889:	81 7d f4 ff ff ff bf 	cmpl   $0xbfffffff,-0xc(%ebp)
  104890:	77 23                	ja     1048b5 <tlb_invalidate+0x43>
  104892:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104895:	89 44 24 0c          	mov    %eax,0xc(%esp)
  104899:	c7 44 24 08 58 6c 10 	movl   $0x106c58,0x8(%esp)
  1048a0:	00 
  1048a1:	c7 44 24 04 fa 01 00 	movl   $0x1fa,0x4(%esp)
  1048a8:	00 
  1048a9:	c7 04 24 7c 6c 10 00 	movl   $0x106c7c,(%esp)
  1048b0:	e8 5f c4 ff ff       	call   100d14 <__panic>
  1048b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1048b8:	05 00 00 00 40       	add    $0x40000000,%eax
  1048bd:	39 c2                	cmp    %eax,%edx
  1048bf:	75 0c                	jne    1048cd <tlb_invalidate+0x5b>
        invlpg((void *)la);
  1048c1:	8b 45 0c             	mov    0xc(%ebp),%eax
  1048c4:	89 45 ec             	mov    %eax,-0x14(%ebp)
}

static inline void
invlpg(void *addr) {
    asm volatile ("invlpg (%0)" :: "r" (addr) : "memory");
  1048c7:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1048ca:	0f 01 38             	invlpg (%eax)
    }
}
  1048cd:	c9                   	leave  
  1048ce:	c3                   	ret    

001048cf <check_alloc_page>:

static void
check_alloc_page(void) {
  1048cf:	55                   	push   %ebp
  1048d0:	89 e5                	mov    %esp,%ebp
  1048d2:	83 ec 18             	sub    $0x18,%esp
    pmm_manager->check();
  1048d5:	a1 bc 89 11 00       	mov    0x1189bc,%eax
  1048da:	8b 40 18             	mov    0x18(%eax),%eax
  1048dd:	ff d0                	call   *%eax
    cprintf("check_alloc_page() succeeded!\n");
  1048df:	c7 04 24 dc 6c 10 00 	movl   $0x106cdc,(%esp)
  1048e6:	e8 61 ba ff ff       	call   10034c <cprintf>
}
  1048eb:	c9                   	leave  
  1048ec:	c3                   	ret    

001048ed <check_pgdir>:

static void
check_pgdir(void) {
  1048ed:	55                   	push   %ebp
  1048ee:	89 e5                	mov    %esp,%ebp
  1048f0:	83 ec 38             	sub    $0x38,%esp
    assert(npage <= KMEMSIZE / PGSIZE);
  1048f3:	a1 c0 88 11 00       	mov    0x1188c0,%eax
  1048f8:	3d 00 80 03 00       	cmp    $0x38000,%eax
  1048fd:	76 24                	jbe    104923 <check_pgdir+0x36>
  1048ff:	c7 44 24 0c fb 6c 10 	movl   $0x106cfb,0xc(%esp)
  104906:	00 
  104907:	c7 44 24 08 a1 6c 10 	movl   $0x106ca1,0x8(%esp)
  10490e:	00 
  10490f:	c7 44 24 04 07 02 00 	movl   $0x207,0x4(%esp)
  104916:	00 
  104917:	c7 04 24 7c 6c 10 00 	movl   $0x106c7c,(%esp)
  10491e:	e8 f1 c3 ff ff       	call   100d14 <__panic>
    assert(boot_pgdir != NULL && (uint32_t)PGOFF(boot_pgdir) == 0);
  104923:	a1 c4 88 11 00       	mov    0x1188c4,%eax
  104928:	85 c0                	test   %eax,%eax
  10492a:	74 0e                	je     10493a <check_pgdir+0x4d>
  10492c:	a1 c4 88 11 00       	mov    0x1188c4,%eax
  104931:	25 ff 0f 00 00       	and    $0xfff,%eax
  104936:	85 c0                	test   %eax,%eax
  104938:	74 24                	je     10495e <check_pgdir+0x71>
  10493a:	c7 44 24 0c 18 6d 10 	movl   $0x106d18,0xc(%esp)
  104941:	00 
  104942:	c7 44 24 08 a1 6c 10 	movl   $0x106ca1,0x8(%esp)
  104949:	00 
  10494a:	c7 44 24 04 08 02 00 	movl   $0x208,0x4(%esp)
  104951:	00 
  104952:	c7 04 24 7c 6c 10 00 	movl   $0x106c7c,(%esp)
  104959:	e8 b6 c3 ff ff       	call   100d14 <__panic>
    assert(get_page(boot_pgdir, 0x0, NULL) == NULL);
  10495e:	a1 c4 88 11 00       	mov    0x1188c4,%eax
  104963:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  10496a:	00 
  10496b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  104972:	00 
  104973:	89 04 24             	mov    %eax,(%esp)
  104976:	e8 3b fd ff ff       	call   1046b6 <get_page>
  10497b:	85 c0                	test   %eax,%eax
  10497d:	74 24                	je     1049a3 <check_pgdir+0xb6>
  10497f:	c7 44 24 0c 50 6d 10 	movl   $0x106d50,0xc(%esp)
  104986:	00 
  104987:	c7 44 24 08 a1 6c 10 	movl   $0x106ca1,0x8(%esp)
  10498e:	00 
  10498f:	c7 44 24 04 09 02 00 	movl   $0x209,0x4(%esp)
  104996:	00 
  104997:	c7 04 24 7c 6c 10 00 	movl   $0x106c7c,(%esp)
  10499e:	e8 71 c3 ff ff       	call   100d14 <__panic>

    struct Page *p1, *p2;
    p1 = alloc_page();
  1049a3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  1049aa:	e8 87 f4 ff ff       	call   103e36 <alloc_pages>
  1049af:	89 45 f4             	mov    %eax,-0xc(%ebp)
    assert(page_insert(boot_pgdir, p1, 0x0, 0) == 0);
  1049b2:	a1 c4 88 11 00       	mov    0x1188c4,%eax
  1049b7:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  1049be:	00 
  1049bf:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  1049c6:	00 
  1049c7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1049ca:	89 54 24 04          	mov    %edx,0x4(%esp)
  1049ce:	89 04 24             	mov    %eax,(%esp)
  1049d1:	e8 e3 fd ff ff       	call   1047b9 <page_insert>
  1049d6:	85 c0                	test   %eax,%eax
  1049d8:	74 24                	je     1049fe <check_pgdir+0x111>
  1049da:	c7 44 24 0c 78 6d 10 	movl   $0x106d78,0xc(%esp)
  1049e1:	00 
  1049e2:	c7 44 24 08 a1 6c 10 	movl   $0x106ca1,0x8(%esp)
  1049e9:	00 
  1049ea:	c7 44 24 04 0d 02 00 	movl   $0x20d,0x4(%esp)
  1049f1:	00 
  1049f2:	c7 04 24 7c 6c 10 00 	movl   $0x106c7c,(%esp)
  1049f9:	e8 16 c3 ff ff       	call   100d14 <__panic>

    pte_t *ptep;
    assert((ptep = get_pte(boot_pgdir, 0x0, 0)) != NULL);
  1049fe:	a1 c4 88 11 00       	mov    0x1188c4,%eax
  104a03:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  104a0a:	00 
  104a0b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  104a12:	00 
  104a13:	89 04 24             	mov    %eax,(%esp)
  104a16:	e8 5a fb ff ff       	call   104575 <get_pte>
  104a1b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  104a1e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  104a22:	75 24                	jne    104a48 <check_pgdir+0x15b>
  104a24:	c7 44 24 0c a4 6d 10 	movl   $0x106da4,0xc(%esp)
  104a2b:	00 
  104a2c:	c7 44 24 08 a1 6c 10 	movl   $0x106ca1,0x8(%esp)
  104a33:	00 
  104a34:	c7 44 24 04 10 02 00 	movl   $0x210,0x4(%esp)
  104a3b:	00 
  104a3c:	c7 04 24 7c 6c 10 00 	movl   $0x106c7c,(%esp)
  104a43:	e8 cc c2 ff ff       	call   100d14 <__panic>
    assert(pa2page(*ptep) == p1);
  104a48:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104a4b:	8b 00                	mov    (%eax),%eax
  104a4d:	89 04 24             	mov    %eax,(%esp)
  104a50:	e8 fb f0 ff ff       	call   103b50 <pa2page>
  104a55:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  104a58:	74 24                	je     104a7e <check_pgdir+0x191>
  104a5a:	c7 44 24 0c d1 6d 10 	movl   $0x106dd1,0xc(%esp)
  104a61:	00 
  104a62:	c7 44 24 08 a1 6c 10 	movl   $0x106ca1,0x8(%esp)
  104a69:	00 
  104a6a:	c7 44 24 04 11 02 00 	movl   $0x211,0x4(%esp)
  104a71:	00 
  104a72:	c7 04 24 7c 6c 10 00 	movl   $0x106c7c,(%esp)
  104a79:	e8 96 c2 ff ff       	call   100d14 <__panic>
    assert(page_ref(p1) == 1);
  104a7e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104a81:	89 04 24             	mov    %eax,(%esp)
  104a84:	e8 a8 f1 ff ff       	call   103c31 <page_ref>
  104a89:	83 f8 01             	cmp    $0x1,%eax
  104a8c:	74 24                	je     104ab2 <check_pgdir+0x1c5>
  104a8e:	c7 44 24 0c e6 6d 10 	movl   $0x106de6,0xc(%esp)
  104a95:	00 
  104a96:	c7 44 24 08 a1 6c 10 	movl   $0x106ca1,0x8(%esp)
  104a9d:	00 
  104a9e:	c7 44 24 04 12 02 00 	movl   $0x212,0x4(%esp)
  104aa5:	00 
  104aa6:	c7 04 24 7c 6c 10 00 	movl   $0x106c7c,(%esp)
  104aad:	e8 62 c2 ff ff       	call   100d14 <__panic>

    ptep = &((pte_t *)KADDR(PDE_ADDR(boot_pgdir[0])))[1];
  104ab2:	a1 c4 88 11 00       	mov    0x1188c4,%eax
  104ab7:	8b 00                	mov    (%eax),%eax
  104ab9:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  104abe:	89 45 ec             	mov    %eax,-0x14(%ebp)
  104ac1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  104ac4:	c1 e8 0c             	shr    $0xc,%eax
  104ac7:	89 45 e8             	mov    %eax,-0x18(%ebp)
  104aca:	a1 c0 88 11 00       	mov    0x1188c0,%eax
  104acf:	39 45 e8             	cmp    %eax,-0x18(%ebp)
  104ad2:	72 23                	jb     104af7 <check_pgdir+0x20a>
  104ad4:	8b 45 ec             	mov    -0x14(%ebp),%eax
  104ad7:	89 44 24 0c          	mov    %eax,0xc(%esp)
  104adb:	c7 44 24 08 b4 6b 10 	movl   $0x106bb4,0x8(%esp)
  104ae2:	00 
  104ae3:	c7 44 24 04 14 02 00 	movl   $0x214,0x4(%esp)
  104aea:	00 
  104aeb:	c7 04 24 7c 6c 10 00 	movl   $0x106c7c,(%esp)
  104af2:	e8 1d c2 ff ff       	call   100d14 <__panic>
  104af7:	8b 45 ec             	mov    -0x14(%ebp),%eax
  104afa:	2d 00 00 00 40       	sub    $0x40000000,%eax
  104aff:	83 c0 04             	add    $0x4,%eax
  104b02:	89 45 f0             	mov    %eax,-0x10(%ebp)
    assert(get_pte(boot_pgdir, PGSIZE, 0) == ptep);
  104b05:	a1 c4 88 11 00       	mov    0x1188c4,%eax
  104b0a:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  104b11:	00 
  104b12:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
  104b19:	00 
  104b1a:	89 04 24             	mov    %eax,(%esp)
  104b1d:	e8 53 fa ff ff       	call   104575 <get_pte>
  104b22:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  104b25:	74 24                	je     104b4b <check_pgdir+0x25e>
  104b27:	c7 44 24 0c f8 6d 10 	movl   $0x106df8,0xc(%esp)
  104b2e:	00 
  104b2f:	c7 44 24 08 a1 6c 10 	movl   $0x106ca1,0x8(%esp)
  104b36:	00 
  104b37:	c7 44 24 04 15 02 00 	movl   $0x215,0x4(%esp)
  104b3e:	00 
  104b3f:	c7 04 24 7c 6c 10 00 	movl   $0x106c7c,(%esp)
  104b46:	e8 c9 c1 ff ff       	call   100d14 <__panic>

    p2 = alloc_page();
  104b4b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  104b52:	e8 df f2 ff ff       	call   103e36 <alloc_pages>
  104b57:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    assert(page_insert(boot_pgdir, p2, PGSIZE, PTE_U | PTE_W) == 0);
  104b5a:	a1 c4 88 11 00       	mov    0x1188c4,%eax
  104b5f:	c7 44 24 0c 06 00 00 	movl   $0x6,0xc(%esp)
  104b66:	00 
  104b67:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
  104b6e:	00 
  104b6f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  104b72:	89 54 24 04          	mov    %edx,0x4(%esp)
  104b76:	89 04 24             	mov    %eax,(%esp)
  104b79:	e8 3b fc ff ff       	call   1047b9 <page_insert>
  104b7e:	85 c0                	test   %eax,%eax
  104b80:	74 24                	je     104ba6 <check_pgdir+0x2b9>
  104b82:	c7 44 24 0c 20 6e 10 	movl   $0x106e20,0xc(%esp)
  104b89:	00 
  104b8a:	c7 44 24 08 a1 6c 10 	movl   $0x106ca1,0x8(%esp)
  104b91:	00 
  104b92:	c7 44 24 04 18 02 00 	movl   $0x218,0x4(%esp)
  104b99:	00 
  104b9a:	c7 04 24 7c 6c 10 00 	movl   $0x106c7c,(%esp)
  104ba1:	e8 6e c1 ff ff       	call   100d14 <__panic>
    assert((ptep = get_pte(boot_pgdir, PGSIZE, 0)) != NULL);
  104ba6:	a1 c4 88 11 00       	mov    0x1188c4,%eax
  104bab:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  104bb2:	00 
  104bb3:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
  104bba:	00 
  104bbb:	89 04 24             	mov    %eax,(%esp)
  104bbe:	e8 b2 f9 ff ff       	call   104575 <get_pte>
  104bc3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  104bc6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  104bca:	75 24                	jne    104bf0 <check_pgdir+0x303>
  104bcc:	c7 44 24 0c 58 6e 10 	movl   $0x106e58,0xc(%esp)
  104bd3:	00 
  104bd4:	c7 44 24 08 a1 6c 10 	movl   $0x106ca1,0x8(%esp)
  104bdb:	00 
  104bdc:	c7 44 24 04 19 02 00 	movl   $0x219,0x4(%esp)
  104be3:	00 
  104be4:	c7 04 24 7c 6c 10 00 	movl   $0x106c7c,(%esp)
  104beb:	e8 24 c1 ff ff       	call   100d14 <__panic>
    assert(*ptep & PTE_U);
  104bf0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104bf3:	8b 00                	mov    (%eax),%eax
  104bf5:	83 e0 04             	and    $0x4,%eax
  104bf8:	85 c0                	test   %eax,%eax
  104bfa:	75 24                	jne    104c20 <check_pgdir+0x333>
  104bfc:	c7 44 24 0c 88 6e 10 	movl   $0x106e88,0xc(%esp)
  104c03:	00 
  104c04:	c7 44 24 08 a1 6c 10 	movl   $0x106ca1,0x8(%esp)
  104c0b:	00 
  104c0c:	c7 44 24 04 1a 02 00 	movl   $0x21a,0x4(%esp)
  104c13:	00 
  104c14:	c7 04 24 7c 6c 10 00 	movl   $0x106c7c,(%esp)
  104c1b:	e8 f4 c0 ff ff       	call   100d14 <__panic>
    assert(*ptep & PTE_W);
  104c20:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104c23:	8b 00                	mov    (%eax),%eax
  104c25:	83 e0 02             	and    $0x2,%eax
  104c28:	85 c0                	test   %eax,%eax
  104c2a:	75 24                	jne    104c50 <check_pgdir+0x363>
  104c2c:	c7 44 24 0c 96 6e 10 	movl   $0x106e96,0xc(%esp)
  104c33:	00 
  104c34:	c7 44 24 08 a1 6c 10 	movl   $0x106ca1,0x8(%esp)
  104c3b:	00 
  104c3c:	c7 44 24 04 1b 02 00 	movl   $0x21b,0x4(%esp)
  104c43:	00 
  104c44:	c7 04 24 7c 6c 10 00 	movl   $0x106c7c,(%esp)
  104c4b:	e8 c4 c0 ff ff       	call   100d14 <__panic>
    assert(boot_pgdir[0] & PTE_U);
  104c50:	a1 c4 88 11 00       	mov    0x1188c4,%eax
  104c55:	8b 00                	mov    (%eax),%eax
  104c57:	83 e0 04             	and    $0x4,%eax
  104c5a:	85 c0                	test   %eax,%eax
  104c5c:	75 24                	jne    104c82 <check_pgdir+0x395>
  104c5e:	c7 44 24 0c a4 6e 10 	movl   $0x106ea4,0xc(%esp)
  104c65:	00 
  104c66:	c7 44 24 08 a1 6c 10 	movl   $0x106ca1,0x8(%esp)
  104c6d:	00 
  104c6e:	c7 44 24 04 1c 02 00 	movl   $0x21c,0x4(%esp)
  104c75:	00 
  104c76:	c7 04 24 7c 6c 10 00 	movl   $0x106c7c,(%esp)
  104c7d:	e8 92 c0 ff ff       	call   100d14 <__panic>
    assert(page_ref(p2) == 1);
  104c82:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  104c85:	89 04 24             	mov    %eax,(%esp)
  104c88:	e8 a4 ef ff ff       	call   103c31 <page_ref>
  104c8d:	83 f8 01             	cmp    $0x1,%eax
  104c90:	74 24                	je     104cb6 <check_pgdir+0x3c9>
  104c92:	c7 44 24 0c ba 6e 10 	movl   $0x106eba,0xc(%esp)
  104c99:	00 
  104c9a:	c7 44 24 08 a1 6c 10 	movl   $0x106ca1,0x8(%esp)
  104ca1:	00 
  104ca2:	c7 44 24 04 1d 02 00 	movl   $0x21d,0x4(%esp)
  104ca9:	00 
  104caa:	c7 04 24 7c 6c 10 00 	movl   $0x106c7c,(%esp)
  104cb1:	e8 5e c0 ff ff       	call   100d14 <__panic>

    assert(page_insert(boot_pgdir, p1, PGSIZE, 0) == 0);
  104cb6:	a1 c4 88 11 00       	mov    0x1188c4,%eax
  104cbb:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  104cc2:	00 
  104cc3:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
  104cca:	00 
  104ccb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  104cce:	89 54 24 04          	mov    %edx,0x4(%esp)
  104cd2:	89 04 24             	mov    %eax,(%esp)
  104cd5:	e8 df fa ff ff       	call   1047b9 <page_insert>
  104cda:	85 c0                	test   %eax,%eax
  104cdc:	74 24                	je     104d02 <check_pgdir+0x415>
  104cde:	c7 44 24 0c cc 6e 10 	movl   $0x106ecc,0xc(%esp)
  104ce5:	00 
  104ce6:	c7 44 24 08 a1 6c 10 	movl   $0x106ca1,0x8(%esp)
  104ced:	00 
  104cee:	c7 44 24 04 1f 02 00 	movl   $0x21f,0x4(%esp)
  104cf5:	00 
  104cf6:	c7 04 24 7c 6c 10 00 	movl   $0x106c7c,(%esp)
  104cfd:	e8 12 c0 ff ff       	call   100d14 <__panic>
    assert(page_ref(p1) == 2);
  104d02:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104d05:	89 04 24             	mov    %eax,(%esp)
  104d08:	e8 24 ef ff ff       	call   103c31 <page_ref>
  104d0d:	83 f8 02             	cmp    $0x2,%eax
  104d10:	74 24                	je     104d36 <check_pgdir+0x449>
  104d12:	c7 44 24 0c f8 6e 10 	movl   $0x106ef8,0xc(%esp)
  104d19:	00 
  104d1a:	c7 44 24 08 a1 6c 10 	movl   $0x106ca1,0x8(%esp)
  104d21:	00 
  104d22:	c7 44 24 04 20 02 00 	movl   $0x220,0x4(%esp)
  104d29:	00 
  104d2a:	c7 04 24 7c 6c 10 00 	movl   $0x106c7c,(%esp)
  104d31:	e8 de bf ff ff       	call   100d14 <__panic>
    assert(page_ref(p2) == 0);
  104d36:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  104d39:	89 04 24             	mov    %eax,(%esp)
  104d3c:	e8 f0 ee ff ff       	call   103c31 <page_ref>
  104d41:	85 c0                	test   %eax,%eax
  104d43:	74 24                	je     104d69 <check_pgdir+0x47c>
  104d45:	c7 44 24 0c 0a 6f 10 	movl   $0x106f0a,0xc(%esp)
  104d4c:	00 
  104d4d:	c7 44 24 08 a1 6c 10 	movl   $0x106ca1,0x8(%esp)
  104d54:	00 
  104d55:	c7 44 24 04 21 02 00 	movl   $0x221,0x4(%esp)
  104d5c:	00 
  104d5d:	c7 04 24 7c 6c 10 00 	movl   $0x106c7c,(%esp)
  104d64:	e8 ab bf ff ff       	call   100d14 <__panic>
    assert((ptep = get_pte(boot_pgdir, PGSIZE, 0)) != NULL);
  104d69:	a1 c4 88 11 00       	mov    0x1188c4,%eax
  104d6e:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  104d75:	00 
  104d76:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
  104d7d:	00 
  104d7e:	89 04 24             	mov    %eax,(%esp)
  104d81:	e8 ef f7 ff ff       	call   104575 <get_pte>
  104d86:	89 45 f0             	mov    %eax,-0x10(%ebp)
  104d89:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  104d8d:	75 24                	jne    104db3 <check_pgdir+0x4c6>
  104d8f:	c7 44 24 0c 58 6e 10 	movl   $0x106e58,0xc(%esp)
  104d96:	00 
  104d97:	c7 44 24 08 a1 6c 10 	movl   $0x106ca1,0x8(%esp)
  104d9e:	00 
  104d9f:	c7 44 24 04 22 02 00 	movl   $0x222,0x4(%esp)
  104da6:	00 
  104da7:	c7 04 24 7c 6c 10 00 	movl   $0x106c7c,(%esp)
  104dae:	e8 61 bf ff ff       	call   100d14 <__panic>
    assert(pa2page(*ptep) == p1);
  104db3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104db6:	8b 00                	mov    (%eax),%eax
  104db8:	89 04 24             	mov    %eax,(%esp)
  104dbb:	e8 90 ed ff ff       	call   103b50 <pa2page>
  104dc0:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  104dc3:	74 24                	je     104de9 <check_pgdir+0x4fc>
  104dc5:	c7 44 24 0c d1 6d 10 	movl   $0x106dd1,0xc(%esp)
  104dcc:	00 
  104dcd:	c7 44 24 08 a1 6c 10 	movl   $0x106ca1,0x8(%esp)
  104dd4:	00 
  104dd5:	c7 44 24 04 23 02 00 	movl   $0x223,0x4(%esp)
  104ddc:	00 
  104ddd:	c7 04 24 7c 6c 10 00 	movl   $0x106c7c,(%esp)
  104de4:	e8 2b bf ff ff       	call   100d14 <__panic>
    assert((*ptep & PTE_U) == 0);
  104de9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104dec:	8b 00                	mov    (%eax),%eax
  104dee:	83 e0 04             	and    $0x4,%eax
  104df1:	85 c0                	test   %eax,%eax
  104df3:	74 24                	je     104e19 <check_pgdir+0x52c>
  104df5:	c7 44 24 0c 1c 6f 10 	movl   $0x106f1c,0xc(%esp)
  104dfc:	00 
  104dfd:	c7 44 24 08 a1 6c 10 	movl   $0x106ca1,0x8(%esp)
  104e04:	00 
  104e05:	c7 44 24 04 24 02 00 	movl   $0x224,0x4(%esp)
  104e0c:	00 
  104e0d:	c7 04 24 7c 6c 10 00 	movl   $0x106c7c,(%esp)
  104e14:	e8 fb be ff ff       	call   100d14 <__panic>

    page_remove(boot_pgdir, 0x0);
  104e19:	a1 c4 88 11 00       	mov    0x1188c4,%eax
  104e1e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  104e25:	00 
  104e26:	89 04 24             	mov    %eax,(%esp)
  104e29:	e8 47 f9 ff ff       	call   104775 <page_remove>
    assert(page_ref(p1) == 1);
  104e2e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104e31:	89 04 24             	mov    %eax,(%esp)
  104e34:	e8 f8 ed ff ff       	call   103c31 <page_ref>
  104e39:	83 f8 01             	cmp    $0x1,%eax
  104e3c:	74 24                	je     104e62 <check_pgdir+0x575>
  104e3e:	c7 44 24 0c e6 6d 10 	movl   $0x106de6,0xc(%esp)
  104e45:	00 
  104e46:	c7 44 24 08 a1 6c 10 	movl   $0x106ca1,0x8(%esp)
  104e4d:	00 
  104e4e:	c7 44 24 04 27 02 00 	movl   $0x227,0x4(%esp)
  104e55:	00 
  104e56:	c7 04 24 7c 6c 10 00 	movl   $0x106c7c,(%esp)
  104e5d:	e8 b2 be ff ff       	call   100d14 <__panic>
    assert(page_ref(p2) == 0);
  104e62:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  104e65:	89 04 24             	mov    %eax,(%esp)
  104e68:	e8 c4 ed ff ff       	call   103c31 <page_ref>
  104e6d:	85 c0                	test   %eax,%eax
  104e6f:	74 24                	je     104e95 <check_pgdir+0x5a8>
  104e71:	c7 44 24 0c 0a 6f 10 	movl   $0x106f0a,0xc(%esp)
  104e78:	00 
  104e79:	c7 44 24 08 a1 6c 10 	movl   $0x106ca1,0x8(%esp)
  104e80:	00 
  104e81:	c7 44 24 04 28 02 00 	movl   $0x228,0x4(%esp)
  104e88:	00 
  104e89:	c7 04 24 7c 6c 10 00 	movl   $0x106c7c,(%esp)
  104e90:	e8 7f be ff ff       	call   100d14 <__panic>

    page_remove(boot_pgdir, PGSIZE);
  104e95:	a1 c4 88 11 00       	mov    0x1188c4,%eax
  104e9a:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
  104ea1:	00 
  104ea2:	89 04 24             	mov    %eax,(%esp)
  104ea5:	e8 cb f8 ff ff       	call   104775 <page_remove>
    assert(page_ref(p1) == 0);
  104eaa:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104ead:	89 04 24             	mov    %eax,(%esp)
  104eb0:	e8 7c ed ff ff       	call   103c31 <page_ref>
  104eb5:	85 c0                	test   %eax,%eax
  104eb7:	74 24                	je     104edd <check_pgdir+0x5f0>
  104eb9:	c7 44 24 0c 31 6f 10 	movl   $0x106f31,0xc(%esp)
  104ec0:	00 
  104ec1:	c7 44 24 08 a1 6c 10 	movl   $0x106ca1,0x8(%esp)
  104ec8:	00 
  104ec9:	c7 44 24 04 2b 02 00 	movl   $0x22b,0x4(%esp)
  104ed0:	00 
  104ed1:	c7 04 24 7c 6c 10 00 	movl   $0x106c7c,(%esp)
  104ed8:	e8 37 be ff ff       	call   100d14 <__panic>
    assert(page_ref(p2) == 0);
  104edd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  104ee0:	89 04 24             	mov    %eax,(%esp)
  104ee3:	e8 49 ed ff ff       	call   103c31 <page_ref>
  104ee8:	85 c0                	test   %eax,%eax
  104eea:	74 24                	je     104f10 <check_pgdir+0x623>
  104eec:	c7 44 24 0c 0a 6f 10 	movl   $0x106f0a,0xc(%esp)
  104ef3:	00 
  104ef4:	c7 44 24 08 a1 6c 10 	movl   $0x106ca1,0x8(%esp)
  104efb:	00 
  104efc:	c7 44 24 04 2c 02 00 	movl   $0x22c,0x4(%esp)
  104f03:	00 
  104f04:	c7 04 24 7c 6c 10 00 	movl   $0x106c7c,(%esp)
  104f0b:	e8 04 be ff ff       	call   100d14 <__panic>

    assert(page_ref(pa2page(boot_pgdir[0])) == 1);
  104f10:	a1 c4 88 11 00       	mov    0x1188c4,%eax
  104f15:	8b 00                	mov    (%eax),%eax
  104f17:	89 04 24             	mov    %eax,(%esp)
  104f1a:	e8 31 ec ff ff       	call   103b50 <pa2page>
  104f1f:	89 04 24             	mov    %eax,(%esp)
  104f22:	e8 0a ed ff ff       	call   103c31 <page_ref>
  104f27:	83 f8 01             	cmp    $0x1,%eax
  104f2a:	74 24                	je     104f50 <check_pgdir+0x663>
  104f2c:	c7 44 24 0c 44 6f 10 	movl   $0x106f44,0xc(%esp)
  104f33:	00 
  104f34:	c7 44 24 08 a1 6c 10 	movl   $0x106ca1,0x8(%esp)
  104f3b:	00 
  104f3c:	c7 44 24 04 2e 02 00 	movl   $0x22e,0x4(%esp)
  104f43:	00 
  104f44:	c7 04 24 7c 6c 10 00 	movl   $0x106c7c,(%esp)
  104f4b:	e8 c4 bd ff ff       	call   100d14 <__panic>
    free_page(pa2page(boot_pgdir[0]));
  104f50:	a1 c4 88 11 00       	mov    0x1188c4,%eax
  104f55:	8b 00                	mov    (%eax),%eax
  104f57:	89 04 24             	mov    %eax,(%esp)
  104f5a:	e8 f1 eb ff ff       	call   103b50 <pa2page>
  104f5f:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  104f66:	00 
  104f67:	89 04 24             	mov    %eax,(%esp)
  104f6a:	e8 ff ee ff ff       	call   103e6e <free_pages>
    boot_pgdir[0] = 0;
  104f6f:	a1 c4 88 11 00       	mov    0x1188c4,%eax
  104f74:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

    cprintf("check_pgdir() succeeded!\n");
  104f7a:	c7 04 24 6a 6f 10 00 	movl   $0x106f6a,(%esp)
  104f81:	e8 c6 b3 ff ff       	call   10034c <cprintf>
}
  104f86:	c9                   	leave  
  104f87:	c3                   	ret    

00104f88 <check_boot_pgdir>:

static void
check_boot_pgdir(void) {
  104f88:	55                   	push   %ebp
  104f89:	89 e5                	mov    %esp,%ebp
  104f8b:	83 ec 38             	sub    $0x38,%esp
    pte_t *ptep;
    int i;
    for (i = 0; i < npage; i += PGSIZE) {
  104f8e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  104f95:	e9 ca 00 00 00       	jmp    105064 <check_boot_pgdir+0xdc>
        assert((ptep = get_pte(boot_pgdir, (uintptr_t)KADDR(i), 0)) != NULL);
  104f9a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104f9d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  104fa0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104fa3:	c1 e8 0c             	shr    $0xc,%eax
  104fa6:	89 45 ec             	mov    %eax,-0x14(%ebp)
  104fa9:	a1 c0 88 11 00       	mov    0x1188c0,%eax
  104fae:	39 45 ec             	cmp    %eax,-0x14(%ebp)
  104fb1:	72 23                	jb     104fd6 <check_boot_pgdir+0x4e>
  104fb3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104fb6:	89 44 24 0c          	mov    %eax,0xc(%esp)
  104fba:	c7 44 24 08 b4 6b 10 	movl   $0x106bb4,0x8(%esp)
  104fc1:	00 
  104fc2:	c7 44 24 04 3a 02 00 	movl   $0x23a,0x4(%esp)
  104fc9:	00 
  104fca:	c7 04 24 7c 6c 10 00 	movl   $0x106c7c,(%esp)
  104fd1:	e8 3e bd ff ff       	call   100d14 <__panic>
  104fd6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104fd9:	2d 00 00 00 40       	sub    $0x40000000,%eax
  104fde:	89 c2                	mov    %eax,%edx
  104fe0:	a1 c4 88 11 00       	mov    0x1188c4,%eax
  104fe5:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  104fec:	00 
  104fed:	89 54 24 04          	mov    %edx,0x4(%esp)
  104ff1:	89 04 24             	mov    %eax,(%esp)
  104ff4:	e8 7c f5 ff ff       	call   104575 <get_pte>
  104ff9:	89 45 e8             	mov    %eax,-0x18(%ebp)
  104ffc:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  105000:	75 24                	jne    105026 <check_boot_pgdir+0x9e>
  105002:	c7 44 24 0c 84 6f 10 	movl   $0x106f84,0xc(%esp)
  105009:	00 
  10500a:	c7 44 24 08 a1 6c 10 	movl   $0x106ca1,0x8(%esp)
  105011:	00 
  105012:	c7 44 24 04 3a 02 00 	movl   $0x23a,0x4(%esp)
  105019:	00 
  10501a:	c7 04 24 7c 6c 10 00 	movl   $0x106c7c,(%esp)
  105021:	e8 ee bc ff ff       	call   100d14 <__panic>
        assert(PTE_ADDR(*ptep) == i);
  105026:	8b 45 e8             	mov    -0x18(%ebp),%eax
  105029:	8b 00                	mov    (%eax),%eax
  10502b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  105030:	89 c2                	mov    %eax,%edx
  105032:	8b 45 f4             	mov    -0xc(%ebp),%eax
  105035:	39 c2                	cmp    %eax,%edx
  105037:	74 24                	je     10505d <check_boot_pgdir+0xd5>
  105039:	c7 44 24 0c c1 6f 10 	movl   $0x106fc1,0xc(%esp)
  105040:	00 
  105041:	c7 44 24 08 a1 6c 10 	movl   $0x106ca1,0x8(%esp)
  105048:	00 
  105049:	c7 44 24 04 3b 02 00 	movl   $0x23b,0x4(%esp)
  105050:	00 
  105051:	c7 04 24 7c 6c 10 00 	movl   $0x106c7c,(%esp)
  105058:	e8 b7 bc ff ff       	call   100d14 <__panic>

static void
check_boot_pgdir(void) {
    pte_t *ptep;
    int i;
    for (i = 0; i < npage; i += PGSIZE) {
  10505d:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
  105064:	8b 55 f4             	mov    -0xc(%ebp),%edx
  105067:	a1 c0 88 11 00       	mov    0x1188c0,%eax
  10506c:	39 c2                	cmp    %eax,%edx
  10506e:	0f 82 26 ff ff ff    	jb     104f9a <check_boot_pgdir+0x12>
        assert((ptep = get_pte(boot_pgdir, (uintptr_t)KADDR(i), 0)) != NULL);
        assert(PTE_ADDR(*ptep) == i);
    }

    assert(PDE_ADDR(boot_pgdir[PDX(VPT)]) == PADDR(boot_pgdir));
  105074:	a1 c4 88 11 00       	mov    0x1188c4,%eax
  105079:	05 ac 0f 00 00       	add    $0xfac,%eax
  10507e:	8b 00                	mov    (%eax),%eax
  105080:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  105085:	89 c2                	mov    %eax,%edx
  105087:	a1 c4 88 11 00       	mov    0x1188c4,%eax
  10508c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  10508f:	81 7d e4 ff ff ff bf 	cmpl   $0xbfffffff,-0x1c(%ebp)
  105096:	77 23                	ja     1050bb <check_boot_pgdir+0x133>
  105098:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  10509b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  10509f:	c7 44 24 08 58 6c 10 	movl   $0x106c58,0x8(%esp)
  1050a6:	00 
  1050a7:	c7 44 24 04 3e 02 00 	movl   $0x23e,0x4(%esp)
  1050ae:	00 
  1050af:	c7 04 24 7c 6c 10 00 	movl   $0x106c7c,(%esp)
  1050b6:	e8 59 bc ff ff       	call   100d14 <__panic>
  1050bb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1050be:	05 00 00 00 40       	add    $0x40000000,%eax
  1050c3:	39 c2                	cmp    %eax,%edx
  1050c5:	74 24                	je     1050eb <check_boot_pgdir+0x163>
  1050c7:	c7 44 24 0c d8 6f 10 	movl   $0x106fd8,0xc(%esp)
  1050ce:	00 
  1050cf:	c7 44 24 08 a1 6c 10 	movl   $0x106ca1,0x8(%esp)
  1050d6:	00 
  1050d7:	c7 44 24 04 3e 02 00 	movl   $0x23e,0x4(%esp)
  1050de:	00 
  1050df:	c7 04 24 7c 6c 10 00 	movl   $0x106c7c,(%esp)
  1050e6:	e8 29 bc ff ff       	call   100d14 <__panic>

    assert(boot_pgdir[0] == 0);
  1050eb:	a1 c4 88 11 00       	mov    0x1188c4,%eax
  1050f0:	8b 00                	mov    (%eax),%eax
  1050f2:	85 c0                	test   %eax,%eax
  1050f4:	74 24                	je     10511a <check_boot_pgdir+0x192>
  1050f6:	c7 44 24 0c 0c 70 10 	movl   $0x10700c,0xc(%esp)
  1050fd:	00 
  1050fe:	c7 44 24 08 a1 6c 10 	movl   $0x106ca1,0x8(%esp)
  105105:	00 
  105106:	c7 44 24 04 40 02 00 	movl   $0x240,0x4(%esp)
  10510d:	00 
  10510e:	c7 04 24 7c 6c 10 00 	movl   $0x106c7c,(%esp)
  105115:	e8 fa bb ff ff       	call   100d14 <__panic>

    struct Page *p;
    p = alloc_page();
  10511a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  105121:	e8 10 ed ff ff       	call   103e36 <alloc_pages>
  105126:	89 45 e0             	mov    %eax,-0x20(%ebp)
    assert(page_insert(boot_pgdir, p, 0x100, PTE_W) == 0);
  105129:	a1 c4 88 11 00       	mov    0x1188c4,%eax
  10512e:	c7 44 24 0c 02 00 00 	movl   $0x2,0xc(%esp)
  105135:	00 
  105136:	c7 44 24 08 00 01 00 	movl   $0x100,0x8(%esp)
  10513d:	00 
  10513e:	8b 55 e0             	mov    -0x20(%ebp),%edx
  105141:	89 54 24 04          	mov    %edx,0x4(%esp)
  105145:	89 04 24             	mov    %eax,(%esp)
  105148:	e8 6c f6 ff ff       	call   1047b9 <page_insert>
  10514d:	85 c0                	test   %eax,%eax
  10514f:	74 24                	je     105175 <check_boot_pgdir+0x1ed>
  105151:	c7 44 24 0c 20 70 10 	movl   $0x107020,0xc(%esp)
  105158:	00 
  105159:	c7 44 24 08 a1 6c 10 	movl   $0x106ca1,0x8(%esp)
  105160:	00 
  105161:	c7 44 24 04 44 02 00 	movl   $0x244,0x4(%esp)
  105168:	00 
  105169:	c7 04 24 7c 6c 10 00 	movl   $0x106c7c,(%esp)
  105170:	e8 9f bb ff ff       	call   100d14 <__panic>
    assert(page_ref(p) == 1);
  105175:	8b 45 e0             	mov    -0x20(%ebp),%eax
  105178:	89 04 24             	mov    %eax,(%esp)
  10517b:	e8 b1 ea ff ff       	call   103c31 <page_ref>
  105180:	83 f8 01             	cmp    $0x1,%eax
  105183:	74 24                	je     1051a9 <check_boot_pgdir+0x221>
  105185:	c7 44 24 0c 4e 70 10 	movl   $0x10704e,0xc(%esp)
  10518c:	00 
  10518d:	c7 44 24 08 a1 6c 10 	movl   $0x106ca1,0x8(%esp)
  105194:	00 
  105195:	c7 44 24 04 45 02 00 	movl   $0x245,0x4(%esp)
  10519c:	00 
  10519d:	c7 04 24 7c 6c 10 00 	movl   $0x106c7c,(%esp)
  1051a4:	e8 6b bb ff ff       	call   100d14 <__panic>
    assert(page_insert(boot_pgdir, p, 0x100 + PGSIZE, PTE_W) == 0);
  1051a9:	a1 c4 88 11 00       	mov    0x1188c4,%eax
  1051ae:	c7 44 24 0c 02 00 00 	movl   $0x2,0xc(%esp)
  1051b5:	00 
  1051b6:	c7 44 24 08 00 11 00 	movl   $0x1100,0x8(%esp)
  1051bd:	00 
  1051be:	8b 55 e0             	mov    -0x20(%ebp),%edx
  1051c1:	89 54 24 04          	mov    %edx,0x4(%esp)
  1051c5:	89 04 24             	mov    %eax,(%esp)
  1051c8:	e8 ec f5 ff ff       	call   1047b9 <page_insert>
  1051cd:	85 c0                	test   %eax,%eax
  1051cf:	74 24                	je     1051f5 <check_boot_pgdir+0x26d>
  1051d1:	c7 44 24 0c 60 70 10 	movl   $0x107060,0xc(%esp)
  1051d8:	00 
  1051d9:	c7 44 24 08 a1 6c 10 	movl   $0x106ca1,0x8(%esp)
  1051e0:	00 
  1051e1:	c7 44 24 04 46 02 00 	movl   $0x246,0x4(%esp)
  1051e8:	00 
  1051e9:	c7 04 24 7c 6c 10 00 	movl   $0x106c7c,(%esp)
  1051f0:	e8 1f bb ff ff       	call   100d14 <__panic>
    assert(page_ref(p) == 2);
  1051f5:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1051f8:	89 04 24             	mov    %eax,(%esp)
  1051fb:	e8 31 ea ff ff       	call   103c31 <page_ref>
  105200:	83 f8 02             	cmp    $0x2,%eax
  105203:	74 24                	je     105229 <check_boot_pgdir+0x2a1>
  105205:	c7 44 24 0c 97 70 10 	movl   $0x107097,0xc(%esp)
  10520c:	00 
  10520d:	c7 44 24 08 a1 6c 10 	movl   $0x106ca1,0x8(%esp)
  105214:	00 
  105215:	c7 44 24 04 47 02 00 	movl   $0x247,0x4(%esp)
  10521c:	00 
  10521d:	c7 04 24 7c 6c 10 00 	movl   $0x106c7c,(%esp)
  105224:	e8 eb ba ff ff       	call   100d14 <__panic>

    const char *str = "ucore: Hello world!!";
  105229:	c7 45 dc a8 70 10 00 	movl   $0x1070a8,-0x24(%ebp)
    strcpy((void *)0x100, str);
  105230:	8b 45 dc             	mov    -0x24(%ebp),%eax
  105233:	89 44 24 04          	mov    %eax,0x4(%esp)
  105237:	c7 04 24 00 01 00 00 	movl   $0x100,(%esp)
  10523e:	e8 1e 0a 00 00       	call   105c61 <strcpy>
    assert(strcmp((void *)0x100, (void *)(0x100 + PGSIZE)) == 0);
  105243:	c7 44 24 04 00 11 00 	movl   $0x1100,0x4(%esp)
  10524a:	00 
  10524b:	c7 04 24 00 01 00 00 	movl   $0x100,(%esp)
  105252:	e8 83 0a 00 00       	call   105cda <strcmp>
  105257:	85 c0                	test   %eax,%eax
  105259:	74 24                	je     10527f <check_boot_pgdir+0x2f7>
  10525b:	c7 44 24 0c c0 70 10 	movl   $0x1070c0,0xc(%esp)
  105262:	00 
  105263:	c7 44 24 08 a1 6c 10 	movl   $0x106ca1,0x8(%esp)
  10526a:	00 
  10526b:	c7 44 24 04 4b 02 00 	movl   $0x24b,0x4(%esp)
  105272:	00 
  105273:	c7 04 24 7c 6c 10 00 	movl   $0x106c7c,(%esp)
  10527a:	e8 95 ba ff ff       	call   100d14 <__panic>

    *(char *)(page2kva(p) + 0x100) = '\0';
  10527f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  105282:	89 04 24             	mov    %eax,(%esp)
  105285:	e8 15 e9 ff ff       	call   103b9f <page2kva>
  10528a:	05 00 01 00 00       	add    $0x100,%eax
  10528f:	c6 00 00             	movb   $0x0,(%eax)
    assert(strlen((const char *)0x100) == 0);
  105292:	c7 04 24 00 01 00 00 	movl   $0x100,(%esp)
  105299:	e8 6b 09 00 00       	call   105c09 <strlen>
  10529e:	85 c0                	test   %eax,%eax
  1052a0:	74 24                	je     1052c6 <check_boot_pgdir+0x33e>
  1052a2:	c7 44 24 0c f8 70 10 	movl   $0x1070f8,0xc(%esp)
  1052a9:	00 
  1052aa:	c7 44 24 08 a1 6c 10 	movl   $0x106ca1,0x8(%esp)
  1052b1:	00 
  1052b2:	c7 44 24 04 4e 02 00 	movl   $0x24e,0x4(%esp)
  1052b9:	00 
  1052ba:	c7 04 24 7c 6c 10 00 	movl   $0x106c7c,(%esp)
  1052c1:	e8 4e ba ff ff       	call   100d14 <__panic>

    free_page(p);
  1052c6:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  1052cd:	00 
  1052ce:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1052d1:	89 04 24             	mov    %eax,(%esp)
  1052d4:	e8 95 eb ff ff       	call   103e6e <free_pages>
    free_page(pa2page(PDE_ADDR(boot_pgdir[0])));
  1052d9:	a1 c4 88 11 00       	mov    0x1188c4,%eax
  1052de:	8b 00                	mov    (%eax),%eax
  1052e0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  1052e5:	89 04 24             	mov    %eax,(%esp)
  1052e8:	e8 63 e8 ff ff       	call   103b50 <pa2page>
  1052ed:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  1052f4:	00 
  1052f5:	89 04 24             	mov    %eax,(%esp)
  1052f8:	e8 71 eb ff ff       	call   103e6e <free_pages>
    boot_pgdir[0] = 0;
  1052fd:	a1 c4 88 11 00       	mov    0x1188c4,%eax
  105302:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

    cprintf("check_boot_pgdir() succeeded!\n");
  105308:	c7 04 24 1c 71 10 00 	movl   $0x10711c,(%esp)
  10530f:	e8 38 b0 ff ff       	call   10034c <cprintf>
}
  105314:	c9                   	leave  
  105315:	c3                   	ret    

00105316 <perm2str>:

//perm2str - use string 'u,r,w,-' to present the permission
static const char *
perm2str(int perm) {
  105316:	55                   	push   %ebp
  105317:	89 e5                	mov    %esp,%ebp
    static char str[4];
    str[0] = (perm & PTE_U) ? 'u' : '-';
  105319:	8b 45 08             	mov    0x8(%ebp),%eax
  10531c:	83 e0 04             	and    $0x4,%eax
  10531f:	85 c0                	test   %eax,%eax
  105321:	74 07                	je     10532a <perm2str+0x14>
  105323:	b8 75 00 00 00       	mov    $0x75,%eax
  105328:	eb 05                	jmp    10532f <perm2str+0x19>
  10532a:	b8 2d 00 00 00       	mov    $0x2d,%eax
  10532f:	a2 48 89 11 00       	mov    %al,0x118948
    str[1] = 'r';
  105334:	c6 05 49 89 11 00 72 	movb   $0x72,0x118949
    str[2] = (perm & PTE_W) ? 'w' : '-';
  10533b:	8b 45 08             	mov    0x8(%ebp),%eax
  10533e:	83 e0 02             	and    $0x2,%eax
  105341:	85 c0                	test   %eax,%eax
  105343:	74 07                	je     10534c <perm2str+0x36>
  105345:	b8 77 00 00 00       	mov    $0x77,%eax
  10534a:	eb 05                	jmp    105351 <perm2str+0x3b>
  10534c:	b8 2d 00 00 00       	mov    $0x2d,%eax
  105351:	a2 4a 89 11 00       	mov    %al,0x11894a
    str[3] = '\0';
  105356:	c6 05 4b 89 11 00 00 	movb   $0x0,0x11894b
    return str;
  10535d:	b8 48 89 11 00       	mov    $0x118948,%eax
}
  105362:	5d                   	pop    %ebp
  105363:	c3                   	ret    

00105364 <get_pgtable_items>:
//  table:       the beginning addr of table
//  left_store:  the pointer of the high side of table's next range
//  right_store: the pointer of the low side of table's next range
// return value: 0 - not a invalid item range, perm - a valid item range with perm permission 
static int
get_pgtable_items(size_t left, size_t right, size_t start, uintptr_t *table, size_t *left_store, size_t *right_store) {
  105364:	55                   	push   %ebp
  105365:	89 e5                	mov    %esp,%ebp
  105367:	83 ec 10             	sub    $0x10,%esp
    if (start >= right) {
  10536a:	8b 45 10             	mov    0x10(%ebp),%eax
  10536d:	3b 45 0c             	cmp    0xc(%ebp),%eax
  105370:	72 0a                	jb     10537c <get_pgtable_items+0x18>
        return 0;
  105372:	b8 00 00 00 00       	mov    $0x0,%eax
  105377:	e9 9c 00 00 00       	jmp    105418 <get_pgtable_items+0xb4>
    }
    while (start < right && !(table[start] & PTE_P)) {
  10537c:	eb 04                	jmp    105382 <get_pgtable_items+0x1e>
        start ++;
  10537e:	83 45 10 01          	addl   $0x1,0x10(%ebp)
static int
get_pgtable_items(size_t left, size_t right, size_t start, uintptr_t *table, size_t *left_store, size_t *right_store) {
    if (start >= right) {
        return 0;
    }
    while (start < right && !(table[start] & PTE_P)) {
  105382:	8b 45 10             	mov    0x10(%ebp),%eax
  105385:	3b 45 0c             	cmp    0xc(%ebp),%eax
  105388:	73 18                	jae    1053a2 <get_pgtable_items+0x3e>
  10538a:	8b 45 10             	mov    0x10(%ebp),%eax
  10538d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  105394:	8b 45 14             	mov    0x14(%ebp),%eax
  105397:	01 d0                	add    %edx,%eax
  105399:	8b 00                	mov    (%eax),%eax
  10539b:	83 e0 01             	and    $0x1,%eax
  10539e:	85 c0                	test   %eax,%eax
  1053a0:	74 dc                	je     10537e <get_pgtable_items+0x1a>
        start ++;
    }
    if (start < right) {
  1053a2:	8b 45 10             	mov    0x10(%ebp),%eax
  1053a5:	3b 45 0c             	cmp    0xc(%ebp),%eax
  1053a8:	73 69                	jae    105413 <get_pgtable_items+0xaf>
        if (left_store != NULL) {
  1053aa:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
  1053ae:	74 08                	je     1053b8 <get_pgtable_items+0x54>
            *left_store = start;
  1053b0:	8b 45 18             	mov    0x18(%ebp),%eax
  1053b3:	8b 55 10             	mov    0x10(%ebp),%edx
  1053b6:	89 10                	mov    %edx,(%eax)
        }
        int perm = (table[start ++] & PTE_USER);
  1053b8:	8b 45 10             	mov    0x10(%ebp),%eax
  1053bb:	8d 50 01             	lea    0x1(%eax),%edx
  1053be:	89 55 10             	mov    %edx,0x10(%ebp)
  1053c1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  1053c8:	8b 45 14             	mov    0x14(%ebp),%eax
  1053cb:	01 d0                	add    %edx,%eax
  1053cd:	8b 00                	mov    (%eax),%eax
  1053cf:	83 e0 07             	and    $0x7,%eax
  1053d2:	89 45 fc             	mov    %eax,-0x4(%ebp)
        while (start < right && (table[start] & PTE_USER) == perm) {
  1053d5:	eb 04                	jmp    1053db <get_pgtable_items+0x77>
            start ++;
  1053d7:	83 45 10 01          	addl   $0x1,0x10(%ebp)
    if (start < right) {
        if (left_store != NULL) {
            *left_store = start;
        }
        int perm = (table[start ++] & PTE_USER);
        while (start < right && (table[start] & PTE_USER) == perm) {
  1053db:	8b 45 10             	mov    0x10(%ebp),%eax
  1053de:	3b 45 0c             	cmp    0xc(%ebp),%eax
  1053e1:	73 1d                	jae    105400 <get_pgtable_items+0x9c>
  1053e3:	8b 45 10             	mov    0x10(%ebp),%eax
  1053e6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  1053ed:	8b 45 14             	mov    0x14(%ebp),%eax
  1053f0:	01 d0                	add    %edx,%eax
  1053f2:	8b 00                	mov    (%eax),%eax
  1053f4:	83 e0 07             	and    $0x7,%eax
  1053f7:	89 c2                	mov    %eax,%edx
  1053f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1053fc:	39 c2                	cmp    %eax,%edx
  1053fe:	74 d7                	je     1053d7 <get_pgtable_items+0x73>
            start ++;
        }
        if (right_store != NULL) {
  105400:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  105404:	74 08                	je     10540e <get_pgtable_items+0xaa>
            *right_store = start;
  105406:	8b 45 1c             	mov    0x1c(%ebp),%eax
  105409:	8b 55 10             	mov    0x10(%ebp),%edx
  10540c:	89 10                	mov    %edx,(%eax)
        }
        return perm;
  10540e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  105411:	eb 05                	jmp    105418 <get_pgtable_items+0xb4>
    }
    return 0;
  105413:	b8 00 00 00 00       	mov    $0x0,%eax
}
  105418:	c9                   	leave  
  105419:	c3                   	ret    

0010541a <print_pgdir>:

//print_pgdir - print the PDT&PT
void
print_pgdir(void) {
  10541a:	55                   	push   %ebp
  10541b:	89 e5                	mov    %esp,%ebp
  10541d:	57                   	push   %edi
  10541e:	56                   	push   %esi
  10541f:	53                   	push   %ebx
  105420:	83 ec 4c             	sub    $0x4c,%esp
    cprintf("-------------------- BEGIN --------------------\n");
  105423:	c7 04 24 3c 71 10 00 	movl   $0x10713c,(%esp)
  10542a:	e8 1d af ff ff       	call   10034c <cprintf>
    size_t left, right = 0, perm;
  10542f:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    while ((perm = get_pgtable_items(0, NPDEENTRY, right, vpd, &left, &right)) != 0) {
  105436:	e9 fa 00 00 00       	jmp    105535 <print_pgdir+0x11b>
        cprintf("PDE(%03x) %08x-%08x %08x %s\n", right - left,
  10543b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  10543e:	89 04 24             	mov    %eax,(%esp)
  105441:	e8 d0 fe ff ff       	call   105316 <perm2str>
                left * PTSIZE, right * PTSIZE, (right - left) * PTSIZE, perm2str(perm));
  105446:	8b 4d dc             	mov    -0x24(%ebp),%ecx
  105449:	8b 55 e0             	mov    -0x20(%ebp),%edx
  10544c:	29 d1                	sub    %edx,%ecx
  10544e:	89 ca                	mov    %ecx,%edx
void
print_pgdir(void) {
    cprintf("-------------------- BEGIN --------------------\n");
    size_t left, right = 0, perm;
    while ((perm = get_pgtable_items(0, NPDEENTRY, right, vpd, &left, &right)) != 0) {
        cprintf("PDE(%03x) %08x-%08x %08x %s\n", right - left,
  105450:	89 d6                	mov    %edx,%esi
  105452:	c1 e6 16             	shl    $0x16,%esi
  105455:	8b 55 dc             	mov    -0x24(%ebp),%edx
  105458:	89 d3                	mov    %edx,%ebx
  10545a:	c1 e3 16             	shl    $0x16,%ebx
  10545d:	8b 55 e0             	mov    -0x20(%ebp),%edx
  105460:	89 d1                	mov    %edx,%ecx
  105462:	c1 e1 16             	shl    $0x16,%ecx
  105465:	8b 7d dc             	mov    -0x24(%ebp),%edi
  105468:	8b 55 e0             	mov    -0x20(%ebp),%edx
  10546b:	29 d7                	sub    %edx,%edi
  10546d:	89 fa                	mov    %edi,%edx
  10546f:	89 44 24 14          	mov    %eax,0x14(%esp)
  105473:	89 74 24 10          	mov    %esi,0x10(%esp)
  105477:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
  10547b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  10547f:	89 54 24 04          	mov    %edx,0x4(%esp)
  105483:	c7 04 24 6d 71 10 00 	movl   $0x10716d,(%esp)
  10548a:	e8 bd ae ff ff       	call   10034c <cprintf>
                left * PTSIZE, right * PTSIZE, (right - left) * PTSIZE, perm2str(perm));
        size_t l, r = left * NPTEENTRY;
  10548f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  105492:	c1 e0 0a             	shl    $0xa,%eax
  105495:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        while ((perm = get_pgtable_items(left * NPTEENTRY, right * NPTEENTRY, r, vpt, &l, &r)) != 0) {
  105498:	eb 54                	jmp    1054ee <print_pgdir+0xd4>
            cprintf("  |-- PTE(%05x) %08x-%08x %08x %s\n", r - l,
  10549a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  10549d:	89 04 24             	mov    %eax,(%esp)
  1054a0:	e8 71 fe ff ff       	call   105316 <perm2str>
                    l * PGSIZE, r * PGSIZE, (r - l) * PGSIZE, perm2str(perm));
  1054a5:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
  1054a8:	8b 55 d8             	mov    -0x28(%ebp),%edx
  1054ab:	29 d1                	sub    %edx,%ecx
  1054ad:	89 ca                	mov    %ecx,%edx
    while ((perm = get_pgtable_items(0, NPDEENTRY, right, vpd, &left, &right)) != 0) {
        cprintf("PDE(%03x) %08x-%08x %08x %s\n", right - left,
                left * PTSIZE, right * PTSIZE, (right - left) * PTSIZE, perm2str(perm));
        size_t l, r = left * NPTEENTRY;
        while ((perm = get_pgtable_items(left * NPTEENTRY, right * NPTEENTRY, r, vpt, &l, &r)) != 0) {
            cprintf("  |-- PTE(%05x) %08x-%08x %08x %s\n", r - l,
  1054af:	89 d6                	mov    %edx,%esi
  1054b1:	c1 e6 0c             	shl    $0xc,%esi
  1054b4:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  1054b7:	89 d3                	mov    %edx,%ebx
  1054b9:	c1 e3 0c             	shl    $0xc,%ebx
  1054bc:	8b 55 d8             	mov    -0x28(%ebp),%edx
  1054bf:	c1 e2 0c             	shl    $0xc,%edx
  1054c2:	89 d1                	mov    %edx,%ecx
  1054c4:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  1054c7:	8b 55 d8             	mov    -0x28(%ebp),%edx
  1054ca:	29 d7                	sub    %edx,%edi
  1054cc:	89 fa                	mov    %edi,%edx
  1054ce:	89 44 24 14          	mov    %eax,0x14(%esp)
  1054d2:	89 74 24 10          	mov    %esi,0x10(%esp)
  1054d6:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
  1054da:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  1054de:	89 54 24 04          	mov    %edx,0x4(%esp)
  1054e2:	c7 04 24 8c 71 10 00 	movl   $0x10718c,(%esp)
  1054e9:	e8 5e ae ff ff       	call   10034c <cprintf>
    size_t left, right = 0, perm;
    while ((perm = get_pgtable_items(0, NPDEENTRY, right, vpd, &left, &right)) != 0) {
        cprintf("PDE(%03x) %08x-%08x %08x %s\n", right - left,
                left * PTSIZE, right * PTSIZE, (right - left) * PTSIZE, perm2str(perm));
        size_t l, r = left * NPTEENTRY;
        while ((perm = get_pgtable_items(left * NPTEENTRY, right * NPTEENTRY, r, vpt, &l, &r)) != 0) {
  1054ee:	ba 00 00 c0 fa       	mov    $0xfac00000,%edx
  1054f3:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1054f6:	8b 4d dc             	mov    -0x24(%ebp),%ecx
  1054f9:	89 ce                	mov    %ecx,%esi
  1054fb:	c1 e6 0a             	shl    $0xa,%esi
  1054fe:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  105501:	89 cb                	mov    %ecx,%ebx
  105503:	c1 e3 0a             	shl    $0xa,%ebx
  105506:	8d 4d d4             	lea    -0x2c(%ebp),%ecx
  105509:	89 4c 24 14          	mov    %ecx,0x14(%esp)
  10550d:	8d 4d d8             	lea    -0x28(%ebp),%ecx
  105510:	89 4c 24 10          	mov    %ecx,0x10(%esp)
  105514:	89 54 24 0c          	mov    %edx,0xc(%esp)
  105518:	89 44 24 08          	mov    %eax,0x8(%esp)
  10551c:	89 74 24 04          	mov    %esi,0x4(%esp)
  105520:	89 1c 24             	mov    %ebx,(%esp)
  105523:	e8 3c fe ff ff       	call   105364 <get_pgtable_items>
  105528:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  10552b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  10552f:	0f 85 65 ff ff ff    	jne    10549a <print_pgdir+0x80>
//print_pgdir - print the PDT&PT
void
print_pgdir(void) {
    cprintf("-------------------- BEGIN --------------------\n");
    size_t left, right = 0, perm;
    while ((perm = get_pgtable_items(0, NPDEENTRY, right, vpd, &left, &right)) != 0) {
  105535:	ba 00 b0 fe fa       	mov    $0xfafeb000,%edx
  10553a:	8b 45 dc             	mov    -0x24(%ebp),%eax
  10553d:	8d 4d dc             	lea    -0x24(%ebp),%ecx
  105540:	89 4c 24 14          	mov    %ecx,0x14(%esp)
  105544:	8d 4d e0             	lea    -0x20(%ebp),%ecx
  105547:	89 4c 24 10          	mov    %ecx,0x10(%esp)
  10554b:	89 54 24 0c          	mov    %edx,0xc(%esp)
  10554f:	89 44 24 08          	mov    %eax,0x8(%esp)
  105553:	c7 44 24 04 00 04 00 	movl   $0x400,0x4(%esp)
  10555a:	00 
  10555b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  105562:	e8 fd fd ff ff       	call   105364 <get_pgtable_items>
  105567:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  10556a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  10556e:	0f 85 c7 fe ff ff    	jne    10543b <print_pgdir+0x21>
        while ((perm = get_pgtable_items(left * NPTEENTRY, right * NPTEENTRY, r, vpt, &l, &r)) != 0) {
            cprintf("  |-- PTE(%05x) %08x-%08x %08x %s\n", r - l,
                    l * PGSIZE, r * PGSIZE, (r - l) * PGSIZE, perm2str(perm));
        }
    }
    cprintf("--------------------- END ---------------------\n");
  105574:	c7 04 24 b0 71 10 00 	movl   $0x1071b0,(%esp)
  10557b:	e8 cc ad ff ff       	call   10034c <cprintf>
}
  105580:	83 c4 4c             	add    $0x4c,%esp
  105583:	5b                   	pop    %ebx
  105584:	5e                   	pop    %esi
  105585:	5f                   	pop    %edi
  105586:	5d                   	pop    %ebp
  105587:	c3                   	ret    

00105588 <printnum>:
 * @width:      maximum number of digits, if the actual width is less than @width, use @padc instead
 * @padc:       character that padded on the left if the actual width is less than @width
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
  105588:	55                   	push   %ebp
  105589:	89 e5                	mov    %esp,%ebp
  10558b:	83 ec 58             	sub    $0x58,%esp
  10558e:	8b 45 10             	mov    0x10(%ebp),%eax
  105591:	89 45 d0             	mov    %eax,-0x30(%ebp)
  105594:	8b 45 14             	mov    0x14(%ebp),%eax
  105597:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    unsigned long long result = num;
  10559a:	8b 45 d0             	mov    -0x30(%ebp),%eax
  10559d:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  1055a0:	89 45 e8             	mov    %eax,-0x18(%ebp)
  1055a3:	89 55 ec             	mov    %edx,-0x14(%ebp)
    unsigned mod = do_div(result, base);
  1055a6:	8b 45 18             	mov    0x18(%ebp),%eax
  1055a9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  1055ac:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1055af:	8b 55 ec             	mov    -0x14(%ebp),%edx
  1055b2:	89 45 e0             	mov    %eax,-0x20(%ebp)
  1055b5:	89 55 f0             	mov    %edx,-0x10(%ebp)
  1055b8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1055bb:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1055be:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  1055c2:	74 1c                	je     1055e0 <printnum+0x58>
  1055c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1055c7:	ba 00 00 00 00       	mov    $0x0,%edx
  1055cc:	f7 75 e4             	divl   -0x1c(%ebp)
  1055cf:	89 55 f4             	mov    %edx,-0xc(%ebp)
  1055d2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1055d5:	ba 00 00 00 00       	mov    $0x0,%edx
  1055da:	f7 75 e4             	divl   -0x1c(%ebp)
  1055dd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1055e0:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1055e3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1055e6:	f7 75 e4             	divl   -0x1c(%ebp)
  1055e9:	89 45 e0             	mov    %eax,-0x20(%ebp)
  1055ec:	89 55 dc             	mov    %edx,-0x24(%ebp)
  1055ef:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1055f2:	8b 55 f0             	mov    -0x10(%ebp),%edx
  1055f5:	89 45 e8             	mov    %eax,-0x18(%ebp)
  1055f8:	89 55 ec             	mov    %edx,-0x14(%ebp)
  1055fb:	8b 45 dc             	mov    -0x24(%ebp),%eax
  1055fe:	89 45 d8             	mov    %eax,-0x28(%ebp)

    // first recursively print all preceding (more significant) digits
    if (num >= base) {
  105601:	8b 45 18             	mov    0x18(%ebp),%eax
  105604:	ba 00 00 00 00       	mov    $0x0,%edx
  105609:	3b 55 d4             	cmp    -0x2c(%ebp),%edx
  10560c:	77 56                	ja     105664 <printnum+0xdc>
  10560e:	3b 55 d4             	cmp    -0x2c(%ebp),%edx
  105611:	72 05                	jb     105618 <printnum+0x90>
  105613:	3b 45 d0             	cmp    -0x30(%ebp),%eax
  105616:	77 4c                	ja     105664 <printnum+0xdc>
        printnum(putch, putdat, result, base, width - 1, padc);
  105618:	8b 45 1c             	mov    0x1c(%ebp),%eax
  10561b:	8d 50 ff             	lea    -0x1(%eax),%edx
  10561e:	8b 45 20             	mov    0x20(%ebp),%eax
  105621:	89 44 24 18          	mov    %eax,0x18(%esp)
  105625:	89 54 24 14          	mov    %edx,0x14(%esp)
  105629:	8b 45 18             	mov    0x18(%ebp),%eax
  10562c:	89 44 24 10          	mov    %eax,0x10(%esp)
  105630:	8b 45 e8             	mov    -0x18(%ebp),%eax
  105633:	8b 55 ec             	mov    -0x14(%ebp),%edx
  105636:	89 44 24 08          	mov    %eax,0x8(%esp)
  10563a:	89 54 24 0c          	mov    %edx,0xc(%esp)
  10563e:	8b 45 0c             	mov    0xc(%ebp),%eax
  105641:	89 44 24 04          	mov    %eax,0x4(%esp)
  105645:	8b 45 08             	mov    0x8(%ebp),%eax
  105648:	89 04 24             	mov    %eax,(%esp)
  10564b:	e8 38 ff ff ff       	call   105588 <printnum>
  105650:	eb 1c                	jmp    10566e <printnum+0xe6>
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
            putch(padc, putdat);
  105652:	8b 45 0c             	mov    0xc(%ebp),%eax
  105655:	89 44 24 04          	mov    %eax,0x4(%esp)
  105659:	8b 45 20             	mov    0x20(%ebp),%eax
  10565c:	89 04 24             	mov    %eax,(%esp)
  10565f:	8b 45 08             	mov    0x8(%ebp),%eax
  105662:	ff d0                	call   *%eax
    // first recursively print all preceding (more significant) digits
    if (num >= base) {
        printnum(putch, putdat, result, base, width - 1, padc);
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
  105664:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
  105668:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  10566c:	7f e4                	jg     105652 <printnum+0xca>
            putch(padc, putdat);
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
  10566e:	8b 45 d8             	mov    -0x28(%ebp),%eax
  105671:	05 64 72 10 00       	add    $0x107264,%eax
  105676:	0f b6 00             	movzbl (%eax),%eax
  105679:	0f be c0             	movsbl %al,%eax
  10567c:	8b 55 0c             	mov    0xc(%ebp),%edx
  10567f:	89 54 24 04          	mov    %edx,0x4(%esp)
  105683:	89 04 24             	mov    %eax,(%esp)
  105686:	8b 45 08             	mov    0x8(%ebp),%eax
  105689:	ff d0                	call   *%eax
}
  10568b:	c9                   	leave  
  10568c:	c3                   	ret    

0010568d <getuint>:
 * getuint - get an unsigned int of various possible sizes from a varargs list
 * @ap:         a varargs list pointer
 * @lflag:      determines the size of the vararg that @ap points to
 * */
static unsigned long long
getuint(va_list *ap, int lflag) {
  10568d:	55                   	push   %ebp
  10568e:	89 e5                	mov    %esp,%ebp
    if (lflag >= 2) {
  105690:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  105694:	7e 14                	jle    1056aa <getuint+0x1d>
        return va_arg(*ap, unsigned long long);
  105696:	8b 45 08             	mov    0x8(%ebp),%eax
  105699:	8b 00                	mov    (%eax),%eax
  10569b:	8d 48 08             	lea    0x8(%eax),%ecx
  10569e:	8b 55 08             	mov    0x8(%ebp),%edx
  1056a1:	89 0a                	mov    %ecx,(%edx)
  1056a3:	8b 50 04             	mov    0x4(%eax),%edx
  1056a6:	8b 00                	mov    (%eax),%eax
  1056a8:	eb 30                	jmp    1056da <getuint+0x4d>
    }
    else if (lflag) {
  1056aa:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  1056ae:	74 16                	je     1056c6 <getuint+0x39>
        return va_arg(*ap, unsigned long);
  1056b0:	8b 45 08             	mov    0x8(%ebp),%eax
  1056b3:	8b 00                	mov    (%eax),%eax
  1056b5:	8d 48 04             	lea    0x4(%eax),%ecx
  1056b8:	8b 55 08             	mov    0x8(%ebp),%edx
  1056bb:	89 0a                	mov    %ecx,(%edx)
  1056bd:	8b 00                	mov    (%eax),%eax
  1056bf:	ba 00 00 00 00       	mov    $0x0,%edx
  1056c4:	eb 14                	jmp    1056da <getuint+0x4d>
    }
    else {
        return va_arg(*ap, unsigned int);
  1056c6:	8b 45 08             	mov    0x8(%ebp),%eax
  1056c9:	8b 00                	mov    (%eax),%eax
  1056cb:	8d 48 04             	lea    0x4(%eax),%ecx
  1056ce:	8b 55 08             	mov    0x8(%ebp),%edx
  1056d1:	89 0a                	mov    %ecx,(%edx)
  1056d3:	8b 00                	mov    (%eax),%eax
  1056d5:	ba 00 00 00 00       	mov    $0x0,%edx
    }
}
  1056da:	5d                   	pop    %ebp
  1056db:	c3                   	ret    

001056dc <getint>:
 * getint - same as getuint but signed, we can't use getuint because of sign extension
 * @ap:         a varargs list pointer
 * @lflag:      determines the size of the vararg that @ap points to
 * */
static long long
getint(va_list *ap, int lflag) {
  1056dc:	55                   	push   %ebp
  1056dd:	89 e5                	mov    %esp,%ebp
    if (lflag >= 2) {
  1056df:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  1056e3:	7e 14                	jle    1056f9 <getint+0x1d>
        return va_arg(*ap, long long);
  1056e5:	8b 45 08             	mov    0x8(%ebp),%eax
  1056e8:	8b 00                	mov    (%eax),%eax
  1056ea:	8d 48 08             	lea    0x8(%eax),%ecx
  1056ed:	8b 55 08             	mov    0x8(%ebp),%edx
  1056f0:	89 0a                	mov    %ecx,(%edx)
  1056f2:	8b 50 04             	mov    0x4(%eax),%edx
  1056f5:	8b 00                	mov    (%eax),%eax
  1056f7:	eb 28                	jmp    105721 <getint+0x45>
    }
    else if (lflag) {
  1056f9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  1056fd:	74 12                	je     105711 <getint+0x35>
        return va_arg(*ap, long);
  1056ff:	8b 45 08             	mov    0x8(%ebp),%eax
  105702:	8b 00                	mov    (%eax),%eax
  105704:	8d 48 04             	lea    0x4(%eax),%ecx
  105707:	8b 55 08             	mov    0x8(%ebp),%edx
  10570a:	89 0a                	mov    %ecx,(%edx)
  10570c:	8b 00                	mov    (%eax),%eax
  10570e:	99                   	cltd   
  10570f:	eb 10                	jmp    105721 <getint+0x45>
    }
    else {
        return va_arg(*ap, int);
  105711:	8b 45 08             	mov    0x8(%ebp),%eax
  105714:	8b 00                	mov    (%eax),%eax
  105716:	8d 48 04             	lea    0x4(%eax),%ecx
  105719:	8b 55 08             	mov    0x8(%ebp),%edx
  10571c:	89 0a                	mov    %ecx,(%edx)
  10571e:	8b 00                	mov    (%eax),%eax
  105720:	99                   	cltd   
    }
}
  105721:	5d                   	pop    %ebp
  105722:	c3                   	ret    

00105723 <printfmt>:
 * @putch:      specified putch function, print a single character
 * @putdat:     used by @putch function
 * @fmt:        the format string to use
 * */
void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  105723:	55                   	push   %ebp
  105724:	89 e5                	mov    %esp,%ebp
  105726:	83 ec 28             	sub    $0x28,%esp
    va_list ap;

    va_start(ap, fmt);
  105729:	8d 45 14             	lea    0x14(%ebp),%eax
  10572c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    vprintfmt(putch, putdat, fmt, ap);
  10572f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  105732:	89 44 24 0c          	mov    %eax,0xc(%esp)
  105736:	8b 45 10             	mov    0x10(%ebp),%eax
  105739:	89 44 24 08          	mov    %eax,0x8(%esp)
  10573d:	8b 45 0c             	mov    0xc(%ebp),%eax
  105740:	89 44 24 04          	mov    %eax,0x4(%esp)
  105744:	8b 45 08             	mov    0x8(%ebp),%eax
  105747:	89 04 24             	mov    %eax,(%esp)
  10574a:	e8 02 00 00 00       	call   105751 <vprintfmt>
    va_end(ap);
}
  10574f:	c9                   	leave  
  105750:	c3                   	ret    

00105751 <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
  105751:	55                   	push   %ebp
  105752:	89 e5                	mov    %esp,%ebp
  105754:	56                   	push   %esi
  105755:	53                   	push   %ebx
  105756:	83 ec 40             	sub    $0x40,%esp
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  105759:	eb 18                	jmp    105773 <vprintfmt+0x22>
            if (ch == '\0') {
  10575b:	85 db                	test   %ebx,%ebx
  10575d:	75 05                	jne    105764 <vprintfmt+0x13>
                return;
  10575f:	e9 d1 03 00 00       	jmp    105b35 <vprintfmt+0x3e4>
            }
            putch(ch, putdat);
  105764:	8b 45 0c             	mov    0xc(%ebp),%eax
  105767:	89 44 24 04          	mov    %eax,0x4(%esp)
  10576b:	89 1c 24             	mov    %ebx,(%esp)
  10576e:	8b 45 08             	mov    0x8(%ebp),%eax
  105771:	ff d0                	call   *%eax
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  105773:	8b 45 10             	mov    0x10(%ebp),%eax
  105776:	8d 50 01             	lea    0x1(%eax),%edx
  105779:	89 55 10             	mov    %edx,0x10(%ebp)
  10577c:	0f b6 00             	movzbl (%eax),%eax
  10577f:	0f b6 d8             	movzbl %al,%ebx
  105782:	83 fb 25             	cmp    $0x25,%ebx
  105785:	75 d4                	jne    10575b <vprintfmt+0xa>
            }
            putch(ch, putdat);
        }

        // Process a %-escape sequence
        char padc = ' ';
  105787:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
        width = precision = -1;
  10578b:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
  105792:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  105795:	89 45 e8             	mov    %eax,-0x18(%ebp)
        lflag = altflag = 0;
  105798:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  10579f:	8b 45 dc             	mov    -0x24(%ebp),%eax
  1057a2:	89 45 e0             	mov    %eax,-0x20(%ebp)

    reswitch:
        switch (ch = *(unsigned char *)fmt ++) {
  1057a5:	8b 45 10             	mov    0x10(%ebp),%eax
  1057a8:	8d 50 01             	lea    0x1(%eax),%edx
  1057ab:	89 55 10             	mov    %edx,0x10(%ebp)
  1057ae:	0f b6 00             	movzbl (%eax),%eax
  1057b1:	0f b6 d8             	movzbl %al,%ebx
  1057b4:	8d 43 dd             	lea    -0x23(%ebx),%eax
  1057b7:	83 f8 55             	cmp    $0x55,%eax
  1057ba:	0f 87 44 03 00 00    	ja     105b04 <vprintfmt+0x3b3>
  1057c0:	8b 04 85 88 72 10 00 	mov    0x107288(,%eax,4),%eax
  1057c7:	ff e0                	jmp    *%eax

        // flag to pad on the right
        case '-':
            padc = '-';
  1057c9:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
            goto reswitch;
  1057cd:	eb d6                	jmp    1057a5 <vprintfmt+0x54>

        // flag to pad with 0's instead of spaces
        case '0':
            padc = '0';
  1057cf:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
            goto reswitch;
  1057d3:	eb d0                	jmp    1057a5 <vprintfmt+0x54>

        // width field
        case '1' ... '9':
            for (precision = 0; ; ++ fmt) {
  1057d5:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
                precision = precision * 10 + ch - '0';
  1057dc:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  1057df:	89 d0                	mov    %edx,%eax
  1057e1:	c1 e0 02             	shl    $0x2,%eax
  1057e4:	01 d0                	add    %edx,%eax
  1057e6:	01 c0                	add    %eax,%eax
  1057e8:	01 d8                	add    %ebx,%eax
  1057ea:	83 e8 30             	sub    $0x30,%eax
  1057ed:	89 45 e4             	mov    %eax,-0x1c(%ebp)
                ch = *fmt;
  1057f0:	8b 45 10             	mov    0x10(%ebp),%eax
  1057f3:	0f b6 00             	movzbl (%eax),%eax
  1057f6:	0f be d8             	movsbl %al,%ebx
                if (ch < '0' || ch > '9') {
  1057f9:	83 fb 2f             	cmp    $0x2f,%ebx
  1057fc:	7e 0b                	jle    105809 <vprintfmt+0xb8>
  1057fe:	83 fb 39             	cmp    $0x39,%ebx
  105801:	7f 06                	jg     105809 <vprintfmt+0xb8>
            padc = '0';
            goto reswitch;

        // width field
        case '1' ... '9':
            for (precision = 0; ; ++ fmt) {
  105803:	83 45 10 01          	addl   $0x1,0x10(%ebp)
                precision = precision * 10 + ch - '0';
                ch = *fmt;
                if (ch < '0' || ch > '9') {
                    break;
                }
            }
  105807:	eb d3                	jmp    1057dc <vprintfmt+0x8b>
            goto process_precision;
  105809:	eb 33                	jmp    10583e <vprintfmt+0xed>

        case '*':
            precision = va_arg(ap, int);
  10580b:	8b 45 14             	mov    0x14(%ebp),%eax
  10580e:	8d 50 04             	lea    0x4(%eax),%edx
  105811:	89 55 14             	mov    %edx,0x14(%ebp)
  105814:	8b 00                	mov    (%eax),%eax
  105816:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            goto process_precision;
  105819:	eb 23                	jmp    10583e <vprintfmt+0xed>

        case '.':
            if (width < 0)
  10581b:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  10581f:	79 0c                	jns    10582d <vprintfmt+0xdc>
                width = 0;
  105821:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
            goto reswitch;
  105828:	e9 78 ff ff ff       	jmp    1057a5 <vprintfmt+0x54>
  10582d:	e9 73 ff ff ff       	jmp    1057a5 <vprintfmt+0x54>

        case '#':
            altflag = 1;
  105832:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
            goto reswitch;
  105839:	e9 67 ff ff ff       	jmp    1057a5 <vprintfmt+0x54>

        process_precision:
            if (width < 0)
  10583e:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  105842:	79 12                	jns    105856 <vprintfmt+0x105>
                width = precision, precision = -1;
  105844:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  105847:	89 45 e8             	mov    %eax,-0x18(%ebp)
  10584a:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
            goto reswitch;
  105851:	e9 4f ff ff ff       	jmp    1057a5 <vprintfmt+0x54>
  105856:	e9 4a ff ff ff       	jmp    1057a5 <vprintfmt+0x54>

        // long flag (doubled for long long)
        case 'l':
            lflag ++;
  10585b:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
            goto reswitch;
  10585f:	e9 41 ff ff ff       	jmp    1057a5 <vprintfmt+0x54>

        // character
        case 'c':
            putch(va_arg(ap, int), putdat);
  105864:	8b 45 14             	mov    0x14(%ebp),%eax
  105867:	8d 50 04             	lea    0x4(%eax),%edx
  10586a:	89 55 14             	mov    %edx,0x14(%ebp)
  10586d:	8b 00                	mov    (%eax),%eax
  10586f:	8b 55 0c             	mov    0xc(%ebp),%edx
  105872:	89 54 24 04          	mov    %edx,0x4(%esp)
  105876:	89 04 24             	mov    %eax,(%esp)
  105879:	8b 45 08             	mov    0x8(%ebp),%eax
  10587c:	ff d0                	call   *%eax
            break;
  10587e:	e9 ac 02 00 00       	jmp    105b2f <vprintfmt+0x3de>

        // error message
        case 'e':
            err = va_arg(ap, int);
  105883:	8b 45 14             	mov    0x14(%ebp),%eax
  105886:	8d 50 04             	lea    0x4(%eax),%edx
  105889:	89 55 14             	mov    %edx,0x14(%ebp)
  10588c:	8b 18                	mov    (%eax),%ebx
            if (err < 0) {
  10588e:	85 db                	test   %ebx,%ebx
  105890:	79 02                	jns    105894 <vprintfmt+0x143>
                err = -err;
  105892:	f7 db                	neg    %ebx
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  105894:	83 fb 06             	cmp    $0x6,%ebx
  105897:	7f 0b                	jg     1058a4 <vprintfmt+0x153>
  105899:	8b 34 9d 48 72 10 00 	mov    0x107248(,%ebx,4),%esi
  1058a0:	85 f6                	test   %esi,%esi
  1058a2:	75 23                	jne    1058c7 <vprintfmt+0x176>
                printfmt(putch, putdat, "error %d", err);
  1058a4:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
  1058a8:	c7 44 24 08 75 72 10 	movl   $0x107275,0x8(%esp)
  1058af:	00 
  1058b0:	8b 45 0c             	mov    0xc(%ebp),%eax
  1058b3:	89 44 24 04          	mov    %eax,0x4(%esp)
  1058b7:	8b 45 08             	mov    0x8(%ebp),%eax
  1058ba:	89 04 24             	mov    %eax,(%esp)
  1058bd:	e8 61 fe ff ff       	call   105723 <printfmt>
            }
            else {
                printfmt(putch, putdat, "%s", p);
            }
            break;
  1058c2:	e9 68 02 00 00       	jmp    105b2f <vprintfmt+0x3de>
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
                printfmt(putch, putdat, "error %d", err);
            }
            else {
                printfmt(putch, putdat, "%s", p);
  1058c7:	89 74 24 0c          	mov    %esi,0xc(%esp)
  1058cb:	c7 44 24 08 7e 72 10 	movl   $0x10727e,0x8(%esp)
  1058d2:	00 
  1058d3:	8b 45 0c             	mov    0xc(%ebp),%eax
  1058d6:	89 44 24 04          	mov    %eax,0x4(%esp)
  1058da:	8b 45 08             	mov    0x8(%ebp),%eax
  1058dd:	89 04 24             	mov    %eax,(%esp)
  1058e0:	e8 3e fe ff ff       	call   105723 <printfmt>
            }
            break;
  1058e5:	e9 45 02 00 00       	jmp    105b2f <vprintfmt+0x3de>

        // string
        case 's':
            if ((p = va_arg(ap, char *)) == NULL) {
  1058ea:	8b 45 14             	mov    0x14(%ebp),%eax
  1058ed:	8d 50 04             	lea    0x4(%eax),%edx
  1058f0:	89 55 14             	mov    %edx,0x14(%ebp)
  1058f3:	8b 30                	mov    (%eax),%esi
  1058f5:	85 f6                	test   %esi,%esi
  1058f7:	75 05                	jne    1058fe <vprintfmt+0x1ad>
                p = "(null)";
  1058f9:	be 81 72 10 00       	mov    $0x107281,%esi
            }
            if (width > 0 && padc != '-') {
  1058fe:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  105902:	7e 3e                	jle    105942 <vprintfmt+0x1f1>
  105904:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  105908:	74 38                	je     105942 <vprintfmt+0x1f1>
                for (width -= strnlen(p, precision); width > 0; width --) {
  10590a:	8b 5d e8             	mov    -0x18(%ebp),%ebx
  10590d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  105910:	89 44 24 04          	mov    %eax,0x4(%esp)
  105914:	89 34 24             	mov    %esi,(%esp)
  105917:	e8 15 03 00 00       	call   105c31 <strnlen>
  10591c:	29 c3                	sub    %eax,%ebx
  10591e:	89 d8                	mov    %ebx,%eax
  105920:	89 45 e8             	mov    %eax,-0x18(%ebp)
  105923:	eb 17                	jmp    10593c <vprintfmt+0x1eb>
                    putch(padc, putdat);
  105925:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  105929:	8b 55 0c             	mov    0xc(%ebp),%edx
  10592c:	89 54 24 04          	mov    %edx,0x4(%esp)
  105930:	89 04 24             	mov    %eax,(%esp)
  105933:	8b 45 08             	mov    0x8(%ebp),%eax
  105936:	ff d0                	call   *%eax
        case 's':
            if ((p = va_arg(ap, char *)) == NULL) {
                p = "(null)";
            }
            if (width > 0 && padc != '-') {
                for (width -= strnlen(p, precision); width > 0; width --) {
  105938:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
  10593c:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  105940:	7f e3                	jg     105925 <vprintfmt+0x1d4>
                    putch(padc, putdat);
                }
            }
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  105942:	eb 38                	jmp    10597c <vprintfmt+0x22b>
                if (altflag && (ch < ' ' || ch > '~')) {
  105944:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  105948:	74 1f                	je     105969 <vprintfmt+0x218>
  10594a:	83 fb 1f             	cmp    $0x1f,%ebx
  10594d:	7e 05                	jle    105954 <vprintfmt+0x203>
  10594f:	83 fb 7e             	cmp    $0x7e,%ebx
  105952:	7e 15                	jle    105969 <vprintfmt+0x218>
                    putch('?', putdat);
  105954:	8b 45 0c             	mov    0xc(%ebp),%eax
  105957:	89 44 24 04          	mov    %eax,0x4(%esp)
  10595b:	c7 04 24 3f 00 00 00 	movl   $0x3f,(%esp)
  105962:	8b 45 08             	mov    0x8(%ebp),%eax
  105965:	ff d0                	call   *%eax
  105967:	eb 0f                	jmp    105978 <vprintfmt+0x227>
                }
                else {
                    putch(ch, putdat);
  105969:	8b 45 0c             	mov    0xc(%ebp),%eax
  10596c:	89 44 24 04          	mov    %eax,0x4(%esp)
  105970:	89 1c 24             	mov    %ebx,(%esp)
  105973:	8b 45 08             	mov    0x8(%ebp),%eax
  105976:	ff d0                	call   *%eax
            if (width > 0 && padc != '-') {
                for (width -= strnlen(p, precision); width > 0; width --) {
                    putch(padc, putdat);
                }
            }
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  105978:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
  10597c:	89 f0                	mov    %esi,%eax
  10597e:	8d 70 01             	lea    0x1(%eax),%esi
  105981:	0f b6 00             	movzbl (%eax),%eax
  105984:	0f be d8             	movsbl %al,%ebx
  105987:	85 db                	test   %ebx,%ebx
  105989:	74 10                	je     10599b <vprintfmt+0x24a>
  10598b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  10598f:	78 b3                	js     105944 <vprintfmt+0x1f3>
  105991:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
  105995:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  105999:	79 a9                	jns    105944 <vprintfmt+0x1f3>
                }
                else {
                    putch(ch, putdat);
                }
            }
            for (; width > 0; width --) {
  10599b:	eb 17                	jmp    1059b4 <vprintfmt+0x263>
                putch(' ', putdat);
  10599d:	8b 45 0c             	mov    0xc(%ebp),%eax
  1059a0:	89 44 24 04          	mov    %eax,0x4(%esp)
  1059a4:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  1059ab:	8b 45 08             	mov    0x8(%ebp),%eax
  1059ae:	ff d0                	call   *%eax
                }
                else {
                    putch(ch, putdat);
                }
            }
            for (; width > 0; width --) {
  1059b0:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
  1059b4:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  1059b8:	7f e3                	jg     10599d <vprintfmt+0x24c>
                putch(' ', putdat);
            }
            break;
  1059ba:	e9 70 01 00 00       	jmp    105b2f <vprintfmt+0x3de>

        // (signed) decimal
        case 'd':
            num = getint(&ap, lflag);
  1059bf:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1059c2:	89 44 24 04          	mov    %eax,0x4(%esp)
  1059c6:	8d 45 14             	lea    0x14(%ebp),%eax
  1059c9:	89 04 24             	mov    %eax,(%esp)
  1059cc:	e8 0b fd ff ff       	call   1056dc <getint>
  1059d1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1059d4:	89 55 f4             	mov    %edx,-0xc(%ebp)
            if ((long long)num < 0) {
  1059d7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1059da:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1059dd:	85 d2                	test   %edx,%edx
  1059df:	79 26                	jns    105a07 <vprintfmt+0x2b6>
                putch('-', putdat);
  1059e1:	8b 45 0c             	mov    0xc(%ebp),%eax
  1059e4:	89 44 24 04          	mov    %eax,0x4(%esp)
  1059e8:	c7 04 24 2d 00 00 00 	movl   $0x2d,(%esp)
  1059ef:	8b 45 08             	mov    0x8(%ebp),%eax
  1059f2:	ff d0                	call   *%eax
                num = -(long long)num;
  1059f4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1059f7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1059fa:	f7 d8                	neg    %eax
  1059fc:	83 d2 00             	adc    $0x0,%edx
  1059ff:	f7 da                	neg    %edx
  105a01:	89 45 f0             	mov    %eax,-0x10(%ebp)
  105a04:	89 55 f4             	mov    %edx,-0xc(%ebp)
            }
            base = 10;
  105a07:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
            goto number;
  105a0e:	e9 a8 00 00 00       	jmp    105abb <vprintfmt+0x36a>

        // unsigned decimal
        case 'u':
            num = getuint(&ap, lflag);
  105a13:	8b 45 e0             	mov    -0x20(%ebp),%eax
  105a16:	89 44 24 04          	mov    %eax,0x4(%esp)
  105a1a:	8d 45 14             	lea    0x14(%ebp),%eax
  105a1d:	89 04 24             	mov    %eax,(%esp)
  105a20:	e8 68 fc ff ff       	call   10568d <getuint>
  105a25:	89 45 f0             	mov    %eax,-0x10(%ebp)
  105a28:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 10;
  105a2b:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
            goto number;
  105a32:	e9 84 00 00 00       	jmp    105abb <vprintfmt+0x36a>

        // (unsigned) octal
        case 'o':
            num = getuint(&ap, lflag);
  105a37:	8b 45 e0             	mov    -0x20(%ebp),%eax
  105a3a:	89 44 24 04          	mov    %eax,0x4(%esp)
  105a3e:	8d 45 14             	lea    0x14(%ebp),%eax
  105a41:	89 04 24             	mov    %eax,(%esp)
  105a44:	e8 44 fc ff ff       	call   10568d <getuint>
  105a49:	89 45 f0             	mov    %eax,-0x10(%ebp)
  105a4c:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 8;
  105a4f:	c7 45 ec 08 00 00 00 	movl   $0x8,-0x14(%ebp)
            goto number;
  105a56:	eb 63                	jmp    105abb <vprintfmt+0x36a>

        // pointer
        case 'p':
            putch('0', putdat);
  105a58:	8b 45 0c             	mov    0xc(%ebp),%eax
  105a5b:	89 44 24 04          	mov    %eax,0x4(%esp)
  105a5f:	c7 04 24 30 00 00 00 	movl   $0x30,(%esp)
  105a66:	8b 45 08             	mov    0x8(%ebp),%eax
  105a69:	ff d0                	call   *%eax
            putch('x', putdat);
  105a6b:	8b 45 0c             	mov    0xc(%ebp),%eax
  105a6e:	89 44 24 04          	mov    %eax,0x4(%esp)
  105a72:	c7 04 24 78 00 00 00 	movl   $0x78,(%esp)
  105a79:	8b 45 08             	mov    0x8(%ebp),%eax
  105a7c:	ff d0                	call   *%eax
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
  105a7e:	8b 45 14             	mov    0x14(%ebp),%eax
  105a81:	8d 50 04             	lea    0x4(%eax),%edx
  105a84:	89 55 14             	mov    %edx,0x14(%ebp)
  105a87:	8b 00                	mov    (%eax),%eax
  105a89:	89 45 f0             	mov    %eax,-0x10(%ebp)
  105a8c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
            base = 16;
  105a93:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
            goto number;
  105a9a:	eb 1f                	jmp    105abb <vprintfmt+0x36a>

        // (unsigned) hexadecimal
        case 'x':
            num = getuint(&ap, lflag);
  105a9c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  105a9f:	89 44 24 04          	mov    %eax,0x4(%esp)
  105aa3:	8d 45 14             	lea    0x14(%ebp),%eax
  105aa6:	89 04 24             	mov    %eax,(%esp)
  105aa9:	e8 df fb ff ff       	call   10568d <getuint>
  105aae:	89 45 f0             	mov    %eax,-0x10(%ebp)
  105ab1:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 16;
  105ab4:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
        number:
            printnum(putch, putdat, num, base, width, padc);
  105abb:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  105abf:	8b 45 ec             	mov    -0x14(%ebp),%eax
  105ac2:	89 54 24 18          	mov    %edx,0x18(%esp)
  105ac6:	8b 55 e8             	mov    -0x18(%ebp),%edx
  105ac9:	89 54 24 14          	mov    %edx,0x14(%esp)
  105acd:	89 44 24 10          	mov    %eax,0x10(%esp)
  105ad1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  105ad4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  105ad7:	89 44 24 08          	mov    %eax,0x8(%esp)
  105adb:	89 54 24 0c          	mov    %edx,0xc(%esp)
  105adf:	8b 45 0c             	mov    0xc(%ebp),%eax
  105ae2:	89 44 24 04          	mov    %eax,0x4(%esp)
  105ae6:	8b 45 08             	mov    0x8(%ebp),%eax
  105ae9:	89 04 24             	mov    %eax,(%esp)
  105aec:	e8 97 fa ff ff       	call   105588 <printnum>
            break;
  105af1:	eb 3c                	jmp    105b2f <vprintfmt+0x3de>

        // escaped '%' character
        case '%':
            putch(ch, putdat);
  105af3:	8b 45 0c             	mov    0xc(%ebp),%eax
  105af6:	89 44 24 04          	mov    %eax,0x4(%esp)
  105afa:	89 1c 24             	mov    %ebx,(%esp)
  105afd:	8b 45 08             	mov    0x8(%ebp),%eax
  105b00:	ff d0                	call   *%eax
            break;
  105b02:	eb 2b                	jmp    105b2f <vprintfmt+0x3de>

        // unrecognized escape sequence - just print it literally
        default:
            putch('%', putdat);
  105b04:	8b 45 0c             	mov    0xc(%ebp),%eax
  105b07:	89 44 24 04          	mov    %eax,0x4(%esp)
  105b0b:	c7 04 24 25 00 00 00 	movl   $0x25,(%esp)
  105b12:	8b 45 08             	mov    0x8(%ebp),%eax
  105b15:	ff d0                	call   *%eax
            for (fmt --; fmt[-1] != '%'; fmt --)
  105b17:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  105b1b:	eb 04                	jmp    105b21 <vprintfmt+0x3d0>
  105b1d:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  105b21:	8b 45 10             	mov    0x10(%ebp),%eax
  105b24:	83 e8 01             	sub    $0x1,%eax
  105b27:	0f b6 00             	movzbl (%eax),%eax
  105b2a:	3c 25                	cmp    $0x25,%al
  105b2c:	75 ef                	jne    105b1d <vprintfmt+0x3cc>
                /* do nothing */;
            break;
  105b2e:	90                   	nop
        }
    }
  105b2f:	90                   	nop
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  105b30:	e9 3e fc ff ff       	jmp    105773 <vprintfmt+0x22>
            for (fmt --; fmt[-1] != '%'; fmt --)
                /* do nothing */;
            break;
        }
    }
}
  105b35:	83 c4 40             	add    $0x40,%esp
  105b38:	5b                   	pop    %ebx
  105b39:	5e                   	pop    %esi
  105b3a:	5d                   	pop    %ebp
  105b3b:	c3                   	ret    

00105b3c <sprintputch>:
 * sprintputch - 'print' a single character in a buffer
 * @ch:         the character will be printed
 * @b:          the buffer to place the character @ch
 * */
static void
sprintputch(int ch, struct sprintbuf *b) {
  105b3c:	55                   	push   %ebp
  105b3d:	89 e5                	mov    %esp,%ebp
    b->cnt ++;
  105b3f:	8b 45 0c             	mov    0xc(%ebp),%eax
  105b42:	8b 40 08             	mov    0x8(%eax),%eax
  105b45:	8d 50 01             	lea    0x1(%eax),%edx
  105b48:	8b 45 0c             	mov    0xc(%ebp),%eax
  105b4b:	89 50 08             	mov    %edx,0x8(%eax)
    if (b->buf < b->ebuf) {
  105b4e:	8b 45 0c             	mov    0xc(%ebp),%eax
  105b51:	8b 10                	mov    (%eax),%edx
  105b53:	8b 45 0c             	mov    0xc(%ebp),%eax
  105b56:	8b 40 04             	mov    0x4(%eax),%eax
  105b59:	39 c2                	cmp    %eax,%edx
  105b5b:	73 12                	jae    105b6f <sprintputch+0x33>
        *b->buf ++ = ch;
  105b5d:	8b 45 0c             	mov    0xc(%ebp),%eax
  105b60:	8b 00                	mov    (%eax),%eax
  105b62:	8d 48 01             	lea    0x1(%eax),%ecx
  105b65:	8b 55 0c             	mov    0xc(%ebp),%edx
  105b68:	89 0a                	mov    %ecx,(%edx)
  105b6a:	8b 55 08             	mov    0x8(%ebp),%edx
  105b6d:	88 10                	mov    %dl,(%eax)
    }
}
  105b6f:	5d                   	pop    %ebp
  105b70:	c3                   	ret    

00105b71 <snprintf>:
 * @str:        the buffer to place the result into
 * @size:       the size of buffer, including the trailing null space
 * @fmt:        the format string to use
 * */
int
snprintf(char *str, size_t size, const char *fmt, ...) {
  105b71:	55                   	push   %ebp
  105b72:	89 e5                	mov    %esp,%ebp
  105b74:	83 ec 28             	sub    $0x28,%esp
    va_list ap;
    int cnt;
    va_start(ap, fmt);
  105b77:	8d 45 14             	lea    0x14(%ebp),%eax
  105b7a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    cnt = vsnprintf(str, size, fmt, ap);
  105b7d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  105b80:	89 44 24 0c          	mov    %eax,0xc(%esp)
  105b84:	8b 45 10             	mov    0x10(%ebp),%eax
  105b87:	89 44 24 08          	mov    %eax,0x8(%esp)
  105b8b:	8b 45 0c             	mov    0xc(%ebp),%eax
  105b8e:	89 44 24 04          	mov    %eax,0x4(%esp)
  105b92:	8b 45 08             	mov    0x8(%ebp),%eax
  105b95:	89 04 24             	mov    %eax,(%esp)
  105b98:	e8 08 00 00 00       	call   105ba5 <vsnprintf>
  105b9d:	89 45 f4             	mov    %eax,-0xc(%ebp)
    va_end(ap);
    return cnt;
  105ba0:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  105ba3:	c9                   	leave  
  105ba4:	c3                   	ret    

00105ba5 <vsnprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want snprintf() instead.
 * */
int
vsnprintf(char *str, size_t size, const char *fmt, va_list ap) {
  105ba5:	55                   	push   %ebp
  105ba6:	89 e5                	mov    %esp,%ebp
  105ba8:	83 ec 28             	sub    $0x28,%esp
    struct sprintbuf b = {str, str + size - 1, 0};
  105bab:	8b 45 08             	mov    0x8(%ebp),%eax
  105bae:	89 45 ec             	mov    %eax,-0x14(%ebp)
  105bb1:	8b 45 0c             	mov    0xc(%ebp),%eax
  105bb4:	8d 50 ff             	lea    -0x1(%eax),%edx
  105bb7:	8b 45 08             	mov    0x8(%ebp),%eax
  105bba:	01 d0                	add    %edx,%eax
  105bbc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  105bbf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if (str == NULL || b.buf > b.ebuf) {
  105bc6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  105bca:	74 0a                	je     105bd6 <vsnprintf+0x31>
  105bcc:	8b 55 ec             	mov    -0x14(%ebp),%edx
  105bcf:	8b 45 f0             	mov    -0x10(%ebp),%eax
  105bd2:	39 c2                	cmp    %eax,%edx
  105bd4:	76 07                	jbe    105bdd <vsnprintf+0x38>
        return -E_INVAL;
  105bd6:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  105bdb:	eb 2a                	jmp    105c07 <vsnprintf+0x62>
    }
    // print the string to the buffer
    vprintfmt((void*)sprintputch, &b, fmt, ap);
  105bdd:	8b 45 14             	mov    0x14(%ebp),%eax
  105be0:	89 44 24 0c          	mov    %eax,0xc(%esp)
  105be4:	8b 45 10             	mov    0x10(%ebp),%eax
  105be7:	89 44 24 08          	mov    %eax,0x8(%esp)
  105beb:	8d 45 ec             	lea    -0x14(%ebp),%eax
  105bee:	89 44 24 04          	mov    %eax,0x4(%esp)
  105bf2:	c7 04 24 3c 5b 10 00 	movl   $0x105b3c,(%esp)
  105bf9:	e8 53 fb ff ff       	call   105751 <vprintfmt>
    // null terminate the buffer
    *b.buf = '\0';
  105bfe:	8b 45 ec             	mov    -0x14(%ebp),%eax
  105c01:	c6 00 00             	movb   $0x0,(%eax)
    return b.cnt;
  105c04:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  105c07:	c9                   	leave  
  105c08:	c3                   	ret    

00105c09 <strlen>:
 * @s:      the input string
 *
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
  105c09:	55                   	push   %ebp
  105c0a:	89 e5                	mov    %esp,%ebp
  105c0c:	83 ec 10             	sub    $0x10,%esp
    size_t cnt = 0;
  105c0f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (*s ++ != '\0') {
  105c16:	eb 04                	jmp    105c1c <strlen+0x13>
        cnt ++;
  105c18:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
    size_t cnt = 0;
    while (*s ++ != '\0') {
  105c1c:	8b 45 08             	mov    0x8(%ebp),%eax
  105c1f:	8d 50 01             	lea    0x1(%eax),%edx
  105c22:	89 55 08             	mov    %edx,0x8(%ebp)
  105c25:	0f b6 00             	movzbl (%eax),%eax
  105c28:	84 c0                	test   %al,%al
  105c2a:	75 ec                	jne    105c18 <strlen+0xf>
        cnt ++;
    }
    return cnt;
  105c2c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  105c2f:	c9                   	leave  
  105c30:	c3                   	ret    

00105c31 <strnlen>:
 * The return value is strlen(s), if that is less than @len, or
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
  105c31:	55                   	push   %ebp
  105c32:	89 e5                	mov    %esp,%ebp
  105c34:	83 ec 10             	sub    $0x10,%esp
    size_t cnt = 0;
  105c37:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (cnt < len && *s ++ != '\0') {
  105c3e:	eb 04                	jmp    105c44 <strnlen+0x13>
        cnt ++;
  105c40:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
    size_t cnt = 0;
    while (cnt < len && *s ++ != '\0') {
  105c44:	8b 45 fc             	mov    -0x4(%ebp),%eax
  105c47:	3b 45 0c             	cmp    0xc(%ebp),%eax
  105c4a:	73 10                	jae    105c5c <strnlen+0x2b>
  105c4c:	8b 45 08             	mov    0x8(%ebp),%eax
  105c4f:	8d 50 01             	lea    0x1(%eax),%edx
  105c52:	89 55 08             	mov    %edx,0x8(%ebp)
  105c55:	0f b6 00             	movzbl (%eax),%eax
  105c58:	84 c0                	test   %al,%al
  105c5a:	75 e4                	jne    105c40 <strnlen+0xf>
        cnt ++;
    }
    return cnt;
  105c5c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  105c5f:	c9                   	leave  
  105c60:	c3                   	ret    

00105c61 <strcpy>:
 * To avoid overflows, the size of array pointed by @dst should be long enough to
 * contain the same string as @src (including the terminating null character), and
 * should not overlap in memory with @src.
 * */
char *
strcpy(char *dst, const char *src) {
  105c61:	55                   	push   %ebp
  105c62:	89 e5                	mov    %esp,%ebp
  105c64:	57                   	push   %edi
  105c65:	56                   	push   %esi
  105c66:	83 ec 20             	sub    $0x20,%esp
  105c69:	8b 45 08             	mov    0x8(%ebp),%eax
  105c6c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  105c6f:	8b 45 0c             	mov    0xc(%ebp),%eax
  105c72:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_STRCPY
#define __HAVE_ARCH_STRCPY
static inline char *
__strcpy(char *dst, const char *src) {
    int d0, d1, d2;
    asm volatile (
  105c75:	8b 55 f0             	mov    -0x10(%ebp),%edx
  105c78:	8b 45 f4             	mov    -0xc(%ebp),%eax
  105c7b:	89 d1                	mov    %edx,%ecx
  105c7d:	89 c2                	mov    %eax,%edx
  105c7f:	89 ce                	mov    %ecx,%esi
  105c81:	89 d7                	mov    %edx,%edi
  105c83:	ac                   	lods   %ds:(%esi),%al
  105c84:	aa                   	stos   %al,%es:(%edi)
  105c85:	84 c0                	test   %al,%al
  105c87:	75 fa                	jne    105c83 <strcpy+0x22>
  105c89:	89 fa                	mov    %edi,%edx
  105c8b:	89 f1                	mov    %esi,%ecx
  105c8d:	89 4d ec             	mov    %ecx,-0x14(%ebp)
  105c90:	89 55 e8             	mov    %edx,-0x18(%ebp)
  105c93:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        "stosb;"
        "testb %%al, %%al;"
        "jne 1b;"
        : "=&S" (d0), "=&D" (d1), "=&a" (d2)
        : "0" (src), "1" (dst) : "memory");
    return dst;
  105c96:	8b 45 f4             	mov    -0xc(%ebp),%eax
    char *p = dst;
    while ((*p ++ = *src ++) != '\0')
        /* nothing */;
    return dst;
#endif /* __HAVE_ARCH_STRCPY */
}
  105c99:	83 c4 20             	add    $0x20,%esp
  105c9c:	5e                   	pop    %esi
  105c9d:	5f                   	pop    %edi
  105c9e:	5d                   	pop    %ebp
  105c9f:	c3                   	ret    

00105ca0 <strncpy>:
 * @len:    maximum number of characters to be copied from @src
 *
 * The return value is @dst
 * */
char *
strncpy(char *dst, const char *src, size_t len) {
  105ca0:	55                   	push   %ebp
  105ca1:	89 e5                	mov    %esp,%ebp
  105ca3:	83 ec 10             	sub    $0x10,%esp
    char *p = dst;
  105ca6:	8b 45 08             	mov    0x8(%ebp),%eax
  105ca9:	89 45 fc             	mov    %eax,-0x4(%ebp)
    while (len > 0) {
  105cac:	eb 21                	jmp    105ccf <strncpy+0x2f>
        if ((*p = *src) != '\0') {
  105cae:	8b 45 0c             	mov    0xc(%ebp),%eax
  105cb1:	0f b6 10             	movzbl (%eax),%edx
  105cb4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  105cb7:	88 10                	mov    %dl,(%eax)
  105cb9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  105cbc:	0f b6 00             	movzbl (%eax),%eax
  105cbf:	84 c0                	test   %al,%al
  105cc1:	74 04                	je     105cc7 <strncpy+0x27>
            src ++;
  105cc3:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
        }
        p ++, len --;
  105cc7:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  105ccb:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
 * The return value is @dst
 * */
char *
strncpy(char *dst, const char *src, size_t len) {
    char *p = dst;
    while (len > 0) {
  105ccf:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  105cd3:	75 d9                	jne    105cae <strncpy+0xe>
        if ((*p = *src) != '\0') {
            src ++;
        }
        p ++, len --;
    }
    return dst;
  105cd5:	8b 45 08             	mov    0x8(%ebp),%eax
}
  105cd8:	c9                   	leave  
  105cd9:	c3                   	ret    

00105cda <strcmp>:
 * - A value greater than zero indicates that the first character that does
 *   not match has a greater value in @s1 than in @s2;
 * - And a value less than zero indicates the opposite.
 * */
int
strcmp(const char *s1, const char *s2) {
  105cda:	55                   	push   %ebp
  105cdb:	89 e5                	mov    %esp,%ebp
  105cdd:	57                   	push   %edi
  105cde:	56                   	push   %esi
  105cdf:	83 ec 20             	sub    $0x20,%esp
  105ce2:	8b 45 08             	mov    0x8(%ebp),%eax
  105ce5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  105ce8:	8b 45 0c             	mov    0xc(%ebp),%eax
  105ceb:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_STRCMP
#define __HAVE_ARCH_STRCMP
static inline int
__strcmp(const char *s1, const char *s2) {
    int d0, d1, ret;
    asm volatile (
  105cee:	8b 55 f4             	mov    -0xc(%ebp),%edx
  105cf1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  105cf4:	89 d1                	mov    %edx,%ecx
  105cf6:	89 c2                	mov    %eax,%edx
  105cf8:	89 ce                	mov    %ecx,%esi
  105cfa:	89 d7                	mov    %edx,%edi
  105cfc:	ac                   	lods   %ds:(%esi),%al
  105cfd:	ae                   	scas   %es:(%edi),%al
  105cfe:	75 08                	jne    105d08 <strcmp+0x2e>
  105d00:	84 c0                	test   %al,%al
  105d02:	75 f8                	jne    105cfc <strcmp+0x22>
  105d04:	31 c0                	xor    %eax,%eax
  105d06:	eb 04                	jmp    105d0c <strcmp+0x32>
  105d08:	19 c0                	sbb    %eax,%eax
  105d0a:	0c 01                	or     $0x1,%al
  105d0c:	89 fa                	mov    %edi,%edx
  105d0e:	89 f1                	mov    %esi,%ecx
  105d10:	89 45 ec             	mov    %eax,-0x14(%ebp)
  105d13:	89 4d e8             	mov    %ecx,-0x18(%ebp)
  105d16:	89 55 e4             	mov    %edx,-0x1c(%ebp)
        "orb $1, %%al;"
        "3:"
        : "=a" (ret), "=&S" (d0), "=&D" (d1)
        : "1" (s1), "2" (s2)
        : "memory");
    return ret;
  105d19:	8b 45 ec             	mov    -0x14(%ebp),%eax
    while (*s1 != '\0' && *s1 == *s2) {
        s1 ++, s2 ++;
    }
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
#endif /* __HAVE_ARCH_STRCMP */
}
  105d1c:	83 c4 20             	add    $0x20,%esp
  105d1f:	5e                   	pop    %esi
  105d20:	5f                   	pop    %edi
  105d21:	5d                   	pop    %ebp
  105d22:	c3                   	ret    

00105d23 <strncmp>:
 * they are equal to each other, it continues with the following pairs until
 * the characters differ, until a terminating null-character is reached, or
 * until @n characters match in both strings, whichever happens first.
 * */
int
strncmp(const char *s1, const char *s2, size_t n) {
  105d23:	55                   	push   %ebp
  105d24:	89 e5                	mov    %esp,%ebp
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
  105d26:	eb 0c                	jmp    105d34 <strncmp+0x11>
        n --, s1 ++, s2 ++;
  105d28:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  105d2c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  105d30:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
 * the characters differ, until a terminating null-character is reached, or
 * until @n characters match in both strings, whichever happens first.
 * */
int
strncmp(const char *s1, const char *s2, size_t n) {
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
  105d34:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  105d38:	74 1a                	je     105d54 <strncmp+0x31>
  105d3a:	8b 45 08             	mov    0x8(%ebp),%eax
  105d3d:	0f b6 00             	movzbl (%eax),%eax
  105d40:	84 c0                	test   %al,%al
  105d42:	74 10                	je     105d54 <strncmp+0x31>
  105d44:	8b 45 08             	mov    0x8(%ebp),%eax
  105d47:	0f b6 10             	movzbl (%eax),%edx
  105d4a:	8b 45 0c             	mov    0xc(%ebp),%eax
  105d4d:	0f b6 00             	movzbl (%eax),%eax
  105d50:	38 c2                	cmp    %al,%dl
  105d52:	74 d4                	je     105d28 <strncmp+0x5>
        n --, s1 ++, s2 ++;
    }
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
  105d54:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  105d58:	74 18                	je     105d72 <strncmp+0x4f>
  105d5a:	8b 45 08             	mov    0x8(%ebp),%eax
  105d5d:	0f b6 00             	movzbl (%eax),%eax
  105d60:	0f b6 d0             	movzbl %al,%edx
  105d63:	8b 45 0c             	mov    0xc(%ebp),%eax
  105d66:	0f b6 00             	movzbl (%eax),%eax
  105d69:	0f b6 c0             	movzbl %al,%eax
  105d6c:	29 c2                	sub    %eax,%edx
  105d6e:	89 d0                	mov    %edx,%eax
  105d70:	eb 05                	jmp    105d77 <strncmp+0x54>
  105d72:	b8 00 00 00 00       	mov    $0x0,%eax
}
  105d77:	5d                   	pop    %ebp
  105d78:	c3                   	ret    

00105d79 <strchr>:
 *
 * The strchr() function returns a pointer to the first occurrence of
 * character in @s. If the value is not found, the function returns 'NULL'.
 * */
char *
strchr(const char *s, char c) {
  105d79:	55                   	push   %ebp
  105d7a:	89 e5                	mov    %esp,%ebp
  105d7c:	83 ec 04             	sub    $0x4,%esp
  105d7f:	8b 45 0c             	mov    0xc(%ebp),%eax
  105d82:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
  105d85:	eb 14                	jmp    105d9b <strchr+0x22>
        if (*s == c) {
  105d87:	8b 45 08             	mov    0x8(%ebp),%eax
  105d8a:	0f b6 00             	movzbl (%eax),%eax
  105d8d:	3a 45 fc             	cmp    -0x4(%ebp),%al
  105d90:	75 05                	jne    105d97 <strchr+0x1e>
            return (char *)s;
  105d92:	8b 45 08             	mov    0x8(%ebp),%eax
  105d95:	eb 13                	jmp    105daa <strchr+0x31>
        }
        s ++;
  105d97:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 * The strchr() function returns a pointer to the first occurrence of
 * character in @s. If the value is not found, the function returns 'NULL'.
 * */
char *
strchr(const char *s, char c) {
    while (*s != '\0') {
  105d9b:	8b 45 08             	mov    0x8(%ebp),%eax
  105d9e:	0f b6 00             	movzbl (%eax),%eax
  105da1:	84 c0                	test   %al,%al
  105da3:	75 e2                	jne    105d87 <strchr+0xe>
        if (*s == c) {
            return (char *)s;
        }
        s ++;
    }
    return NULL;
  105da5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  105daa:	c9                   	leave  
  105dab:	c3                   	ret    

00105dac <strfind>:
 * The strfind() function is like strchr() except that if @c is
 * not found in @s, then it returns a pointer to the null byte at the
 * end of @s, rather than 'NULL'.
 * */
char *
strfind(const char *s, char c) {
  105dac:	55                   	push   %ebp
  105dad:	89 e5                	mov    %esp,%ebp
  105daf:	83 ec 04             	sub    $0x4,%esp
  105db2:	8b 45 0c             	mov    0xc(%ebp),%eax
  105db5:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
  105db8:	eb 11                	jmp    105dcb <strfind+0x1f>
        if (*s == c) {
  105dba:	8b 45 08             	mov    0x8(%ebp),%eax
  105dbd:	0f b6 00             	movzbl (%eax),%eax
  105dc0:	3a 45 fc             	cmp    -0x4(%ebp),%al
  105dc3:	75 02                	jne    105dc7 <strfind+0x1b>
            break;
  105dc5:	eb 0e                	jmp    105dd5 <strfind+0x29>
        }
        s ++;
  105dc7:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 * not found in @s, then it returns a pointer to the null byte at the
 * end of @s, rather than 'NULL'.
 * */
char *
strfind(const char *s, char c) {
    while (*s != '\0') {
  105dcb:	8b 45 08             	mov    0x8(%ebp),%eax
  105dce:	0f b6 00             	movzbl (%eax),%eax
  105dd1:	84 c0                	test   %al,%al
  105dd3:	75 e5                	jne    105dba <strfind+0xe>
        if (*s == c) {
            break;
        }
        s ++;
    }
    return (char *)s;
  105dd5:	8b 45 08             	mov    0x8(%ebp),%eax
}
  105dd8:	c9                   	leave  
  105dd9:	c3                   	ret    

00105dda <strtol>:
 * an optional "0x" or "0X" prefix.
 *
 * The strtol() function returns the converted integral number as a long int value.
 * */
long
strtol(const char *s, char **endptr, int base) {
  105dda:	55                   	push   %ebp
  105ddb:	89 e5                	mov    %esp,%ebp
  105ddd:	83 ec 10             	sub    $0x10,%esp
    int neg = 0;
  105de0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    long val = 0;
  105de7:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t') {
  105dee:	eb 04                	jmp    105df4 <strtol+0x1a>
        s ++;
  105df0:	83 45 08 01          	addl   $0x1,0x8(%ebp)
strtol(const char *s, char **endptr, int base) {
    int neg = 0;
    long val = 0;

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t') {
  105df4:	8b 45 08             	mov    0x8(%ebp),%eax
  105df7:	0f b6 00             	movzbl (%eax),%eax
  105dfa:	3c 20                	cmp    $0x20,%al
  105dfc:	74 f2                	je     105df0 <strtol+0x16>
  105dfe:	8b 45 08             	mov    0x8(%ebp),%eax
  105e01:	0f b6 00             	movzbl (%eax),%eax
  105e04:	3c 09                	cmp    $0x9,%al
  105e06:	74 e8                	je     105df0 <strtol+0x16>
        s ++;
    }

    // plus/minus sign
    if (*s == '+') {
  105e08:	8b 45 08             	mov    0x8(%ebp),%eax
  105e0b:	0f b6 00             	movzbl (%eax),%eax
  105e0e:	3c 2b                	cmp    $0x2b,%al
  105e10:	75 06                	jne    105e18 <strtol+0x3e>
        s ++;
  105e12:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  105e16:	eb 15                	jmp    105e2d <strtol+0x53>
    }
    else if (*s == '-') {
  105e18:	8b 45 08             	mov    0x8(%ebp),%eax
  105e1b:	0f b6 00             	movzbl (%eax),%eax
  105e1e:	3c 2d                	cmp    $0x2d,%al
  105e20:	75 0b                	jne    105e2d <strtol+0x53>
        s ++, neg = 1;
  105e22:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  105e26:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
    }

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x')) {
  105e2d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  105e31:	74 06                	je     105e39 <strtol+0x5f>
  105e33:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  105e37:	75 24                	jne    105e5d <strtol+0x83>
  105e39:	8b 45 08             	mov    0x8(%ebp),%eax
  105e3c:	0f b6 00             	movzbl (%eax),%eax
  105e3f:	3c 30                	cmp    $0x30,%al
  105e41:	75 1a                	jne    105e5d <strtol+0x83>
  105e43:	8b 45 08             	mov    0x8(%ebp),%eax
  105e46:	83 c0 01             	add    $0x1,%eax
  105e49:	0f b6 00             	movzbl (%eax),%eax
  105e4c:	3c 78                	cmp    $0x78,%al
  105e4e:	75 0d                	jne    105e5d <strtol+0x83>
        s += 2, base = 16;
  105e50:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  105e54:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  105e5b:	eb 2a                	jmp    105e87 <strtol+0xad>
    }
    else if (base == 0 && s[0] == '0') {
  105e5d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  105e61:	75 17                	jne    105e7a <strtol+0xa0>
  105e63:	8b 45 08             	mov    0x8(%ebp),%eax
  105e66:	0f b6 00             	movzbl (%eax),%eax
  105e69:	3c 30                	cmp    $0x30,%al
  105e6b:	75 0d                	jne    105e7a <strtol+0xa0>
        s ++, base = 8;
  105e6d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  105e71:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  105e78:	eb 0d                	jmp    105e87 <strtol+0xad>
    }
    else if (base == 0) {
  105e7a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  105e7e:	75 07                	jne    105e87 <strtol+0xad>
        base = 10;
  105e80:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9') {
  105e87:	8b 45 08             	mov    0x8(%ebp),%eax
  105e8a:	0f b6 00             	movzbl (%eax),%eax
  105e8d:	3c 2f                	cmp    $0x2f,%al
  105e8f:	7e 1b                	jle    105eac <strtol+0xd2>
  105e91:	8b 45 08             	mov    0x8(%ebp),%eax
  105e94:	0f b6 00             	movzbl (%eax),%eax
  105e97:	3c 39                	cmp    $0x39,%al
  105e99:	7f 11                	jg     105eac <strtol+0xd2>
            dig = *s - '0';
  105e9b:	8b 45 08             	mov    0x8(%ebp),%eax
  105e9e:	0f b6 00             	movzbl (%eax),%eax
  105ea1:	0f be c0             	movsbl %al,%eax
  105ea4:	83 e8 30             	sub    $0x30,%eax
  105ea7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  105eaa:	eb 48                	jmp    105ef4 <strtol+0x11a>
        }
        else if (*s >= 'a' && *s <= 'z') {
  105eac:	8b 45 08             	mov    0x8(%ebp),%eax
  105eaf:	0f b6 00             	movzbl (%eax),%eax
  105eb2:	3c 60                	cmp    $0x60,%al
  105eb4:	7e 1b                	jle    105ed1 <strtol+0xf7>
  105eb6:	8b 45 08             	mov    0x8(%ebp),%eax
  105eb9:	0f b6 00             	movzbl (%eax),%eax
  105ebc:	3c 7a                	cmp    $0x7a,%al
  105ebe:	7f 11                	jg     105ed1 <strtol+0xf7>
            dig = *s - 'a' + 10;
  105ec0:	8b 45 08             	mov    0x8(%ebp),%eax
  105ec3:	0f b6 00             	movzbl (%eax),%eax
  105ec6:	0f be c0             	movsbl %al,%eax
  105ec9:	83 e8 57             	sub    $0x57,%eax
  105ecc:	89 45 f4             	mov    %eax,-0xc(%ebp)
  105ecf:	eb 23                	jmp    105ef4 <strtol+0x11a>
        }
        else if (*s >= 'A' && *s <= 'Z') {
  105ed1:	8b 45 08             	mov    0x8(%ebp),%eax
  105ed4:	0f b6 00             	movzbl (%eax),%eax
  105ed7:	3c 40                	cmp    $0x40,%al
  105ed9:	7e 3d                	jle    105f18 <strtol+0x13e>
  105edb:	8b 45 08             	mov    0x8(%ebp),%eax
  105ede:	0f b6 00             	movzbl (%eax),%eax
  105ee1:	3c 5a                	cmp    $0x5a,%al
  105ee3:	7f 33                	jg     105f18 <strtol+0x13e>
            dig = *s - 'A' + 10;
  105ee5:	8b 45 08             	mov    0x8(%ebp),%eax
  105ee8:	0f b6 00             	movzbl (%eax),%eax
  105eeb:	0f be c0             	movsbl %al,%eax
  105eee:	83 e8 37             	sub    $0x37,%eax
  105ef1:	89 45 f4             	mov    %eax,-0xc(%ebp)
        }
        else {
            break;
        }
        if (dig >= base) {
  105ef4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  105ef7:	3b 45 10             	cmp    0x10(%ebp),%eax
  105efa:	7c 02                	jl     105efe <strtol+0x124>
            break;
  105efc:	eb 1a                	jmp    105f18 <strtol+0x13e>
        }
        s ++, val = (val * base) + dig;
  105efe:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  105f02:	8b 45 f8             	mov    -0x8(%ebp),%eax
  105f05:	0f af 45 10          	imul   0x10(%ebp),%eax
  105f09:	89 c2                	mov    %eax,%edx
  105f0b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  105f0e:	01 d0                	add    %edx,%eax
  105f10:	89 45 f8             	mov    %eax,-0x8(%ebp)
        // we don't properly detect overflow!
    }
  105f13:	e9 6f ff ff ff       	jmp    105e87 <strtol+0xad>

    if (endptr) {
  105f18:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  105f1c:	74 08                	je     105f26 <strtol+0x14c>
        *endptr = (char *) s;
  105f1e:	8b 45 0c             	mov    0xc(%ebp),%eax
  105f21:	8b 55 08             	mov    0x8(%ebp),%edx
  105f24:	89 10                	mov    %edx,(%eax)
    }
    return (neg ? -val : val);
  105f26:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  105f2a:	74 07                	je     105f33 <strtol+0x159>
  105f2c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  105f2f:	f7 d8                	neg    %eax
  105f31:	eb 03                	jmp    105f36 <strtol+0x15c>
  105f33:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  105f36:	c9                   	leave  
  105f37:	c3                   	ret    

00105f38 <memset>:
 * @n:      number of bytes to be set to the value
 *
 * The memset() function returns @s.
 * */
void *
memset(void *s, char c, size_t n) {
  105f38:	55                   	push   %ebp
  105f39:	89 e5                	mov    %esp,%ebp
  105f3b:	57                   	push   %edi
  105f3c:	83 ec 24             	sub    $0x24,%esp
  105f3f:	8b 45 0c             	mov    0xc(%ebp),%eax
  105f42:	88 45 d8             	mov    %al,-0x28(%ebp)
#ifdef __HAVE_ARCH_MEMSET
    return __memset(s, c, n);
  105f45:	0f be 45 d8          	movsbl -0x28(%ebp),%eax
  105f49:	8b 55 08             	mov    0x8(%ebp),%edx
  105f4c:	89 55 f8             	mov    %edx,-0x8(%ebp)
  105f4f:	88 45 f7             	mov    %al,-0x9(%ebp)
  105f52:	8b 45 10             	mov    0x10(%ebp),%eax
  105f55:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_MEMSET
#define __HAVE_ARCH_MEMSET
static inline void *
__memset(void *s, char c, size_t n) {
    int d0, d1;
    asm volatile (
  105f58:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  105f5b:	0f b6 45 f7          	movzbl -0x9(%ebp),%eax
  105f5f:	8b 55 f8             	mov    -0x8(%ebp),%edx
  105f62:	89 d7                	mov    %edx,%edi
  105f64:	f3 aa                	rep stos %al,%es:(%edi)
  105f66:	89 fa                	mov    %edi,%edx
  105f68:	89 4d ec             	mov    %ecx,-0x14(%ebp)
  105f6b:	89 55 e8             	mov    %edx,-0x18(%ebp)
        "rep; stosb;"
        : "=&c" (d0), "=&D" (d1)
        : "0" (n), "a" (c), "1" (s)
        : "memory");
    return s;
  105f6e:	8b 45 f8             	mov    -0x8(%ebp),%eax
    while (n -- > 0) {
        *p ++ = c;
    }
    return s;
#endif /* __HAVE_ARCH_MEMSET */
}
  105f71:	83 c4 24             	add    $0x24,%esp
  105f74:	5f                   	pop    %edi
  105f75:	5d                   	pop    %ebp
  105f76:	c3                   	ret    

00105f77 <memmove>:
 * @n:      number of bytes to copy
 *
 * The memmove() function returns @dst.
 * */
void *
memmove(void *dst, const void *src, size_t n) {
  105f77:	55                   	push   %ebp
  105f78:	89 e5                	mov    %esp,%ebp
  105f7a:	57                   	push   %edi
  105f7b:	56                   	push   %esi
  105f7c:	53                   	push   %ebx
  105f7d:	83 ec 30             	sub    $0x30,%esp
  105f80:	8b 45 08             	mov    0x8(%ebp),%eax
  105f83:	89 45 f0             	mov    %eax,-0x10(%ebp)
  105f86:	8b 45 0c             	mov    0xc(%ebp),%eax
  105f89:	89 45 ec             	mov    %eax,-0x14(%ebp)
  105f8c:	8b 45 10             	mov    0x10(%ebp),%eax
  105f8f:	89 45 e8             	mov    %eax,-0x18(%ebp)

#ifndef __HAVE_ARCH_MEMMOVE
#define __HAVE_ARCH_MEMMOVE
static inline void *
__memmove(void *dst, const void *src, size_t n) {
    if (dst < src) {
  105f92:	8b 45 f0             	mov    -0x10(%ebp),%eax
  105f95:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  105f98:	73 42                	jae    105fdc <memmove+0x65>
  105f9a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  105f9d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  105fa0:	8b 45 ec             	mov    -0x14(%ebp),%eax
  105fa3:	89 45 e0             	mov    %eax,-0x20(%ebp)
  105fa6:	8b 45 e8             	mov    -0x18(%ebp),%eax
  105fa9:	89 45 dc             	mov    %eax,-0x24(%ebp)
        "andl $3, %%ecx;"
        "jz 1f;"
        "rep; movsb;"
        "1:"
        : "=&c" (d0), "=&D" (d1), "=&S" (d2)
        : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
  105fac:	8b 45 dc             	mov    -0x24(%ebp),%eax
  105faf:	c1 e8 02             	shr    $0x2,%eax
  105fb2:	89 c1                	mov    %eax,%ecx
#ifndef __HAVE_ARCH_MEMCPY
#define __HAVE_ARCH_MEMCPY
static inline void *
__memcpy(void *dst, const void *src, size_t n) {
    int d0, d1, d2;
    asm volatile (
  105fb4:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  105fb7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  105fba:	89 d7                	mov    %edx,%edi
  105fbc:	89 c6                	mov    %eax,%esi
  105fbe:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  105fc0:	8b 4d dc             	mov    -0x24(%ebp),%ecx
  105fc3:	83 e1 03             	and    $0x3,%ecx
  105fc6:	74 02                	je     105fca <memmove+0x53>
  105fc8:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  105fca:	89 f0                	mov    %esi,%eax
  105fcc:	89 fa                	mov    %edi,%edx
  105fce:	89 4d d8             	mov    %ecx,-0x28(%ebp)
  105fd1:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  105fd4:	89 45 d0             	mov    %eax,-0x30(%ebp)
        "rep; movsb;"
        "1:"
        : "=&c" (d0), "=&D" (d1), "=&S" (d2)
        : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
        : "memory");
    return dst;
  105fd7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  105fda:	eb 36                	jmp    106012 <memmove+0x9b>
    asm volatile (
        "std;"
        "rep; movsb;"
        "cld;"
        : "=&c" (d0), "=&S" (d1), "=&D" (d2)
        : "0" (n), "1" (n - 1 + src), "2" (n - 1 + dst)
  105fdc:	8b 45 e8             	mov    -0x18(%ebp),%eax
  105fdf:	8d 50 ff             	lea    -0x1(%eax),%edx
  105fe2:	8b 45 ec             	mov    -0x14(%ebp),%eax
  105fe5:	01 c2                	add    %eax,%edx
  105fe7:	8b 45 e8             	mov    -0x18(%ebp),%eax
  105fea:	8d 48 ff             	lea    -0x1(%eax),%ecx
  105fed:	8b 45 f0             	mov    -0x10(%ebp),%eax
  105ff0:	8d 1c 01             	lea    (%ecx,%eax,1),%ebx
__memmove(void *dst, const void *src, size_t n) {
    if (dst < src) {
        return __memcpy(dst, src, n);
    }
    int d0, d1, d2;
    asm volatile (
  105ff3:	8b 45 e8             	mov    -0x18(%ebp),%eax
  105ff6:	89 c1                	mov    %eax,%ecx
  105ff8:	89 d8                	mov    %ebx,%eax
  105ffa:	89 d6                	mov    %edx,%esi
  105ffc:	89 c7                	mov    %eax,%edi
  105ffe:	fd                   	std    
  105fff:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  106001:	fc                   	cld    
  106002:	89 f8                	mov    %edi,%eax
  106004:	89 f2                	mov    %esi,%edx
  106006:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  106009:	89 55 c8             	mov    %edx,-0x38(%ebp)
  10600c:	89 45 c4             	mov    %eax,-0x3c(%ebp)
        "rep; movsb;"
        "cld;"
        : "=&c" (d0), "=&S" (d1), "=&D" (d2)
        : "0" (n), "1" (n - 1 + src), "2" (n - 1 + dst)
        : "memory");
    return dst;
  10600f:	8b 45 f0             	mov    -0x10(%ebp),%eax
            *d ++ = *s ++;
        }
    }
    return dst;
#endif /* __HAVE_ARCH_MEMMOVE */
}
  106012:	83 c4 30             	add    $0x30,%esp
  106015:	5b                   	pop    %ebx
  106016:	5e                   	pop    %esi
  106017:	5f                   	pop    %edi
  106018:	5d                   	pop    %ebp
  106019:	c3                   	ret    

0010601a <memcpy>:
 * it always copies exactly @n bytes. To avoid overflows, the size of arrays pointed
 * by both @src and @dst, should be at least @n bytes, and should not overlap
 * (for overlapping memory area, memmove is a safer approach).
 * */
void *
memcpy(void *dst, const void *src, size_t n) {
  10601a:	55                   	push   %ebp
  10601b:	89 e5                	mov    %esp,%ebp
  10601d:	57                   	push   %edi
  10601e:	56                   	push   %esi
  10601f:	83 ec 20             	sub    $0x20,%esp
  106022:	8b 45 08             	mov    0x8(%ebp),%eax
  106025:	89 45 f4             	mov    %eax,-0xc(%ebp)
  106028:	8b 45 0c             	mov    0xc(%ebp),%eax
  10602b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  10602e:	8b 45 10             	mov    0x10(%ebp),%eax
  106031:	89 45 ec             	mov    %eax,-0x14(%ebp)
        "andl $3, %%ecx;"
        "jz 1f;"
        "rep; movsb;"
        "1:"
        : "=&c" (d0), "=&D" (d1), "=&S" (d2)
        : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
  106034:	8b 45 ec             	mov    -0x14(%ebp),%eax
  106037:	c1 e8 02             	shr    $0x2,%eax
  10603a:	89 c1                	mov    %eax,%ecx
#ifndef __HAVE_ARCH_MEMCPY
#define __HAVE_ARCH_MEMCPY
static inline void *
__memcpy(void *dst, const void *src, size_t n) {
    int d0, d1, d2;
    asm volatile (
  10603c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  10603f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  106042:	89 d7                	mov    %edx,%edi
  106044:	89 c6                	mov    %eax,%esi
  106046:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  106048:	8b 4d ec             	mov    -0x14(%ebp),%ecx
  10604b:	83 e1 03             	and    $0x3,%ecx
  10604e:	74 02                	je     106052 <memcpy+0x38>
  106050:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  106052:	89 f0                	mov    %esi,%eax
  106054:	89 fa                	mov    %edi,%edx
  106056:	89 4d e8             	mov    %ecx,-0x18(%ebp)
  106059:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  10605c:	89 45 e0             	mov    %eax,-0x20(%ebp)
        "rep; movsb;"
        "1:"
        : "=&c" (d0), "=&D" (d1), "=&S" (d2)
        : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
        : "memory");
    return dst;
  10605f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    while (n -- > 0) {
        *d ++ = *s ++;
    }
    return dst;
#endif /* __HAVE_ARCH_MEMCPY */
}
  106062:	83 c4 20             	add    $0x20,%esp
  106065:	5e                   	pop    %esi
  106066:	5f                   	pop    %edi
  106067:	5d                   	pop    %ebp
  106068:	c3                   	ret    

00106069 <memcmp>:
 *   match in both memory blocks has a greater value in @v1 than in @v2
 *   as if evaluated as unsigned char values;
 * - And a value less than zero indicates the opposite.
 * */
int
memcmp(const void *v1, const void *v2, size_t n) {
  106069:	55                   	push   %ebp
  10606a:	89 e5                	mov    %esp,%ebp
  10606c:	83 ec 10             	sub    $0x10,%esp
    const char *s1 = (const char *)v1;
  10606f:	8b 45 08             	mov    0x8(%ebp),%eax
  106072:	89 45 fc             	mov    %eax,-0x4(%ebp)
    const char *s2 = (const char *)v2;
  106075:	8b 45 0c             	mov    0xc(%ebp),%eax
  106078:	89 45 f8             	mov    %eax,-0x8(%ebp)
    while (n -- > 0) {
  10607b:	eb 30                	jmp    1060ad <memcmp+0x44>
        if (*s1 != *s2) {
  10607d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  106080:	0f b6 10             	movzbl (%eax),%edx
  106083:	8b 45 f8             	mov    -0x8(%ebp),%eax
  106086:	0f b6 00             	movzbl (%eax),%eax
  106089:	38 c2                	cmp    %al,%dl
  10608b:	74 18                	je     1060a5 <memcmp+0x3c>
            return (int)((unsigned char)*s1 - (unsigned char)*s2);
  10608d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  106090:	0f b6 00             	movzbl (%eax),%eax
  106093:	0f b6 d0             	movzbl %al,%edx
  106096:	8b 45 f8             	mov    -0x8(%ebp),%eax
  106099:	0f b6 00             	movzbl (%eax),%eax
  10609c:	0f b6 c0             	movzbl %al,%eax
  10609f:	29 c2                	sub    %eax,%edx
  1060a1:	89 d0                	mov    %edx,%eax
  1060a3:	eb 1a                	jmp    1060bf <memcmp+0x56>
        }
        s1 ++, s2 ++;
  1060a5:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  1060a9:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
 * */
int
memcmp(const void *v1, const void *v2, size_t n) {
    const char *s1 = (const char *)v1;
    const char *s2 = (const char *)v2;
    while (n -- > 0) {
  1060ad:	8b 45 10             	mov    0x10(%ebp),%eax
  1060b0:	8d 50 ff             	lea    -0x1(%eax),%edx
  1060b3:	89 55 10             	mov    %edx,0x10(%ebp)
  1060b6:	85 c0                	test   %eax,%eax
  1060b8:	75 c3                	jne    10607d <memcmp+0x14>
        if (*s1 != *s2) {
            return (int)((unsigned char)*s1 - (unsigned char)*s2);
        }
        s1 ++, s2 ++;
    }
    return 0;
  1060ba:	b8 00 00 00 00       	mov    $0x0,%eax
}
  1060bf:	c9                   	leave  
  1060c0:	c3                   	ret    
