
bin/kernel:     file format elf32-i386


Disassembly of section .text:

00100000 <kern_init>:
int kern_init(void) __attribute__((noreturn));
void grade_backtrace(void);
static void lab1_switch_test(void);

int
kern_init(void) {
  100000:	55                   	push   %ebp
  100001:	89 e5                	mov    %esp,%ebp
  100003:	83 ec 28             	sub    $0x28,%esp
    extern char edata[], end[];
    memset(edata, 0, end - edata);
  100006:	ba 80 fd 10 00       	mov    $0x10fd80,%edx
  10000b:	b8 16 ea 10 00       	mov    $0x10ea16,%eax
  100010:	29 c2                	sub    %eax,%edx
  100012:	89 d0                	mov    %edx,%eax
  100014:	89 44 24 08          	mov    %eax,0x8(%esp)
  100018:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  10001f:	00 
  100020:	c7 04 24 16 ea 10 00 	movl   $0x10ea16,(%esp)
  100027:	e8 07 34 00 00       	call   103433 <memset>

    cons_init();                // init the console
  10002c:	e8 82 15 00 00       	call   1015b3 <cons_init>

    const char *message = "(THU.CST) os is loading ...";
  100031:	c7 45 f4 c0 35 10 00 	movl   $0x1035c0,-0xc(%ebp)
    cprintf("%s\n\n", message);
  100038:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10003b:	89 44 24 04          	mov    %eax,0x4(%esp)
  10003f:	c7 04 24 dc 35 10 00 	movl   $0x1035dc,(%esp)
  100046:	e8 d7 02 00 00       	call   100322 <cprintf>

    print_kerninfo();
  10004b:	e8 06 08 00 00       	call   100856 <print_kerninfo>

    grade_backtrace();
  100050:	e8 8b 00 00 00       	call   1000e0 <grade_backtrace>

    pmm_init();                 // init physical memory management
  100055:	e8 1f 2a 00 00       	call   102a79 <pmm_init>

    pic_init();                 // init interrupt controller
  10005a:	e8 97 16 00 00       	call   1016f6 <pic_init>
    idt_init();                 // init interrupt descriptor table
  10005f:	e8 0f 18 00 00       	call   101873 <idt_init>

    clock_init();               // init clock interrupt
  100064:	e8 3d 0d 00 00       	call   100da6 <clock_init>
    intr_enable();              // enable irq interrupt
  100069:	e8 f6 15 00 00       	call   101664 <intr_enable>

    //LAB1: CAHLLENGE 1 If you try to do it, uncomment lab1_switch_test()
    // user/kernel mode switch test
    lab1_switch_test();
  10006e:	e8 6d 01 00 00       	call   1001e0 <lab1_switch_test>

    /* do nothing */
    while (1);
  100073:	eb fe                	jmp    100073 <kern_init+0x73>

00100075 <grade_backtrace2>:
}

void __attribute__((noinline))
grade_backtrace2(int arg0, int arg1, int arg2, int arg3) {
  100075:	55                   	push   %ebp
  100076:	89 e5                	mov    %esp,%ebp
  100078:	83 ec 18             	sub    $0x18,%esp
    mon_backtrace(0, NULL, NULL);
  10007b:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  100082:	00 
  100083:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  10008a:	00 
  10008b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100092:	e8 41 0c 00 00       	call   100cd8 <mon_backtrace>
}
  100097:	c9                   	leave  
  100098:	c3                   	ret    

00100099 <grade_backtrace1>:

void __attribute__((noinline))
grade_backtrace1(int arg0, int arg1) {
  100099:	55                   	push   %ebp
  10009a:	89 e5                	mov    %esp,%ebp
  10009c:	53                   	push   %ebx
  10009d:	83 ec 14             	sub    $0x14,%esp
    grade_backtrace2(arg0, (int)&arg0, arg1, (int)&arg1);
  1000a0:	8d 5d 0c             	lea    0xc(%ebp),%ebx
  1000a3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  1000a6:	8d 55 08             	lea    0x8(%ebp),%edx
  1000a9:	8b 45 08             	mov    0x8(%ebp),%eax
  1000ac:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
  1000b0:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  1000b4:	89 54 24 04          	mov    %edx,0x4(%esp)
  1000b8:	89 04 24             	mov    %eax,(%esp)
  1000bb:	e8 b5 ff ff ff       	call   100075 <grade_backtrace2>
}
  1000c0:	83 c4 14             	add    $0x14,%esp
  1000c3:	5b                   	pop    %ebx
  1000c4:	5d                   	pop    %ebp
  1000c5:	c3                   	ret    

001000c6 <grade_backtrace0>:

void __attribute__((noinline))
grade_backtrace0(int arg0, int arg1, int arg2) {
  1000c6:	55                   	push   %ebp
  1000c7:	89 e5                	mov    %esp,%ebp
  1000c9:	83 ec 18             	sub    $0x18,%esp
    grade_backtrace1(arg0, arg2);
  1000cc:	8b 45 10             	mov    0x10(%ebp),%eax
  1000cf:	89 44 24 04          	mov    %eax,0x4(%esp)
  1000d3:	8b 45 08             	mov    0x8(%ebp),%eax
  1000d6:	89 04 24             	mov    %eax,(%esp)
  1000d9:	e8 bb ff ff ff       	call   100099 <grade_backtrace1>
}
  1000de:	c9                   	leave  
  1000df:	c3                   	ret    

001000e0 <grade_backtrace>:

void
grade_backtrace(void) {
  1000e0:	55                   	push   %ebp
  1000e1:	89 e5                	mov    %esp,%ebp
  1000e3:	83 ec 18             	sub    $0x18,%esp
    grade_backtrace0(0, (int)kern_init, 0xffff0000);
  1000e6:	b8 00 00 10 00       	mov    $0x100000,%eax
  1000eb:	c7 44 24 08 00 00 ff 	movl   $0xffff0000,0x8(%esp)
  1000f2:	ff 
  1000f3:	89 44 24 04          	mov    %eax,0x4(%esp)
  1000f7:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1000fe:	e8 c3 ff ff ff       	call   1000c6 <grade_backtrace0>
}
  100103:	c9                   	leave  
  100104:	c3                   	ret    

00100105 <lab1_print_cur_status>:

static void
lab1_print_cur_status(void) {
  100105:	55                   	push   %ebp
  100106:	89 e5                	mov    %esp,%ebp
  100108:	83 ec 28             	sub    $0x28,%esp
    static int round = 0;
    uint16_t reg1, reg2, reg3, reg4;
    asm volatile (
  10010b:	8c 4d f6             	mov    %cs,-0xa(%ebp)
  10010e:	8c 5d f4             	mov    %ds,-0xc(%ebp)
  100111:	8c 45 f2             	mov    %es,-0xe(%ebp)
  100114:	8c 55 f0             	mov    %ss,-0x10(%ebp)
            "mov %%cs, %0;"
            "mov %%ds, %1;"
            "mov %%es, %2;"
            "mov %%ss, %3;"
            : "=m"(reg1), "=m"(reg2), "=m"(reg3), "=m"(reg4));
    cprintf("%d: @ring %d\n", round, reg1 & 3);
  100117:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  10011b:	0f b7 c0             	movzwl %ax,%eax
  10011e:	83 e0 03             	and    $0x3,%eax
  100121:	89 c2                	mov    %eax,%edx
  100123:	a1 20 ea 10 00       	mov    0x10ea20,%eax
  100128:	89 54 24 08          	mov    %edx,0x8(%esp)
  10012c:	89 44 24 04          	mov    %eax,0x4(%esp)
  100130:	c7 04 24 e1 35 10 00 	movl   $0x1035e1,(%esp)
  100137:	e8 e6 01 00 00       	call   100322 <cprintf>
    cprintf("%d:  cs = %x\n", round, reg1);
  10013c:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  100140:	0f b7 d0             	movzwl %ax,%edx
  100143:	a1 20 ea 10 00       	mov    0x10ea20,%eax
  100148:	89 54 24 08          	mov    %edx,0x8(%esp)
  10014c:	89 44 24 04          	mov    %eax,0x4(%esp)
  100150:	c7 04 24 ef 35 10 00 	movl   $0x1035ef,(%esp)
  100157:	e8 c6 01 00 00       	call   100322 <cprintf>
    cprintf("%d:  ds = %x\n", round, reg2);
  10015c:	0f b7 45 f4          	movzwl -0xc(%ebp),%eax
  100160:	0f b7 d0             	movzwl %ax,%edx
  100163:	a1 20 ea 10 00       	mov    0x10ea20,%eax
  100168:	89 54 24 08          	mov    %edx,0x8(%esp)
  10016c:	89 44 24 04          	mov    %eax,0x4(%esp)
  100170:	c7 04 24 fd 35 10 00 	movl   $0x1035fd,(%esp)
  100177:	e8 a6 01 00 00       	call   100322 <cprintf>
    cprintf("%d:  es = %x\n", round, reg3);
  10017c:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  100180:	0f b7 d0             	movzwl %ax,%edx
  100183:	a1 20 ea 10 00       	mov    0x10ea20,%eax
  100188:	89 54 24 08          	mov    %edx,0x8(%esp)
  10018c:	89 44 24 04          	mov    %eax,0x4(%esp)
  100190:	c7 04 24 0b 36 10 00 	movl   $0x10360b,(%esp)
  100197:	e8 86 01 00 00       	call   100322 <cprintf>
    cprintf("%d:  ss = %x\n", round, reg4);
  10019c:	0f b7 45 f0          	movzwl -0x10(%ebp),%eax
  1001a0:	0f b7 d0             	movzwl %ax,%edx
  1001a3:	a1 20 ea 10 00       	mov    0x10ea20,%eax
  1001a8:	89 54 24 08          	mov    %edx,0x8(%esp)
  1001ac:	89 44 24 04          	mov    %eax,0x4(%esp)
  1001b0:	c7 04 24 19 36 10 00 	movl   $0x103619,(%esp)
  1001b7:	e8 66 01 00 00       	call   100322 <cprintf>
    round ++;
  1001bc:	a1 20 ea 10 00       	mov    0x10ea20,%eax
  1001c1:	83 c0 01             	add    $0x1,%eax
  1001c4:	a3 20 ea 10 00       	mov    %eax,0x10ea20
}
  1001c9:	c9                   	leave  
  1001ca:	c3                   	ret    

001001cb <lab1_switch_to_user>:

static void
lab1_switch_to_user(void) {
  1001cb:	55                   	push   %ebp
  1001cc:	89 e5                	mov    %esp,%ebp
    //LAB1 CHALLENGE 1 : TODO
	asm volatile (
  1001ce:	83 ec 08             	sub    $0x8,%esp
  1001d1:	cd 78                	int    $0x78
  1001d3:	89 ec                	mov    %ebp,%esp
		    "int %0 \n"
		    "movl %%ebp, %%esp"
		    :
		    : "i"(T_SWITCH_TOU)
		);
}
  1001d5:	5d                   	pop    %ebp
  1001d6:	c3                   	ret    

001001d7 <lab1_switch_to_kernel>:

static void
lab1_switch_to_kernel(void) {
  1001d7:	55                   	push   %ebp
  1001d8:	89 e5                	mov    %esp,%ebp
    //LAB1 CHALLENGE 1 :  TODO
	asm volatile (
  1001da:	cd 79                	int    $0x79
  1001dc:	89 ec                	mov    %ebp,%esp
		    "int %0 \n"
		    "movl %%ebp, %%esp \n"
		    :
		    : "i"(T_SWITCH_TOK)
		);
}
  1001de:	5d                   	pop    %ebp
  1001df:	c3                   	ret    

001001e0 <lab1_switch_test>:

static void
lab1_switch_test(void) {
  1001e0:	55                   	push   %ebp
  1001e1:	89 e5                	mov    %esp,%ebp
  1001e3:	83 ec 18             	sub    $0x18,%esp
    lab1_print_cur_status();
  1001e6:	e8 1a ff ff ff       	call   100105 <lab1_print_cur_status>
    cprintf("+++ switch to  user  mode +++\n");
  1001eb:	c7 04 24 28 36 10 00 	movl   $0x103628,(%esp)
  1001f2:	e8 2b 01 00 00       	call   100322 <cprintf>
    lab1_switch_to_user();
  1001f7:	e8 cf ff ff ff       	call   1001cb <lab1_switch_to_user>
    lab1_print_cur_status();
  1001fc:	e8 04 ff ff ff       	call   100105 <lab1_print_cur_status>
    cprintf("+++ switch to kernel mode +++\n");
  100201:	c7 04 24 48 36 10 00 	movl   $0x103648,(%esp)
  100208:	e8 15 01 00 00       	call   100322 <cprintf>
    lab1_switch_to_kernel();
  10020d:	e8 c5 ff ff ff       	call   1001d7 <lab1_switch_to_kernel>
    lab1_print_cur_status();
  100212:	e8 ee fe ff ff       	call   100105 <lab1_print_cur_status>
}
  100217:	c9                   	leave  
  100218:	c3                   	ret    

00100219 <readline>:
 * The readline() function returns the text of the line read. If some errors
 * are happened, NULL is returned. The return value is a global variable,
 * thus it should be copied before it is used.
 * */
char *
readline(const char *prompt) {
  100219:	55                   	push   %ebp
  10021a:	89 e5                	mov    %esp,%ebp
  10021c:	83 ec 28             	sub    $0x28,%esp
    if (prompt != NULL) {
  10021f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  100223:	74 13                	je     100238 <readline+0x1f>
        cprintf("%s", prompt);
  100225:	8b 45 08             	mov    0x8(%ebp),%eax
  100228:	89 44 24 04          	mov    %eax,0x4(%esp)
  10022c:	c7 04 24 67 36 10 00 	movl   $0x103667,(%esp)
  100233:	e8 ea 00 00 00       	call   100322 <cprintf>
    }
    int i = 0, c;
  100238:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while (1) {
        c = getchar();
  10023f:	e8 66 01 00 00       	call   1003aa <getchar>
  100244:	89 45 f0             	mov    %eax,-0x10(%ebp)
        if (c < 0) {
  100247:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  10024b:	79 07                	jns    100254 <readline+0x3b>
            return NULL;
  10024d:	b8 00 00 00 00       	mov    $0x0,%eax
  100252:	eb 79                	jmp    1002cd <readline+0xb4>
        }
        else if (c >= ' ' && i < BUFSIZE - 1) {
  100254:	83 7d f0 1f          	cmpl   $0x1f,-0x10(%ebp)
  100258:	7e 28                	jle    100282 <readline+0x69>
  10025a:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  100261:	7f 1f                	jg     100282 <readline+0x69>
            cputchar(c);
  100263:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100266:	89 04 24             	mov    %eax,(%esp)
  100269:	e8 da 00 00 00       	call   100348 <cputchar>
            buf[i ++] = c;
  10026e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100271:	8d 50 01             	lea    0x1(%eax),%edx
  100274:	89 55 f4             	mov    %edx,-0xc(%ebp)
  100277:	8b 55 f0             	mov    -0x10(%ebp),%edx
  10027a:	88 90 40 ea 10 00    	mov    %dl,0x10ea40(%eax)
  100280:	eb 46                	jmp    1002c8 <readline+0xaf>
        }
        else if (c == '\b' && i > 0) {
  100282:	83 7d f0 08          	cmpl   $0x8,-0x10(%ebp)
  100286:	75 17                	jne    10029f <readline+0x86>
  100288:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  10028c:	7e 11                	jle    10029f <readline+0x86>
            cputchar(c);
  10028e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100291:	89 04 24             	mov    %eax,(%esp)
  100294:	e8 af 00 00 00       	call   100348 <cputchar>
            i --;
  100299:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
  10029d:	eb 29                	jmp    1002c8 <readline+0xaf>
        }
        else if (c == '\n' || c == '\r') {
  10029f:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
  1002a3:	74 06                	je     1002ab <readline+0x92>
  1002a5:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
  1002a9:	75 1d                	jne    1002c8 <readline+0xaf>
            cputchar(c);
  1002ab:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1002ae:	89 04 24             	mov    %eax,(%esp)
  1002b1:	e8 92 00 00 00       	call   100348 <cputchar>
            buf[i] = '\0';
  1002b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1002b9:	05 40 ea 10 00       	add    $0x10ea40,%eax
  1002be:	c6 00 00             	movb   $0x0,(%eax)
            return buf;
  1002c1:	b8 40 ea 10 00       	mov    $0x10ea40,%eax
  1002c6:	eb 05                	jmp    1002cd <readline+0xb4>
        }
    }
  1002c8:	e9 72 ff ff ff       	jmp    10023f <readline+0x26>
}
  1002cd:	c9                   	leave  
  1002ce:	c3                   	ret    

001002cf <cputch>:
/* *
 * cputch - writes a single character @c to stdout, and it will
 * increace the value of counter pointed by @cnt.
 * */
static void
cputch(int c, int *cnt) {
  1002cf:	55                   	push   %ebp
  1002d0:	89 e5                	mov    %esp,%ebp
  1002d2:	83 ec 18             	sub    $0x18,%esp
    cons_putc(c);
  1002d5:	8b 45 08             	mov    0x8(%ebp),%eax
  1002d8:	89 04 24             	mov    %eax,(%esp)
  1002db:	e8 ff 12 00 00       	call   1015df <cons_putc>
    (*cnt) ++;
  1002e0:	8b 45 0c             	mov    0xc(%ebp),%eax
  1002e3:	8b 00                	mov    (%eax),%eax
  1002e5:	8d 50 01             	lea    0x1(%eax),%edx
  1002e8:	8b 45 0c             	mov    0xc(%ebp),%eax
  1002eb:	89 10                	mov    %edx,(%eax)
}
  1002ed:	c9                   	leave  
  1002ee:	c3                   	ret    

001002ef <vcprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want cprintf() instead.
 * */
int
vcprintf(const char *fmt, va_list ap) {
  1002ef:	55                   	push   %ebp
  1002f0:	89 e5                	mov    %esp,%ebp
  1002f2:	83 ec 28             	sub    $0x28,%esp
    int cnt = 0;
  1002f5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
  1002fc:	8b 45 0c             	mov    0xc(%ebp),%eax
  1002ff:	89 44 24 0c          	mov    %eax,0xc(%esp)
  100303:	8b 45 08             	mov    0x8(%ebp),%eax
  100306:	89 44 24 08          	mov    %eax,0x8(%esp)
  10030a:	8d 45 f4             	lea    -0xc(%ebp),%eax
  10030d:	89 44 24 04          	mov    %eax,0x4(%esp)
  100311:	c7 04 24 cf 02 10 00 	movl   $0x1002cf,(%esp)
  100318:	e8 2f 29 00 00       	call   102c4c <vprintfmt>
    return cnt;
  10031d:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  100320:	c9                   	leave  
  100321:	c3                   	ret    

00100322 <cprintf>:
 *
 * The return value is the number of characters which would be
 * written to stdout.
 * */
int
cprintf(const char *fmt, ...) {
  100322:	55                   	push   %ebp
  100323:	89 e5                	mov    %esp,%ebp
  100325:	83 ec 28             	sub    $0x28,%esp
    va_list ap;
    int cnt;
    va_start(ap, fmt);
  100328:	8d 45 0c             	lea    0xc(%ebp),%eax
  10032b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    cnt = vcprintf(fmt, ap);
  10032e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100331:	89 44 24 04          	mov    %eax,0x4(%esp)
  100335:	8b 45 08             	mov    0x8(%ebp),%eax
  100338:	89 04 24             	mov    %eax,(%esp)
  10033b:	e8 af ff ff ff       	call   1002ef <vcprintf>
  100340:	89 45 f4             	mov    %eax,-0xc(%ebp)
    va_end(ap);
    return cnt;
  100343:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  100346:	c9                   	leave  
  100347:	c3                   	ret    

00100348 <cputchar>:

/* cputchar - writes a single character to stdout */
void
cputchar(int c) {
  100348:	55                   	push   %ebp
  100349:	89 e5                	mov    %esp,%ebp
  10034b:	83 ec 18             	sub    $0x18,%esp
    cons_putc(c);
  10034e:	8b 45 08             	mov    0x8(%ebp),%eax
  100351:	89 04 24             	mov    %eax,(%esp)
  100354:	e8 86 12 00 00       	call   1015df <cons_putc>
}
  100359:	c9                   	leave  
  10035a:	c3                   	ret    

0010035b <cputs>:
/* *
 * cputs- writes the string pointed by @str to stdout and
 * appends a newline character.
 * */
int
cputs(const char *str) {
  10035b:	55                   	push   %ebp
  10035c:	89 e5                	mov    %esp,%ebp
  10035e:	83 ec 28             	sub    $0x28,%esp
    int cnt = 0;
  100361:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    char c;
    while ((c = *str ++) != '\0') {
  100368:	eb 13                	jmp    10037d <cputs+0x22>
        cputch(c, &cnt);
  10036a:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  10036e:	8d 55 f0             	lea    -0x10(%ebp),%edx
  100371:	89 54 24 04          	mov    %edx,0x4(%esp)
  100375:	89 04 24             	mov    %eax,(%esp)
  100378:	e8 52 ff ff ff       	call   1002cf <cputch>
 * */
int
cputs(const char *str) {
    int cnt = 0;
    char c;
    while ((c = *str ++) != '\0') {
  10037d:	8b 45 08             	mov    0x8(%ebp),%eax
  100380:	8d 50 01             	lea    0x1(%eax),%edx
  100383:	89 55 08             	mov    %edx,0x8(%ebp)
  100386:	0f b6 00             	movzbl (%eax),%eax
  100389:	88 45 f7             	mov    %al,-0x9(%ebp)
  10038c:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
  100390:	75 d8                	jne    10036a <cputs+0xf>
        cputch(c, &cnt);
    }
    cputch('\n', &cnt);
  100392:	8d 45 f0             	lea    -0x10(%ebp),%eax
  100395:	89 44 24 04          	mov    %eax,0x4(%esp)
  100399:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
  1003a0:	e8 2a ff ff ff       	call   1002cf <cputch>
    return cnt;
  1003a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  1003a8:	c9                   	leave  
  1003a9:	c3                   	ret    

001003aa <getchar>:

/* getchar - reads a single non-zero character from stdin */
int
getchar(void) {
  1003aa:	55                   	push   %ebp
  1003ab:	89 e5                	mov    %esp,%ebp
  1003ad:	83 ec 18             	sub    $0x18,%esp
    int c;
    while ((c = cons_getc()) == 0)
  1003b0:	e8 53 12 00 00       	call   101608 <cons_getc>
  1003b5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1003b8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1003bc:	74 f2                	je     1003b0 <getchar+0x6>
        /* do nothing */;
    return c;
  1003be:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  1003c1:	c9                   	leave  
  1003c2:	c3                   	ret    

001003c3 <stab_binsearch>:
 *      stab_binsearch(stabs, &left, &right, N_SO, 0xf0100184);
 * will exit setting left = 118, right = 554.
 * */
static void
stab_binsearch(const struct stab *stabs, int *region_left, int *region_right,
           int type, uintptr_t addr) {
  1003c3:	55                   	push   %ebp
  1003c4:	89 e5                	mov    %esp,%ebp
  1003c6:	83 ec 20             	sub    $0x20,%esp
    int l = *region_left, r = *region_right, any_matches = 0;
  1003c9:	8b 45 0c             	mov    0xc(%ebp),%eax
  1003cc:	8b 00                	mov    (%eax),%eax
  1003ce:	89 45 fc             	mov    %eax,-0x4(%ebp)
  1003d1:	8b 45 10             	mov    0x10(%ebp),%eax
  1003d4:	8b 00                	mov    (%eax),%eax
  1003d6:	89 45 f8             	mov    %eax,-0x8(%ebp)
  1003d9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    while (l <= r) {
  1003e0:	e9 d2 00 00 00       	jmp    1004b7 <stab_binsearch+0xf4>
        int true_m = (l + r) / 2, m = true_m;
  1003e5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1003e8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  1003eb:	01 d0                	add    %edx,%eax
  1003ed:	89 c2                	mov    %eax,%edx
  1003ef:	c1 ea 1f             	shr    $0x1f,%edx
  1003f2:	01 d0                	add    %edx,%eax
  1003f4:	d1 f8                	sar    %eax
  1003f6:	89 45 ec             	mov    %eax,-0x14(%ebp)
  1003f9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1003fc:	89 45 f0             	mov    %eax,-0x10(%ebp)

        // search for earliest stab with right type
        while (m >= l && stabs[m].n_type != type) {
  1003ff:	eb 04                	jmp    100405 <stab_binsearch+0x42>
            m --;
  100401:	83 6d f0 01          	subl   $0x1,-0x10(%ebp)

    while (l <= r) {
        int true_m = (l + r) / 2, m = true_m;

        // search for earliest stab with right type
        while (m >= l && stabs[m].n_type != type) {
  100405:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100408:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  10040b:	7c 1f                	jl     10042c <stab_binsearch+0x69>
  10040d:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100410:	89 d0                	mov    %edx,%eax
  100412:	01 c0                	add    %eax,%eax
  100414:	01 d0                	add    %edx,%eax
  100416:	c1 e0 02             	shl    $0x2,%eax
  100419:	89 c2                	mov    %eax,%edx
  10041b:	8b 45 08             	mov    0x8(%ebp),%eax
  10041e:	01 d0                	add    %edx,%eax
  100420:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  100424:	0f b6 c0             	movzbl %al,%eax
  100427:	3b 45 14             	cmp    0x14(%ebp),%eax
  10042a:	75 d5                	jne    100401 <stab_binsearch+0x3e>
            m --;
        }
        if (m < l) {    // no match in [l, m]
  10042c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10042f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  100432:	7d 0b                	jge    10043f <stab_binsearch+0x7c>
            l = true_m + 1;
  100434:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100437:	83 c0 01             	add    $0x1,%eax
  10043a:	89 45 fc             	mov    %eax,-0x4(%ebp)
            continue;
  10043d:	eb 78                	jmp    1004b7 <stab_binsearch+0xf4>
        }

        // actual binary search
        any_matches = 1;
  10043f:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        if (stabs[m].n_value < addr) {
  100446:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100449:	89 d0                	mov    %edx,%eax
  10044b:	01 c0                	add    %eax,%eax
  10044d:	01 d0                	add    %edx,%eax
  10044f:	c1 e0 02             	shl    $0x2,%eax
  100452:	89 c2                	mov    %eax,%edx
  100454:	8b 45 08             	mov    0x8(%ebp),%eax
  100457:	01 d0                	add    %edx,%eax
  100459:	8b 40 08             	mov    0x8(%eax),%eax
  10045c:	3b 45 18             	cmp    0x18(%ebp),%eax
  10045f:	73 13                	jae    100474 <stab_binsearch+0xb1>
            *region_left = m;
  100461:	8b 45 0c             	mov    0xc(%ebp),%eax
  100464:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100467:	89 10                	mov    %edx,(%eax)
            l = true_m + 1;
  100469:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10046c:	83 c0 01             	add    $0x1,%eax
  10046f:	89 45 fc             	mov    %eax,-0x4(%ebp)
  100472:	eb 43                	jmp    1004b7 <stab_binsearch+0xf4>
        } else if (stabs[m].n_value > addr) {
  100474:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100477:	89 d0                	mov    %edx,%eax
  100479:	01 c0                	add    %eax,%eax
  10047b:	01 d0                	add    %edx,%eax
  10047d:	c1 e0 02             	shl    $0x2,%eax
  100480:	89 c2                	mov    %eax,%edx
  100482:	8b 45 08             	mov    0x8(%ebp),%eax
  100485:	01 d0                	add    %edx,%eax
  100487:	8b 40 08             	mov    0x8(%eax),%eax
  10048a:	3b 45 18             	cmp    0x18(%ebp),%eax
  10048d:	76 16                	jbe    1004a5 <stab_binsearch+0xe2>
            *region_right = m - 1;
  10048f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100492:	8d 50 ff             	lea    -0x1(%eax),%edx
  100495:	8b 45 10             	mov    0x10(%ebp),%eax
  100498:	89 10                	mov    %edx,(%eax)
            r = m - 1;
  10049a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10049d:	83 e8 01             	sub    $0x1,%eax
  1004a0:	89 45 f8             	mov    %eax,-0x8(%ebp)
  1004a3:	eb 12                	jmp    1004b7 <stab_binsearch+0xf4>
        } else {
            // exact match for 'addr', but continue loop to find
            // *region_right
            *region_left = m;
  1004a5:	8b 45 0c             	mov    0xc(%ebp),%eax
  1004a8:	8b 55 f0             	mov    -0x10(%ebp),%edx
  1004ab:	89 10                	mov    %edx,(%eax)
            l = m;
  1004ad:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1004b0:	89 45 fc             	mov    %eax,-0x4(%ebp)
            addr ++;
  1004b3:	83 45 18 01          	addl   $0x1,0x18(%ebp)
static void
stab_binsearch(const struct stab *stabs, int *region_left, int *region_right,
           int type, uintptr_t addr) {
    int l = *region_left, r = *region_right, any_matches = 0;

    while (l <= r) {
  1004b7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1004ba:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  1004bd:	0f 8e 22 ff ff ff    	jle    1003e5 <stab_binsearch+0x22>
            l = m;
            addr ++;
        }
    }

    if (!any_matches) {
  1004c3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1004c7:	75 0f                	jne    1004d8 <stab_binsearch+0x115>
        *region_right = *region_left - 1;
  1004c9:	8b 45 0c             	mov    0xc(%ebp),%eax
  1004cc:	8b 00                	mov    (%eax),%eax
  1004ce:	8d 50 ff             	lea    -0x1(%eax),%edx
  1004d1:	8b 45 10             	mov    0x10(%ebp),%eax
  1004d4:	89 10                	mov    %edx,(%eax)
  1004d6:	eb 3f                	jmp    100517 <stab_binsearch+0x154>
    }
    else {
        // find rightmost region containing 'addr'
        l = *region_right;
  1004d8:	8b 45 10             	mov    0x10(%ebp),%eax
  1004db:	8b 00                	mov    (%eax),%eax
  1004dd:	89 45 fc             	mov    %eax,-0x4(%ebp)
        for (; l > *region_left && stabs[l].n_type != type; l --)
  1004e0:	eb 04                	jmp    1004e6 <stab_binsearch+0x123>
  1004e2:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
  1004e6:	8b 45 0c             	mov    0xc(%ebp),%eax
  1004e9:	8b 00                	mov    (%eax),%eax
  1004eb:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  1004ee:	7d 1f                	jge    10050f <stab_binsearch+0x14c>
  1004f0:	8b 55 fc             	mov    -0x4(%ebp),%edx
  1004f3:	89 d0                	mov    %edx,%eax
  1004f5:	01 c0                	add    %eax,%eax
  1004f7:	01 d0                	add    %edx,%eax
  1004f9:	c1 e0 02             	shl    $0x2,%eax
  1004fc:	89 c2                	mov    %eax,%edx
  1004fe:	8b 45 08             	mov    0x8(%ebp),%eax
  100501:	01 d0                	add    %edx,%eax
  100503:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  100507:	0f b6 c0             	movzbl %al,%eax
  10050a:	3b 45 14             	cmp    0x14(%ebp),%eax
  10050d:	75 d3                	jne    1004e2 <stab_binsearch+0x11f>
            /* do nothing */;
        *region_left = l;
  10050f:	8b 45 0c             	mov    0xc(%ebp),%eax
  100512:	8b 55 fc             	mov    -0x4(%ebp),%edx
  100515:	89 10                	mov    %edx,(%eax)
    }
}
  100517:	c9                   	leave  
  100518:	c3                   	ret    

00100519 <debuginfo_eip>:
 * the specified instruction address, @addr.  Returns 0 if information
 * was found, and negative if not.  But even if it returns negative it
 * has stored some information into '*info'.
 * */
int
debuginfo_eip(uintptr_t addr, struct eipdebuginfo *info) {
  100519:	55                   	push   %ebp
  10051a:	89 e5                	mov    %esp,%ebp
  10051c:	83 ec 58             	sub    $0x58,%esp
    const struct stab *stabs, *stab_end;
    const char *stabstr, *stabstr_end;

    info->eip_file = "<unknown>";
  10051f:	8b 45 0c             	mov    0xc(%ebp),%eax
  100522:	c7 00 6c 36 10 00    	movl   $0x10366c,(%eax)
    info->eip_line = 0;
  100528:	8b 45 0c             	mov    0xc(%ebp),%eax
  10052b:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    info->eip_fn_name = "<unknown>";
  100532:	8b 45 0c             	mov    0xc(%ebp),%eax
  100535:	c7 40 08 6c 36 10 00 	movl   $0x10366c,0x8(%eax)
    info->eip_fn_namelen = 9;
  10053c:	8b 45 0c             	mov    0xc(%ebp),%eax
  10053f:	c7 40 0c 09 00 00 00 	movl   $0x9,0xc(%eax)
    info->eip_fn_addr = addr;
  100546:	8b 45 0c             	mov    0xc(%ebp),%eax
  100549:	8b 55 08             	mov    0x8(%ebp),%edx
  10054c:	89 50 10             	mov    %edx,0x10(%eax)
    info->eip_fn_narg = 0;
  10054f:	8b 45 0c             	mov    0xc(%ebp),%eax
  100552:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)

    stabs = __STAB_BEGIN__;
  100559:	c7 45 f4 ec 3e 10 00 	movl   $0x103eec,-0xc(%ebp)
    stab_end = __STAB_END__;
  100560:	c7 45 f0 58 b7 10 00 	movl   $0x10b758,-0x10(%ebp)
    stabstr = __STABSTR_BEGIN__;
  100567:	c7 45 ec 59 b7 10 00 	movl   $0x10b759,-0x14(%ebp)
    stabstr_end = __STABSTR_END__;
  10056e:	c7 45 e8 7d d7 10 00 	movl   $0x10d77d,-0x18(%ebp)

    // String table validity checks
    if (stabstr_end <= stabstr || stabstr_end[-1] != 0) {
  100575:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100578:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  10057b:	76 0d                	jbe    10058a <debuginfo_eip+0x71>
  10057d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100580:	83 e8 01             	sub    $0x1,%eax
  100583:	0f b6 00             	movzbl (%eax),%eax
  100586:	84 c0                	test   %al,%al
  100588:	74 0a                	je     100594 <debuginfo_eip+0x7b>
        return -1;
  10058a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10058f:	e9 c0 02 00 00       	jmp    100854 <debuginfo_eip+0x33b>
    // 'eip'.  First, we find the basic source file containing 'eip'.
    // Then, we look in that source file for the function.  Then we look
    // for the line number.

    // Search the entire set of stabs for the source file (type N_SO).
    int lfile = 0, rfile = (stab_end - stabs) - 1;
  100594:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  10059b:	8b 55 f0             	mov    -0x10(%ebp),%edx
  10059e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1005a1:	29 c2                	sub    %eax,%edx
  1005a3:	89 d0                	mov    %edx,%eax
  1005a5:	c1 f8 02             	sar    $0x2,%eax
  1005a8:	69 c0 ab aa aa aa    	imul   $0xaaaaaaab,%eax,%eax
  1005ae:	83 e8 01             	sub    $0x1,%eax
  1005b1:	89 45 e0             	mov    %eax,-0x20(%ebp)
    stab_binsearch(stabs, &lfile, &rfile, N_SO, addr);
  1005b4:	8b 45 08             	mov    0x8(%ebp),%eax
  1005b7:	89 44 24 10          	mov    %eax,0x10(%esp)
  1005bb:	c7 44 24 0c 64 00 00 	movl   $0x64,0xc(%esp)
  1005c2:	00 
  1005c3:	8d 45 e0             	lea    -0x20(%ebp),%eax
  1005c6:	89 44 24 08          	mov    %eax,0x8(%esp)
  1005ca:	8d 45 e4             	lea    -0x1c(%ebp),%eax
  1005cd:	89 44 24 04          	mov    %eax,0x4(%esp)
  1005d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1005d4:	89 04 24             	mov    %eax,(%esp)
  1005d7:	e8 e7 fd ff ff       	call   1003c3 <stab_binsearch>
    if (lfile == 0)
  1005dc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1005df:	85 c0                	test   %eax,%eax
  1005e1:	75 0a                	jne    1005ed <debuginfo_eip+0xd4>
        return -1;
  1005e3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1005e8:	e9 67 02 00 00       	jmp    100854 <debuginfo_eip+0x33b>

    // Search within that file's stabs for the function definition
    // (N_FUN).
    int lfun = lfile, rfun = rfile;
  1005ed:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1005f0:	89 45 dc             	mov    %eax,-0x24(%ebp)
  1005f3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1005f6:	89 45 d8             	mov    %eax,-0x28(%ebp)
    int lline, rline;
    stab_binsearch(stabs, &lfun, &rfun, N_FUN, addr);
  1005f9:	8b 45 08             	mov    0x8(%ebp),%eax
  1005fc:	89 44 24 10          	mov    %eax,0x10(%esp)
  100600:	c7 44 24 0c 24 00 00 	movl   $0x24,0xc(%esp)
  100607:	00 
  100608:	8d 45 d8             	lea    -0x28(%ebp),%eax
  10060b:	89 44 24 08          	mov    %eax,0x8(%esp)
  10060f:	8d 45 dc             	lea    -0x24(%ebp),%eax
  100612:	89 44 24 04          	mov    %eax,0x4(%esp)
  100616:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100619:	89 04 24             	mov    %eax,(%esp)
  10061c:	e8 a2 fd ff ff       	call   1003c3 <stab_binsearch>

    if (lfun <= rfun) {
  100621:	8b 55 dc             	mov    -0x24(%ebp),%edx
  100624:	8b 45 d8             	mov    -0x28(%ebp),%eax
  100627:	39 c2                	cmp    %eax,%edx
  100629:	7f 7c                	jg     1006a7 <debuginfo_eip+0x18e>
        // stabs[lfun] points to the function name
        // in the string table, but check bounds just in case.
        if (stabs[lfun].n_strx < stabstr_end - stabstr) {
  10062b:	8b 45 dc             	mov    -0x24(%ebp),%eax
  10062e:	89 c2                	mov    %eax,%edx
  100630:	89 d0                	mov    %edx,%eax
  100632:	01 c0                	add    %eax,%eax
  100634:	01 d0                	add    %edx,%eax
  100636:	c1 e0 02             	shl    $0x2,%eax
  100639:	89 c2                	mov    %eax,%edx
  10063b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10063e:	01 d0                	add    %edx,%eax
  100640:	8b 10                	mov    (%eax),%edx
  100642:	8b 4d e8             	mov    -0x18(%ebp),%ecx
  100645:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100648:	29 c1                	sub    %eax,%ecx
  10064a:	89 c8                	mov    %ecx,%eax
  10064c:	39 c2                	cmp    %eax,%edx
  10064e:	73 22                	jae    100672 <debuginfo_eip+0x159>
            info->eip_fn_name = stabstr + stabs[lfun].n_strx;
  100650:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100653:	89 c2                	mov    %eax,%edx
  100655:	89 d0                	mov    %edx,%eax
  100657:	01 c0                	add    %eax,%eax
  100659:	01 d0                	add    %edx,%eax
  10065b:	c1 e0 02             	shl    $0x2,%eax
  10065e:	89 c2                	mov    %eax,%edx
  100660:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100663:	01 d0                	add    %edx,%eax
  100665:	8b 10                	mov    (%eax),%edx
  100667:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10066a:	01 c2                	add    %eax,%edx
  10066c:	8b 45 0c             	mov    0xc(%ebp),%eax
  10066f:	89 50 08             	mov    %edx,0x8(%eax)
        }
        info->eip_fn_addr = stabs[lfun].n_value;
  100672:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100675:	89 c2                	mov    %eax,%edx
  100677:	89 d0                	mov    %edx,%eax
  100679:	01 c0                	add    %eax,%eax
  10067b:	01 d0                	add    %edx,%eax
  10067d:	c1 e0 02             	shl    $0x2,%eax
  100680:	89 c2                	mov    %eax,%edx
  100682:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100685:	01 d0                	add    %edx,%eax
  100687:	8b 50 08             	mov    0x8(%eax),%edx
  10068a:	8b 45 0c             	mov    0xc(%ebp),%eax
  10068d:	89 50 10             	mov    %edx,0x10(%eax)
        addr -= info->eip_fn_addr;
  100690:	8b 45 0c             	mov    0xc(%ebp),%eax
  100693:	8b 40 10             	mov    0x10(%eax),%eax
  100696:	29 45 08             	sub    %eax,0x8(%ebp)
        // Search within the function definition for the line number.
        lline = lfun;
  100699:	8b 45 dc             	mov    -0x24(%ebp),%eax
  10069c:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        rline = rfun;
  10069f:	8b 45 d8             	mov    -0x28(%ebp),%eax
  1006a2:	89 45 d0             	mov    %eax,-0x30(%ebp)
  1006a5:	eb 15                	jmp    1006bc <debuginfo_eip+0x1a3>
    } else {
        // Couldn't find function stab!  Maybe we're in an assembly
        // file.  Search the whole file for the line number.
        info->eip_fn_addr = addr;
  1006a7:	8b 45 0c             	mov    0xc(%ebp),%eax
  1006aa:	8b 55 08             	mov    0x8(%ebp),%edx
  1006ad:	89 50 10             	mov    %edx,0x10(%eax)
        lline = lfile;
  1006b0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1006b3:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        rline = rfile;
  1006b6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1006b9:	89 45 d0             	mov    %eax,-0x30(%ebp)
    }
    info->eip_fn_namelen = strfind(info->eip_fn_name, ':') - info->eip_fn_name;
  1006bc:	8b 45 0c             	mov    0xc(%ebp),%eax
  1006bf:	8b 40 08             	mov    0x8(%eax),%eax
  1006c2:	c7 44 24 04 3a 00 00 	movl   $0x3a,0x4(%esp)
  1006c9:	00 
  1006ca:	89 04 24             	mov    %eax,(%esp)
  1006cd:	e8 d5 2b 00 00       	call   1032a7 <strfind>
  1006d2:	89 c2                	mov    %eax,%edx
  1006d4:	8b 45 0c             	mov    0xc(%ebp),%eax
  1006d7:	8b 40 08             	mov    0x8(%eax),%eax
  1006da:	29 c2                	sub    %eax,%edx
  1006dc:	8b 45 0c             	mov    0xc(%ebp),%eax
  1006df:	89 50 0c             	mov    %edx,0xc(%eax)

    // Search within [lline, rline] for the line number stab.
    // If found, set info->eip_line to the right line number.
    // If not found, return -1.
    stab_binsearch(stabs, &lline, &rline, N_SLINE, addr);
  1006e2:	8b 45 08             	mov    0x8(%ebp),%eax
  1006e5:	89 44 24 10          	mov    %eax,0x10(%esp)
  1006e9:	c7 44 24 0c 44 00 00 	movl   $0x44,0xc(%esp)
  1006f0:	00 
  1006f1:	8d 45 d0             	lea    -0x30(%ebp),%eax
  1006f4:	89 44 24 08          	mov    %eax,0x8(%esp)
  1006f8:	8d 45 d4             	lea    -0x2c(%ebp),%eax
  1006fb:	89 44 24 04          	mov    %eax,0x4(%esp)
  1006ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100702:	89 04 24             	mov    %eax,(%esp)
  100705:	e8 b9 fc ff ff       	call   1003c3 <stab_binsearch>
    if (lline <= rline) {
  10070a:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  10070d:	8b 45 d0             	mov    -0x30(%ebp),%eax
  100710:	39 c2                	cmp    %eax,%edx
  100712:	7f 24                	jg     100738 <debuginfo_eip+0x21f>
        info->eip_line = stabs[rline].n_desc;
  100714:	8b 45 d0             	mov    -0x30(%ebp),%eax
  100717:	89 c2                	mov    %eax,%edx
  100719:	89 d0                	mov    %edx,%eax
  10071b:	01 c0                	add    %eax,%eax
  10071d:	01 d0                	add    %edx,%eax
  10071f:	c1 e0 02             	shl    $0x2,%eax
  100722:	89 c2                	mov    %eax,%edx
  100724:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100727:	01 d0                	add    %edx,%eax
  100729:	0f b7 40 06          	movzwl 0x6(%eax),%eax
  10072d:	0f b7 d0             	movzwl %ax,%edx
  100730:	8b 45 0c             	mov    0xc(%ebp),%eax
  100733:	89 50 04             	mov    %edx,0x4(%eax)

    // Search backwards from the line number for the relevant filename stab.
    // We can't just use the "lfile" stab because inlined functions
    // can interpolate code from a different file!
    // Such included source files use the N_SOL stab type.
    while (lline >= lfile
  100736:	eb 13                	jmp    10074b <debuginfo_eip+0x232>
    // If not found, return -1.
    stab_binsearch(stabs, &lline, &rline, N_SLINE, addr);
    if (lline <= rline) {
        info->eip_line = stabs[rline].n_desc;
    } else {
        return -1;
  100738:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10073d:	e9 12 01 00 00       	jmp    100854 <debuginfo_eip+0x33b>
    // can interpolate code from a different file!
    // Such included source files use the N_SOL stab type.
    while (lline >= lfile
           && stabs[lline].n_type != N_SOL
           && (stabs[lline].n_type != N_SO || !stabs[lline].n_value)) {
        lline --;
  100742:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100745:	83 e8 01             	sub    $0x1,%eax
  100748:	89 45 d4             	mov    %eax,-0x2c(%ebp)

    // Search backwards from the line number for the relevant filename stab.
    // We can't just use the "lfile" stab because inlined functions
    // can interpolate code from a different file!
    // Such included source files use the N_SOL stab type.
    while (lline >= lfile
  10074b:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  10074e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  100751:	39 c2                	cmp    %eax,%edx
  100753:	7c 56                	jl     1007ab <debuginfo_eip+0x292>
           && stabs[lline].n_type != N_SOL
  100755:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100758:	89 c2                	mov    %eax,%edx
  10075a:	89 d0                	mov    %edx,%eax
  10075c:	01 c0                	add    %eax,%eax
  10075e:	01 d0                	add    %edx,%eax
  100760:	c1 e0 02             	shl    $0x2,%eax
  100763:	89 c2                	mov    %eax,%edx
  100765:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100768:	01 d0                	add    %edx,%eax
  10076a:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  10076e:	3c 84                	cmp    $0x84,%al
  100770:	74 39                	je     1007ab <debuginfo_eip+0x292>
           && (stabs[lline].n_type != N_SO || !stabs[lline].n_value)) {
  100772:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100775:	89 c2                	mov    %eax,%edx
  100777:	89 d0                	mov    %edx,%eax
  100779:	01 c0                	add    %eax,%eax
  10077b:	01 d0                	add    %edx,%eax
  10077d:	c1 e0 02             	shl    $0x2,%eax
  100780:	89 c2                	mov    %eax,%edx
  100782:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100785:	01 d0                	add    %edx,%eax
  100787:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  10078b:	3c 64                	cmp    $0x64,%al
  10078d:	75 b3                	jne    100742 <debuginfo_eip+0x229>
  10078f:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100792:	89 c2                	mov    %eax,%edx
  100794:	89 d0                	mov    %edx,%eax
  100796:	01 c0                	add    %eax,%eax
  100798:	01 d0                	add    %edx,%eax
  10079a:	c1 e0 02             	shl    $0x2,%eax
  10079d:	89 c2                	mov    %eax,%edx
  10079f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1007a2:	01 d0                	add    %edx,%eax
  1007a4:	8b 40 08             	mov    0x8(%eax),%eax
  1007a7:	85 c0                	test   %eax,%eax
  1007a9:	74 97                	je     100742 <debuginfo_eip+0x229>
        lline --;
    }
    if (lline >= lfile && stabs[lline].n_strx < stabstr_end - stabstr) {
  1007ab:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  1007ae:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1007b1:	39 c2                	cmp    %eax,%edx
  1007b3:	7c 46                	jl     1007fb <debuginfo_eip+0x2e2>
  1007b5:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1007b8:	89 c2                	mov    %eax,%edx
  1007ba:	89 d0                	mov    %edx,%eax
  1007bc:	01 c0                	add    %eax,%eax
  1007be:	01 d0                	add    %edx,%eax
  1007c0:	c1 e0 02             	shl    $0x2,%eax
  1007c3:	89 c2                	mov    %eax,%edx
  1007c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1007c8:	01 d0                	add    %edx,%eax
  1007ca:	8b 10                	mov    (%eax),%edx
  1007cc:	8b 4d e8             	mov    -0x18(%ebp),%ecx
  1007cf:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1007d2:	29 c1                	sub    %eax,%ecx
  1007d4:	89 c8                	mov    %ecx,%eax
  1007d6:	39 c2                	cmp    %eax,%edx
  1007d8:	73 21                	jae    1007fb <debuginfo_eip+0x2e2>
        info->eip_file = stabstr + stabs[lline].n_strx;
  1007da:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1007dd:	89 c2                	mov    %eax,%edx
  1007df:	89 d0                	mov    %edx,%eax
  1007e1:	01 c0                	add    %eax,%eax
  1007e3:	01 d0                	add    %edx,%eax
  1007e5:	c1 e0 02             	shl    $0x2,%eax
  1007e8:	89 c2                	mov    %eax,%edx
  1007ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1007ed:	01 d0                	add    %edx,%eax
  1007ef:	8b 10                	mov    (%eax),%edx
  1007f1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1007f4:	01 c2                	add    %eax,%edx
  1007f6:	8b 45 0c             	mov    0xc(%ebp),%eax
  1007f9:	89 10                	mov    %edx,(%eax)
    }

    // Set eip_fn_narg to the number of arguments taken by the function,
    // or 0 if there was no containing function.
    if (lfun < rfun) {
  1007fb:	8b 55 dc             	mov    -0x24(%ebp),%edx
  1007fe:	8b 45 d8             	mov    -0x28(%ebp),%eax
  100801:	39 c2                	cmp    %eax,%edx
  100803:	7d 4a                	jge    10084f <debuginfo_eip+0x336>
        for (lline = lfun + 1;
  100805:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100808:	83 c0 01             	add    $0x1,%eax
  10080b:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  10080e:	eb 18                	jmp    100828 <debuginfo_eip+0x30f>
             lline < rfun && stabs[lline].n_type == N_PSYM;
             lline ++) {
            info->eip_fn_narg ++;
  100810:	8b 45 0c             	mov    0xc(%ebp),%eax
  100813:	8b 40 14             	mov    0x14(%eax),%eax
  100816:	8d 50 01             	lea    0x1(%eax),%edx
  100819:	8b 45 0c             	mov    0xc(%ebp),%eax
  10081c:	89 50 14             	mov    %edx,0x14(%eax)
    // Set eip_fn_narg to the number of arguments taken by the function,
    // or 0 if there was no containing function.
    if (lfun < rfun) {
        for (lline = lfun + 1;
             lline < rfun && stabs[lline].n_type == N_PSYM;
             lline ++) {
  10081f:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100822:	83 c0 01             	add    $0x1,%eax
  100825:	89 45 d4             	mov    %eax,-0x2c(%ebp)

    // Set eip_fn_narg to the number of arguments taken by the function,
    // or 0 if there was no containing function.
    if (lfun < rfun) {
        for (lline = lfun + 1;
             lline < rfun && stabs[lline].n_type == N_PSYM;
  100828:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  10082b:	8b 45 d8             	mov    -0x28(%ebp),%eax
    }

    // Set eip_fn_narg to the number of arguments taken by the function,
    // or 0 if there was no containing function.
    if (lfun < rfun) {
        for (lline = lfun + 1;
  10082e:	39 c2                	cmp    %eax,%edx
  100830:	7d 1d                	jge    10084f <debuginfo_eip+0x336>
             lline < rfun && stabs[lline].n_type == N_PSYM;
  100832:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100835:	89 c2                	mov    %eax,%edx
  100837:	89 d0                	mov    %edx,%eax
  100839:	01 c0                	add    %eax,%eax
  10083b:	01 d0                	add    %edx,%eax
  10083d:	c1 e0 02             	shl    $0x2,%eax
  100840:	89 c2                	mov    %eax,%edx
  100842:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100845:	01 d0                	add    %edx,%eax
  100847:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  10084b:	3c a0                	cmp    $0xa0,%al
  10084d:	74 c1                	je     100810 <debuginfo_eip+0x2f7>
             lline ++) {
            info->eip_fn_narg ++;
        }
    }
    return 0;
  10084f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100854:	c9                   	leave  
  100855:	c3                   	ret    

00100856 <print_kerninfo>:
 * print_kerninfo - print the information about kernel, including the location
 * of kernel entry, the start addresses of data and text segements, the start
 * address of free memory and how many memory that kernel has used.
 * */
void
print_kerninfo(void) {
  100856:	55                   	push   %ebp
  100857:	89 e5                	mov    %esp,%ebp
  100859:	83 ec 18             	sub    $0x18,%esp
    extern char etext[], edata[], end[], kern_init[];
    cprintf("Special kernel symbols:\n");
  10085c:	c7 04 24 76 36 10 00 	movl   $0x103676,(%esp)
  100863:	e8 ba fa ff ff       	call   100322 <cprintf>
    cprintf("  entry  0x%08x (phys)\n", kern_init);
  100868:	c7 44 24 04 00 00 10 	movl   $0x100000,0x4(%esp)
  10086f:	00 
  100870:	c7 04 24 8f 36 10 00 	movl   $0x10368f,(%esp)
  100877:	e8 a6 fa ff ff       	call   100322 <cprintf>
    cprintf("  etext  0x%08x (phys)\n", etext);
  10087c:	c7 44 24 04 bc 35 10 	movl   $0x1035bc,0x4(%esp)
  100883:	00 
  100884:	c7 04 24 a7 36 10 00 	movl   $0x1036a7,(%esp)
  10088b:	e8 92 fa ff ff       	call   100322 <cprintf>
    cprintf("  edata  0x%08x (phys)\n", edata);
  100890:	c7 44 24 04 16 ea 10 	movl   $0x10ea16,0x4(%esp)
  100897:	00 
  100898:	c7 04 24 bf 36 10 00 	movl   $0x1036bf,(%esp)
  10089f:	e8 7e fa ff ff       	call   100322 <cprintf>
    cprintf("  end    0x%08x (phys)\n", end);
  1008a4:	c7 44 24 04 80 fd 10 	movl   $0x10fd80,0x4(%esp)
  1008ab:	00 
  1008ac:	c7 04 24 d7 36 10 00 	movl   $0x1036d7,(%esp)
  1008b3:	e8 6a fa ff ff       	call   100322 <cprintf>
    cprintf("Kernel executable memory footprint: %dKB\n", (end - kern_init + 1023)/1024);
  1008b8:	b8 80 fd 10 00       	mov    $0x10fd80,%eax
  1008bd:	8d 90 ff 03 00 00    	lea    0x3ff(%eax),%edx
  1008c3:	b8 00 00 10 00       	mov    $0x100000,%eax
  1008c8:	29 c2                	sub    %eax,%edx
  1008ca:	89 d0                	mov    %edx,%eax
  1008cc:	8d 90 ff 03 00 00    	lea    0x3ff(%eax),%edx
  1008d2:	85 c0                	test   %eax,%eax
  1008d4:	0f 48 c2             	cmovs  %edx,%eax
  1008d7:	c1 f8 0a             	sar    $0xa,%eax
  1008da:	89 44 24 04          	mov    %eax,0x4(%esp)
  1008de:	c7 04 24 f0 36 10 00 	movl   $0x1036f0,(%esp)
  1008e5:	e8 38 fa ff ff       	call   100322 <cprintf>
}
  1008ea:	c9                   	leave  
  1008eb:	c3                   	ret    

001008ec <print_debuginfo>:
/* *
 * print_debuginfo - read and print the stat information for the address @eip,
 * and info.eip_fn_addr should be the first address of the related function.
 * */
void
print_debuginfo(uintptr_t eip) {
  1008ec:	55                   	push   %ebp
  1008ed:	89 e5                	mov    %esp,%ebp
  1008ef:	81 ec 48 01 00 00    	sub    $0x148,%esp
    struct eipdebuginfo info;
    if (debuginfo_eip(eip, &info) != 0) {
  1008f5:	8d 45 dc             	lea    -0x24(%ebp),%eax
  1008f8:	89 44 24 04          	mov    %eax,0x4(%esp)
  1008fc:	8b 45 08             	mov    0x8(%ebp),%eax
  1008ff:	89 04 24             	mov    %eax,(%esp)
  100902:	e8 12 fc ff ff       	call   100519 <debuginfo_eip>
  100907:	85 c0                	test   %eax,%eax
  100909:	74 15                	je     100920 <print_debuginfo+0x34>
        cprintf("    <unknow>: -- 0x%08x --\n", eip);
  10090b:	8b 45 08             	mov    0x8(%ebp),%eax
  10090e:	89 44 24 04          	mov    %eax,0x4(%esp)
  100912:	c7 04 24 1a 37 10 00 	movl   $0x10371a,(%esp)
  100919:	e8 04 fa ff ff       	call   100322 <cprintf>
  10091e:	eb 6d                	jmp    10098d <print_debuginfo+0xa1>
    }
    else {
        char fnname[256];
        int j;
        for (j = 0; j < info.eip_fn_namelen; j ++) {
  100920:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100927:	eb 1c                	jmp    100945 <print_debuginfo+0x59>
            fnname[j] = info.eip_fn_name[j];
  100929:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  10092c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10092f:	01 d0                	add    %edx,%eax
  100931:	0f b6 00             	movzbl (%eax),%eax
  100934:	8d 8d dc fe ff ff    	lea    -0x124(%ebp),%ecx
  10093a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  10093d:	01 ca                	add    %ecx,%edx
  10093f:	88 02                	mov    %al,(%edx)
        cprintf("    <unknow>: -- 0x%08x --\n", eip);
    }
    else {
        char fnname[256];
        int j;
        for (j = 0; j < info.eip_fn_namelen; j ++) {
  100941:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  100945:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100948:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  10094b:	7f dc                	jg     100929 <print_debuginfo+0x3d>
            fnname[j] = info.eip_fn_name[j];
        }
        fnname[j] = '\0';
  10094d:	8d 95 dc fe ff ff    	lea    -0x124(%ebp),%edx
  100953:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100956:	01 d0                	add    %edx,%eax
  100958:	c6 00 00             	movb   $0x0,(%eax)
        cprintf("    %s:%d: %s+%d\n", info.eip_file, info.eip_line,
                fnname, eip - info.eip_fn_addr);
  10095b:	8b 45 ec             	mov    -0x14(%ebp),%eax
        int j;
        for (j = 0; j < info.eip_fn_namelen; j ++) {
            fnname[j] = info.eip_fn_name[j];
        }
        fnname[j] = '\0';
        cprintf("    %s:%d: %s+%d\n", info.eip_file, info.eip_line,
  10095e:	8b 55 08             	mov    0x8(%ebp),%edx
  100961:	89 d1                	mov    %edx,%ecx
  100963:	29 c1                	sub    %eax,%ecx
  100965:	8b 55 e0             	mov    -0x20(%ebp),%edx
  100968:	8b 45 dc             	mov    -0x24(%ebp),%eax
  10096b:	89 4c 24 10          	mov    %ecx,0x10(%esp)
  10096f:	8d 8d dc fe ff ff    	lea    -0x124(%ebp),%ecx
  100975:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  100979:	89 54 24 08          	mov    %edx,0x8(%esp)
  10097d:	89 44 24 04          	mov    %eax,0x4(%esp)
  100981:	c7 04 24 36 37 10 00 	movl   $0x103736,(%esp)
  100988:	e8 95 f9 ff ff       	call   100322 <cprintf>
                fnname, eip - info.eip_fn_addr);
    }
}
  10098d:	c9                   	leave  
  10098e:	c3                   	ret    

0010098f <read_eip>:

static __noinline uint32_t
read_eip(void) {
  10098f:	55                   	push   %ebp
  100990:	89 e5                	mov    %esp,%ebp
  100992:	83 ec 10             	sub    $0x10,%esp
    uint32_t eip;
    asm volatile("movl 4(%%ebp), %0" : "=r" (eip));
  100995:	8b 45 04             	mov    0x4(%ebp),%eax
  100998:	89 45 fc             	mov    %eax,-0x4(%ebp)
    return eip;
  10099b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  10099e:	c9                   	leave  
  10099f:	c3                   	ret    

001009a0 <print_stackframe>:
 *
 * Note that, the length of ebp-chain is limited. In boot/bootasm.S, before jumping
 * to the kernel entry, the value of ebp has been set to zero, that's the boundary.
 * */
void
print_stackframe(void) {
  1009a0:	55                   	push   %ebp
  1009a1:	89 e5                	mov    %esp,%ebp
  1009a3:	53                   	push   %ebx
  1009a4:	83 ec 44             	sub    $0x44,%esp
}

static inline uint32_t
read_ebp(void) {
    uint32_t ebp;
    asm volatile ("movl %%ebp, %0" : "=r" (ebp));
  1009a7:	89 e8                	mov    %ebp,%eax
  1009a9:	89 45 e8             	mov    %eax,-0x18(%ebp)
    return ebp;
  1009ac:	8b 45 e8             	mov    -0x18(%ebp),%eax
      *    (3.5) popup a calling stackframe
      *           NOTICE: the calling funciton's return addr eip  = ss:[ebp+4]
      *                   the calling funciton's ebp = ss:[ebp]
      */

	uint32_t ebp= read_ebp(), eip= read_eip();
  1009af:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1009b2:	e8 d8 ff ff ff       	call   10098f <read_eip>
  1009b7:	89 45 f0             	mov    %eax,-0x10(%ebp)

	int i=0;
  1009ba:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
	while (ebp!=0 && (i++)<STACKFRAME_DEPTH )
  1009c1:	e9 b9 00 00 00       	jmp    100a7f <print_stackframe+0xdf>
	{
		uint32_t args[4]={0};
  1009c6:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
  1009cd:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  1009d4:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  1009db:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
		asm volatile ("movl 8(%1), %0" : "=r" (args[0])  : "r"(ebp));
  1009e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1009e5:	8b 40 08             	mov    0x8(%eax),%eax
  1009e8:	89 45 d8             	mov    %eax,-0x28(%ebp)
		asm volatile ("movl 12(%1), %0" : "=r" (args[1])  : "r"(ebp));
  1009eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1009ee:	8b 40 0c             	mov    0xc(%eax),%eax
  1009f1:	89 45 dc             	mov    %eax,-0x24(%ebp)
		asm volatile ("movl 16(%1), %0" : "=r" (args[2])  : "r"(ebp));
  1009f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1009f7:	8b 40 10             	mov    0x10(%eax),%eax
  1009fa:	89 45 e0             	mov    %eax,-0x20(%ebp)
		asm volatile ("movl 20(%1), %0" : "=r" (args[3])  : "r"(ebp));
  1009fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a00:	8b 40 14             	mov    0x14(%eax),%eax
  100a03:	89 45 e4             	mov    %eax,-0x1c(%ebp)

		cprintf("ebp:0x%08x", ebp);
  100a06:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a09:	89 44 24 04          	mov    %eax,0x4(%esp)
  100a0d:	c7 04 24 48 37 10 00 	movl   $0x103748,(%esp)
  100a14:	e8 09 f9 ff ff       	call   100322 <cprintf>
		cprintf(" eip:0x%08x", eip);
  100a19:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100a1c:	89 44 24 04          	mov    %eax,0x4(%esp)
  100a20:	c7 04 24 53 37 10 00 	movl   $0x103753,(%esp)
  100a27:	e8 f6 f8 ff ff       	call   100322 <cprintf>
		cprintf(" args:0x%08x 0x%08x 0x%08x 0x%08x", args[0], args[1], args[2], args[3]);
  100a2c:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  100a2f:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  100a32:	8b 55 dc             	mov    -0x24(%ebp),%edx
  100a35:	8b 45 d8             	mov    -0x28(%ebp),%eax
  100a38:	89 5c 24 10          	mov    %ebx,0x10(%esp)
  100a3c:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  100a40:	89 54 24 08          	mov    %edx,0x8(%esp)
  100a44:	89 44 24 04          	mov    %eax,0x4(%esp)
  100a48:	c7 04 24 60 37 10 00 	movl   $0x103760,(%esp)
  100a4f:	e8 ce f8 ff ff       	call   100322 <cprintf>
		cprintf("\n");
  100a54:	c7 04 24 82 37 10 00 	movl   $0x103782,(%esp)
  100a5b:	e8 c2 f8 ff ff       	call   100322 <cprintf>
		print_debuginfo(eip-1);
  100a60:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100a63:	83 e8 01             	sub    $0x1,%eax
  100a66:	89 04 24             	mov    %eax,(%esp)
  100a69:	e8 7e fe ff ff       	call   1008ec <print_debuginfo>

		asm volatile ("movl 4(%1), %0" : "=r" (eip) : "r"(ebp));
  100a6e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a71:	8b 40 04             	mov    0x4(%eax),%eax
  100a74:	89 45 f0             	mov    %eax,-0x10(%ebp)
		asm volatile ("movl 0(%1), %0" : "=r" (ebp) : "r"(ebp));
  100a77:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a7a:	8b 00                	mov    (%eax),%eax
  100a7c:	89 45 f4             	mov    %eax,-0xc(%ebp)
      */

	uint32_t ebp= read_ebp(), eip= read_eip();

	int i=0;
	while (ebp!=0 && (i++)<STACKFRAME_DEPTH )
  100a7f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100a83:	74 12                	je     100a97 <print_stackframe+0xf7>
  100a85:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100a88:	8d 50 01             	lea    0x1(%eax),%edx
  100a8b:	89 55 ec             	mov    %edx,-0x14(%ebp)
  100a8e:	83 f8 13             	cmp    $0x13,%eax
  100a91:	0f 8e 2f ff ff ff    	jle    1009c6 <print_stackframe+0x26>
		print_debuginfo(eip-1);

		asm volatile ("movl 4(%1), %0" : "=r" (eip) : "r"(ebp));
		asm volatile ("movl 0(%1), %0" : "=r" (ebp) : "r"(ebp));
	}
}
  100a97:	83 c4 44             	add    $0x44,%esp
  100a9a:	5b                   	pop    %ebx
  100a9b:	5d                   	pop    %ebp
  100a9c:	c3                   	ret    

00100a9d <parse>:
#define MAXARGS         16
#define WHITESPACE      " \t\n\r"

/* parse - parse the command buffer into whitespace-separated arguments */
static int
parse(char *buf, char **argv) {
  100a9d:	55                   	push   %ebp
  100a9e:	89 e5                	mov    %esp,%ebp
  100aa0:	83 ec 28             	sub    $0x28,%esp
    int argc = 0;
  100aa3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while (1) {
        // find global whitespace
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100aaa:	eb 0c                	jmp    100ab8 <parse+0x1b>
            *buf ++ = '\0';
  100aac:	8b 45 08             	mov    0x8(%ebp),%eax
  100aaf:	8d 50 01             	lea    0x1(%eax),%edx
  100ab2:	89 55 08             	mov    %edx,0x8(%ebp)
  100ab5:	c6 00 00             	movb   $0x0,(%eax)
static int
parse(char *buf, char **argv) {
    int argc = 0;
    while (1) {
        // find global whitespace
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100ab8:	8b 45 08             	mov    0x8(%ebp),%eax
  100abb:	0f b6 00             	movzbl (%eax),%eax
  100abe:	84 c0                	test   %al,%al
  100ac0:	74 1d                	je     100adf <parse+0x42>
  100ac2:	8b 45 08             	mov    0x8(%ebp),%eax
  100ac5:	0f b6 00             	movzbl (%eax),%eax
  100ac8:	0f be c0             	movsbl %al,%eax
  100acb:	89 44 24 04          	mov    %eax,0x4(%esp)
  100acf:	c7 04 24 04 38 10 00 	movl   $0x103804,(%esp)
  100ad6:	e8 99 27 00 00       	call   103274 <strchr>
  100adb:	85 c0                	test   %eax,%eax
  100add:	75 cd                	jne    100aac <parse+0xf>
            *buf ++ = '\0';
        }
        if (*buf == '\0') {
  100adf:	8b 45 08             	mov    0x8(%ebp),%eax
  100ae2:	0f b6 00             	movzbl (%eax),%eax
  100ae5:	84 c0                	test   %al,%al
  100ae7:	75 02                	jne    100aeb <parse+0x4e>
            break;
  100ae9:	eb 67                	jmp    100b52 <parse+0xb5>
        }

        // save and scan past next arg
        if (argc == MAXARGS - 1) {
  100aeb:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
  100aef:	75 14                	jne    100b05 <parse+0x68>
            cprintf("Too many arguments (max %d).\n", MAXARGS);
  100af1:	c7 44 24 04 10 00 00 	movl   $0x10,0x4(%esp)
  100af8:	00 
  100af9:	c7 04 24 09 38 10 00 	movl   $0x103809,(%esp)
  100b00:	e8 1d f8 ff ff       	call   100322 <cprintf>
        }
        argv[argc ++] = buf;
  100b05:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100b08:	8d 50 01             	lea    0x1(%eax),%edx
  100b0b:	89 55 f4             	mov    %edx,-0xc(%ebp)
  100b0e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  100b15:	8b 45 0c             	mov    0xc(%ebp),%eax
  100b18:	01 c2                	add    %eax,%edx
  100b1a:	8b 45 08             	mov    0x8(%ebp),%eax
  100b1d:	89 02                	mov    %eax,(%edx)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
  100b1f:	eb 04                	jmp    100b25 <parse+0x88>
            buf ++;
  100b21:	83 45 08 01          	addl   $0x1,0x8(%ebp)
        // save and scan past next arg
        if (argc == MAXARGS - 1) {
            cprintf("Too many arguments (max %d).\n", MAXARGS);
        }
        argv[argc ++] = buf;
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
  100b25:	8b 45 08             	mov    0x8(%ebp),%eax
  100b28:	0f b6 00             	movzbl (%eax),%eax
  100b2b:	84 c0                	test   %al,%al
  100b2d:	74 1d                	je     100b4c <parse+0xaf>
  100b2f:	8b 45 08             	mov    0x8(%ebp),%eax
  100b32:	0f b6 00             	movzbl (%eax),%eax
  100b35:	0f be c0             	movsbl %al,%eax
  100b38:	89 44 24 04          	mov    %eax,0x4(%esp)
  100b3c:	c7 04 24 04 38 10 00 	movl   $0x103804,(%esp)
  100b43:	e8 2c 27 00 00       	call   103274 <strchr>
  100b48:	85 c0                	test   %eax,%eax
  100b4a:	74 d5                	je     100b21 <parse+0x84>
            buf ++;
        }
    }
  100b4c:	90                   	nop
static int
parse(char *buf, char **argv) {
    int argc = 0;
    while (1) {
        // find global whitespace
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100b4d:	e9 66 ff ff ff       	jmp    100ab8 <parse+0x1b>
        argv[argc ++] = buf;
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
            buf ++;
        }
    }
    return argc;
  100b52:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  100b55:	c9                   	leave  
  100b56:	c3                   	ret    

00100b57 <runcmd>:
/* *
 * runcmd - parse the input string, split it into separated arguments
 * and then lookup and invoke some related commands/
 * */
static int
runcmd(char *buf, struct trapframe *tf) {
  100b57:	55                   	push   %ebp
  100b58:	89 e5                	mov    %esp,%ebp
  100b5a:	83 ec 68             	sub    $0x68,%esp
    char *argv[MAXARGS];
    int argc = parse(buf, argv);
  100b5d:	8d 45 b0             	lea    -0x50(%ebp),%eax
  100b60:	89 44 24 04          	mov    %eax,0x4(%esp)
  100b64:	8b 45 08             	mov    0x8(%ebp),%eax
  100b67:	89 04 24             	mov    %eax,(%esp)
  100b6a:	e8 2e ff ff ff       	call   100a9d <parse>
  100b6f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if (argc == 0) {
  100b72:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  100b76:	75 0a                	jne    100b82 <runcmd+0x2b>
        return 0;
  100b78:	b8 00 00 00 00       	mov    $0x0,%eax
  100b7d:	e9 85 00 00 00       	jmp    100c07 <runcmd+0xb0>
    }
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
  100b82:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100b89:	eb 5c                	jmp    100be7 <runcmd+0x90>
        if (strcmp(commands[i].name, argv[0]) == 0) {
  100b8b:	8b 4d b0             	mov    -0x50(%ebp),%ecx
  100b8e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100b91:	89 d0                	mov    %edx,%eax
  100b93:	01 c0                	add    %eax,%eax
  100b95:	01 d0                	add    %edx,%eax
  100b97:	c1 e0 02             	shl    $0x2,%eax
  100b9a:	05 00 e0 10 00       	add    $0x10e000,%eax
  100b9f:	8b 00                	mov    (%eax),%eax
  100ba1:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  100ba5:	89 04 24             	mov    %eax,(%esp)
  100ba8:	e8 28 26 00 00       	call   1031d5 <strcmp>
  100bad:	85 c0                	test   %eax,%eax
  100baf:	75 32                	jne    100be3 <runcmd+0x8c>
            return commands[i].func(argc - 1, argv + 1, tf);
  100bb1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100bb4:	89 d0                	mov    %edx,%eax
  100bb6:	01 c0                	add    %eax,%eax
  100bb8:	01 d0                	add    %edx,%eax
  100bba:	c1 e0 02             	shl    $0x2,%eax
  100bbd:	05 00 e0 10 00       	add    $0x10e000,%eax
  100bc2:	8b 40 08             	mov    0x8(%eax),%eax
  100bc5:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100bc8:	8d 4a ff             	lea    -0x1(%edx),%ecx
  100bcb:	8b 55 0c             	mov    0xc(%ebp),%edx
  100bce:	89 54 24 08          	mov    %edx,0x8(%esp)
  100bd2:	8d 55 b0             	lea    -0x50(%ebp),%edx
  100bd5:	83 c2 04             	add    $0x4,%edx
  100bd8:	89 54 24 04          	mov    %edx,0x4(%esp)
  100bdc:	89 0c 24             	mov    %ecx,(%esp)
  100bdf:	ff d0                	call   *%eax
  100be1:	eb 24                	jmp    100c07 <runcmd+0xb0>
    int argc = parse(buf, argv);
    if (argc == 0) {
        return 0;
    }
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
  100be3:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  100be7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100bea:	83 f8 02             	cmp    $0x2,%eax
  100bed:	76 9c                	jbe    100b8b <runcmd+0x34>
        if (strcmp(commands[i].name, argv[0]) == 0) {
            return commands[i].func(argc - 1, argv + 1, tf);
        }
    }
    cprintf("Unknown command '%s'\n", argv[0]);
  100bef:	8b 45 b0             	mov    -0x50(%ebp),%eax
  100bf2:	89 44 24 04          	mov    %eax,0x4(%esp)
  100bf6:	c7 04 24 27 38 10 00 	movl   $0x103827,(%esp)
  100bfd:	e8 20 f7 ff ff       	call   100322 <cprintf>
    return 0;
  100c02:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100c07:	c9                   	leave  
  100c08:	c3                   	ret    

00100c09 <kmonitor>:

/***** Implementations of basic kernel monitor commands *****/

void
kmonitor(struct trapframe *tf) {
  100c09:	55                   	push   %ebp
  100c0a:	89 e5                	mov    %esp,%ebp
  100c0c:	83 ec 28             	sub    $0x28,%esp
    cprintf("Welcome to the kernel debug monitor!!\n");
  100c0f:	c7 04 24 40 38 10 00 	movl   $0x103840,(%esp)
  100c16:	e8 07 f7 ff ff       	call   100322 <cprintf>
    cprintf("Type 'help' for a list of commands.\n");
  100c1b:	c7 04 24 68 38 10 00 	movl   $0x103868,(%esp)
  100c22:	e8 fb f6 ff ff       	call   100322 <cprintf>

    if (tf != NULL) {
  100c27:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  100c2b:	74 0b                	je     100c38 <kmonitor+0x2f>
        print_trapframe(tf);
  100c2d:	8b 45 08             	mov    0x8(%ebp),%eax
  100c30:	89 04 24             	mov    %eax,(%esp)
  100c33:	e8 f5 0d 00 00       	call   101a2d <print_trapframe>
    }

    char *buf;
    while (1) {
        if ((buf = readline("K> ")) != NULL) {
  100c38:	c7 04 24 8d 38 10 00 	movl   $0x10388d,(%esp)
  100c3f:	e8 d5 f5 ff ff       	call   100219 <readline>
  100c44:	89 45 f4             	mov    %eax,-0xc(%ebp)
  100c47:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100c4b:	74 18                	je     100c65 <kmonitor+0x5c>
            if (runcmd(buf, tf) < 0) {
  100c4d:	8b 45 08             	mov    0x8(%ebp),%eax
  100c50:	89 44 24 04          	mov    %eax,0x4(%esp)
  100c54:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100c57:	89 04 24             	mov    %eax,(%esp)
  100c5a:	e8 f8 fe ff ff       	call   100b57 <runcmd>
  100c5f:	85 c0                	test   %eax,%eax
  100c61:	79 02                	jns    100c65 <kmonitor+0x5c>
                break;
  100c63:	eb 02                	jmp    100c67 <kmonitor+0x5e>
            }
        }
    }
  100c65:	eb d1                	jmp    100c38 <kmonitor+0x2f>
}
  100c67:	c9                   	leave  
  100c68:	c3                   	ret    

00100c69 <mon_help>:

/* mon_help - print the information about mon_* functions */
int
mon_help(int argc, char **argv, struct trapframe *tf) {
  100c69:	55                   	push   %ebp
  100c6a:	89 e5                	mov    %esp,%ebp
  100c6c:	83 ec 28             	sub    $0x28,%esp
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
  100c6f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100c76:	eb 3f                	jmp    100cb7 <mon_help+0x4e>
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
  100c78:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100c7b:	89 d0                	mov    %edx,%eax
  100c7d:	01 c0                	add    %eax,%eax
  100c7f:	01 d0                	add    %edx,%eax
  100c81:	c1 e0 02             	shl    $0x2,%eax
  100c84:	05 00 e0 10 00       	add    $0x10e000,%eax
  100c89:	8b 48 04             	mov    0x4(%eax),%ecx
  100c8c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100c8f:	89 d0                	mov    %edx,%eax
  100c91:	01 c0                	add    %eax,%eax
  100c93:	01 d0                	add    %edx,%eax
  100c95:	c1 e0 02             	shl    $0x2,%eax
  100c98:	05 00 e0 10 00       	add    $0x10e000,%eax
  100c9d:	8b 00                	mov    (%eax),%eax
  100c9f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  100ca3:	89 44 24 04          	mov    %eax,0x4(%esp)
  100ca7:	c7 04 24 91 38 10 00 	movl   $0x103891,(%esp)
  100cae:	e8 6f f6 ff ff       	call   100322 <cprintf>

/* mon_help - print the information about mon_* functions */
int
mon_help(int argc, char **argv, struct trapframe *tf) {
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
  100cb3:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  100cb7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100cba:	83 f8 02             	cmp    $0x2,%eax
  100cbd:	76 b9                	jbe    100c78 <mon_help+0xf>
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
    }
    return 0;
  100cbf:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100cc4:	c9                   	leave  
  100cc5:	c3                   	ret    

00100cc6 <mon_kerninfo>:
/* *
 * mon_kerninfo - call print_kerninfo in kern/debug/kdebug.c to
 * print the memory occupancy in kernel.
 * */
int
mon_kerninfo(int argc, char **argv, struct trapframe *tf) {
  100cc6:	55                   	push   %ebp
  100cc7:	89 e5                	mov    %esp,%ebp
  100cc9:	83 ec 08             	sub    $0x8,%esp
    print_kerninfo();
  100ccc:	e8 85 fb ff ff       	call   100856 <print_kerninfo>
    return 0;
  100cd1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100cd6:	c9                   	leave  
  100cd7:	c3                   	ret    

00100cd8 <mon_backtrace>:
/* *
 * mon_backtrace - call print_stackframe in kern/debug/kdebug.c to
 * print a backtrace of the stack.
 * */
int
mon_backtrace(int argc, char **argv, struct trapframe *tf) {
  100cd8:	55                   	push   %ebp
  100cd9:	89 e5                	mov    %esp,%ebp
  100cdb:	83 ec 08             	sub    $0x8,%esp
    print_stackframe();
  100cde:	e8 bd fc ff ff       	call   1009a0 <print_stackframe>
    return 0;
  100ce3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100ce8:	c9                   	leave  
  100ce9:	c3                   	ret    

00100cea <__panic>:
/* *
 * __panic - __panic is called on unresolvable fatal errors. it prints
 * "panic: 'message'", and then enters the kernel monitor.
 * */
void
__panic(const char *file, int line, const char *fmt, ...) {
  100cea:	55                   	push   %ebp
  100ceb:	89 e5                	mov    %esp,%ebp
  100ced:	83 ec 28             	sub    $0x28,%esp
    if (is_panic) {
  100cf0:	a1 40 ee 10 00       	mov    0x10ee40,%eax
  100cf5:	85 c0                	test   %eax,%eax
  100cf7:	74 02                	je     100cfb <__panic+0x11>
        goto panic_dead;
  100cf9:	eb 48                	jmp    100d43 <__panic+0x59>
    }
    is_panic = 1;
  100cfb:	c7 05 40 ee 10 00 01 	movl   $0x1,0x10ee40
  100d02:	00 00 00 

    // print the 'message'
    va_list ap;
    va_start(ap, fmt);
  100d05:	8d 45 14             	lea    0x14(%ebp),%eax
  100d08:	89 45 f4             	mov    %eax,-0xc(%ebp)
    cprintf("kernel panic at %s:%d:\n    ", file, line);
  100d0b:	8b 45 0c             	mov    0xc(%ebp),%eax
  100d0e:	89 44 24 08          	mov    %eax,0x8(%esp)
  100d12:	8b 45 08             	mov    0x8(%ebp),%eax
  100d15:	89 44 24 04          	mov    %eax,0x4(%esp)
  100d19:	c7 04 24 9a 38 10 00 	movl   $0x10389a,(%esp)
  100d20:	e8 fd f5 ff ff       	call   100322 <cprintf>
    vcprintf(fmt, ap);
  100d25:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100d28:	89 44 24 04          	mov    %eax,0x4(%esp)
  100d2c:	8b 45 10             	mov    0x10(%ebp),%eax
  100d2f:	89 04 24             	mov    %eax,(%esp)
  100d32:	e8 b8 f5 ff ff       	call   1002ef <vcprintf>
    cprintf("\n");
  100d37:	c7 04 24 b6 38 10 00 	movl   $0x1038b6,(%esp)
  100d3e:	e8 df f5 ff ff       	call   100322 <cprintf>
    va_end(ap);

panic_dead:
    intr_disable();
  100d43:	e8 22 09 00 00       	call   10166a <intr_disable>
    while (1) {
        kmonitor(NULL);
  100d48:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100d4f:	e8 b5 fe ff ff       	call   100c09 <kmonitor>
    }
  100d54:	eb f2                	jmp    100d48 <__panic+0x5e>

00100d56 <__warn>:
}

/* __warn - like panic, but don't */
void
__warn(const char *file, int line, const char *fmt, ...) {
  100d56:	55                   	push   %ebp
  100d57:	89 e5                	mov    %esp,%ebp
  100d59:	83 ec 28             	sub    $0x28,%esp
    va_list ap;
    va_start(ap, fmt);
  100d5c:	8d 45 14             	lea    0x14(%ebp),%eax
  100d5f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    cprintf("kernel warning at %s:%d:\n    ", file, line);
  100d62:	8b 45 0c             	mov    0xc(%ebp),%eax
  100d65:	89 44 24 08          	mov    %eax,0x8(%esp)
  100d69:	8b 45 08             	mov    0x8(%ebp),%eax
  100d6c:	89 44 24 04          	mov    %eax,0x4(%esp)
  100d70:	c7 04 24 b8 38 10 00 	movl   $0x1038b8,(%esp)
  100d77:	e8 a6 f5 ff ff       	call   100322 <cprintf>
    vcprintf(fmt, ap);
  100d7c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100d7f:	89 44 24 04          	mov    %eax,0x4(%esp)
  100d83:	8b 45 10             	mov    0x10(%ebp),%eax
  100d86:	89 04 24             	mov    %eax,(%esp)
  100d89:	e8 61 f5 ff ff       	call   1002ef <vcprintf>
    cprintf("\n");
  100d8e:	c7 04 24 b6 38 10 00 	movl   $0x1038b6,(%esp)
  100d95:	e8 88 f5 ff ff       	call   100322 <cprintf>
    va_end(ap);
}
  100d9a:	c9                   	leave  
  100d9b:	c3                   	ret    

00100d9c <is_kernel_panic>:

bool
is_kernel_panic(void) {
  100d9c:	55                   	push   %ebp
  100d9d:	89 e5                	mov    %esp,%ebp
    return is_panic;
  100d9f:	a1 40 ee 10 00       	mov    0x10ee40,%eax
}
  100da4:	5d                   	pop    %ebp
  100da5:	c3                   	ret    

00100da6 <clock_init>:
/* *
 * clock_init - initialize 8253 clock to interrupt 100 times per second,
 * and then enable IRQ_TIMER.
 * */
void
clock_init(void) {
  100da6:	55                   	push   %ebp
  100da7:	89 e5                	mov    %esp,%ebp
  100da9:	83 ec 28             	sub    $0x28,%esp
  100dac:	66 c7 45 f6 43 00    	movw   $0x43,-0xa(%ebp)
  100db2:	c6 45 f5 34          	movb   $0x34,-0xb(%ebp)
            : "memory", "cc");
}

static inline void
outb(uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100db6:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  100dba:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  100dbe:	ee                   	out    %al,(%dx)
  100dbf:	66 c7 45 f2 40 00    	movw   $0x40,-0xe(%ebp)
  100dc5:	c6 45 f1 9c          	movb   $0x9c,-0xf(%ebp)
  100dc9:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  100dcd:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  100dd1:	ee                   	out    %al,(%dx)
  100dd2:	66 c7 45 ee 40 00    	movw   $0x40,-0x12(%ebp)
  100dd8:	c6 45 ed 2e          	movb   $0x2e,-0x13(%ebp)
  100ddc:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  100de0:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  100de4:	ee                   	out    %al,(%dx)
    outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
    outb(IO_TIMER1, TIMER_DIV(100) % 256);
    outb(IO_TIMER1, TIMER_DIV(100) / 256);

    // initialize time counter 'ticks' to zero
    ticks = 0;
  100de5:	c7 05 08 f9 10 00 00 	movl   $0x0,0x10f908
  100dec:	00 00 00 

    cprintf("++ setup timer interrupts\n");
  100def:	c7 04 24 d6 38 10 00 	movl   $0x1038d6,(%esp)
  100df6:	e8 27 f5 ff ff       	call   100322 <cprintf>
    pic_enable(IRQ_TIMER);
  100dfb:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100e02:	e8 c1 08 00 00       	call   1016c8 <pic_enable>
}
  100e07:	c9                   	leave  
  100e08:	c3                   	ret    

00100e09 <delay>:
#include <picirq.h>
#include <trap.h>

/* stupid I/O delay routine necessitated by historical PC design flaws */
static void
delay(void) {
  100e09:	55                   	push   %ebp
  100e0a:	89 e5                	mov    %esp,%ebp
  100e0c:	83 ec 10             	sub    $0x10,%esp
  100e0f:	66 c7 45 fe 84 00    	movw   $0x84,-0x2(%ebp)
static inline void ltr(uint16_t sel) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100e15:	0f b7 45 fe          	movzwl -0x2(%ebp),%eax
  100e19:	89 c2                	mov    %eax,%edx
  100e1b:	ec                   	in     (%dx),%al
  100e1c:	88 45 fd             	mov    %al,-0x3(%ebp)
  100e1f:	66 c7 45 fa 84 00    	movw   $0x84,-0x6(%ebp)
  100e25:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  100e29:	89 c2                	mov    %eax,%edx
  100e2b:	ec                   	in     (%dx),%al
  100e2c:	88 45 f9             	mov    %al,-0x7(%ebp)
  100e2f:	66 c7 45 f6 84 00    	movw   $0x84,-0xa(%ebp)
  100e35:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  100e39:	89 c2                	mov    %eax,%edx
  100e3b:	ec                   	in     (%dx),%al
  100e3c:	88 45 f5             	mov    %al,-0xb(%ebp)
  100e3f:	66 c7 45 f2 84 00    	movw   $0x84,-0xe(%ebp)
  100e45:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  100e49:	89 c2                	mov    %eax,%edx
  100e4b:	ec                   	in     (%dx),%al
  100e4c:	88 45 f1             	mov    %al,-0xf(%ebp)
    inb(0x84);
    inb(0x84);
    inb(0x84);
    inb(0x84);
}
  100e4f:	c9                   	leave  
  100e50:	c3                   	ret    

00100e51 <cga_init>:
static uint16_t addr_6845;

/* TEXT-mode CGA/VGA display output */

static void
cga_init(void) {
  100e51:	55                   	push   %ebp
  100e52:	89 e5                	mov    %esp,%ebp
  100e54:	83 ec 20             	sub    $0x20,%esp
    volatile uint16_t *cp = (uint16_t *)CGA_BUF;
  100e57:	c7 45 fc 00 80 0b 00 	movl   $0xb8000,-0x4(%ebp)
    uint16_t was = *cp;
  100e5e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100e61:	0f b7 00             	movzwl (%eax),%eax
  100e64:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
    *cp = (uint16_t) 0xA55A;
  100e68:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100e6b:	66 c7 00 5a a5       	movw   $0xa55a,(%eax)
    if (*cp != 0xA55A) {
  100e70:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100e73:	0f b7 00             	movzwl (%eax),%eax
  100e76:	66 3d 5a a5          	cmp    $0xa55a,%ax
  100e7a:	74 12                	je     100e8e <cga_init+0x3d>
        cp = (uint16_t*)MONO_BUF;
  100e7c:	c7 45 fc 00 00 0b 00 	movl   $0xb0000,-0x4(%ebp)
        addr_6845 = MONO_BASE;
  100e83:	66 c7 05 66 ee 10 00 	movw   $0x3b4,0x10ee66
  100e8a:	b4 03 
  100e8c:	eb 13                	jmp    100ea1 <cga_init+0x50>
    } else {
        *cp = was;
  100e8e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100e91:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  100e95:	66 89 10             	mov    %dx,(%eax)
        addr_6845 = CGA_BASE;
  100e98:	66 c7 05 66 ee 10 00 	movw   $0x3d4,0x10ee66
  100e9f:	d4 03 
    }

    // Extract cursor location
    uint32_t pos;
    outb(addr_6845, 14);
  100ea1:	0f b7 05 66 ee 10 00 	movzwl 0x10ee66,%eax
  100ea8:	0f b7 c0             	movzwl %ax,%eax
  100eab:	66 89 45 f2          	mov    %ax,-0xe(%ebp)
  100eaf:	c6 45 f1 0e          	movb   $0xe,-0xf(%ebp)
            : "memory", "cc");
}

static inline void
outb(uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100eb3:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  100eb7:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  100ebb:	ee                   	out    %al,(%dx)
    pos = inb(addr_6845 + 1) << 8;
  100ebc:	0f b7 05 66 ee 10 00 	movzwl 0x10ee66,%eax
  100ec3:	83 c0 01             	add    $0x1,%eax
  100ec6:	0f b7 c0             	movzwl %ax,%eax
  100ec9:	66 89 45 ee          	mov    %ax,-0x12(%ebp)
static inline void ltr(uint16_t sel) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100ecd:	0f b7 45 ee          	movzwl -0x12(%ebp),%eax
  100ed1:	89 c2                	mov    %eax,%edx
  100ed3:	ec                   	in     (%dx),%al
  100ed4:	88 45 ed             	mov    %al,-0x13(%ebp)
    return data;
  100ed7:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  100edb:	0f b6 c0             	movzbl %al,%eax
  100ede:	c1 e0 08             	shl    $0x8,%eax
  100ee1:	89 45 f4             	mov    %eax,-0xc(%ebp)
    outb(addr_6845, 15);
  100ee4:	0f b7 05 66 ee 10 00 	movzwl 0x10ee66,%eax
  100eeb:	0f b7 c0             	movzwl %ax,%eax
  100eee:	66 89 45 ea          	mov    %ax,-0x16(%ebp)
  100ef2:	c6 45 e9 0f          	movb   $0xf,-0x17(%ebp)
            : "memory", "cc");
}

static inline void
outb(uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100ef6:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  100efa:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  100efe:	ee                   	out    %al,(%dx)
    pos |= inb(addr_6845 + 1);
  100eff:	0f b7 05 66 ee 10 00 	movzwl 0x10ee66,%eax
  100f06:	83 c0 01             	add    $0x1,%eax
  100f09:	0f b7 c0             	movzwl %ax,%eax
  100f0c:	66 89 45 e6          	mov    %ax,-0x1a(%ebp)
static inline void ltr(uint16_t sel) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100f10:	0f b7 45 e6          	movzwl -0x1a(%ebp),%eax
  100f14:	89 c2                	mov    %eax,%edx
  100f16:	ec                   	in     (%dx),%al
  100f17:	88 45 e5             	mov    %al,-0x1b(%ebp)
    return data;
  100f1a:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  100f1e:	0f b6 c0             	movzbl %al,%eax
  100f21:	09 45 f4             	or     %eax,-0xc(%ebp)

    crt_buf = (uint16_t*) cp;
  100f24:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100f27:	a3 60 ee 10 00       	mov    %eax,0x10ee60
    crt_pos = pos;
  100f2c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100f2f:	66 a3 64 ee 10 00    	mov    %ax,0x10ee64
}
  100f35:	c9                   	leave  
  100f36:	c3                   	ret    

00100f37 <serial_init>:

static bool serial_exists = 0;

static void
serial_init(void) {
  100f37:	55                   	push   %ebp
  100f38:	89 e5                	mov    %esp,%ebp
  100f3a:	83 ec 48             	sub    $0x48,%esp
  100f3d:	66 c7 45 f6 fa 03    	movw   $0x3fa,-0xa(%ebp)
  100f43:	c6 45 f5 00          	movb   $0x0,-0xb(%ebp)
            : "memory", "cc");
}

static inline void
outb(uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100f47:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  100f4b:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  100f4f:	ee                   	out    %al,(%dx)
  100f50:	66 c7 45 f2 fb 03    	movw   $0x3fb,-0xe(%ebp)
  100f56:	c6 45 f1 80          	movb   $0x80,-0xf(%ebp)
  100f5a:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  100f5e:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  100f62:	ee                   	out    %al,(%dx)
  100f63:	66 c7 45 ee f8 03    	movw   $0x3f8,-0x12(%ebp)
  100f69:	c6 45 ed 0c          	movb   $0xc,-0x13(%ebp)
  100f6d:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  100f71:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  100f75:	ee                   	out    %al,(%dx)
  100f76:	66 c7 45 ea f9 03    	movw   $0x3f9,-0x16(%ebp)
  100f7c:	c6 45 e9 00          	movb   $0x0,-0x17(%ebp)
  100f80:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  100f84:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  100f88:	ee                   	out    %al,(%dx)
  100f89:	66 c7 45 e6 fb 03    	movw   $0x3fb,-0x1a(%ebp)
  100f8f:	c6 45 e5 03          	movb   $0x3,-0x1b(%ebp)
  100f93:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  100f97:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  100f9b:	ee                   	out    %al,(%dx)
  100f9c:	66 c7 45 e2 fc 03    	movw   $0x3fc,-0x1e(%ebp)
  100fa2:	c6 45 e1 00          	movb   $0x0,-0x1f(%ebp)
  100fa6:	0f b6 45 e1          	movzbl -0x1f(%ebp),%eax
  100faa:	0f b7 55 e2          	movzwl -0x1e(%ebp),%edx
  100fae:	ee                   	out    %al,(%dx)
  100faf:	66 c7 45 de f9 03    	movw   $0x3f9,-0x22(%ebp)
  100fb5:	c6 45 dd 01          	movb   $0x1,-0x23(%ebp)
  100fb9:	0f b6 45 dd          	movzbl -0x23(%ebp),%eax
  100fbd:	0f b7 55 de          	movzwl -0x22(%ebp),%edx
  100fc1:	ee                   	out    %al,(%dx)
  100fc2:	66 c7 45 da fd 03    	movw   $0x3fd,-0x26(%ebp)
static inline void ltr(uint16_t sel) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100fc8:	0f b7 45 da          	movzwl -0x26(%ebp),%eax
  100fcc:	89 c2                	mov    %eax,%edx
  100fce:	ec                   	in     (%dx),%al
  100fcf:	88 45 d9             	mov    %al,-0x27(%ebp)
    return data;
  100fd2:	0f b6 45 d9          	movzbl -0x27(%ebp),%eax
    // Enable rcv interrupts
    outb(COM1 + COM_IER, COM_IER_RDI);

    // Clear any preexisting overrun indications and interrupts
    // Serial port doesn't exist if COM_LSR returns 0xFF
    serial_exists = (inb(COM1 + COM_LSR) != 0xFF);
  100fd6:	3c ff                	cmp    $0xff,%al
  100fd8:	0f 95 c0             	setne  %al
  100fdb:	0f b6 c0             	movzbl %al,%eax
  100fde:	a3 68 ee 10 00       	mov    %eax,0x10ee68
  100fe3:	66 c7 45 d6 fa 03    	movw   $0x3fa,-0x2a(%ebp)
static inline void ltr(uint16_t sel) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100fe9:	0f b7 45 d6          	movzwl -0x2a(%ebp),%eax
  100fed:	89 c2                	mov    %eax,%edx
  100fef:	ec                   	in     (%dx),%al
  100ff0:	88 45 d5             	mov    %al,-0x2b(%ebp)
  100ff3:	66 c7 45 d2 f8 03    	movw   $0x3f8,-0x2e(%ebp)
  100ff9:	0f b7 45 d2          	movzwl -0x2e(%ebp),%eax
  100ffd:	89 c2                	mov    %eax,%edx
  100fff:	ec                   	in     (%dx),%al
  101000:	88 45 d1             	mov    %al,-0x2f(%ebp)
    (void) inb(COM1+COM_IIR);
    (void) inb(COM1+COM_RX);

    if (serial_exists) {
  101003:	a1 68 ee 10 00       	mov    0x10ee68,%eax
  101008:	85 c0                	test   %eax,%eax
  10100a:	74 0c                	je     101018 <serial_init+0xe1>
        pic_enable(IRQ_COM1);
  10100c:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
  101013:	e8 b0 06 00 00       	call   1016c8 <pic_enable>
    }
}
  101018:	c9                   	leave  
  101019:	c3                   	ret    

0010101a <lpt_putc_sub>:

static void
lpt_putc_sub(int c) {
  10101a:	55                   	push   %ebp
  10101b:	89 e5                	mov    %esp,%ebp
  10101d:	83 ec 20             	sub    $0x20,%esp
    int i;
    for (i = 0; !(inb(LPTPORT + 1) & 0x80) && i < 12800; i ++) {
  101020:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  101027:	eb 09                	jmp    101032 <lpt_putc_sub+0x18>
        delay();
  101029:	e8 db fd ff ff       	call   100e09 <delay>
}

static void
lpt_putc_sub(int c) {
    int i;
    for (i = 0; !(inb(LPTPORT + 1) & 0x80) && i < 12800; i ++) {
  10102e:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  101032:	66 c7 45 fa 79 03    	movw   $0x379,-0x6(%ebp)
  101038:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  10103c:	89 c2                	mov    %eax,%edx
  10103e:	ec                   	in     (%dx),%al
  10103f:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  101042:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  101046:	84 c0                	test   %al,%al
  101048:	78 09                	js     101053 <lpt_putc_sub+0x39>
  10104a:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%ebp)
  101051:	7e d6                	jle    101029 <lpt_putc_sub+0xf>
        delay();
    }
    outb(LPTPORT + 0, c);
  101053:	8b 45 08             	mov    0x8(%ebp),%eax
  101056:	0f b6 c0             	movzbl %al,%eax
  101059:	66 c7 45 f6 78 03    	movw   $0x378,-0xa(%ebp)
  10105f:	88 45 f5             	mov    %al,-0xb(%ebp)
            : "memory", "cc");
}

static inline void
outb(uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101062:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  101066:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  10106a:	ee                   	out    %al,(%dx)
  10106b:	66 c7 45 f2 7a 03    	movw   $0x37a,-0xe(%ebp)
  101071:	c6 45 f1 0d          	movb   $0xd,-0xf(%ebp)
  101075:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  101079:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  10107d:	ee                   	out    %al,(%dx)
  10107e:	66 c7 45 ee 7a 03    	movw   $0x37a,-0x12(%ebp)
  101084:	c6 45 ed 08          	movb   $0x8,-0x13(%ebp)
  101088:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  10108c:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  101090:	ee                   	out    %al,(%dx)
    outb(LPTPORT + 2, 0x08 | 0x04 | 0x01);
    outb(LPTPORT + 2, 0x08);
}
  101091:	c9                   	leave  
  101092:	c3                   	ret    

00101093 <lpt_putc>:

/* lpt_putc - copy console output to parallel port */
static void
lpt_putc(int c) {
  101093:	55                   	push   %ebp
  101094:	89 e5                	mov    %esp,%ebp
  101096:	83 ec 04             	sub    $0x4,%esp
    if (c != '\b') {
  101099:	83 7d 08 08          	cmpl   $0x8,0x8(%ebp)
  10109d:	74 0d                	je     1010ac <lpt_putc+0x19>
        lpt_putc_sub(c);
  10109f:	8b 45 08             	mov    0x8(%ebp),%eax
  1010a2:	89 04 24             	mov    %eax,(%esp)
  1010a5:	e8 70 ff ff ff       	call   10101a <lpt_putc_sub>
  1010aa:	eb 24                	jmp    1010d0 <lpt_putc+0x3d>
    }
    else {
        lpt_putc_sub('\b');
  1010ac:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  1010b3:	e8 62 ff ff ff       	call   10101a <lpt_putc_sub>
        lpt_putc_sub(' ');
  1010b8:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  1010bf:	e8 56 ff ff ff       	call   10101a <lpt_putc_sub>
        lpt_putc_sub('\b');
  1010c4:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  1010cb:	e8 4a ff ff ff       	call   10101a <lpt_putc_sub>
    }
}
  1010d0:	c9                   	leave  
  1010d1:	c3                   	ret    

001010d2 <cga_putc>:

/* cga_putc - print character to console */
static void
cga_putc(int c) {
  1010d2:	55                   	push   %ebp
  1010d3:	89 e5                	mov    %esp,%ebp
  1010d5:	53                   	push   %ebx
  1010d6:	83 ec 34             	sub    $0x34,%esp
    // set black on white
    if (!(c & ~0xFF)) {
  1010d9:	8b 45 08             	mov    0x8(%ebp),%eax
  1010dc:	b0 00                	mov    $0x0,%al
  1010de:	85 c0                	test   %eax,%eax
  1010e0:	75 07                	jne    1010e9 <cga_putc+0x17>
        c |= 0x0700;
  1010e2:	81 4d 08 00 07 00 00 	orl    $0x700,0x8(%ebp)
    }

    switch (c & 0xff) {
  1010e9:	8b 45 08             	mov    0x8(%ebp),%eax
  1010ec:	0f b6 c0             	movzbl %al,%eax
  1010ef:	83 f8 0a             	cmp    $0xa,%eax
  1010f2:	74 4c                	je     101140 <cga_putc+0x6e>
  1010f4:	83 f8 0d             	cmp    $0xd,%eax
  1010f7:	74 57                	je     101150 <cga_putc+0x7e>
  1010f9:	83 f8 08             	cmp    $0x8,%eax
  1010fc:	0f 85 88 00 00 00    	jne    10118a <cga_putc+0xb8>
    case '\b':
        if (crt_pos > 0) {
  101102:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  101109:	66 85 c0             	test   %ax,%ax
  10110c:	74 30                	je     10113e <cga_putc+0x6c>
            crt_pos --;
  10110e:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  101115:	83 e8 01             	sub    $0x1,%eax
  101118:	66 a3 64 ee 10 00    	mov    %ax,0x10ee64
            crt_buf[crt_pos] = (c & ~0xff) | ' ';
  10111e:	a1 60 ee 10 00       	mov    0x10ee60,%eax
  101123:	0f b7 15 64 ee 10 00 	movzwl 0x10ee64,%edx
  10112a:	0f b7 d2             	movzwl %dx,%edx
  10112d:	01 d2                	add    %edx,%edx
  10112f:	01 c2                	add    %eax,%edx
  101131:	8b 45 08             	mov    0x8(%ebp),%eax
  101134:	b0 00                	mov    $0x0,%al
  101136:	83 c8 20             	or     $0x20,%eax
  101139:	66 89 02             	mov    %ax,(%edx)
        }
        break;
  10113c:	eb 72                	jmp    1011b0 <cga_putc+0xde>
  10113e:	eb 70                	jmp    1011b0 <cga_putc+0xde>
    case '\n':
        crt_pos += CRT_COLS;
  101140:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  101147:	83 c0 50             	add    $0x50,%eax
  10114a:	66 a3 64 ee 10 00    	mov    %ax,0x10ee64
    case '\r':
        crt_pos -= (crt_pos % CRT_COLS);
  101150:	0f b7 1d 64 ee 10 00 	movzwl 0x10ee64,%ebx
  101157:	0f b7 0d 64 ee 10 00 	movzwl 0x10ee64,%ecx
  10115e:	0f b7 c1             	movzwl %cx,%eax
  101161:	69 c0 cd cc 00 00    	imul   $0xcccd,%eax,%eax
  101167:	c1 e8 10             	shr    $0x10,%eax
  10116a:	89 c2                	mov    %eax,%edx
  10116c:	66 c1 ea 06          	shr    $0x6,%dx
  101170:	89 d0                	mov    %edx,%eax
  101172:	c1 e0 02             	shl    $0x2,%eax
  101175:	01 d0                	add    %edx,%eax
  101177:	c1 e0 04             	shl    $0x4,%eax
  10117a:	29 c1                	sub    %eax,%ecx
  10117c:	89 ca                	mov    %ecx,%edx
  10117e:	89 d8                	mov    %ebx,%eax
  101180:	29 d0                	sub    %edx,%eax
  101182:	66 a3 64 ee 10 00    	mov    %ax,0x10ee64
        break;
  101188:	eb 26                	jmp    1011b0 <cga_putc+0xde>
    default:
        crt_buf[crt_pos ++] = c;     // write the character
  10118a:	8b 0d 60 ee 10 00    	mov    0x10ee60,%ecx
  101190:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  101197:	8d 50 01             	lea    0x1(%eax),%edx
  10119a:	66 89 15 64 ee 10 00 	mov    %dx,0x10ee64
  1011a1:	0f b7 c0             	movzwl %ax,%eax
  1011a4:	01 c0                	add    %eax,%eax
  1011a6:	8d 14 01             	lea    (%ecx,%eax,1),%edx
  1011a9:	8b 45 08             	mov    0x8(%ebp),%eax
  1011ac:	66 89 02             	mov    %ax,(%edx)
        break;
  1011af:	90                   	nop
    }

    // What is the purpose of this?
    if (crt_pos >= CRT_SIZE) {
  1011b0:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  1011b7:	66 3d cf 07          	cmp    $0x7cf,%ax
  1011bb:	76 5b                	jbe    101218 <cga_putc+0x146>
        int i;
        memmove(crt_buf, crt_buf + CRT_COLS, (CRT_SIZE - CRT_COLS) * sizeof(uint16_t));
  1011bd:	a1 60 ee 10 00       	mov    0x10ee60,%eax
  1011c2:	8d 90 a0 00 00 00    	lea    0xa0(%eax),%edx
  1011c8:	a1 60 ee 10 00       	mov    0x10ee60,%eax
  1011cd:	c7 44 24 08 00 0f 00 	movl   $0xf00,0x8(%esp)
  1011d4:	00 
  1011d5:	89 54 24 04          	mov    %edx,0x4(%esp)
  1011d9:	89 04 24             	mov    %eax,(%esp)
  1011dc:	e8 91 22 00 00       	call   103472 <memmove>
        for (i = CRT_SIZE - CRT_COLS; i < CRT_SIZE; i ++) {
  1011e1:	c7 45 f4 80 07 00 00 	movl   $0x780,-0xc(%ebp)
  1011e8:	eb 15                	jmp    1011ff <cga_putc+0x12d>
            crt_buf[i] = 0x0700 | ' ';
  1011ea:	a1 60 ee 10 00       	mov    0x10ee60,%eax
  1011ef:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1011f2:	01 d2                	add    %edx,%edx
  1011f4:	01 d0                	add    %edx,%eax
  1011f6:	66 c7 00 20 07       	movw   $0x720,(%eax)

    // What is the purpose of this?
    if (crt_pos >= CRT_SIZE) {
        int i;
        memmove(crt_buf, crt_buf + CRT_COLS, (CRT_SIZE - CRT_COLS) * sizeof(uint16_t));
        for (i = CRT_SIZE - CRT_COLS; i < CRT_SIZE; i ++) {
  1011fb:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  1011ff:	81 7d f4 cf 07 00 00 	cmpl   $0x7cf,-0xc(%ebp)
  101206:	7e e2                	jle    1011ea <cga_putc+0x118>
            crt_buf[i] = 0x0700 | ' ';
        }
        crt_pos -= CRT_COLS;
  101208:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  10120f:	83 e8 50             	sub    $0x50,%eax
  101212:	66 a3 64 ee 10 00    	mov    %ax,0x10ee64
    }

    // move that little blinky thing
    outb(addr_6845, 14);
  101218:	0f b7 05 66 ee 10 00 	movzwl 0x10ee66,%eax
  10121f:	0f b7 c0             	movzwl %ax,%eax
  101222:	66 89 45 f2          	mov    %ax,-0xe(%ebp)
  101226:	c6 45 f1 0e          	movb   $0xe,-0xf(%ebp)
  10122a:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  10122e:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  101232:	ee                   	out    %al,(%dx)
    outb(addr_6845 + 1, crt_pos >> 8);
  101233:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  10123a:	66 c1 e8 08          	shr    $0x8,%ax
  10123e:	0f b6 c0             	movzbl %al,%eax
  101241:	0f b7 15 66 ee 10 00 	movzwl 0x10ee66,%edx
  101248:	83 c2 01             	add    $0x1,%edx
  10124b:	0f b7 d2             	movzwl %dx,%edx
  10124e:	66 89 55 ee          	mov    %dx,-0x12(%ebp)
  101252:	88 45 ed             	mov    %al,-0x13(%ebp)
  101255:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  101259:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  10125d:	ee                   	out    %al,(%dx)
    outb(addr_6845, 15);
  10125e:	0f b7 05 66 ee 10 00 	movzwl 0x10ee66,%eax
  101265:	0f b7 c0             	movzwl %ax,%eax
  101268:	66 89 45 ea          	mov    %ax,-0x16(%ebp)
  10126c:	c6 45 e9 0f          	movb   $0xf,-0x17(%ebp)
  101270:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  101274:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  101278:	ee                   	out    %al,(%dx)
    outb(addr_6845 + 1, crt_pos);
  101279:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  101280:	0f b6 c0             	movzbl %al,%eax
  101283:	0f b7 15 66 ee 10 00 	movzwl 0x10ee66,%edx
  10128a:	83 c2 01             	add    $0x1,%edx
  10128d:	0f b7 d2             	movzwl %dx,%edx
  101290:	66 89 55 e6          	mov    %dx,-0x1a(%ebp)
  101294:	88 45 e5             	mov    %al,-0x1b(%ebp)
  101297:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  10129b:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  10129f:	ee                   	out    %al,(%dx)
}
  1012a0:	83 c4 34             	add    $0x34,%esp
  1012a3:	5b                   	pop    %ebx
  1012a4:	5d                   	pop    %ebp
  1012a5:	c3                   	ret    

001012a6 <serial_putc_sub>:

static void
serial_putc_sub(int c) {
  1012a6:	55                   	push   %ebp
  1012a7:	89 e5                	mov    %esp,%ebp
  1012a9:	83 ec 10             	sub    $0x10,%esp
    int i;
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i ++) {
  1012ac:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  1012b3:	eb 09                	jmp    1012be <serial_putc_sub+0x18>
        delay();
  1012b5:	e8 4f fb ff ff       	call   100e09 <delay>
}

static void
serial_putc_sub(int c) {
    int i;
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i ++) {
  1012ba:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  1012be:	66 c7 45 fa fd 03    	movw   $0x3fd,-0x6(%ebp)
static inline void ltr(uint16_t sel) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  1012c4:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  1012c8:	89 c2                	mov    %eax,%edx
  1012ca:	ec                   	in     (%dx),%al
  1012cb:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  1012ce:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  1012d2:	0f b6 c0             	movzbl %al,%eax
  1012d5:	83 e0 20             	and    $0x20,%eax
  1012d8:	85 c0                	test   %eax,%eax
  1012da:	75 09                	jne    1012e5 <serial_putc_sub+0x3f>
  1012dc:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%ebp)
  1012e3:	7e d0                	jle    1012b5 <serial_putc_sub+0xf>
        delay();
    }
    outb(COM1 + COM_TX, c);
  1012e5:	8b 45 08             	mov    0x8(%ebp),%eax
  1012e8:	0f b6 c0             	movzbl %al,%eax
  1012eb:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
  1012f1:	88 45 f5             	mov    %al,-0xb(%ebp)
            : "memory", "cc");
}

static inline void
outb(uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1012f4:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  1012f8:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  1012fc:	ee                   	out    %al,(%dx)
}
  1012fd:	c9                   	leave  
  1012fe:	c3                   	ret    

001012ff <serial_putc>:

/* serial_putc - print character to serial port */
static void
serial_putc(int c) {
  1012ff:	55                   	push   %ebp
  101300:	89 e5                	mov    %esp,%ebp
  101302:	83 ec 04             	sub    $0x4,%esp
    if (c != '\b') {
  101305:	83 7d 08 08          	cmpl   $0x8,0x8(%ebp)
  101309:	74 0d                	je     101318 <serial_putc+0x19>
        serial_putc_sub(c);
  10130b:	8b 45 08             	mov    0x8(%ebp),%eax
  10130e:	89 04 24             	mov    %eax,(%esp)
  101311:	e8 90 ff ff ff       	call   1012a6 <serial_putc_sub>
  101316:	eb 24                	jmp    10133c <serial_putc+0x3d>
    }
    else {
        serial_putc_sub('\b');
  101318:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  10131f:	e8 82 ff ff ff       	call   1012a6 <serial_putc_sub>
        serial_putc_sub(' ');
  101324:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  10132b:	e8 76 ff ff ff       	call   1012a6 <serial_putc_sub>
        serial_putc_sub('\b');
  101330:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  101337:	e8 6a ff ff ff       	call   1012a6 <serial_putc_sub>
    }
}
  10133c:	c9                   	leave  
  10133d:	c3                   	ret    

0010133e <cons_intr>:
/* *
 * cons_intr - called by device interrupt routines to feed input
 * characters into the circular console input buffer.
 * */
static void
cons_intr(int (*proc)(void)) {
  10133e:	55                   	push   %ebp
  10133f:	89 e5                	mov    %esp,%ebp
  101341:	83 ec 18             	sub    $0x18,%esp
    int c;
    while ((c = (*proc)()) != -1) {
  101344:	eb 33                	jmp    101379 <cons_intr+0x3b>
        if (c != 0) {
  101346:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  10134a:	74 2d                	je     101379 <cons_intr+0x3b>
            cons.buf[cons.wpos ++] = c;
  10134c:	a1 84 f0 10 00       	mov    0x10f084,%eax
  101351:	8d 50 01             	lea    0x1(%eax),%edx
  101354:	89 15 84 f0 10 00    	mov    %edx,0x10f084
  10135a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  10135d:	88 90 80 ee 10 00    	mov    %dl,0x10ee80(%eax)
            if (cons.wpos == CONSBUFSIZE) {
  101363:	a1 84 f0 10 00       	mov    0x10f084,%eax
  101368:	3d 00 02 00 00       	cmp    $0x200,%eax
  10136d:	75 0a                	jne    101379 <cons_intr+0x3b>
                cons.wpos = 0;
  10136f:	c7 05 84 f0 10 00 00 	movl   $0x0,0x10f084
  101376:	00 00 00 
 * characters into the circular console input buffer.
 * */
static void
cons_intr(int (*proc)(void)) {
    int c;
    while ((c = (*proc)()) != -1) {
  101379:	8b 45 08             	mov    0x8(%ebp),%eax
  10137c:	ff d0                	call   *%eax
  10137e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  101381:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
  101385:	75 bf                	jne    101346 <cons_intr+0x8>
            if (cons.wpos == CONSBUFSIZE) {
                cons.wpos = 0;
            }
        }
    }
}
  101387:	c9                   	leave  
  101388:	c3                   	ret    

00101389 <serial_proc_data>:

/* serial_proc_data - get data from serial port */
static int
serial_proc_data(void) {
  101389:	55                   	push   %ebp
  10138a:	89 e5                	mov    %esp,%ebp
  10138c:	83 ec 10             	sub    $0x10,%esp
  10138f:	66 c7 45 fa fd 03    	movw   $0x3fd,-0x6(%ebp)
static inline void ltr(uint16_t sel) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  101395:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  101399:	89 c2                	mov    %eax,%edx
  10139b:	ec                   	in     (%dx),%al
  10139c:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  10139f:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
    if (!(inb(COM1 + COM_LSR) & COM_LSR_DATA)) {
  1013a3:	0f b6 c0             	movzbl %al,%eax
  1013a6:	83 e0 01             	and    $0x1,%eax
  1013a9:	85 c0                	test   %eax,%eax
  1013ab:	75 07                	jne    1013b4 <serial_proc_data+0x2b>
        return -1;
  1013ad:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1013b2:	eb 2a                	jmp    1013de <serial_proc_data+0x55>
  1013b4:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
static inline void ltr(uint16_t sel) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  1013ba:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  1013be:	89 c2                	mov    %eax,%edx
  1013c0:	ec                   	in     (%dx),%al
  1013c1:	88 45 f5             	mov    %al,-0xb(%ebp)
    return data;
  1013c4:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
    }
    int c = inb(COM1 + COM_RX);
  1013c8:	0f b6 c0             	movzbl %al,%eax
  1013cb:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (c == 127) {
  1013ce:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%ebp)
  1013d2:	75 07                	jne    1013db <serial_proc_data+0x52>
        c = '\b';
  1013d4:	c7 45 fc 08 00 00 00 	movl   $0x8,-0x4(%ebp)
    }
    return c;
  1013db:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  1013de:	c9                   	leave  
  1013df:	c3                   	ret    

001013e0 <serial_intr>:

/* serial_intr - try to feed input characters from serial port */
void
serial_intr(void) {
  1013e0:	55                   	push   %ebp
  1013e1:	89 e5                	mov    %esp,%ebp
  1013e3:	83 ec 18             	sub    $0x18,%esp
    if (serial_exists) {
  1013e6:	a1 68 ee 10 00       	mov    0x10ee68,%eax
  1013eb:	85 c0                	test   %eax,%eax
  1013ed:	74 0c                	je     1013fb <serial_intr+0x1b>
        cons_intr(serial_proc_data);
  1013ef:	c7 04 24 89 13 10 00 	movl   $0x101389,(%esp)
  1013f6:	e8 43 ff ff ff       	call   10133e <cons_intr>
    }
}
  1013fb:	c9                   	leave  
  1013fc:	c3                   	ret    

001013fd <kbd_proc_data>:
 *
 * The kbd_proc_data() function gets data from the keyboard.
 * If we finish a character, return it, else 0. And return -1 if no data.
 * */
static int
kbd_proc_data(void) {
  1013fd:	55                   	push   %ebp
  1013fe:	89 e5                	mov    %esp,%ebp
  101400:	83 ec 38             	sub    $0x38,%esp
  101403:	66 c7 45 f0 64 00    	movw   $0x64,-0x10(%ebp)
static inline void ltr(uint16_t sel) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  101409:	0f b7 45 f0          	movzwl -0x10(%ebp),%eax
  10140d:	89 c2                	mov    %eax,%edx
  10140f:	ec                   	in     (%dx),%al
  101410:	88 45 ef             	mov    %al,-0x11(%ebp)
    return data;
  101413:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    int c;
    uint8_t data;
    static uint32_t shift;

    if ((inb(KBSTATP) & KBS_DIB) == 0) {
  101417:	0f b6 c0             	movzbl %al,%eax
  10141a:	83 e0 01             	and    $0x1,%eax
  10141d:	85 c0                	test   %eax,%eax
  10141f:	75 0a                	jne    10142b <kbd_proc_data+0x2e>
        return -1;
  101421:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  101426:	e9 59 01 00 00       	jmp    101584 <kbd_proc_data+0x187>
  10142b:	66 c7 45 ec 60 00    	movw   $0x60,-0x14(%ebp)
static inline void ltr(uint16_t sel) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  101431:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  101435:	89 c2                	mov    %eax,%edx
  101437:	ec                   	in     (%dx),%al
  101438:	88 45 eb             	mov    %al,-0x15(%ebp)
    return data;
  10143b:	0f b6 45 eb          	movzbl -0x15(%ebp),%eax
    }

    data = inb(KBDATAP);
  10143f:	88 45 f3             	mov    %al,-0xd(%ebp)

    if (data == 0xE0) {
  101442:	80 7d f3 e0          	cmpb   $0xe0,-0xd(%ebp)
  101446:	75 17                	jne    10145f <kbd_proc_data+0x62>
        // E0 escape character
        shift |= E0ESC;
  101448:	a1 88 f0 10 00       	mov    0x10f088,%eax
  10144d:	83 c8 40             	or     $0x40,%eax
  101450:	a3 88 f0 10 00       	mov    %eax,0x10f088
        return 0;
  101455:	b8 00 00 00 00       	mov    $0x0,%eax
  10145a:	e9 25 01 00 00       	jmp    101584 <kbd_proc_data+0x187>
    } else if (data & 0x80) {
  10145f:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101463:	84 c0                	test   %al,%al
  101465:	79 47                	jns    1014ae <kbd_proc_data+0xb1>
        // Key released
        data = (shift & E0ESC ? data : data & 0x7F);
  101467:	a1 88 f0 10 00       	mov    0x10f088,%eax
  10146c:	83 e0 40             	and    $0x40,%eax
  10146f:	85 c0                	test   %eax,%eax
  101471:	75 09                	jne    10147c <kbd_proc_data+0x7f>
  101473:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101477:	83 e0 7f             	and    $0x7f,%eax
  10147a:	eb 04                	jmp    101480 <kbd_proc_data+0x83>
  10147c:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101480:	88 45 f3             	mov    %al,-0xd(%ebp)
        shift &= ~(shiftcode[data] | E0ESC);
  101483:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101487:	0f b6 80 40 e0 10 00 	movzbl 0x10e040(%eax),%eax
  10148e:	83 c8 40             	or     $0x40,%eax
  101491:	0f b6 c0             	movzbl %al,%eax
  101494:	f7 d0                	not    %eax
  101496:	89 c2                	mov    %eax,%edx
  101498:	a1 88 f0 10 00       	mov    0x10f088,%eax
  10149d:	21 d0                	and    %edx,%eax
  10149f:	a3 88 f0 10 00       	mov    %eax,0x10f088
        return 0;
  1014a4:	b8 00 00 00 00       	mov    $0x0,%eax
  1014a9:	e9 d6 00 00 00       	jmp    101584 <kbd_proc_data+0x187>
    } else if (shift & E0ESC) {
  1014ae:	a1 88 f0 10 00       	mov    0x10f088,%eax
  1014b3:	83 e0 40             	and    $0x40,%eax
  1014b6:	85 c0                	test   %eax,%eax
  1014b8:	74 11                	je     1014cb <kbd_proc_data+0xce>
        // Last character was an E0 escape; or with 0x80
        data |= 0x80;
  1014ba:	80 4d f3 80          	orb    $0x80,-0xd(%ebp)
        shift &= ~E0ESC;
  1014be:	a1 88 f0 10 00       	mov    0x10f088,%eax
  1014c3:	83 e0 bf             	and    $0xffffffbf,%eax
  1014c6:	a3 88 f0 10 00       	mov    %eax,0x10f088
    }

    shift |= shiftcode[data];
  1014cb:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1014cf:	0f b6 80 40 e0 10 00 	movzbl 0x10e040(%eax),%eax
  1014d6:	0f b6 d0             	movzbl %al,%edx
  1014d9:	a1 88 f0 10 00       	mov    0x10f088,%eax
  1014de:	09 d0                	or     %edx,%eax
  1014e0:	a3 88 f0 10 00       	mov    %eax,0x10f088
    shift ^= togglecode[data];
  1014e5:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1014e9:	0f b6 80 40 e1 10 00 	movzbl 0x10e140(%eax),%eax
  1014f0:	0f b6 d0             	movzbl %al,%edx
  1014f3:	a1 88 f0 10 00       	mov    0x10f088,%eax
  1014f8:	31 d0                	xor    %edx,%eax
  1014fa:	a3 88 f0 10 00       	mov    %eax,0x10f088

    c = charcode[shift & (CTL | SHIFT)][data];
  1014ff:	a1 88 f0 10 00       	mov    0x10f088,%eax
  101504:	83 e0 03             	and    $0x3,%eax
  101507:	8b 14 85 40 e5 10 00 	mov    0x10e540(,%eax,4),%edx
  10150e:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101512:	01 d0                	add    %edx,%eax
  101514:	0f b6 00             	movzbl (%eax),%eax
  101517:	0f b6 c0             	movzbl %al,%eax
  10151a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (shift & CAPSLOCK) {
  10151d:	a1 88 f0 10 00       	mov    0x10f088,%eax
  101522:	83 e0 08             	and    $0x8,%eax
  101525:	85 c0                	test   %eax,%eax
  101527:	74 22                	je     10154b <kbd_proc_data+0x14e>
        if ('a' <= c && c <= 'z')
  101529:	83 7d f4 60          	cmpl   $0x60,-0xc(%ebp)
  10152d:	7e 0c                	jle    10153b <kbd_proc_data+0x13e>
  10152f:	83 7d f4 7a          	cmpl   $0x7a,-0xc(%ebp)
  101533:	7f 06                	jg     10153b <kbd_proc_data+0x13e>
            c += 'A' - 'a';
  101535:	83 6d f4 20          	subl   $0x20,-0xc(%ebp)
  101539:	eb 10                	jmp    10154b <kbd_proc_data+0x14e>
        else if ('A' <= c && c <= 'Z')
  10153b:	83 7d f4 40          	cmpl   $0x40,-0xc(%ebp)
  10153f:	7e 0a                	jle    10154b <kbd_proc_data+0x14e>
  101541:	83 7d f4 5a          	cmpl   $0x5a,-0xc(%ebp)
  101545:	7f 04                	jg     10154b <kbd_proc_data+0x14e>
            c += 'a' - 'A';
  101547:	83 45 f4 20          	addl   $0x20,-0xc(%ebp)
    }

    // Process special keys
    // Ctrl-Alt-Del: reboot
    if (!(~shift & (CTL | ALT)) && c == KEY_DEL) {
  10154b:	a1 88 f0 10 00       	mov    0x10f088,%eax
  101550:	f7 d0                	not    %eax
  101552:	83 e0 06             	and    $0x6,%eax
  101555:	85 c0                	test   %eax,%eax
  101557:	75 28                	jne    101581 <kbd_proc_data+0x184>
  101559:	81 7d f4 e9 00 00 00 	cmpl   $0xe9,-0xc(%ebp)
  101560:	75 1f                	jne    101581 <kbd_proc_data+0x184>
        cprintf("Rebooting!\n");
  101562:	c7 04 24 f1 38 10 00 	movl   $0x1038f1,(%esp)
  101569:	e8 b4 ed ff ff       	call   100322 <cprintf>
  10156e:	66 c7 45 e8 92 00    	movw   $0x92,-0x18(%ebp)
  101574:	c6 45 e7 03          	movb   $0x3,-0x19(%ebp)
            : "memory", "cc");
}

static inline void
outb(uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101578:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
  10157c:	0f b7 55 e8          	movzwl -0x18(%ebp),%edx
  101580:	ee                   	out    %al,(%dx)
        outb(0x92, 0x3); // courtesy of Chris Frost
    }
    return c;
  101581:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  101584:	c9                   	leave  
  101585:	c3                   	ret    

00101586 <kbd_intr>:

/* kbd_intr - try to feed input characters from keyboard */
static void
kbd_intr(void) {
  101586:	55                   	push   %ebp
  101587:	89 e5                	mov    %esp,%ebp
  101589:	83 ec 18             	sub    $0x18,%esp
    cons_intr(kbd_proc_data);
  10158c:	c7 04 24 fd 13 10 00 	movl   $0x1013fd,(%esp)
  101593:	e8 a6 fd ff ff       	call   10133e <cons_intr>
}
  101598:	c9                   	leave  
  101599:	c3                   	ret    

0010159a <kbd_init>:

static void
kbd_init(void) {
  10159a:	55                   	push   %ebp
  10159b:	89 e5                	mov    %esp,%ebp
  10159d:	83 ec 18             	sub    $0x18,%esp
    // drain the kbd buffer
    kbd_intr();
  1015a0:	e8 e1 ff ff ff       	call   101586 <kbd_intr>
    pic_enable(IRQ_KBD);
  1015a5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  1015ac:	e8 17 01 00 00       	call   1016c8 <pic_enable>
}
  1015b1:	c9                   	leave  
  1015b2:	c3                   	ret    

001015b3 <cons_init>:

/* cons_init - initializes the console devices */
void
cons_init(void) {
  1015b3:	55                   	push   %ebp
  1015b4:	89 e5                	mov    %esp,%ebp
  1015b6:	83 ec 18             	sub    $0x18,%esp
    cga_init();
  1015b9:	e8 93 f8 ff ff       	call   100e51 <cga_init>
    serial_init();
  1015be:	e8 74 f9 ff ff       	call   100f37 <serial_init>
    kbd_init();
  1015c3:	e8 d2 ff ff ff       	call   10159a <kbd_init>
    if (!serial_exists) {
  1015c8:	a1 68 ee 10 00       	mov    0x10ee68,%eax
  1015cd:	85 c0                	test   %eax,%eax
  1015cf:	75 0c                	jne    1015dd <cons_init+0x2a>
        cprintf("serial port does not exist!!\n");
  1015d1:	c7 04 24 fd 38 10 00 	movl   $0x1038fd,(%esp)
  1015d8:	e8 45 ed ff ff       	call   100322 <cprintf>
    }
}
  1015dd:	c9                   	leave  
  1015de:	c3                   	ret    

001015df <cons_putc>:

/* cons_putc - print a single character @c to console devices */
void
cons_putc(int c) {
  1015df:	55                   	push   %ebp
  1015e0:	89 e5                	mov    %esp,%ebp
  1015e2:	83 ec 18             	sub    $0x18,%esp
    lpt_putc(c);
  1015e5:	8b 45 08             	mov    0x8(%ebp),%eax
  1015e8:	89 04 24             	mov    %eax,(%esp)
  1015eb:	e8 a3 fa ff ff       	call   101093 <lpt_putc>
    cga_putc(c);
  1015f0:	8b 45 08             	mov    0x8(%ebp),%eax
  1015f3:	89 04 24             	mov    %eax,(%esp)
  1015f6:	e8 d7 fa ff ff       	call   1010d2 <cga_putc>
    serial_putc(c);
  1015fb:	8b 45 08             	mov    0x8(%ebp),%eax
  1015fe:	89 04 24             	mov    %eax,(%esp)
  101601:	e8 f9 fc ff ff       	call   1012ff <serial_putc>
}
  101606:	c9                   	leave  
  101607:	c3                   	ret    

00101608 <cons_getc>:
/* *
 * cons_getc - return the next input character from console,
 * or 0 if none waiting.
 * */
int
cons_getc(void) {
  101608:	55                   	push   %ebp
  101609:	89 e5                	mov    %esp,%ebp
  10160b:	83 ec 18             	sub    $0x18,%esp
    int c;

    // poll for any pending input characters,
    // so that this function works even when interrupts are disabled
    // (e.g., when called from the kernel monitor).
    serial_intr();
  10160e:	e8 cd fd ff ff       	call   1013e0 <serial_intr>
    kbd_intr();
  101613:	e8 6e ff ff ff       	call   101586 <kbd_intr>

    // grab the next character from the input buffer.
    if (cons.rpos != cons.wpos) {
  101618:	8b 15 80 f0 10 00    	mov    0x10f080,%edx
  10161e:	a1 84 f0 10 00       	mov    0x10f084,%eax
  101623:	39 c2                	cmp    %eax,%edx
  101625:	74 36                	je     10165d <cons_getc+0x55>
        c = cons.buf[cons.rpos ++];
  101627:	a1 80 f0 10 00       	mov    0x10f080,%eax
  10162c:	8d 50 01             	lea    0x1(%eax),%edx
  10162f:	89 15 80 f0 10 00    	mov    %edx,0x10f080
  101635:	0f b6 80 80 ee 10 00 	movzbl 0x10ee80(%eax),%eax
  10163c:	0f b6 c0             	movzbl %al,%eax
  10163f:	89 45 f4             	mov    %eax,-0xc(%ebp)
        if (cons.rpos == CONSBUFSIZE) {
  101642:	a1 80 f0 10 00       	mov    0x10f080,%eax
  101647:	3d 00 02 00 00       	cmp    $0x200,%eax
  10164c:	75 0a                	jne    101658 <cons_getc+0x50>
            cons.rpos = 0;
  10164e:	c7 05 80 f0 10 00 00 	movl   $0x0,0x10f080
  101655:	00 00 00 
        }
        return c;
  101658:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10165b:	eb 05                	jmp    101662 <cons_getc+0x5a>
    }
    return 0;
  10165d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  101662:	c9                   	leave  
  101663:	c3                   	ret    

00101664 <intr_enable>:
#include <x86.h>
#include <intr.h>

/* intr_enable - enable irq interrupt */
void
intr_enable(void) {
  101664:	55                   	push   %ebp
  101665:	89 e5                	mov    %esp,%ebp
    asm volatile ("lidt (%0)" :: "r" (pd));
}

static inline void
sti(void) {
    asm volatile ("sti");
  101667:	fb                   	sti    
    sti();
}
  101668:	5d                   	pop    %ebp
  101669:	c3                   	ret    

0010166a <intr_disable>:

/* intr_disable - disable irq interrupt */
void
intr_disable(void) {
  10166a:	55                   	push   %ebp
  10166b:	89 e5                	mov    %esp,%ebp
}

static inline void
cli(void) {
    asm volatile ("cli");
  10166d:	fa                   	cli    
    cli();
}
  10166e:	5d                   	pop    %ebp
  10166f:	c3                   	ret    

00101670 <pic_setmask>:
// Initial IRQ mask has interrupt 2 enabled (for slave 8259A).
static uint16_t irq_mask = 0xFFFF & ~(1 << IRQ_SLAVE);
static bool did_init = 0;

static void
pic_setmask(uint16_t mask) {
  101670:	55                   	push   %ebp
  101671:	89 e5                	mov    %esp,%ebp
  101673:	83 ec 14             	sub    $0x14,%esp
  101676:	8b 45 08             	mov    0x8(%ebp),%eax
  101679:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
    irq_mask = mask;
  10167d:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  101681:	66 a3 50 e5 10 00    	mov    %ax,0x10e550
    if (did_init) {
  101687:	a1 8c f0 10 00       	mov    0x10f08c,%eax
  10168c:	85 c0                	test   %eax,%eax
  10168e:	74 36                	je     1016c6 <pic_setmask+0x56>
        outb(IO_PIC1 + 1, mask);
  101690:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  101694:	0f b6 c0             	movzbl %al,%eax
  101697:	66 c7 45 fe 21 00    	movw   $0x21,-0x2(%ebp)
  10169d:	88 45 fd             	mov    %al,-0x3(%ebp)
            : "memory", "cc");
}

static inline void
outb(uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1016a0:	0f b6 45 fd          	movzbl -0x3(%ebp),%eax
  1016a4:	0f b7 55 fe          	movzwl -0x2(%ebp),%edx
  1016a8:	ee                   	out    %al,(%dx)
        outb(IO_PIC2 + 1, mask >> 8);
  1016a9:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  1016ad:	66 c1 e8 08          	shr    $0x8,%ax
  1016b1:	0f b6 c0             	movzbl %al,%eax
  1016b4:	66 c7 45 fa a1 00    	movw   $0xa1,-0x6(%ebp)
  1016ba:	88 45 f9             	mov    %al,-0x7(%ebp)
  1016bd:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  1016c1:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  1016c5:	ee                   	out    %al,(%dx)
    }
}
  1016c6:	c9                   	leave  
  1016c7:	c3                   	ret    

001016c8 <pic_enable>:

void
pic_enable(unsigned int irq) {
  1016c8:	55                   	push   %ebp
  1016c9:	89 e5                	mov    %esp,%ebp
  1016cb:	83 ec 04             	sub    $0x4,%esp
    pic_setmask(irq_mask & ~(1 << irq));
  1016ce:	8b 45 08             	mov    0x8(%ebp),%eax
  1016d1:	ba 01 00 00 00       	mov    $0x1,%edx
  1016d6:	89 c1                	mov    %eax,%ecx
  1016d8:	d3 e2                	shl    %cl,%edx
  1016da:	89 d0                	mov    %edx,%eax
  1016dc:	f7 d0                	not    %eax
  1016de:	89 c2                	mov    %eax,%edx
  1016e0:	0f b7 05 50 e5 10 00 	movzwl 0x10e550,%eax
  1016e7:	21 d0                	and    %edx,%eax
  1016e9:	0f b7 c0             	movzwl %ax,%eax
  1016ec:	89 04 24             	mov    %eax,(%esp)
  1016ef:	e8 7c ff ff ff       	call   101670 <pic_setmask>
}
  1016f4:	c9                   	leave  
  1016f5:	c3                   	ret    

001016f6 <pic_init>:

/* pic_init - initialize the 8259A interrupt controllers */
void
pic_init(void) {
  1016f6:	55                   	push   %ebp
  1016f7:	89 e5                	mov    %esp,%ebp
  1016f9:	83 ec 44             	sub    $0x44,%esp
    did_init = 1;
  1016fc:	c7 05 8c f0 10 00 01 	movl   $0x1,0x10f08c
  101703:	00 00 00 
  101706:	66 c7 45 fe 21 00    	movw   $0x21,-0x2(%ebp)
  10170c:	c6 45 fd ff          	movb   $0xff,-0x3(%ebp)
  101710:	0f b6 45 fd          	movzbl -0x3(%ebp),%eax
  101714:	0f b7 55 fe          	movzwl -0x2(%ebp),%edx
  101718:	ee                   	out    %al,(%dx)
  101719:	66 c7 45 fa a1 00    	movw   $0xa1,-0x6(%ebp)
  10171f:	c6 45 f9 ff          	movb   $0xff,-0x7(%ebp)
  101723:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  101727:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  10172b:	ee                   	out    %al,(%dx)
  10172c:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%ebp)
  101732:	c6 45 f5 11          	movb   $0x11,-0xb(%ebp)
  101736:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  10173a:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  10173e:	ee                   	out    %al,(%dx)
  10173f:	66 c7 45 f2 21 00    	movw   $0x21,-0xe(%ebp)
  101745:	c6 45 f1 20          	movb   $0x20,-0xf(%ebp)
  101749:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  10174d:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  101751:	ee                   	out    %al,(%dx)
  101752:	66 c7 45 ee 21 00    	movw   $0x21,-0x12(%ebp)
  101758:	c6 45 ed 04          	movb   $0x4,-0x13(%ebp)
  10175c:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  101760:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  101764:	ee                   	out    %al,(%dx)
  101765:	66 c7 45 ea 21 00    	movw   $0x21,-0x16(%ebp)
  10176b:	c6 45 e9 03          	movb   $0x3,-0x17(%ebp)
  10176f:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  101773:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  101777:	ee                   	out    %al,(%dx)
  101778:	66 c7 45 e6 a0 00    	movw   $0xa0,-0x1a(%ebp)
  10177e:	c6 45 e5 11          	movb   $0x11,-0x1b(%ebp)
  101782:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  101786:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  10178a:	ee                   	out    %al,(%dx)
  10178b:	66 c7 45 e2 a1 00    	movw   $0xa1,-0x1e(%ebp)
  101791:	c6 45 e1 28          	movb   $0x28,-0x1f(%ebp)
  101795:	0f b6 45 e1          	movzbl -0x1f(%ebp),%eax
  101799:	0f b7 55 e2          	movzwl -0x1e(%ebp),%edx
  10179d:	ee                   	out    %al,(%dx)
  10179e:	66 c7 45 de a1 00    	movw   $0xa1,-0x22(%ebp)
  1017a4:	c6 45 dd 02          	movb   $0x2,-0x23(%ebp)
  1017a8:	0f b6 45 dd          	movzbl -0x23(%ebp),%eax
  1017ac:	0f b7 55 de          	movzwl -0x22(%ebp),%edx
  1017b0:	ee                   	out    %al,(%dx)
  1017b1:	66 c7 45 da a1 00    	movw   $0xa1,-0x26(%ebp)
  1017b7:	c6 45 d9 03          	movb   $0x3,-0x27(%ebp)
  1017bb:	0f b6 45 d9          	movzbl -0x27(%ebp),%eax
  1017bf:	0f b7 55 da          	movzwl -0x26(%ebp),%edx
  1017c3:	ee                   	out    %al,(%dx)
  1017c4:	66 c7 45 d6 20 00    	movw   $0x20,-0x2a(%ebp)
  1017ca:	c6 45 d5 68          	movb   $0x68,-0x2b(%ebp)
  1017ce:	0f b6 45 d5          	movzbl -0x2b(%ebp),%eax
  1017d2:	0f b7 55 d6          	movzwl -0x2a(%ebp),%edx
  1017d6:	ee                   	out    %al,(%dx)
  1017d7:	66 c7 45 d2 20 00    	movw   $0x20,-0x2e(%ebp)
  1017dd:	c6 45 d1 0a          	movb   $0xa,-0x2f(%ebp)
  1017e1:	0f b6 45 d1          	movzbl -0x2f(%ebp),%eax
  1017e5:	0f b7 55 d2          	movzwl -0x2e(%ebp),%edx
  1017e9:	ee                   	out    %al,(%dx)
  1017ea:	66 c7 45 ce a0 00    	movw   $0xa0,-0x32(%ebp)
  1017f0:	c6 45 cd 68          	movb   $0x68,-0x33(%ebp)
  1017f4:	0f b6 45 cd          	movzbl -0x33(%ebp),%eax
  1017f8:	0f b7 55 ce          	movzwl -0x32(%ebp),%edx
  1017fc:	ee                   	out    %al,(%dx)
  1017fd:	66 c7 45 ca a0 00    	movw   $0xa0,-0x36(%ebp)
  101803:	c6 45 c9 0a          	movb   $0xa,-0x37(%ebp)
  101807:	0f b6 45 c9          	movzbl -0x37(%ebp),%eax
  10180b:	0f b7 55 ca          	movzwl -0x36(%ebp),%edx
  10180f:	ee                   	out    %al,(%dx)
    outb(IO_PIC1, 0x0a);    // read IRR by default

    outb(IO_PIC2, 0x68);    // OCW3
    outb(IO_PIC2, 0x0a);    // OCW3

    if (irq_mask != 0xFFFF) {
  101810:	0f b7 05 50 e5 10 00 	movzwl 0x10e550,%eax
  101817:	66 83 f8 ff          	cmp    $0xffff,%ax
  10181b:	74 12                	je     10182f <pic_init+0x139>
        pic_setmask(irq_mask);
  10181d:	0f b7 05 50 e5 10 00 	movzwl 0x10e550,%eax
  101824:	0f b7 c0             	movzwl %ax,%eax
  101827:	89 04 24             	mov    %eax,(%esp)
  10182a:	e8 41 fe ff ff       	call   101670 <pic_setmask>
    }
}
  10182f:	c9                   	leave  
  101830:	c3                   	ret    

00101831 <print_ticks>:
#include <console.h>
#include <kdebug.h>

#define TICK_NUM 100

static void print_ticks() {
  101831:	55                   	push   %ebp
  101832:	89 e5                	mov    %esp,%ebp
  101834:	83 ec 18             	sub    $0x18,%esp
    cprintf("%d ticks\n",TICK_NUM);
  101837:	c7 44 24 04 64 00 00 	movl   $0x64,0x4(%esp)
  10183e:	00 
  10183f:	c7 04 24 20 39 10 00 	movl   $0x103920,(%esp)
  101846:	e8 d7 ea ff ff       	call   100322 <cprintf>
#ifdef DEBUG_GRADE
    cprintf("End of Test.\n");
  10184b:	c7 04 24 2a 39 10 00 	movl   $0x10392a,(%esp)
  101852:	e8 cb ea ff ff       	call   100322 <cprintf>
    panic("EOT: kernel seems ok.");
  101857:	c7 44 24 08 38 39 10 	movl   $0x103938,0x8(%esp)
  10185e:	00 
  10185f:	c7 44 24 04 12 00 00 	movl   $0x12,0x4(%esp)
  101866:	00 
  101867:	c7 04 24 4e 39 10 00 	movl   $0x10394e,(%esp)
  10186e:	e8 77 f4 ff ff       	call   100cea <__panic>

00101873 <idt_init>:
    sizeof(idt) - 1, (uintptr_t)idt
};

/* idt_init - initialize IDT to each of the entry points in kern/trap/vectors.S */
void
idt_init(void) {
  101873:	55                   	push   %ebp
  101874:	89 e5                	mov    %esp,%ebp
  101876:	83 ec 10             	sub    $0x10,%esp
      *     You don't know the meaning of this instruction? just google it! and check the libs/x86.h to know more.
      *     Notice: the argument of lidt is idt_pd. try to find it!
      */
	extern uintptr_t __vectors[];

	int i=0, num=sizeof(idt)/sizeof(idt[0]);
  101879:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  101880:	c7 45 f8 00 01 00 00 	movl   $0x100,-0x8(%ebp)
	for (; i<num; ++i)
  101887:	e9 c3 00 00 00       	jmp    10194f <idt_init+0xdc>
		SETGATE(idt[i], 0, GD_KTEXT, __vectors[i], DPL_KERNEL);
  10188c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10188f:	8b 04 85 e0 e5 10 00 	mov    0x10e5e0(,%eax,4),%eax
  101896:	89 c2                	mov    %eax,%edx
  101898:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10189b:	66 89 14 c5 a0 f0 10 	mov    %dx,0x10f0a0(,%eax,8)
  1018a2:	00 
  1018a3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1018a6:	66 c7 04 c5 a2 f0 10 	movw   $0x8,0x10f0a2(,%eax,8)
  1018ad:	00 08 00 
  1018b0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1018b3:	0f b6 14 c5 a4 f0 10 	movzbl 0x10f0a4(,%eax,8),%edx
  1018ba:	00 
  1018bb:	83 e2 e0             	and    $0xffffffe0,%edx
  1018be:	88 14 c5 a4 f0 10 00 	mov    %dl,0x10f0a4(,%eax,8)
  1018c5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1018c8:	0f b6 14 c5 a4 f0 10 	movzbl 0x10f0a4(,%eax,8),%edx
  1018cf:	00 
  1018d0:	83 e2 1f             	and    $0x1f,%edx
  1018d3:	88 14 c5 a4 f0 10 00 	mov    %dl,0x10f0a4(,%eax,8)
  1018da:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1018dd:	0f b6 14 c5 a5 f0 10 	movzbl 0x10f0a5(,%eax,8),%edx
  1018e4:	00 
  1018e5:	83 e2 f0             	and    $0xfffffff0,%edx
  1018e8:	83 ca 0e             	or     $0xe,%edx
  1018eb:	88 14 c5 a5 f0 10 00 	mov    %dl,0x10f0a5(,%eax,8)
  1018f2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1018f5:	0f b6 14 c5 a5 f0 10 	movzbl 0x10f0a5(,%eax,8),%edx
  1018fc:	00 
  1018fd:	83 e2 ef             	and    $0xffffffef,%edx
  101900:	88 14 c5 a5 f0 10 00 	mov    %dl,0x10f0a5(,%eax,8)
  101907:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10190a:	0f b6 14 c5 a5 f0 10 	movzbl 0x10f0a5(,%eax,8),%edx
  101911:	00 
  101912:	83 e2 9f             	and    $0xffffff9f,%edx
  101915:	88 14 c5 a5 f0 10 00 	mov    %dl,0x10f0a5(,%eax,8)
  10191c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10191f:	0f b6 14 c5 a5 f0 10 	movzbl 0x10f0a5(,%eax,8),%edx
  101926:	00 
  101927:	83 ca 80             	or     $0xffffff80,%edx
  10192a:	88 14 c5 a5 f0 10 00 	mov    %dl,0x10f0a5(,%eax,8)
  101931:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101934:	8b 04 85 e0 e5 10 00 	mov    0x10e5e0(,%eax,4),%eax
  10193b:	c1 e8 10             	shr    $0x10,%eax
  10193e:	89 c2                	mov    %eax,%edx
  101940:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101943:	66 89 14 c5 a6 f0 10 	mov    %dx,0x10f0a6(,%eax,8)
  10194a:	00 
      *     Notice: the argument of lidt is idt_pd. try to find it!
      */
	extern uintptr_t __vectors[];

	int i=0, num=sizeof(idt)/sizeof(idt[0]);
	for (; i<num; ++i)
  10194b:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  10194f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101952:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  101955:	0f 8c 31 ff ff ff    	jl     10188c <idt_init+0x19>
		SETGATE(idt[i], 0, GD_KTEXT, __vectors[i], DPL_KERNEL);

	SETGATE(idt[T_SWITCH_TOK], 1, GD_KTEXT, __vectors[T_SWITCH_TOK], DPL_USER);
  10195b:	a1 c4 e7 10 00       	mov    0x10e7c4,%eax
  101960:	66 a3 68 f4 10 00    	mov    %ax,0x10f468
  101966:	66 c7 05 6a f4 10 00 	movw   $0x8,0x10f46a
  10196d:	08 00 
  10196f:	0f b6 05 6c f4 10 00 	movzbl 0x10f46c,%eax
  101976:	83 e0 e0             	and    $0xffffffe0,%eax
  101979:	a2 6c f4 10 00       	mov    %al,0x10f46c
  10197e:	0f b6 05 6c f4 10 00 	movzbl 0x10f46c,%eax
  101985:	83 e0 1f             	and    $0x1f,%eax
  101988:	a2 6c f4 10 00       	mov    %al,0x10f46c
  10198d:	0f b6 05 6d f4 10 00 	movzbl 0x10f46d,%eax
  101994:	83 c8 0f             	or     $0xf,%eax
  101997:	a2 6d f4 10 00       	mov    %al,0x10f46d
  10199c:	0f b6 05 6d f4 10 00 	movzbl 0x10f46d,%eax
  1019a3:	83 e0 ef             	and    $0xffffffef,%eax
  1019a6:	a2 6d f4 10 00       	mov    %al,0x10f46d
  1019ab:	0f b6 05 6d f4 10 00 	movzbl 0x10f46d,%eax
  1019b2:	83 c8 60             	or     $0x60,%eax
  1019b5:	a2 6d f4 10 00       	mov    %al,0x10f46d
  1019ba:	0f b6 05 6d f4 10 00 	movzbl 0x10f46d,%eax
  1019c1:	83 c8 80             	or     $0xffffff80,%eax
  1019c4:	a2 6d f4 10 00       	mov    %al,0x10f46d
  1019c9:	a1 c4 e7 10 00       	mov    0x10e7c4,%eax
  1019ce:	c1 e8 10             	shr    $0x10,%eax
  1019d1:	66 a3 6e f4 10 00    	mov    %ax,0x10f46e
  1019d7:	c7 45 f4 60 e5 10 00 	movl   $0x10e560,-0xc(%ebp)
    return ebp;
}

static inline void
lidt(struct pseudodesc *pd) {
    asm volatile ("lidt (%0)" :: "r" (pd));
  1019de:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1019e1:	0f 01 18             	lidtl  (%eax)

	lidt(&idt_pd);
}
  1019e4:	c9                   	leave  
  1019e5:	c3                   	ret    

001019e6 <trapname>:

static const char *
trapname(int trapno) {
  1019e6:	55                   	push   %ebp
  1019e7:	89 e5                	mov    %esp,%ebp
        "Alignment Check",
        "Machine-Check",
        "SIMD Floating-Point Exception"
    };

    if (trapno < sizeof(excnames)/sizeof(const char * const)) {
  1019e9:	8b 45 08             	mov    0x8(%ebp),%eax
  1019ec:	83 f8 13             	cmp    $0x13,%eax
  1019ef:	77 0c                	ja     1019fd <trapname+0x17>
        return excnames[trapno];
  1019f1:	8b 45 08             	mov    0x8(%ebp),%eax
  1019f4:	8b 04 85 a0 3c 10 00 	mov    0x103ca0(,%eax,4),%eax
  1019fb:	eb 18                	jmp    101a15 <trapname+0x2f>
    }
    if (trapno >= IRQ_OFFSET && trapno < IRQ_OFFSET + 16) {
  1019fd:	83 7d 08 1f          	cmpl   $0x1f,0x8(%ebp)
  101a01:	7e 0d                	jle    101a10 <trapname+0x2a>
  101a03:	83 7d 08 2f          	cmpl   $0x2f,0x8(%ebp)
  101a07:	7f 07                	jg     101a10 <trapname+0x2a>
        return "Hardware Interrupt";
  101a09:	b8 5f 39 10 00       	mov    $0x10395f,%eax
  101a0e:	eb 05                	jmp    101a15 <trapname+0x2f>
    }
    return "(unknown trap)";
  101a10:	b8 72 39 10 00       	mov    $0x103972,%eax
}
  101a15:	5d                   	pop    %ebp
  101a16:	c3                   	ret    

00101a17 <trap_in_kernel>:

/* trap_in_kernel - test if trap happened in kernel */
bool
trap_in_kernel(struct trapframe *tf) {
  101a17:	55                   	push   %ebp
  101a18:	89 e5                	mov    %esp,%ebp
    return (tf->tf_cs == (uint16_t)KERNEL_CS);
  101a1a:	8b 45 08             	mov    0x8(%ebp),%eax
  101a1d:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101a21:	66 83 f8 08          	cmp    $0x8,%ax
  101a25:	0f 94 c0             	sete   %al
  101a28:	0f b6 c0             	movzbl %al,%eax
}
  101a2b:	5d                   	pop    %ebp
  101a2c:	c3                   	ret    

00101a2d <print_trapframe>:
    "TF", "IF", "DF", "OF", NULL, NULL, "NT", NULL,
    "RF", "VM", "AC", "VIF", "VIP", "ID", NULL, NULL,
};

void
print_trapframe(struct trapframe *tf) {
  101a2d:	55                   	push   %ebp
  101a2e:	89 e5                	mov    %esp,%ebp
  101a30:	83 ec 28             	sub    $0x28,%esp
    cprintf("trapframe at %p\n", tf);
  101a33:	8b 45 08             	mov    0x8(%ebp),%eax
  101a36:	89 44 24 04          	mov    %eax,0x4(%esp)
  101a3a:	c7 04 24 b3 39 10 00 	movl   $0x1039b3,(%esp)
  101a41:	e8 dc e8 ff ff       	call   100322 <cprintf>
    print_regs(&tf->tf_regs);
  101a46:	8b 45 08             	mov    0x8(%ebp),%eax
  101a49:	89 04 24             	mov    %eax,(%esp)
  101a4c:	e8 a1 01 00 00       	call   101bf2 <print_regs>
    cprintf("  ds   0x----%04x\n", tf->tf_ds);
  101a51:	8b 45 08             	mov    0x8(%ebp),%eax
  101a54:	0f b7 40 2c          	movzwl 0x2c(%eax),%eax
  101a58:	0f b7 c0             	movzwl %ax,%eax
  101a5b:	89 44 24 04          	mov    %eax,0x4(%esp)
  101a5f:	c7 04 24 c4 39 10 00 	movl   $0x1039c4,(%esp)
  101a66:	e8 b7 e8 ff ff       	call   100322 <cprintf>
    cprintf("  es   0x----%04x\n", tf->tf_es);
  101a6b:	8b 45 08             	mov    0x8(%ebp),%eax
  101a6e:	0f b7 40 28          	movzwl 0x28(%eax),%eax
  101a72:	0f b7 c0             	movzwl %ax,%eax
  101a75:	89 44 24 04          	mov    %eax,0x4(%esp)
  101a79:	c7 04 24 d7 39 10 00 	movl   $0x1039d7,(%esp)
  101a80:	e8 9d e8 ff ff       	call   100322 <cprintf>
    cprintf("  fs   0x----%04x\n", tf->tf_fs);
  101a85:	8b 45 08             	mov    0x8(%ebp),%eax
  101a88:	0f b7 40 24          	movzwl 0x24(%eax),%eax
  101a8c:	0f b7 c0             	movzwl %ax,%eax
  101a8f:	89 44 24 04          	mov    %eax,0x4(%esp)
  101a93:	c7 04 24 ea 39 10 00 	movl   $0x1039ea,(%esp)
  101a9a:	e8 83 e8 ff ff       	call   100322 <cprintf>
    cprintf("  gs   0x----%04x\n", tf->tf_gs);
  101a9f:	8b 45 08             	mov    0x8(%ebp),%eax
  101aa2:	0f b7 40 20          	movzwl 0x20(%eax),%eax
  101aa6:	0f b7 c0             	movzwl %ax,%eax
  101aa9:	89 44 24 04          	mov    %eax,0x4(%esp)
  101aad:	c7 04 24 fd 39 10 00 	movl   $0x1039fd,(%esp)
  101ab4:	e8 69 e8 ff ff       	call   100322 <cprintf>
    cprintf("  trap 0x%08x %s\n", tf->tf_trapno, trapname(tf->tf_trapno));
  101ab9:	8b 45 08             	mov    0x8(%ebp),%eax
  101abc:	8b 40 30             	mov    0x30(%eax),%eax
  101abf:	89 04 24             	mov    %eax,(%esp)
  101ac2:	e8 1f ff ff ff       	call   1019e6 <trapname>
  101ac7:	8b 55 08             	mov    0x8(%ebp),%edx
  101aca:	8b 52 30             	mov    0x30(%edx),%edx
  101acd:	89 44 24 08          	mov    %eax,0x8(%esp)
  101ad1:	89 54 24 04          	mov    %edx,0x4(%esp)
  101ad5:	c7 04 24 10 3a 10 00 	movl   $0x103a10,(%esp)
  101adc:	e8 41 e8 ff ff       	call   100322 <cprintf>
    cprintf("  err  0x%08x\n", tf->tf_err);
  101ae1:	8b 45 08             	mov    0x8(%ebp),%eax
  101ae4:	8b 40 34             	mov    0x34(%eax),%eax
  101ae7:	89 44 24 04          	mov    %eax,0x4(%esp)
  101aeb:	c7 04 24 22 3a 10 00 	movl   $0x103a22,(%esp)
  101af2:	e8 2b e8 ff ff       	call   100322 <cprintf>
    cprintf("  eip  0x%08x\n", tf->tf_eip);
  101af7:	8b 45 08             	mov    0x8(%ebp),%eax
  101afa:	8b 40 38             	mov    0x38(%eax),%eax
  101afd:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b01:	c7 04 24 31 3a 10 00 	movl   $0x103a31,(%esp)
  101b08:	e8 15 e8 ff ff       	call   100322 <cprintf>
    cprintf("  cs   0x----%04x\n", tf->tf_cs);
  101b0d:	8b 45 08             	mov    0x8(%ebp),%eax
  101b10:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101b14:	0f b7 c0             	movzwl %ax,%eax
  101b17:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b1b:	c7 04 24 40 3a 10 00 	movl   $0x103a40,(%esp)
  101b22:	e8 fb e7 ff ff       	call   100322 <cprintf>
    cprintf("  flag 0x%08x ", tf->tf_eflags);
  101b27:	8b 45 08             	mov    0x8(%ebp),%eax
  101b2a:	8b 40 40             	mov    0x40(%eax),%eax
  101b2d:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b31:	c7 04 24 53 3a 10 00 	movl   $0x103a53,(%esp)
  101b38:	e8 e5 e7 ff ff       	call   100322 <cprintf>

    int i, j;
    for (i = 0, j = 1; i < sizeof(IA32flags) / sizeof(IA32flags[0]); i ++, j <<= 1) {
  101b3d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  101b44:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
  101b4b:	eb 3e                	jmp    101b8b <print_trapframe+0x15e>
        if ((tf->tf_eflags & j) && IA32flags[i] != NULL) {
  101b4d:	8b 45 08             	mov    0x8(%ebp),%eax
  101b50:	8b 50 40             	mov    0x40(%eax),%edx
  101b53:	8b 45 f0             	mov    -0x10(%ebp),%eax
  101b56:	21 d0                	and    %edx,%eax
  101b58:	85 c0                	test   %eax,%eax
  101b5a:	74 28                	je     101b84 <print_trapframe+0x157>
  101b5c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101b5f:	8b 04 85 80 e5 10 00 	mov    0x10e580(,%eax,4),%eax
  101b66:	85 c0                	test   %eax,%eax
  101b68:	74 1a                	je     101b84 <print_trapframe+0x157>
            cprintf("%s,", IA32flags[i]);
  101b6a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101b6d:	8b 04 85 80 e5 10 00 	mov    0x10e580(,%eax,4),%eax
  101b74:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b78:	c7 04 24 62 3a 10 00 	movl   $0x103a62,(%esp)
  101b7f:	e8 9e e7 ff ff       	call   100322 <cprintf>
    cprintf("  eip  0x%08x\n", tf->tf_eip);
    cprintf("  cs   0x----%04x\n", tf->tf_cs);
    cprintf("  flag 0x%08x ", tf->tf_eflags);

    int i, j;
    for (i = 0, j = 1; i < sizeof(IA32flags) / sizeof(IA32flags[0]); i ++, j <<= 1) {
  101b84:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  101b88:	d1 65 f0             	shll   -0x10(%ebp)
  101b8b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101b8e:	83 f8 17             	cmp    $0x17,%eax
  101b91:	76 ba                	jbe    101b4d <print_trapframe+0x120>
        if ((tf->tf_eflags & j) && IA32flags[i] != NULL) {
            cprintf("%s,", IA32flags[i]);
        }
    }
    cprintf("IOPL=%d\n", (tf->tf_eflags & FL_IOPL_MASK) >> 12);
  101b93:	8b 45 08             	mov    0x8(%ebp),%eax
  101b96:	8b 40 40             	mov    0x40(%eax),%eax
  101b99:	25 00 30 00 00       	and    $0x3000,%eax
  101b9e:	c1 e8 0c             	shr    $0xc,%eax
  101ba1:	89 44 24 04          	mov    %eax,0x4(%esp)
  101ba5:	c7 04 24 66 3a 10 00 	movl   $0x103a66,(%esp)
  101bac:	e8 71 e7 ff ff       	call   100322 <cprintf>

    if (!trap_in_kernel(tf)) {
  101bb1:	8b 45 08             	mov    0x8(%ebp),%eax
  101bb4:	89 04 24             	mov    %eax,(%esp)
  101bb7:	e8 5b fe ff ff       	call   101a17 <trap_in_kernel>
  101bbc:	85 c0                	test   %eax,%eax
  101bbe:	75 30                	jne    101bf0 <print_trapframe+0x1c3>
        cprintf("  esp  0x%08x\n", tf->tf_esp);
  101bc0:	8b 45 08             	mov    0x8(%ebp),%eax
  101bc3:	8b 40 44             	mov    0x44(%eax),%eax
  101bc6:	89 44 24 04          	mov    %eax,0x4(%esp)
  101bca:	c7 04 24 6f 3a 10 00 	movl   $0x103a6f,(%esp)
  101bd1:	e8 4c e7 ff ff       	call   100322 <cprintf>
        cprintf("  ss   0x----%04x\n", tf->tf_ss);
  101bd6:	8b 45 08             	mov    0x8(%ebp),%eax
  101bd9:	0f b7 40 48          	movzwl 0x48(%eax),%eax
  101bdd:	0f b7 c0             	movzwl %ax,%eax
  101be0:	89 44 24 04          	mov    %eax,0x4(%esp)
  101be4:	c7 04 24 7e 3a 10 00 	movl   $0x103a7e,(%esp)
  101beb:	e8 32 e7 ff ff       	call   100322 <cprintf>
    }
}
  101bf0:	c9                   	leave  
  101bf1:	c3                   	ret    

00101bf2 <print_regs>:

void
print_regs(struct pushregs *regs) {
  101bf2:	55                   	push   %ebp
  101bf3:	89 e5                	mov    %esp,%ebp
  101bf5:	83 ec 18             	sub    $0x18,%esp
    cprintf("  edi  0x%08x\n", regs->reg_edi);
  101bf8:	8b 45 08             	mov    0x8(%ebp),%eax
  101bfb:	8b 00                	mov    (%eax),%eax
  101bfd:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c01:	c7 04 24 91 3a 10 00 	movl   $0x103a91,(%esp)
  101c08:	e8 15 e7 ff ff       	call   100322 <cprintf>
    cprintf("  esi  0x%08x\n", regs->reg_esi);
  101c0d:	8b 45 08             	mov    0x8(%ebp),%eax
  101c10:	8b 40 04             	mov    0x4(%eax),%eax
  101c13:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c17:	c7 04 24 a0 3a 10 00 	movl   $0x103aa0,(%esp)
  101c1e:	e8 ff e6 ff ff       	call   100322 <cprintf>
    cprintf("  ebp  0x%08x\n", regs->reg_ebp);
  101c23:	8b 45 08             	mov    0x8(%ebp),%eax
  101c26:	8b 40 08             	mov    0x8(%eax),%eax
  101c29:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c2d:	c7 04 24 af 3a 10 00 	movl   $0x103aaf,(%esp)
  101c34:	e8 e9 e6 ff ff       	call   100322 <cprintf>
    cprintf("  oesp 0x%08x\n", regs->reg_oesp);
  101c39:	8b 45 08             	mov    0x8(%ebp),%eax
  101c3c:	8b 40 0c             	mov    0xc(%eax),%eax
  101c3f:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c43:	c7 04 24 be 3a 10 00 	movl   $0x103abe,(%esp)
  101c4a:	e8 d3 e6 ff ff       	call   100322 <cprintf>
    cprintf("  ebx  0x%08x\n", regs->reg_ebx);
  101c4f:	8b 45 08             	mov    0x8(%ebp),%eax
  101c52:	8b 40 10             	mov    0x10(%eax),%eax
  101c55:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c59:	c7 04 24 cd 3a 10 00 	movl   $0x103acd,(%esp)
  101c60:	e8 bd e6 ff ff       	call   100322 <cprintf>
    cprintf("  edx  0x%08x\n", regs->reg_edx);
  101c65:	8b 45 08             	mov    0x8(%ebp),%eax
  101c68:	8b 40 14             	mov    0x14(%eax),%eax
  101c6b:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c6f:	c7 04 24 dc 3a 10 00 	movl   $0x103adc,(%esp)
  101c76:	e8 a7 e6 ff ff       	call   100322 <cprintf>
    cprintf("  ecx  0x%08x\n", regs->reg_ecx);
  101c7b:	8b 45 08             	mov    0x8(%ebp),%eax
  101c7e:	8b 40 18             	mov    0x18(%eax),%eax
  101c81:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c85:	c7 04 24 eb 3a 10 00 	movl   $0x103aeb,(%esp)
  101c8c:	e8 91 e6 ff ff       	call   100322 <cprintf>
    cprintf("  eax  0x%08x\n", regs->reg_eax);
  101c91:	8b 45 08             	mov    0x8(%ebp),%eax
  101c94:	8b 40 1c             	mov    0x1c(%eax),%eax
  101c97:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c9b:	c7 04 24 fa 3a 10 00 	movl   $0x103afa,(%esp)
  101ca2:	e8 7b e6 ff ff       	call   100322 <cprintf>
}
  101ca7:	c9                   	leave  
  101ca8:	c3                   	ret    

00101ca9 <trap_dispatch>:

struct trapframe switchk2u, *switchu2k;

/* trap_dispatch - dispatch based on what type of trap occurred */
static void
trap_dispatch(struct trapframe *tf) {
  101ca9:	55                   	push   %ebp
  101caa:	89 e5                	mov    %esp,%ebp
  101cac:	57                   	push   %edi
  101cad:	56                   	push   %esi
  101cae:	53                   	push   %ebx
  101caf:	83 ec 2c             	sub    $0x2c,%esp
    char c;

    switch (tf->tf_trapno) {
  101cb2:	8b 45 08             	mov    0x8(%ebp),%eax
  101cb5:	8b 40 30             	mov    0x30(%eax),%eax
  101cb8:	83 f8 2f             	cmp    $0x2f,%eax
  101cbb:	77 1d                	ja     101cda <trap_dispatch+0x31>
  101cbd:	83 f8 2e             	cmp    $0x2e,%eax
  101cc0:	0f 83 d0 01 00 00    	jae    101e96 <trap_dispatch+0x1ed>
  101cc6:	83 f8 21             	cmp    $0x21,%eax
  101cc9:	74 7f                	je     101d4a <trap_dispatch+0xa1>
  101ccb:	83 f8 24             	cmp    $0x24,%eax
  101cce:	74 51                	je     101d21 <trap_dispatch+0x78>
  101cd0:	83 f8 20             	cmp    $0x20,%eax
  101cd3:	74 1c                	je     101cf1 <trap_dispatch+0x48>
  101cd5:	e9 84 01 00 00       	jmp    101e5e <trap_dispatch+0x1b5>
  101cda:	83 f8 78             	cmp    $0x78,%eax
  101cdd:	0f 84 90 00 00 00    	je     101d73 <trap_dispatch+0xca>
  101ce3:	83 f8 79             	cmp    $0x79,%eax
  101ce6:	0f 84 fe 00 00 00    	je     101dea <trap_dispatch+0x141>
  101cec:	e9 6d 01 00 00       	jmp    101e5e <trap_dispatch+0x1b5>
        /* handle the timer interrupt */
        /* (1) After a timer interrupt, you should record this event using a global variable (increase it), such as ticks in kern/driver/clock.c
         * (2) Every TICK_NUM cycle, you can print some info using a funciton, such as print_ticks().
         * (3) Too Simple? Yes, I think so!
         */
    	ticks++;
  101cf1:	a1 08 f9 10 00       	mov    0x10f908,%eax
  101cf6:	83 c0 01             	add    $0x1,%eax
  101cf9:	a3 08 f9 10 00       	mov    %eax,0x10f908
    	if (ticks == TICK_NUM)
  101cfe:	a1 08 f9 10 00       	mov    0x10f908,%eax
  101d03:	83 f8 64             	cmp    $0x64,%eax
  101d06:	75 14                	jne    101d1c <trap_dispatch+0x73>
    	{
    		print_ticks();
  101d08:	e8 24 fb ff ff       	call   101831 <print_ticks>
    		ticks= 0;
  101d0d:	c7 05 08 f9 10 00 00 	movl   $0x0,0x10f908
  101d14:	00 00 00 
    	}
        break;
  101d17:	e9 7b 01 00 00       	jmp    101e97 <trap_dispatch+0x1ee>
  101d1c:	e9 76 01 00 00       	jmp    101e97 <trap_dispatch+0x1ee>
    case IRQ_OFFSET + IRQ_COM1:
        c = cons_getc();
  101d21:	e8 e2 f8 ff ff       	call   101608 <cons_getc>
  101d26:	88 45 e7             	mov    %al,-0x19(%ebp)
        cprintf("serial [%03d] %c\n", c, c);
  101d29:	0f be 55 e7          	movsbl -0x19(%ebp),%edx
  101d2d:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
  101d31:	89 54 24 08          	mov    %edx,0x8(%esp)
  101d35:	89 44 24 04          	mov    %eax,0x4(%esp)
  101d39:	c7 04 24 09 3b 10 00 	movl   $0x103b09,(%esp)
  101d40:	e8 dd e5 ff ff       	call   100322 <cprintf>
        break;
  101d45:	e9 4d 01 00 00       	jmp    101e97 <trap_dispatch+0x1ee>
    case IRQ_OFFSET + IRQ_KBD:
        c = cons_getc();
  101d4a:	e8 b9 f8 ff ff       	call   101608 <cons_getc>
  101d4f:	88 45 e7             	mov    %al,-0x19(%ebp)
        cprintf("kbd [%03d] %c\n", c, c);
  101d52:	0f be 55 e7          	movsbl -0x19(%ebp),%edx
  101d56:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
  101d5a:	89 54 24 08          	mov    %edx,0x8(%esp)
  101d5e:	89 44 24 04          	mov    %eax,0x4(%esp)
  101d62:	c7 04 24 1b 3b 10 00 	movl   $0x103b1b,(%esp)
  101d69:	e8 b4 e5 ff ff       	call   100322 <cprintf>
        break;
  101d6e:	e9 24 01 00 00       	jmp    101e97 <trap_dispatch+0x1ee>
    //LAB1 CHALLENGE 1 : 2012011274 you should modify below codes.
    case T_SWITCH_TOU:
    	if (tf->tf_cs != USER_CS)
  101d73:	8b 45 08             	mov    0x8(%ebp),%eax
  101d76:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101d7a:	66 83 f8 1b          	cmp    $0x1b,%ax
  101d7e:	74 65                	je     101de5 <trap_dispatch+0x13c>
    	{
    		switchk2u = *tf;
  101d80:	8b 45 08             	mov    0x8(%ebp),%eax
  101d83:	ba 20 f9 10 00       	mov    $0x10f920,%edx
  101d88:	89 c3                	mov    %eax,%ebx
  101d8a:	b8 13 00 00 00       	mov    $0x13,%eax
  101d8f:	89 d7                	mov    %edx,%edi
  101d91:	89 de                	mov    %ebx,%esi
  101d93:	89 c1                	mov    %eax,%ecx
  101d95:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    		switchk2u.tf_cs = USER_CS;
  101d97:	66 c7 05 5c f9 10 00 	movw   $0x1b,0x10f95c
  101d9e:	1b 00 
    	    switchk2u.tf_ds = USER_DS;
  101da0:	66 c7 05 4c f9 10 00 	movw   $0x23,0x10f94c
  101da7:	23 00 
    	    switchk2u.tf_es = USER_DS;
  101da9:	66 c7 05 48 f9 10 00 	movw   $0x23,0x10f948
  101db0:	23 00 
    	    switchk2u.tf_ss = USER_DS;
  101db2:	66 c7 05 68 f9 10 00 	movw   $0x23,0x10f968
  101db9:	23 00 
    	    switchk2u.tf_esp = (uint32_t)tf + sizeof(struct trapframe) - 8;
  101dbb:	8b 45 08             	mov    0x8(%ebp),%eax
  101dbe:	83 c0 44             	add    $0x44,%eax
  101dc1:	a3 64 f9 10 00       	mov    %eax,0x10f964

    	    switchk2u.tf_eflags |= FL_IOPL_MASK;
  101dc6:	a1 60 f9 10 00       	mov    0x10f960,%eax
  101dcb:	80 cc 30             	or     $0x30,%ah
  101dce:	a3 60 f9 10 00       	mov    %eax,0x10f960

			*((uint32_t *)tf - 1) = (uint32_t)&switchk2u;
  101dd3:	8b 45 08             	mov    0x8(%ebp),%eax
  101dd6:	8d 50 fc             	lea    -0x4(%eax),%edx
  101dd9:	b8 20 f9 10 00       	mov    $0x10f920,%eax
  101dde:	89 02                	mov    %eax,(%edx)
		}
		break;
  101de0:	e9 b2 00 00 00       	jmp    101e97 <trap_dispatch+0x1ee>
  101de5:	e9 ad 00 00 00       	jmp    101e97 <trap_dispatch+0x1ee>
    case T_SWITCH_TOK:
    	if (tf->tf_cs != KERNEL_CS)
  101dea:	8b 45 08             	mov    0x8(%ebp),%eax
  101ded:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101df1:	66 83 f8 08          	cmp    $0x8,%ax
  101df5:	74 65                	je     101e5c <trap_dispatch+0x1b3>
    	{
			tf->tf_cs = KERNEL_CS;
  101df7:	8b 45 08             	mov    0x8(%ebp),%eax
  101dfa:	66 c7 40 3c 08 00    	movw   $0x8,0x3c(%eax)
			tf->tf_ds = KERNEL_DS;
  101e00:	8b 45 08             	mov    0x8(%ebp),%eax
  101e03:	66 c7 40 2c 10 00    	movw   $0x10,0x2c(%eax)
			tf->tf_es = KERNEL_DS;
  101e09:	8b 45 08             	mov    0x8(%ebp),%eax
  101e0c:	66 c7 40 28 10 00    	movw   $0x10,0x28(%eax)
			tf->tf_eflags &= ~FL_IOPL_MASK;
  101e12:	8b 45 08             	mov    0x8(%ebp),%eax
  101e15:	8b 40 40             	mov    0x40(%eax),%eax
  101e18:	80 e4 cf             	and    $0xcf,%ah
  101e1b:	89 c2                	mov    %eax,%edx
  101e1d:	8b 45 08             	mov    0x8(%ebp),%eax
  101e20:	89 50 40             	mov    %edx,0x40(%eax)
			switchu2k = (struct trapframe *)(tf->tf_esp - (sizeof(struct trapframe) - 8));
  101e23:	8b 45 08             	mov    0x8(%ebp),%eax
  101e26:	8b 40 44             	mov    0x44(%eax),%eax
  101e29:	83 e8 44             	sub    $0x44,%eax
  101e2c:	a3 6c f9 10 00       	mov    %eax,0x10f96c
			memmove(switchu2k, tf, sizeof(struct trapframe) - 8);
  101e31:	a1 6c f9 10 00       	mov    0x10f96c,%eax
  101e36:	c7 44 24 08 44 00 00 	movl   $0x44,0x8(%esp)
  101e3d:	00 
  101e3e:	8b 55 08             	mov    0x8(%ebp),%edx
  101e41:	89 54 24 04          	mov    %edx,0x4(%esp)
  101e45:	89 04 24             	mov    %eax,(%esp)
  101e48:	e8 25 16 00 00       	call   103472 <memmove>
			*((uint32_t *)tf - 1) = (uint32_t)switchu2k;
  101e4d:	8b 45 08             	mov    0x8(%ebp),%eax
  101e50:	8d 50 fc             	lea    -0x4(%eax),%edx
  101e53:	a1 6c f9 10 00       	mov    0x10f96c,%eax
  101e58:	89 02                	mov    %eax,(%edx)
		}
        break;
  101e5a:	eb 3b                	jmp    101e97 <trap_dispatch+0x1ee>
  101e5c:	eb 39                	jmp    101e97 <trap_dispatch+0x1ee>
    case IRQ_OFFSET + IRQ_IDE2:
        /* do nothing */
        break;
    default:
        // in kernel, it must be a mistake
        if ((tf->tf_cs & 3) == 0) {
  101e5e:	8b 45 08             	mov    0x8(%ebp),%eax
  101e61:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101e65:	0f b7 c0             	movzwl %ax,%eax
  101e68:	83 e0 03             	and    $0x3,%eax
  101e6b:	85 c0                	test   %eax,%eax
  101e6d:	75 28                	jne    101e97 <trap_dispatch+0x1ee>
            print_trapframe(tf);
  101e6f:	8b 45 08             	mov    0x8(%ebp),%eax
  101e72:	89 04 24             	mov    %eax,(%esp)
  101e75:	e8 b3 fb ff ff       	call   101a2d <print_trapframe>
            panic("unexpected trap in kernel.\n");
  101e7a:	c7 44 24 08 2a 3b 10 	movl   $0x103b2a,0x8(%esp)
  101e81:	00 
  101e82:	c7 44 24 04 d4 00 00 	movl   $0xd4,0x4(%esp)
  101e89:	00 
  101e8a:	c7 04 24 4e 39 10 00 	movl   $0x10394e,(%esp)
  101e91:	e8 54 ee ff ff       	call   100cea <__panic>
		}
        break;
    case IRQ_OFFSET + IRQ_IDE1:
    case IRQ_OFFSET + IRQ_IDE2:
        /* do nothing */
        break;
  101e96:	90                   	nop
        if ((tf->tf_cs & 3) == 0) {
            print_trapframe(tf);
            panic("unexpected trap in kernel.\n");
        }
    }
}
  101e97:	83 c4 2c             	add    $0x2c,%esp
  101e9a:	5b                   	pop    %ebx
  101e9b:	5e                   	pop    %esi
  101e9c:	5f                   	pop    %edi
  101e9d:	5d                   	pop    %ebp
  101e9e:	c3                   	ret    

00101e9f <trap>:
 * trap - handles or dispatches an exception/interrupt. if and when trap() returns,
 * the code in kern/trap/trapentry.S restores the old CPU state saved in the
 * trapframe and then uses the iret instruction to return from the exception.
 * */
void
trap(struct trapframe *tf) {
  101e9f:	55                   	push   %ebp
  101ea0:	89 e5                	mov    %esp,%ebp
  101ea2:	83 ec 18             	sub    $0x18,%esp
    // dispatch based on what type of trap occurred
    trap_dispatch(tf);
  101ea5:	8b 45 08             	mov    0x8(%ebp),%eax
  101ea8:	89 04 24             	mov    %eax,(%esp)
  101eab:	e8 f9 fd ff ff       	call   101ca9 <trap_dispatch>
}
  101eb0:	c9                   	leave  
  101eb1:	c3                   	ret    

00101eb2 <__alltraps>:
.text
.globl __alltraps
__alltraps:
    # push registers to build a trap frame
    # therefore make the stack look like a struct trapframe
    pushl %ds
  101eb2:	1e                   	push   %ds
    pushl %es
  101eb3:	06                   	push   %es
    pushl %fs
  101eb4:	0f a0                	push   %fs
    pushl %gs
  101eb6:	0f a8                	push   %gs
    pushal
  101eb8:	60                   	pusha  

    # load GD_KDATA into %ds and %es to set up data segments for kernel
    movl $GD_KDATA, %eax
  101eb9:	b8 10 00 00 00       	mov    $0x10,%eax
    movw %ax, %ds
  101ebe:	8e d8                	mov    %eax,%ds
    movw %ax, %es
  101ec0:	8e c0                	mov    %eax,%es

    # push %esp to pass a pointer to the trapframe as an argument to trap()
    pushl %esp
  101ec2:	54                   	push   %esp

    # call trap(tf), where tf=%esp
    call trap
  101ec3:	e8 d7 ff ff ff       	call   101e9f <trap>

    # pop the pushed stack pointer
    popl %esp
  101ec8:	5c                   	pop    %esp

00101ec9 <__trapret>:

    # return falls through to trapret...
.globl __trapret
__trapret:
    # restore registers from stack
    popal
  101ec9:	61                   	popa   

    # restore %ds, %es, %fs and %gs
    popl %gs
  101eca:	0f a9                	pop    %gs
    popl %fs
  101ecc:	0f a1                	pop    %fs
    popl %es
  101ece:	07                   	pop    %es
    popl %ds
  101ecf:	1f                   	pop    %ds

    # get rid of the trap number and error code
    addl $0x8, %esp
  101ed0:	83 c4 08             	add    $0x8,%esp
    iret
  101ed3:	cf                   	iret   

00101ed4 <vector0>:
# handler
.text
.globl __alltraps
.globl vector0
vector0:
  pushl $0
  101ed4:	6a 00                	push   $0x0
  pushl $0
  101ed6:	6a 00                	push   $0x0
  jmp __alltraps
  101ed8:	e9 d5 ff ff ff       	jmp    101eb2 <__alltraps>

00101edd <vector1>:
.globl vector1
vector1:
  pushl $0
  101edd:	6a 00                	push   $0x0
  pushl $1
  101edf:	6a 01                	push   $0x1
  jmp __alltraps
  101ee1:	e9 cc ff ff ff       	jmp    101eb2 <__alltraps>

00101ee6 <vector2>:
.globl vector2
vector2:
  pushl $0
  101ee6:	6a 00                	push   $0x0
  pushl $2
  101ee8:	6a 02                	push   $0x2
  jmp __alltraps
  101eea:	e9 c3 ff ff ff       	jmp    101eb2 <__alltraps>

00101eef <vector3>:
.globl vector3
vector3:
  pushl $0
  101eef:	6a 00                	push   $0x0
  pushl $3
  101ef1:	6a 03                	push   $0x3
  jmp __alltraps
  101ef3:	e9 ba ff ff ff       	jmp    101eb2 <__alltraps>

00101ef8 <vector4>:
.globl vector4
vector4:
  pushl $0
  101ef8:	6a 00                	push   $0x0
  pushl $4
  101efa:	6a 04                	push   $0x4
  jmp __alltraps
  101efc:	e9 b1 ff ff ff       	jmp    101eb2 <__alltraps>

00101f01 <vector5>:
.globl vector5
vector5:
  pushl $0
  101f01:	6a 00                	push   $0x0
  pushl $5
  101f03:	6a 05                	push   $0x5
  jmp __alltraps
  101f05:	e9 a8 ff ff ff       	jmp    101eb2 <__alltraps>

00101f0a <vector6>:
.globl vector6
vector6:
  pushl $0
  101f0a:	6a 00                	push   $0x0
  pushl $6
  101f0c:	6a 06                	push   $0x6
  jmp __alltraps
  101f0e:	e9 9f ff ff ff       	jmp    101eb2 <__alltraps>

00101f13 <vector7>:
.globl vector7
vector7:
  pushl $0
  101f13:	6a 00                	push   $0x0
  pushl $7
  101f15:	6a 07                	push   $0x7
  jmp __alltraps
  101f17:	e9 96 ff ff ff       	jmp    101eb2 <__alltraps>

00101f1c <vector8>:
.globl vector8
vector8:
  pushl $8
  101f1c:	6a 08                	push   $0x8
  jmp __alltraps
  101f1e:	e9 8f ff ff ff       	jmp    101eb2 <__alltraps>

00101f23 <vector9>:
.globl vector9
vector9:
  pushl $9
  101f23:	6a 09                	push   $0x9
  jmp __alltraps
  101f25:	e9 88 ff ff ff       	jmp    101eb2 <__alltraps>

00101f2a <vector10>:
.globl vector10
vector10:
  pushl $10
  101f2a:	6a 0a                	push   $0xa
  jmp __alltraps
  101f2c:	e9 81 ff ff ff       	jmp    101eb2 <__alltraps>

00101f31 <vector11>:
.globl vector11
vector11:
  pushl $11
  101f31:	6a 0b                	push   $0xb
  jmp __alltraps
  101f33:	e9 7a ff ff ff       	jmp    101eb2 <__alltraps>

00101f38 <vector12>:
.globl vector12
vector12:
  pushl $12
  101f38:	6a 0c                	push   $0xc
  jmp __alltraps
  101f3a:	e9 73 ff ff ff       	jmp    101eb2 <__alltraps>

00101f3f <vector13>:
.globl vector13
vector13:
  pushl $13
  101f3f:	6a 0d                	push   $0xd
  jmp __alltraps
  101f41:	e9 6c ff ff ff       	jmp    101eb2 <__alltraps>

00101f46 <vector14>:
.globl vector14
vector14:
  pushl $14
  101f46:	6a 0e                	push   $0xe
  jmp __alltraps
  101f48:	e9 65 ff ff ff       	jmp    101eb2 <__alltraps>

00101f4d <vector15>:
.globl vector15
vector15:
  pushl $0
  101f4d:	6a 00                	push   $0x0
  pushl $15
  101f4f:	6a 0f                	push   $0xf
  jmp __alltraps
  101f51:	e9 5c ff ff ff       	jmp    101eb2 <__alltraps>

00101f56 <vector16>:
.globl vector16
vector16:
  pushl $0
  101f56:	6a 00                	push   $0x0
  pushl $16
  101f58:	6a 10                	push   $0x10
  jmp __alltraps
  101f5a:	e9 53 ff ff ff       	jmp    101eb2 <__alltraps>

00101f5f <vector17>:
.globl vector17
vector17:
  pushl $17
  101f5f:	6a 11                	push   $0x11
  jmp __alltraps
  101f61:	e9 4c ff ff ff       	jmp    101eb2 <__alltraps>

00101f66 <vector18>:
.globl vector18
vector18:
  pushl $0
  101f66:	6a 00                	push   $0x0
  pushl $18
  101f68:	6a 12                	push   $0x12
  jmp __alltraps
  101f6a:	e9 43 ff ff ff       	jmp    101eb2 <__alltraps>

00101f6f <vector19>:
.globl vector19
vector19:
  pushl $0
  101f6f:	6a 00                	push   $0x0
  pushl $19
  101f71:	6a 13                	push   $0x13
  jmp __alltraps
  101f73:	e9 3a ff ff ff       	jmp    101eb2 <__alltraps>

00101f78 <vector20>:
.globl vector20
vector20:
  pushl $0
  101f78:	6a 00                	push   $0x0
  pushl $20
  101f7a:	6a 14                	push   $0x14
  jmp __alltraps
  101f7c:	e9 31 ff ff ff       	jmp    101eb2 <__alltraps>

00101f81 <vector21>:
.globl vector21
vector21:
  pushl $0
  101f81:	6a 00                	push   $0x0
  pushl $21
  101f83:	6a 15                	push   $0x15
  jmp __alltraps
  101f85:	e9 28 ff ff ff       	jmp    101eb2 <__alltraps>

00101f8a <vector22>:
.globl vector22
vector22:
  pushl $0
  101f8a:	6a 00                	push   $0x0
  pushl $22
  101f8c:	6a 16                	push   $0x16
  jmp __alltraps
  101f8e:	e9 1f ff ff ff       	jmp    101eb2 <__alltraps>

00101f93 <vector23>:
.globl vector23
vector23:
  pushl $0
  101f93:	6a 00                	push   $0x0
  pushl $23
  101f95:	6a 17                	push   $0x17
  jmp __alltraps
  101f97:	e9 16 ff ff ff       	jmp    101eb2 <__alltraps>

00101f9c <vector24>:
.globl vector24
vector24:
  pushl $0
  101f9c:	6a 00                	push   $0x0
  pushl $24
  101f9e:	6a 18                	push   $0x18
  jmp __alltraps
  101fa0:	e9 0d ff ff ff       	jmp    101eb2 <__alltraps>

00101fa5 <vector25>:
.globl vector25
vector25:
  pushl $0
  101fa5:	6a 00                	push   $0x0
  pushl $25
  101fa7:	6a 19                	push   $0x19
  jmp __alltraps
  101fa9:	e9 04 ff ff ff       	jmp    101eb2 <__alltraps>

00101fae <vector26>:
.globl vector26
vector26:
  pushl $0
  101fae:	6a 00                	push   $0x0
  pushl $26
  101fb0:	6a 1a                	push   $0x1a
  jmp __alltraps
  101fb2:	e9 fb fe ff ff       	jmp    101eb2 <__alltraps>

00101fb7 <vector27>:
.globl vector27
vector27:
  pushl $0
  101fb7:	6a 00                	push   $0x0
  pushl $27
  101fb9:	6a 1b                	push   $0x1b
  jmp __alltraps
  101fbb:	e9 f2 fe ff ff       	jmp    101eb2 <__alltraps>

00101fc0 <vector28>:
.globl vector28
vector28:
  pushl $0
  101fc0:	6a 00                	push   $0x0
  pushl $28
  101fc2:	6a 1c                	push   $0x1c
  jmp __alltraps
  101fc4:	e9 e9 fe ff ff       	jmp    101eb2 <__alltraps>

00101fc9 <vector29>:
.globl vector29
vector29:
  pushl $0
  101fc9:	6a 00                	push   $0x0
  pushl $29
  101fcb:	6a 1d                	push   $0x1d
  jmp __alltraps
  101fcd:	e9 e0 fe ff ff       	jmp    101eb2 <__alltraps>

00101fd2 <vector30>:
.globl vector30
vector30:
  pushl $0
  101fd2:	6a 00                	push   $0x0
  pushl $30
  101fd4:	6a 1e                	push   $0x1e
  jmp __alltraps
  101fd6:	e9 d7 fe ff ff       	jmp    101eb2 <__alltraps>

00101fdb <vector31>:
.globl vector31
vector31:
  pushl $0
  101fdb:	6a 00                	push   $0x0
  pushl $31
  101fdd:	6a 1f                	push   $0x1f
  jmp __alltraps
  101fdf:	e9 ce fe ff ff       	jmp    101eb2 <__alltraps>

00101fe4 <vector32>:
.globl vector32
vector32:
  pushl $0
  101fe4:	6a 00                	push   $0x0
  pushl $32
  101fe6:	6a 20                	push   $0x20
  jmp __alltraps
  101fe8:	e9 c5 fe ff ff       	jmp    101eb2 <__alltraps>

00101fed <vector33>:
.globl vector33
vector33:
  pushl $0
  101fed:	6a 00                	push   $0x0
  pushl $33
  101fef:	6a 21                	push   $0x21
  jmp __alltraps
  101ff1:	e9 bc fe ff ff       	jmp    101eb2 <__alltraps>

00101ff6 <vector34>:
.globl vector34
vector34:
  pushl $0
  101ff6:	6a 00                	push   $0x0
  pushl $34
  101ff8:	6a 22                	push   $0x22
  jmp __alltraps
  101ffa:	e9 b3 fe ff ff       	jmp    101eb2 <__alltraps>

00101fff <vector35>:
.globl vector35
vector35:
  pushl $0
  101fff:	6a 00                	push   $0x0
  pushl $35
  102001:	6a 23                	push   $0x23
  jmp __alltraps
  102003:	e9 aa fe ff ff       	jmp    101eb2 <__alltraps>

00102008 <vector36>:
.globl vector36
vector36:
  pushl $0
  102008:	6a 00                	push   $0x0
  pushl $36
  10200a:	6a 24                	push   $0x24
  jmp __alltraps
  10200c:	e9 a1 fe ff ff       	jmp    101eb2 <__alltraps>

00102011 <vector37>:
.globl vector37
vector37:
  pushl $0
  102011:	6a 00                	push   $0x0
  pushl $37
  102013:	6a 25                	push   $0x25
  jmp __alltraps
  102015:	e9 98 fe ff ff       	jmp    101eb2 <__alltraps>

0010201a <vector38>:
.globl vector38
vector38:
  pushl $0
  10201a:	6a 00                	push   $0x0
  pushl $38
  10201c:	6a 26                	push   $0x26
  jmp __alltraps
  10201e:	e9 8f fe ff ff       	jmp    101eb2 <__alltraps>

00102023 <vector39>:
.globl vector39
vector39:
  pushl $0
  102023:	6a 00                	push   $0x0
  pushl $39
  102025:	6a 27                	push   $0x27
  jmp __alltraps
  102027:	e9 86 fe ff ff       	jmp    101eb2 <__alltraps>

0010202c <vector40>:
.globl vector40
vector40:
  pushl $0
  10202c:	6a 00                	push   $0x0
  pushl $40
  10202e:	6a 28                	push   $0x28
  jmp __alltraps
  102030:	e9 7d fe ff ff       	jmp    101eb2 <__alltraps>

00102035 <vector41>:
.globl vector41
vector41:
  pushl $0
  102035:	6a 00                	push   $0x0
  pushl $41
  102037:	6a 29                	push   $0x29
  jmp __alltraps
  102039:	e9 74 fe ff ff       	jmp    101eb2 <__alltraps>

0010203e <vector42>:
.globl vector42
vector42:
  pushl $0
  10203e:	6a 00                	push   $0x0
  pushl $42
  102040:	6a 2a                	push   $0x2a
  jmp __alltraps
  102042:	e9 6b fe ff ff       	jmp    101eb2 <__alltraps>

00102047 <vector43>:
.globl vector43
vector43:
  pushl $0
  102047:	6a 00                	push   $0x0
  pushl $43
  102049:	6a 2b                	push   $0x2b
  jmp __alltraps
  10204b:	e9 62 fe ff ff       	jmp    101eb2 <__alltraps>

00102050 <vector44>:
.globl vector44
vector44:
  pushl $0
  102050:	6a 00                	push   $0x0
  pushl $44
  102052:	6a 2c                	push   $0x2c
  jmp __alltraps
  102054:	e9 59 fe ff ff       	jmp    101eb2 <__alltraps>

00102059 <vector45>:
.globl vector45
vector45:
  pushl $0
  102059:	6a 00                	push   $0x0
  pushl $45
  10205b:	6a 2d                	push   $0x2d
  jmp __alltraps
  10205d:	e9 50 fe ff ff       	jmp    101eb2 <__alltraps>

00102062 <vector46>:
.globl vector46
vector46:
  pushl $0
  102062:	6a 00                	push   $0x0
  pushl $46
  102064:	6a 2e                	push   $0x2e
  jmp __alltraps
  102066:	e9 47 fe ff ff       	jmp    101eb2 <__alltraps>

0010206b <vector47>:
.globl vector47
vector47:
  pushl $0
  10206b:	6a 00                	push   $0x0
  pushl $47
  10206d:	6a 2f                	push   $0x2f
  jmp __alltraps
  10206f:	e9 3e fe ff ff       	jmp    101eb2 <__alltraps>

00102074 <vector48>:
.globl vector48
vector48:
  pushl $0
  102074:	6a 00                	push   $0x0
  pushl $48
  102076:	6a 30                	push   $0x30
  jmp __alltraps
  102078:	e9 35 fe ff ff       	jmp    101eb2 <__alltraps>

0010207d <vector49>:
.globl vector49
vector49:
  pushl $0
  10207d:	6a 00                	push   $0x0
  pushl $49
  10207f:	6a 31                	push   $0x31
  jmp __alltraps
  102081:	e9 2c fe ff ff       	jmp    101eb2 <__alltraps>

00102086 <vector50>:
.globl vector50
vector50:
  pushl $0
  102086:	6a 00                	push   $0x0
  pushl $50
  102088:	6a 32                	push   $0x32
  jmp __alltraps
  10208a:	e9 23 fe ff ff       	jmp    101eb2 <__alltraps>

0010208f <vector51>:
.globl vector51
vector51:
  pushl $0
  10208f:	6a 00                	push   $0x0
  pushl $51
  102091:	6a 33                	push   $0x33
  jmp __alltraps
  102093:	e9 1a fe ff ff       	jmp    101eb2 <__alltraps>

00102098 <vector52>:
.globl vector52
vector52:
  pushl $0
  102098:	6a 00                	push   $0x0
  pushl $52
  10209a:	6a 34                	push   $0x34
  jmp __alltraps
  10209c:	e9 11 fe ff ff       	jmp    101eb2 <__alltraps>

001020a1 <vector53>:
.globl vector53
vector53:
  pushl $0
  1020a1:	6a 00                	push   $0x0
  pushl $53
  1020a3:	6a 35                	push   $0x35
  jmp __alltraps
  1020a5:	e9 08 fe ff ff       	jmp    101eb2 <__alltraps>

001020aa <vector54>:
.globl vector54
vector54:
  pushl $0
  1020aa:	6a 00                	push   $0x0
  pushl $54
  1020ac:	6a 36                	push   $0x36
  jmp __alltraps
  1020ae:	e9 ff fd ff ff       	jmp    101eb2 <__alltraps>

001020b3 <vector55>:
.globl vector55
vector55:
  pushl $0
  1020b3:	6a 00                	push   $0x0
  pushl $55
  1020b5:	6a 37                	push   $0x37
  jmp __alltraps
  1020b7:	e9 f6 fd ff ff       	jmp    101eb2 <__alltraps>

001020bc <vector56>:
.globl vector56
vector56:
  pushl $0
  1020bc:	6a 00                	push   $0x0
  pushl $56
  1020be:	6a 38                	push   $0x38
  jmp __alltraps
  1020c0:	e9 ed fd ff ff       	jmp    101eb2 <__alltraps>

001020c5 <vector57>:
.globl vector57
vector57:
  pushl $0
  1020c5:	6a 00                	push   $0x0
  pushl $57
  1020c7:	6a 39                	push   $0x39
  jmp __alltraps
  1020c9:	e9 e4 fd ff ff       	jmp    101eb2 <__alltraps>

001020ce <vector58>:
.globl vector58
vector58:
  pushl $0
  1020ce:	6a 00                	push   $0x0
  pushl $58
  1020d0:	6a 3a                	push   $0x3a
  jmp __alltraps
  1020d2:	e9 db fd ff ff       	jmp    101eb2 <__alltraps>

001020d7 <vector59>:
.globl vector59
vector59:
  pushl $0
  1020d7:	6a 00                	push   $0x0
  pushl $59
  1020d9:	6a 3b                	push   $0x3b
  jmp __alltraps
  1020db:	e9 d2 fd ff ff       	jmp    101eb2 <__alltraps>

001020e0 <vector60>:
.globl vector60
vector60:
  pushl $0
  1020e0:	6a 00                	push   $0x0
  pushl $60
  1020e2:	6a 3c                	push   $0x3c
  jmp __alltraps
  1020e4:	e9 c9 fd ff ff       	jmp    101eb2 <__alltraps>

001020e9 <vector61>:
.globl vector61
vector61:
  pushl $0
  1020e9:	6a 00                	push   $0x0
  pushl $61
  1020eb:	6a 3d                	push   $0x3d
  jmp __alltraps
  1020ed:	e9 c0 fd ff ff       	jmp    101eb2 <__alltraps>

001020f2 <vector62>:
.globl vector62
vector62:
  pushl $0
  1020f2:	6a 00                	push   $0x0
  pushl $62
  1020f4:	6a 3e                	push   $0x3e
  jmp __alltraps
  1020f6:	e9 b7 fd ff ff       	jmp    101eb2 <__alltraps>

001020fb <vector63>:
.globl vector63
vector63:
  pushl $0
  1020fb:	6a 00                	push   $0x0
  pushl $63
  1020fd:	6a 3f                	push   $0x3f
  jmp __alltraps
  1020ff:	e9 ae fd ff ff       	jmp    101eb2 <__alltraps>

00102104 <vector64>:
.globl vector64
vector64:
  pushl $0
  102104:	6a 00                	push   $0x0
  pushl $64
  102106:	6a 40                	push   $0x40
  jmp __alltraps
  102108:	e9 a5 fd ff ff       	jmp    101eb2 <__alltraps>

0010210d <vector65>:
.globl vector65
vector65:
  pushl $0
  10210d:	6a 00                	push   $0x0
  pushl $65
  10210f:	6a 41                	push   $0x41
  jmp __alltraps
  102111:	e9 9c fd ff ff       	jmp    101eb2 <__alltraps>

00102116 <vector66>:
.globl vector66
vector66:
  pushl $0
  102116:	6a 00                	push   $0x0
  pushl $66
  102118:	6a 42                	push   $0x42
  jmp __alltraps
  10211a:	e9 93 fd ff ff       	jmp    101eb2 <__alltraps>

0010211f <vector67>:
.globl vector67
vector67:
  pushl $0
  10211f:	6a 00                	push   $0x0
  pushl $67
  102121:	6a 43                	push   $0x43
  jmp __alltraps
  102123:	e9 8a fd ff ff       	jmp    101eb2 <__alltraps>

00102128 <vector68>:
.globl vector68
vector68:
  pushl $0
  102128:	6a 00                	push   $0x0
  pushl $68
  10212a:	6a 44                	push   $0x44
  jmp __alltraps
  10212c:	e9 81 fd ff ff       	jmp    101eb2 <__alltraps>

00102131 <vector69>:
.globl vector69
vector69:
  pushl $0
  102131:	6a 00                	push   $0x0
  pushl $69
  102133:	6a 45                	push   $0x45
  jmp __alltraps
  102135:	e9 78 fd ff ff       	jmp    101eb2 <__alltraps>

0010213a <vector70>:
.globl vector70
vector70:
  pushl $0
  10213a:	6a 00                	push   $0x0
  pushl $70
  10213c:	6a 46                	push   $0x46
  jmp __alltraps
  10213e:	e9 6f fd ff ff       	jmp    101eb2 <__alltraps>

00102143 <vector71>:
.globl vector71
vector71:
  pushl $0
  102143:	6a 00                	push   $0x0
  pushl $71
  102145:	6a 47                	push   $0x47
  jmp __alltraps
  102147:	e9 66 fd ff ff       	jmp    101eb2 <__alltraps>

0010214c <vector72>:
.globl vector72
vector72:
  pushl $0
  10214c:	6a 00                	push   $0x0
  pushl $72
  10214e:	6a 48                	push   $0x48
  jmp __alltraps
  102150:	e9 5d fd ff ff       	jmp    101eb2 <__alltraps>

00102155 <vector73>:
.globl vector73
vector73:
  pushl $0
  102155:	6a 00                	push   $0x0
  pushl $73
  102157:	6a 49                	push   $0x49
  jmp __alltraps
  102159:	e9 54 fd ff ff       	jmp    101eb2 <__alltraps>

0010215e <vector74>:
.globl vector74
vector74:
  pushl $0
  10215e:	6a 00                	push   $0x0
  pushl $74
  102160:	6a 4a                	push   $0x4a
  jmp __alltraps
  102162:	e9 4b fd ff ff       	jmp    101eb2 <__alltraps>

00102167 <vector75>:
.globl vector75
vector75:
  pushl $0
  102167:	6a 00                	push   $0x0
  pushl $75
  102169:	6a 4b                	push   $0x4b
  jmp __alltraps
  10216b:	e9 42 fd ff ff       	jmp    101eb2 <__alltraps>

00102170 <vector76>:
.globl vector76
vector76:
  pushl $0
  102170:	6a 00                	push   $0x0
  pushl $76
  102172:	6a 4c                	push   $0x4c
  jmp __alltraps
  102174:	e9 39 fd ff ff       	jmp    101eb2 <__alltraps>

00102179 <vector77>:
.globl vector77
vector77:
  pushl $0
  102179:	6a 00                	push   $0x0
  pushl $77
  10217b:	6a 4d                	push   $0x4d
  jmp __alltraps
  10217d:	e9 30 fd ff ff       	jmp    101eb2 <__alltraps>

00102182 <vector78>:
.globl vector78
vector78:
  pushl $0
  102182:	6a 00                	push   $0x0
  pushl $78
  102184:	6a 4e                	push   $0x4e
  jmp __alltraps
  102186:	e9 27 fd ff ff       	jmp    101eb2 <__alltraps>

0010218b <vector79>:
.globl vector79
vector79:
  pushl $0
  10218b:	6a 00                	push   $0x0
  pushl $79
  10218d:	6a 4f                	push   $0x4f
  jmp __alltraps
  10218f:	e9 1e fd ff ff       	jmp    101eb2 <__alltraps>

00102194 <vector80>:
.globl vector80
vector80:
  pushl $0
  102194:	6a 00                	push   $0x0
  pushl $80
  102196:	6a 50                	push   $0x50
  jmp __alltraps
  102198:	e9 15 fd ff ff       	jmp    101eb2 <__alltraps>

0010219d <vector81>:
.globl vector81
vector81:
  pushl $0
  10219d:	6a 00                	push   $0x0
  pushl $81
  10219f:	6a 51                	push   $0x51
  jmp __alltraps
  1021a1:	e9 0c fd ff ff       	jmp    101eb2 <__alltraps>

001021a6 <vector82>:
.globl vector82
vector82:
  pushl $0
  1021a6:	6a 00                	push   $0x0
  pushl $82
  1021a8:	6a 52                	push   $0x52
  jmp __alltraps
  1021aa:	e9 03 fd ff ff       	jmp    101eb2 <__alltraps>

001021af <vector83>:
.globl vector83
vector83:
  pushl $0
  1021af:	6a 00                	push   $0x0
  pushl $83
  1021b1:	6a 53                	push   $0x53
  jmp __alltraps
  1021b3:	e9 fa fc ff ff       	jmp    101eb2 <__alltraps>

001021b8 <vector84>:
.globl vector84
vector84:
  pushl $0
  1021b8:	6a 00                	push   $0x0
  pushl $84
  1021ba:	6a 54                	push   $0x54
  jmp __alltraps
  1021bc:	e9 f1 fc ff ff       	jmp    101eb2 <__alltraps>

001021c1 <vector85>:
.globl vector85
vector85:
  pushl $0
  1021c1:	6a 00                	push   $0x0
  pushl $85
  1021c3:	6a 55                	push   $0x55
  jmp __alltraps
  1021c5:	e9 e8 fc ff ff       	jmp    101eb2 <__alltraps>

001021ca <vector86>:
.globl vector86
vector86:
  pushl $0
  1021ca:	6a 00                	push   $0x0
  pushl $86
  1021cc:	6a 56                	push   $0x56
  jmp __alltraps
  1021ce:	e9 df fc ff ff       	jmp    101eb2 <__alltraps>

001021d3 <vector87>:
.globl vector87
vector87:
  pushl $0
  1021d3:	6a 00                	push   $0x0
  pushl $87
  1021d5:	6a 57                	push   $0x57
  jmp __alltraps
  1021d7:	e9 d6 fc ff ff       	jmp    101eb2 <__alltraps>

001021dc <vector88>:
.globl vector88
vector88:
  pushl $0
  1021dc:	6a 00                	push   $0x0
  pushl $88
  1021de:	6a 58                	push   $0x58
  jmp __alltraps
  1021e0:	e9 cd fc ff ff       	jmp    101eb2 <__alltraps>

001021e5 <vector89>:
.globl vector89
vector89:
  pushl $0
  1021e5:	6a 00                	push   $0x0
  pushl $89
  1021e7:	6a 59                	push   $0x59
  jmp __alltraps
  1021e9:	e9 c4 fc ff ff       	jmp    101eb2 <__alltraps>

001021ee <vector90>:
.globl vector90
vector90:
  pushl $0
  1021ee:	6a 00                	push   $0x0
  pushl $90
  1021f0:	6a 5a                	push   $0x5a
  jmp __alltraps
  1021f2:	e9 bb fc ff ff       	jmp    101eb2 <__alltraps>

001021f7 <vector91>:
.globl vector91
vector91:
  pushl $0
  1021f7:	6a 00                	push   $0x0
  pushl $91
  1021f9:	6a 5b                	push   $0x5b
  jmp __alltraps
  1021fb:	e9 b2 fc ff ff       	jmp    101eb2 <__alltraps>

00102200 <vector92>:
.globl vector92
vector92:
  pushl $0
  102200:	6a 00                	push   $0x0
  pushl $92
  102202:	6a 5c                	push   $0x5c
  jmp __alltraps
  102204:	e9 a9 fc ff ff       	jmp    101eb2 <__alltraps>

00102209 <vector93>:
.globl vector93
vector93:
  pushl $0
  102209:	6a 00                	push   $0x0
  pushl $93
  10220b:	6a 5d                	push   $0x5d
  jmp __alltraps
  10220d:	e9 a0 fc ff ff       	jmp    101eb2 <__alltraps>

00102212 <vector94>:
.globl vector94
vector94:
  pushl $0
  102212:	6a 00                	push   $0x0
  pushl $94
  102214:	6a 5e                	push   $0x5e
  jmp __alltraps
  102216:	e9 97 fc ff ff       	jmp    101eb2 <__alltraps>

0010221b <vector95>:
.globl vector95
vector95:
  pushl $0
  10221b:	6a 00                	push   $0x0
  pushl $95
  10221d:	6a 5f                	push   $0x5f
  jmp __alltraps
  10221f:	e9 8e fc ff ff       	jmp    101eb2 <__alltraps>

00102224 <vector96>:
.globl vector96
vector96:
  pushl $0
  102224:	6a 00                	push   $0x0
  pushl $96
  102226:	6a 60                	push   $0x60
  jmp __alltraps
  102228:	e9 85 fc ff ff       	jmp    101eb2 <__alltraps>

0010222d <vector97>:
.globl vector97
vector97:
  pushl $0
  10222d:	6a 00                	push   $0x0
  pushl $97
  10222f:	6a 61                	push   $0x61
  jmp __alltraps
  102231:	e9 7c fc ff ff       	jmp    101eb2 <__alltraps>

00102236 <vector98>:
.globl vector98
vector98:
  pushl $0
  102236:	6a 00                	push   $0x0
  pushl $98
  102238:	6a 62                	push   $0x62
  jmp __alltraps
  10223a:	e9 73 fc ff ff       	jmp    101eb2 <__alltraps>

0010223f <vector99>:
.globl vector99
vector99:
  pushl $0
  10223f:	6a 00                	push   $0x0
  pushl $99
  102241:	6a 63                	push   $0x63
  jmp __alltraps
  102243:	e9 6a fc ff ff       	jmp    101eb2 <__alltraps>

00102248 <vector100>:
.globl vector100
vector100:
  pushl $0
  102248:	6a 00                	push   $0x0
  pushl $100
  10224a:	6a 64                	push   $0x64
  jmp __alltraps
  10224c:	e9 61 fc ff ff       	jmp    101eb2 <__alltraps>

00102251 <vector101>:
.globl vector101
vector101:
  pushl $0
  102251:	6a 00                	push   $0x0
  pushl $101
  102253:	6a 65                	push   $0x65
  jmp __alltraps
  102255:	e9 58 fc ff ff       	jmp    101eb2 <__alltraps>

0010225a <vector102>:
.globl vector102
vector102:
  pushl $0
  10225a:	6a 00                	push   $0x0
  pushl $102
  10225c:	6a 66                	push   $0x66
  jmp __alltraps
  10225e:	e9 4f fc ff ff       	jmp    101eb2 <__alltraps>

00102263 <vector103>:
.globl vector103
vector103:
  pushl $0
  102263:	6a 00                	push   $0x0
  pushl $103
  102265:	6a 67                	push   $0x67
  jmp __alltraps
  102267:	e9 46 fc ff ff       	jmp    101eb2 <__alltraps>

0010226c <vector104>:
.globl vector104
vector104:
  pushl $0
  10226c:	6a 00                	push   $0x0
  pushl $104
  10226e:	6a 68                	push   $0x68
  jmp __alltraps
  102270:	e9 3d fc ff ff       	jmp    101eb2 <__alltraps>

00102275 <vector105>:
.globl vector105
vector105:
  pushl $0
  102275:	6a 00                	push   $0x0
  pushl $105
  102277:	6a 69                	push   $0x69
  jmp __alltraps
  102279:	e9 34 fc ff ff       	jmp    101eb2 <__alltraps>

0010227e <vector106>:
.globl vector106
vector106:
  pushl $0
  10227e:	6a 00                	push   $0x0
  pushl $106
  102280:	6a 6a                	push   $0x6a
  jmp __alltraps
  102282:	e9 2b fc ff ff       	jmp    101eb2 <__alltraps>

00102287 <vector107>:
.globl vector107
vector107:
  pushl $0
  102287:	6a 00                	push   $0x0
  pushl $107
  102289:	6a 6b                	push   $0x6b
  jmp __alltraps
  10228b:	e9 22 fc ff ff       	jmp    101eb2 <__alltraps>

00102290 <vector108>:
.globl vector108
vector108:
  pushl $0
  102290:	6a 00                	push   $0x0
  pushl $108
  102292:	6a 6c                	push   $0x6c
  jmp __alltraps
  102294:	e9 19 fc ff ff       	jmp    101eb2 <__alltraps>

00102299 <vector109>:
.globl vector109
vector109:
  pushl $0
  102299:	6a 00                	push   $0x0
  pushl $109
  10229b:	6a 6d                	push   $0x6d
  jmp __alltraps
  10229d:	e9 10 fc ff ff       	jmp    101eb2 <__alltraps>

001022a2 <vector110>:
.globl vector110
vector110:
  pushl $0
  1022a2:	6a 00                	push   $0x0
  pushl $110
  1022a4:	6a 6e                	push   $0x6e
  jmp __alltraps
  1022a6:	e9 07 fc ff ff       	jmp    101eb2 <__alltraps>

001022ab <vector111>:
.globl vector111
vector111:
  pushl $0
  1022ab:	6a 00                	push   $0x0
  pushl $111
  1022ad:	6a 6f                	push   $0x6f
  jmp __alltraps
  1022af:	e9 fe fb ff ff       	jmp    101eb2 <__alltraps>

001022b4 <vector112>:
.globl vector112
vector112:
  pushl $0
  1022b4:	6a 00                	push   $0x0
  pushl $112
  1022b6:	6a 70                	push   $0x70
  jmp __alltraps
  1022b8:	e9 f5 fb ff ff       	jmp    101eb2 <__alltraps>

001022bd <vector113>:
.globl vector113
vector113:
  pushl $0
  1022bd:	6a 00                	push   $0x0
  pushl $113
  1022bf:	6a 71                	push   $0x71
  jmp __alltraps
  1022c1:	e9 ec fb ff ff       	jmp    101eb2 <__alltraps>

001022c6 <vector114>:
.globl vector114
vector114:
  pushl $0
  1022c6:	6a 00                	push   $0x0
  pushl $114
  1022c8:	6a 72                	push   $0x72
  jmp __alltraps
  1022ca:	e9 e3 fb ff ff       	jmp    101eb2 <__alltraps>

001022cf <vector115>:
.globl vector115
vector115:
  pushl $0
  1022cf:	6a 00                	push   $0x0
  pushl $115
  1022d1:	6a 73                	push   $0x73
  jmp __alltraps
  1022d3:	e9 da fb ff ff       	jmp    101eb2 <__alltraps>

001022d8 <vector116>:
.globl vector116
vector116:
  pushl $0
  1022d8:	6a 00                	push   $0x0
  pushl $116
  1022da:	6a 74                	push   $0x74
  jmp __alltraps
  1022dc:	e9 d1 fb ff ff       	jmp    101eb2 <__alltraps>

001022e1 <vector117>:
.globl vector117
vector117:
  pushl $0
  1022e1:	6a 00                	push   $0x0
  pushl $117
  1022e3:	6a 75                	push   $0x75
  jmp __alltraps
  1022e5:	e9 c8 fb ff ff       	jmp    101eb2 <__alltraps>

001022ea <vector118>:
.globl vector118
vector118:
  pushl $0
  1022ea:	6a 00                	push   $0x0
  pushl $118
  1022ec:	6a 76                	push   $0x76
  jmp __alltraps
  1022ee:	e9 bf fb ff ff       	jmp    101eb2 <__alltraps>

001022f3 <vector119>:
.globl vector119
vector119:
  pushl $0
  1022f3:	6a 00                	push   $0x0
  pushl $119
  1022f5:	6a 77                	push   $0x77
  jmp __alltraps
  1022f7:	e9 b6 fb ff ff       	jmp    101eb2 <__alltraps>

001022fc <vector120>:
.globl vector120
vector120:
  pushl $0
  1022fc:	6a 00                	push   $0x0
  pushl $120
  1022fe:	6a 78                	push   $0x78
  jmp __alltraps
  102300:	e9 ad fb ff ff       	jmp    101eb2 <__alltraps>

00102305 <vector121>:
.globl vector121
vector121:
  pushl $0
  102305:	6a 00                	push   $0x0
  pushl $121
  102307:	6a 79                	push   $0x79
  jmp __alltraps
  102309:	e9 a4 fb ff ff       	jmp    101eb2 <__alltraps>

0010230e <vector122>:
.globl vector122
vector122:
  pushl $0
  10230e:	6a 00                	push   $0x0
  pushl $122
  102310:	6a 7a                	push   $0x7a
  jmp __alltraps
  102312:	e9 9b fb ff ff       	jmp    101eb2 <__alltraps>

00102317 <vector123>:
.globl vector123
vector123:
  pushl $0
  102317:	6a 00                	push   $0x0
  pushl $123
  102319:	6a 7b                	push   $0x7b
  jmp __alltraps
  10231b:	e9 92 fb ff ff       	jmp    101eb2 <__alltraps>

00102320 <vector124>:
.globl vector124
vector124:
  pushl $0
  102320:	6a 00                	push   $0x0
  pushl $124
  102322:	6a 7c                	push   $0x7c
  jmp __alltraps
  102324:	e9 89 fb ff ff       	jmp    101eb2 <__alltraps>

00102329 <vector125>:
.globl vector125
vector125:
  pushl $0
  102329:	6a 00                	push   $0x0
  pushl $125
  10232b:	6a 7d                	push   $0x7d
  jmp __alltraps
  10232d:	e9 80 fb ff ff       	jmp    101eb2 <__alltraps>

00102332 <vector126>:
.globl vector126
vector126:
  pushl $0
  102332:	6a 00                	push   $0x0
  pushl $126
  102334:	6a 7e                	push   $0x7e
  jmp __alltraps
  102336:	e9 77 fb ff ff       	jmp    101eb2 <__alltraps>

0010233b <vector127>:
.globl vector127
vector127:
  pushl $0
  10233b:	6a 00                	push   $0x0
  pushl $127
  10233d:	6a 7f                	push   $0x7f
  jmp __alltraps
  10233f:	e9 6e fb ff ff       	jmp    101eb2 <__alltraps>

00102344 <vector128>:
.globl vector128
vector128:
  pushl $0
  102344:	6a 00                	push   $0x0
  pushl $128
  102346:	68 80 00 00 00       	push   $0x80
  jmp __alltraps
  10234b:	e9 62 fb ff ff       	jmp    101eb2 <__alltraps>

00102350 <vector129>:
.globl vector129
vector129:
  pushl $0
  102350:	6a 00                	push   $0x0
  pushl $129
  102352:	68 81 00 00 00       	push   $0x81
  jmp __alltraps
  102357:	e9 56 fb ff ff       	jmp    101eb2 <__alltraps>

0010235c <vector130>:
.globl vector130
vector130:
  pushl $0
  10235c:	6a 00                	push   $0x0
  pushl $130
  10235e:	68 82 00 00 00       	push   $0x82
  jmp __alltraps
  102363:	e9 4a fb ff ff       	jmp    101eb2 <__alltraps>

00102368 <vector131>:
.globl vector131
vector131:
  pushl $0
  102368:	6a 00                	push   $0x0
  pushl $131
  10236a:	68 83 00 00 00       	push   $0x83
  jmp __alltraps
  10236f:	e9 3e fb ff ff       	jmp    101eb2 <__alltraps>

00102374 <vector132>:
.globl vector132
vector132:
  pushl $0
  102374:	6a 00                	push   $0x0
  pushl $132
  102376:	68 84 00 00 00       	push   $0x84
  jmp __alltraps
  10237b:	e9 32 fb ff ff       	jmp    101eb2 <__alltraps>

00102380 <vector133>:
.globl vector133
vector133:
  pushl $0
  102380:	6a 00                	push   $0x0
  pushl $133
  102382:	68 85 00 00 00       	push   $0x85
  jmp __alltraps
  102387:	e9 26 fb ff ff       	jmp    101eb2 <__alltraps>

0010238c <vector134>:
.globl vector134
vector134:
  pushl $0
  10238c:	6a 00                	push   $0x0
  pushl $134
  10238e:	68 86 00 00 00       	push   $0x86
  jmp __alltraps
  102393:	e9 1a fb ff ff       	jmp    101eb2 <__alltraps>

00102398 <vector135>:
.globl vector135
vector135:
  pushl $0
  102398:	6a 00                	push   $0x0
  pushl $135
  10239a:	68 87 00 00 00       	push   $0x87
  jmp __alltraps
  10239f:	e9 0e fb ff ff       	jmp    101eb2 <__alltraps>

001023a4 <vector136>:
.globl vector136
vector136:
  pushl $0
  1023a4:	6a 00                	push   $0x0
  pushl $136
  1023a6:	68 88 00 00 00       	push   $0x88
  jmp __alltraps
  1023ab:	e9 02 fb ff ff       	jmp    101eb2 <__alltraps>

001023b0 <vector137>:
.globl vector137
vector137:
  pushl $0
  1023b0:	6a 00                	push   $0x0
  pushl $137
  1023b2:	68 89 00 00 00       	push   $0x89
  jmp __alltraps
  1023b7:	e9 f6 fa ff ff       	jmp    101eb2 <__alltraps>

001023bc <vector138>:
.globl vector138
vector138:
  pushl $0
  1023bc:	6a 00                	push   $0x0
  pushl $138
  1023be:	68 8a 00 00 00       	push   $0x8a
  jmp __alltraps
  1023c3:	e9 ea fa ff ff       	jmp    101eb2 <__alltraps>

001023c8 <vector139>:
.globl vector139
vector139:
  pushl $0
  1023c8:	6a 00                	push   $0x0
  pushl $139
  1023ca:	68 8b 00 00 00       	push   $0x8b
  jmp __alltraps
  1023cf:	e9 de fa ff ff       	jmp    101eb2 <__alltraps>

001023d4 <vector140>:
.globl vector140
vector140:
  pushl $0
  1023d4:	6a 00                	push   $0x0
  pushl $140
  1023d6:	68 8c 00 00 00       	push   $0x8c
  jmp __alltraps
  1023db:	e9 d2 fa ff ff       	jmp    101eb2 <__alltraps>

001023e0 <vector141>:
.globl vector141
vector141:
  pushl $0
  1023e0:	6a 00                	push   $0x0
  pushl $141
  1023e2:	68 8d 00 00 00       	push   $0x8d
  jmp __alltraps
  1023e7:	e9 c6 fa ff ff       	jmp    101eb2 <__alltraps>

001023ec <vector142>:
.globl vector142
vector142:
  pushl $0
  1023ec:	6a 00                	push   $0x0
  pushl $142
  1023ee:	68 8e 00 00 00       	push   $0x8e
  jmp __alltraps
  1023f3:	e9 ba fa ff ff       	jmp    101eb2 <__alltraps>

001023f8 <vector143>:
.globl vector143
vector143:
  pushl $0
  1023f8:	6a 00                	push   $0x0
  pushl $143
  1023fa:	68 8f 00 00 00       	push   $0x8f
  jmp __alltraps
  1023ff:	e9 ae fa ff ff       	jmp    101eb2 <__alltraps>

00102404 <vector144>:
.globl vector144
vector144:
  pushl $0
  102404:	6a 00                	push   $0x0
  pushl $144
  102406:	68 90 00 00 00       	push   $0x90
  jmp __alltraps
  10240b:	e9 a2 fa ff ff       	jmp    101eb2 <__alltraps>

00102410 <vector145>:
.globl vector145
vector145:
  pushl $0
  102410:	6a 00                	push   $0x0
  pushl $145
  102412:	68 91 00 00 00       	push   $0x91
  jmp __alltraps
  102417:	e9 96 fa ff ff       	jmp    101eb2 <__alltraps>

0010241c <vector146>:
.globl vector146
vector146:
  pushl $0
  10241c:	6a 00                	push   $0x0
  pushl $146
  10241e:	68 92 00 00 00       	push   $0x92
  jmp __alltraps
  102423:	e9 8a fa ff ff       	jmp    101eb2 <__alltraps>

00102428 <vector147>:
.globl vector147
vector147:
  pushl $0
  102428:	6a 00                	push   $0x0
  pushl $147
  10242a:	68 93 00 00 00       	push   $0x93
  jmp __alltraps
  10242f:	e9 7e fa ff ff       	jmp    101eb2 <__alltraps>

00102434 <vector148>:
.globl vector148
vector148:
  pushl $0
  102434:	6a 00                	push   $0x0
  pushl $148
  102436:	68 94 00 00 00       	push   $0x94
  jmp __alltraps
  10243b:	e9 72 fa ff ff       	jmp    101eb2 <__alltraps>

00102440 <vector149>:
.globl vector149
vector149:
  pushl $0
  102440:	6a 00                	push   $0x0
  pushl $149
  102442:	68 95 00 00 00       	push   $0x95
  jmp __alltraps
  102447:	e9 66 fa ff ff       	jmp    101eb2 <__alltraps>

0010244c <vector150>:
.globl vector150
vector150:
  pushl $0
  10244c:	6a 00                	push   $0x0
  pushl $150
  10244e:	68 96 00 00 00       	push   $0x96
  jmp __alltraps
  102453:	e9 5a fa ff ff       	jmp    101eb2 <__alltraps>

00102458 <vector151>:
.globl vector151
vector151:
  pushl $0
  102458:	6a 00                	push   $0x0
  pushl $151
  10245a:	68 97 00 00 00       	push   $0x97
  jmp __alltraps
  10245f:	e9 4e fa ff ff       	jmp    101eb2 <__alltraps>

00102464 <vector152>:
.globl vector152
vector152:
  pushl $0
  102464:	6a 00                	push   $0x0
  pushl $152
  102466:	68 98 00 00 00       	push   $0x98
  jmp __alltraps
  10246b:	e9 42 fa ff ff       	jmp    101eb2 <__alltraps>

00102470 <vector153>:
.globl vector153
vector153:
  pushl $0
  102470:	6a 00                	push   $0x0
  pushl $153
  102472:	68 99 00 00 00       	push   $0x99
  jmp __alltraps
  102477:	e9 36 fa ff ff       	jmp    101eb2 <__alltraps>

0010247c <vector154>:
.globl vector154
vector154:
  pushl $0
  10247c:	6a 00                	push   $0x0
  pushl $154
  10247e:	68 9a 00 00 00       	push   $0x9a
  jmp __alltraps
  102483:	e9 2a fa ff ff       	jmp    101eb2 <__alltraps>

00102488 <vector155>:
.globl vector155
vector155:
  pushl $0
  102488:	6a 00                	push   $0x0
  pushl $155
  10248a:	68 9b 00 00 00       	push   $0x9b
  jmp __alltraps
  10248f:	e9 1e fa ff ff       	jmp    101eb2 <__alltraps>

00102494 <vector156>:
.globl vector156
vector156:
  pushl $0
  102494:	6a 00                	push   $0x0
  pushl $156
  102496:	68 9c 00 00 00       	push   $0x9c
  jmp __alltraps
  10249b:	e9 12 fa ff ff       	jmp    101eb2 <__alltraps>

001024a0 <vector157>:
.globl vector157
vector157:
  pushl $0
  1024a0:	6a 00                	push   $0x0
  pushl $157
  1024a2:	68 9d 00 00 00       	push   $0x9d
  jmp __alltraps
  1024a7:	e9 06 fa ff ff       	jmp    101eb2 <__alltraps>

001024ac <vector158>:
.globl vector158
vector158:
  pushl $0
  1024ac:	6a 00                	push   $0x0
  pushl $158
  1024ae:	68 9e 00 00 00       	push   $0x9e
  jmp __alltraps
  1024b3:	e9 fa f9 ff ff       	jmp    101eb2 <__alltraps>

001024b8 <vector159>:
.globl vector159
vector159:
  pushl $0
  1024b8:	6a 00                	push   $0x0
  pushl $159
  1024ba:	68 9f 00 00 00       	push   $0x9f
  jmp __alltraps
  1024bf:	e9 ee f9 ff ff       	jmp    101eb2 <__alltraps>

001024c4 <vector160>:
.globl vector160
vector160:
  pushl $0
  1024c4:	6a 00                	push   $0x0
  pushl $160
  1024c6:	68 a0 00 00 00       	push   $0xa0
  jmp __alltraps
  1024cb:	e9 e2 f9 ff ff       	jmp    101eb2 <__alltraps>

001024d0 <vector161>:
.globl vector161
vector161:
  pushl $0
  1024d0:	6a 00                	push   $0x0
  pushl $161
  1024d2:	68 a1 00 00 00       	push   $0xa1
  jmp __alltraps
  1024d7:	e9 d6 f9 ff ff       	jmp    101eb2 <__alltraps>

001024dc <vector162>:
.globl vector162
vector162:
  pushl $0
  1024dc:	6a 00                	push   $0x0
  pushl $162
  1024de:	68 a2 00 00 00       	push   $0xa2
  jmp __alltraps
  1024e3:	e9 ca f9 ff ff       	jmp    101eb2 <__alltraps>

001024e8 <vector163>:
.globl vector163
vector163:
  pushl $0
  1024e8:	6a 00                	push   $0x0
  pushl $163
  1024ea:	68 a3 00 00 00       	push   $0xa3
  jmp __alltraps
  1024ef:	e9 be f9 ff ff       	jmp    101eb2 <__alltraps>

001024f4 <vector164>:
.globl vector164
vector164:
  pushl $0
  1024f4:	6a 00                	push   $0x0
  pushl $164
  1024f6:	68 a4 00 00 00       	push   $0xa4
  jmp __alltraps
  1024fb:	e9 b2 f9 ff ff       	jmp    101eb2 <__alltraps>

00102500 <vector165>:
.globl vector165
vector165:
  pushl $0
  102500:	6a 00                	push   $0x0
  pushl $165
  102502:	68 a5 00 00 00       	push   $0xa5
  jmp __alltraps
  102507:	e9 a6 f9 ff ff       	jmp    101eb2 <__alltraps>

0010250c <vector166>:
.globl vector166
vector166:
  pushl $0
  10250c:	6a 00                	push   $0x0
  pushl $166
  10250e:	68 a6 00 00 00       	push   $0xa6
  jmp __alltraps
  102513:	e9 9a f9 ff ff       	jmp    101eb2 <__alltraps>

00102518 <vector167>:
.globl vector167
vector167:
  pushl $0
  102518:	6a 00                	push   $0x0
  pushl $167
  10251a:	68 a7 00 00 00       	push   $0xa7
  jmp __alltraps
  10251f:	e9 8e f9 ff ff       	jmp    101eb2 <__alltraps>

00102524 <vector168>:
.globl vector168
vector168:
  pushl $0
  102524:	6a 00                	push   $0x0
  pushl $168
  102526:	68 a8 00 00 00       	push   $0xa8
  jmp __alltraps
  10252b:	e9 82 f9 ff ff       	jmp    101eb2 <__alltraps>

00102530 <vector169>:
.globl vector169
vector169:
  pushl $0
  102530:	6a 00                	push   $0x0
  pushl $169
  102532:	68 a9 00 00 00       	push   $0xa9
  jmp __alltraps
  102537:	e9 76 f9 ff ff       	jmp    101eb2 <__alltraps>

0010253c <vector170>:
.globl vector170
vector170:
  pushl $0
  10253c:	6a 00                	push   $0x0
  pushl $170
  10253e:	68 aa 00 00 00       	push   $0xaa
  jmp __alltraps
  102543:	e9 6a f9 ff ff       	jmp    101eb2 <__alltraps>

00102548 <vector171>:
.globl vector171
vector171:
  pushl $0
  102548:	6a 00                	push   $0x0
  pushl $171
  10254a:	68 ab 00 00 00       	push   $0xab
  jmp __alltraps
  10254f:	e9 5e f9 ff ff       	jmp    101eb2 <__alltraps>

00102554 <vector172>:
.globl vector172
vector172:
  pushl $0
  102554:	6a 00                	push   $0x0
  pushl $172
  102556:	68 ac 00 00 00       	push   $0xac
  jmp __alltraps
  10255b:	e9 52 f9 ff ff       	jmp    101eb2 <__alltraps>

00102560 <vector173>:
.globl vector173
vector173:
  pushl $0
  102560:	6a 00                	push   $0x0
  pushl $173
  102562:	68 ad 00 00 00       	push   $0xad
  jmp __alltraps
  102567:	e9 46 f9 ff ff       	jmp    101eb2 <__alltraps>

0010256c <vector174>:
.globl vector174
vector174:
  pushl $0
  10256c:	6a 00                	push   $0x0
  pushl $174
  10256e:	68 ae 00 00 00       	push   $0xae
  jmp __alltraps
  102573:	e9 3a f9 ff ff       	jmp    101eb2 <__alltraps>

00102578 <vector175>:
.globl vector175
vector175:
  pushl $0
  102578:	6a 00                	push   $0x0
  pushl $175
  10257a:	68 af 00 00 00       	push   $0xaf
  jmp __alltraps
  10257f:	e9 2e f9 ff ff       	jmp    101eb2 <__alltraps>

00102584 <vector176>:
.globl vector176
vector176:
  pushl $0
  102584:	6a 00                	push   $0x0
  pushl $176
  102586:	68 b0 00 00 00       	push   $0xb0
  jmp __alltraps
  10258b:	e9 22 f9 ff ff       	jmp    101eb2 <__alltraps>

00102590 <vector177>:
.globl vector177
vector177:
  pushl $0
  102590:	6a 00                	push   $0x0
  pushl $177
  102592:	68 b1 00 00 00       	push   $0xb1
  jmp __alltraps
  102597:	e9 16 f9 ff ff       	jmp    101eb2 <__alltraps>

0010259c <vector178>:
.globl vector178
vector178:
  pushl $0
  10259c:	6a 00                	push   $0x0
  pushl $178
  10259e:	68 b2 00 00 00       	push   $0xb2
  jmp __alltraps
  1025a3:	e9 0a f9 ff ff       	jmp    101eb2 <__alltraps>

001025a8 <vector179>:
.globl vector179
vector179:
  pushl $0
  1025a8:	6a 00                	push   $0x0
  pushl $179
  1025aa:	68 b3 00 00 00       	push   $0xb3
  jmp __alltraps
  1025af:	e9 fe f8 ff ff       	jmp    101eb2 <__alltraps>

001025b4 <vector180>:
.globl vector180
vector180:
  pushl $0
  1025b4:	6a 00                	push   $0x0
  pushl $180
  1025b6:	68 b4 00 00 00       	push   $0xb4
  jmp __alltraps
  1025bb:	e9 f2 f8 ff ff       	jmp    101eb2 <__alltraps>

001025c0 <vector181>:
.globl vector181
vector181:
  pushl $0
  1025c0:	6a 00                	push   $0x0
  pushl $181
  1025c2:	68 b5 00 00 00       	push   $0xb5
  jmp __alltraps
  1025c7:	e9 e6 f8 ff ff       	jmp    101eb2 <__alltraps>

001025cc <vector182>:
.globl vector182
vector182:
  pushl $0
  1025cc:	6a 00                	push   $0x0
  pushl $182
  1025ce:	68 b6 00 00 00       	push   $0xb6
  jmp __alltraps
  1025d3:	e9 da f8 ff ff       	jmp    101eb2 <__alltraps>

001025d8 <vector183>:
.globl vector183
vector183:
  pushl $0
  1025d8:	6a 00                	push   $0x0
  pushl $183
  1025da:	68 b7 00 00 00       	push   $0xb7
  jmp __alltraps
  1025df:	e9 ce f8 ff ff       	jmp    101eb2 <__alltraps>

001025e4 <vector184>:
.globl vector184
vector184:
  pushl $0
  1025e4:	6a 00                	push   $0x0
  pushl $184
  1025e6:	68 b8 00 00 00       	push   $0xb8
  jmp __alltraps
  1025eb:	e9 c2 f8 ff ff       	jmp    101eb2 <__alltraps>

001025f0 <vector185>:
.globl vector185
vector185:
  pushl $0
  1025f0:	6a 00                	push   $0x0
  pushl $185
  1025f2:	68 b9 00 00 00       	push   $0xb9
  jmp __alltraps
  1025f7:	e9 b6 f8 ff ff       	jmp    101eb2 <__alltraps>

001025fc <vector186>:
.globl vector186
vector186:
  pushl $0
  1025fc:	6a 00                	push   $0x0
  pushl $186
  1025fe:	68 ba 00 00 00       	push   $0xba
  jmp __alltraps
  102603:	e9 aa f8 ff ff       	jmp    101eb2 <__alltraps>

00102608 <vector187>:
.globl vector187
vector187:
  pushl $0
  102608:	6a 00                	push   $0x0
  pushl $187
  10260a:	68 bb 00 00 00       	push   $0xbb
  jmp __alltraps
  10260f:	e9 9e f8 ff ff       	jmp    101eb2 <__alltraps>

00102614 <vector188>:
.globl vector188
vector188:
  pushl $0
  102614:	6a 00                	push   $0x0
  pushl $188
  102616:	68 bc 00 00 00       	push   $0xbc
  jmp __alltraps
  10261b:	e9 92 f8 ff ff       	jmp    101eb2 <__alltraps>

00102620 <vector189>:
.globl vector189
vector189:
  pushl $0
  102620:	6a 00                	push   $0x0
  pushl $189
  102622:	68 bd 00 00 00       	push   $0xbd
  jmp __alltraps
  102627:	e9 86 f8 ff ff       	jmp    101eb2 <__alltraps>

0010262c <vector190>:
.globl vector190
vector190:
  pushl $0
  10262c:	6a 00                	push   $0x0
  pushl $190
  10262e:	68 be 00 00 00       	push   $0xbe
  jmp __alltraps
  102633:	e9 7a f8 ff ff       	jmp    101eb2 <__alltraps>

00102638 <vector191>:
.globl vector191
vector191:
  pushl $0
  102638:	6a 00                	push   $0x0
  pushl $191
  10263a:	68 bf 00 00 00       	push   $0xbf
  jmp __alltraps
  10263f:	e9 6e f8 ff ff       	jmp    101eb2 <__alltraps>

00102644 <vector192>:
.globl vector192
vector192:
  pushl $0
  102644:	6a 00                	push   $0x0
  pushl $192
  102646:	68 c0 00 00 00       	push   $0xc0
  jmp __alltraps
  10264b:	e9 62 f8 ff ff       	jmp    101eb2 <__alltraps>

00102650 <vector193>:
.globl vector193
vector193:
  pushl $0
  102650:	6a 00                	push   $0x0
  pushl $193
  102652:	68 c1 00 00 00       	push   $0xc1
  jmp __alltraps
  102657:	e9 56 f8 ff ff       	jmp    101eb2 <__alltraps>

0010265c <vector194>:
.globl vector194
vector194:
  pushl $0
  10265c:	6a 00                	push   $0x0
  pushl $194
  10265e:	68 c2 00 00 00       	push   $0xc2
  jmp __alltraps
  102663:	e9 4a f8 ff ff       	jmp    101eb2 <__alltraps>

00102668 <vector195>:
.globl vector195
vector195:
  pushl $0
  102668:	6a 00                	push   $0x0
  pushl $195
  10266a:	68 c3 00 00 00       	push   $0xc3
  jmp __alltraps
  10266f:	e9 3e f8 ff ff       	jmp    101eb2 <__alltraps>

00102674 <vector196>:
.globl vector196
vector196:
  pushl $0
  102674:	6a 00                	push   $0x0
  pushl $196
  102676:	68 c4 00 00 00       	push   $0xc4
  jmp __alltraps
  10267b:	e9 32 f8 ff ff       	jmp    101eb2 <__alltraps>

00102680 <vector197>:
.globl vector197
vector197:
  pushl $0
  102680:	6a 00                	push   $0x0
  pushl $197
  102682:	68 c5 00 00 00       	push   $0xc5
  jmp __alltraps
  102687:	e9 26 f8 ff ff       	jmp    101eb2 <__alltraps>

0010268c <vector198>:
.globl vector198
vector198:
  pushl $0
  10268c:	6a 00                	push   $0x0
  pushl $198
  10268e:	68 c6 00 00 00       	push   $0xc6
  jmp __alltraps
  102693:	e9 1a f8 ff ff       	jmp    101eb2 <__alltraps>

00102698 <vector199>:
.globl vector199
vector199:
  pushl $0
  102698:	6a 00                	push   $0x0
  pushl $199
  10269a:	68 c7 00 00 00       	push   $0xc7
  jmp __alltraps
  10269f:	e9 0e f8 ff ff       	jmp    101eb2 <__alltraps>

001026a4 <vector200>:
.globl vector200
vector200:
  pushl $0
  1026a4:	6a 00                	push   $0x0
  pushl $200
  1026a6:	68 c8 00 00 00       	push   $0xc8
  jmp __alltraps
  1026ab:	e9 02 f8 ff ff       	jmp    101eb2 <__alltraps>

001026b0 <vector201>:
.globl vector201
vector201:
  pushl $0
  1026b0:	6a 00                	push   $0x0
  pushl $201
  1026b2:	68 c9 00 00 00       	push   $0xc9
  jmp __alltraps
  1026b7:	e9 f6 f7 ff ff       	jmp    101eb2 <__alltraps>

001026bc <vector202>:
.globl vector202
vector202:
  pushl $0
  1026bc:	6a 00                	push   $0x0
  pushl $202
  1026be:	68 ca 00 00 00       	push   $0xca
  jmp __alltraps
  1026c3:	e9 ea f7 ff ff       	jmp    101eb2 <__alltraps>

001026c8 <vector203>:
.globl vector203
vector203:
  pushl $0
  1026c8:	6a 00                	push   $0x0
  pushl $203
  1026ca:	68 cb 00 00 00       	push   $0xcb
  jmp __alltraps
  1026cf:	e9 de f7 ff ff       	jmp    101eb2 <__alltraps>

001026d4 <vector204>:
.globl vector204
vector204:
  pushl $0
  1026d4:	6a 00                	push   $0x0
  pushl $204
  1026d6:	68 cc 00 00 00       	push   $0xcc
  jmp __alltraps
  1026db:	e9 d2 f7 ff ff       	jmp    101eb2 <__alltraps>

001026e0 <vector205>:
.globl vector205
vector205:
  pushl $0
  1026e0:	6a 00                	push   $0x0
  pushl $205
  1026e2:	68 cd 00 00 00       	push   $0xcd
  jmp __alltraps
  1026e7:	e9 c6 f7 ff ff       	jmp    101eb2 <__alltraps>

001026ec <vector206>:
.globl vector206
vector206:
  pushl $0
  1026ec:	6a 00                	push   $0x0
  pushl $206
  1026ee:	68 ce 00 00 00       	push   $0xce
  jmp __alltraps
  1026f3:	e9 ba f7 ff ff       	jmp    101eb2 <__alltraps>

001026f8 <vector207>:
.globl vector207
vector207:
  pushl $0
  1026f8:	6a 00                	push   $0x0
  pushl $207
  1026fa:	68 cf 00 00 00       	push   $0xcf
  jmp __alltraps
  1026ff:	e9 ae f7 ff ff       	jmp    101eb2 <__alltraps>

00102704 <vector208>:
.globl vector208
vector208:
  pushl $0
  102704:	6a 00                	push   $0x0
  pushl $208
  102706:	68 d0 00 00 00       	push   $0xd0
  jmp __alltraps
  10270b:	e9 a2 f7 ff ff       	jmp    101eb2 <__alltraps>

00102710 <vector209>:
.globl vector209
vector209:
  pushl $0
  102710:	6a 00                	push   $0x0
  pushl $209
  102712:	68 d1 00 00 00       	push   $0xd1
  jmp __alltraps
  102717:	e9 96 f7 ff ff       	jmp    101eb2 <__alltraps>

0010271c <vector210>:
.globl vector210
vector210:
  pushl $0
  10271c:	6a 00                	push   $0x0
  pushl $210
  10271e:	68 d2 00 00 00       	push   $0xd2
  jmp __alltraps
  102723:	e9 8a f7 ff ff       	jmp    101eb2 <__alltraps>

00102728 <vector211>:
.globl vector211
vector211:
  pushl $0
  102728:	6a 00                	push   $0x0
  pushl $211
  10272a:	68 d3 00 00 00       	push   $0xd3
  jmp __alltraps
  10272f:	e9 7e f7 ff ff       	jmp    101eb2 <__alltraps>

00102734 <vector212>:
.globl vector212
vector212:
  pushl $0
  102734:	6a 00                	push   $0x0
  pushl $212
  102736:	68 d4 00 00 00       	push   $0xd4
  jmp __alltraps
  10273b:	e9 72 f7 ff ff       	jmp    101eb2 <__alltraps>

00102740 <vector213>:
.globl vector213
vector213:
  pushl $0
  102740:	6a 00                	push   $0x0
  pushl $213
  102742:	68 d5 00 00 00       	push   $0xd5
  jmp __alltraps
  102747:	e9 66 f7 ff ff       	jmp    101eb2 <__alltraps>

0010274c <vector214>:
.globl vector214
vector214:
  pushl $0
  10274c:	6a 00                	push   $0x0
  pushl $214
  10274e:	68 d6 00 00 00       	push   $0xd6
  jmp __alltraps
  102753:	e9 5a f7 ff ff       	jmp    101eb2 <__alltraps>

00102758 <vector215>:
.globl vector215
vector215:
  pushl $0
  102758:	6a 00                	push   $0x0
  pushl $215
  10275a:	68 d7 00 00 00       	push   $0xd7
  jmp __alltraps
  10275f:	e9 4e f7 ff ff       	jmp    101eb2 <__alltraps>

00102764 <vector216>:
.globl vector216
vector216:
  pushl $0
  102764:	6a 00                	push   $0x0
  pushl $216
  102766:	68 d8 00 00 00       	push   $0xd8
  jmp __alltraps
  10276b:	e9 42 f7 ff ff       	jmp    101eb2 <__alltraps>

00102770 <vector217>:
.globl vector217
vector217:
  pushl $0
  102770:	6a 00                	push   $0x0
  pushl $217
  102772:	68 d9 00 00 00       	push   $0xd9
  jmp __alltraps
  102777:	e9 36 f7 ff ff       	jmp    101eb2 <__alltraps>

0010277c <vector218>:
.globl vector218
vector218:
  pushl $0
  10277c:	6a 00                	push   $0x0
  pushl $218
  10277e:	68 da 00 00 00       	push   $0xda
  jmp __alltraps
  102783:	e9 2a f7 ff ff       	jmp    101eb2 <__alltraps>

00102788 <vector219>:
.globl vector219
vector219:
  pushl $0
  102788:	6a 00                	push   $0x0
  pushl $219
  10278a:	68 db 00 00 00       	push   $0xdb
  jmp __alltraps
  10278f:	e9 1e f7 ff ff       	jmp    101eb2 <__alltraps>

00102794 <vector220>:
.globl vector220
vector220:
  pushl $0
  102794:	6a 00                	push   $0x0
  pushl $220
  102796:	68 dc 00 00 00       	push   $0xdc
  jmp __alltraps
  10279b:	e9 12 f7 ff ff       	jmp    101eb2 <__alltraps>

001027a0 <vector221>:
.globl vector221
vector221:
  pushl $0
  1027a0:	6a 00                	push   $0x0
  pushl $221
  1027a2:	68 dd 00 00 00       	push   $0xdd
  jmp __alltraps
  1027a7:	e9 06 f7 ff ff       	jmp    101eb2 <__alltraps>

001027ac <vector222>:
.globl vector222
vector222:
  pushl $0
  1027ac:	6a 00                	push   $0x0
  pushl $222
  1027ae:	68 de 00 00 00       	push   $0xde
  jmp __alltraps
  1027b3:	e9 fa f6 ff ff       	jmp    101eb2 <__alltraps>

001027b8 <vector223>:
.globl vector223
vector223:
  pushl $0
  1027b8:	6a 00                	push   $0x0
  pushl $223
  1027ba:	68 df 00 00 00       	push   $0xdf
  jmp __alltraps
  1027bf:	e9 ee f6 ff ff       	jmp    101eb2 <__alltraps>

001027c4 <vector224>:
.globl vector224
vector224:
  pushl $0
  1027c4:	6a 00                	push   $0x0
  pushl $224
  1027c6:	68 e0 00 00 00       	push   $0xe0
  jmp __alltraps
  1027cb:	e9 e2 f6 ff ff       	jmp    101eb2 <__alltraps>

001027d0 <vector225>:
.globl vector225
vector225:
  pushl $0
  1027d0:	6a 00                	push   $0x0
  pushl $225
  1027d2:	68 e1 00 00 00       	push   $0xe1
  jmp __alltraps
  1027d7:	e9 d6 f6 ff ff       	jmp    101eb2 <__alltraps>

001027dc <vector226>:
.globl vector226
vector226:
  pushl $0
  1027dc:	6a 00                	push   $0x0
  pushl $226
  1027de:	68 e2 00 00 00       	push   $0xe2
  jmp __alltraps
  1027e3:	e9 ca f6 ff ff       	jmp    101eb2 <__alltraps>

001027e8 <vector227>:
.globl vector227
vector227:
  pushl $0
  1027e8:	6a 00                	push   $0x0
  pushl $227
  1027ea:	68 e3 00 00 00       	push   $0xe3
  jmp __alltraps
  1027ef:	e9 be f6 ff ff       	jmp    101eb2 <__alltraps>

001027f4 <vector228>:
.globl vector228
vector228:
  pushl $0
  1027f4:	6a 00                	push   $0x0
  pushl $228
  1027f6:	68 e4 00 00 00       	push   $0xe4
  jmp __alltraps
  1027fb:	e9 b2 f6 ff ff       	jmp    101eb2 <__alltraps>

00102800 <vector229>:
.globl vector229
vector229:
  pushl $0
  102800:	6a 00                	push   $0x0
  pushl $229
  102802:	68 e5 00 00 00       	push   $0xe5
  jmp __alltraps
  102807:	e9 a6 f6 ff ff       	jmp    101eb2 <__alltraps>

0010280c <vector230>:
.globl vector230
vector230:
  pushl $0
  10280c:	6a 00                	push   $0x0
  pushl $230
  10280e:	68 e6 00 00 00       	push   $0xe6
  jmp __alltraps
  102813:	e9 9a f6 ff ff       	jmp    101eb2 <__alltraps>

00102818 <vector231>:
.globl vector231
vector231:
  pushl $0
  102818:	6a 00                	push   $0x0
  pushl $231
  10281a:	68 e7 00 00 00       	push   $0xe7
  jmp __alltraps
  10281f:	e9 8e f6 ff ff       	jmp    101eb2 <__alltraps>

00102824 <vector232>:
.globl vector232
vector232:
  pushl $0
  102824:	6a 00                	push   $0x0
  pushl $232
  102826:	68 e8 00 00 00       	push   $0xe8
  jmp __alltraps
  10282b:	e9 82 f6 ff ff       	jmp    101eb2 <__alltraps>

00102830 <vector233>:
.globl vector233
vector233:
  pushl $0
  102830:	6a 00                	push   $0x0
  pushl $233
  102832:	68 e9 00 00 00       	push   $0xe9
  jmp __alltraps
  102837:	e9 76 f6 ff ff       	jmp    101eb2 <__alltraps>

0010283c <vector234>:
.globl vector234
vector234:
  pushl $0
  10283c:	6a 00                	push   $0x0
  pushl $234
  10283e:	68 ea 00 00 00       	push   $0xea
  jmp __alltraps
  102843:	e9 6a f6 ff ff       	jmp    101eb2 <__alltraps>

00102848 <vector235>:
.globl vector235
vector235:
  pushl $0
  102848:	6a 00                	push   $0x0
  pushl $235
  10284a:	68 eb 00 00 00       	push   $0xeb
  jmp __alltraps
  10284f:	e9 5e f6 ff ff       	jmp    101eb2 <__alltraps>

00102854 <vector236>:
.globl vector236
vector236:
  pushl $0
  102854:	6a 00                	push   $0x0
  pushl $236
  102856:	68 ec 00 00 00       	push   $0xec
  jmp __alltraps
  10285b:	e9 52 f6 ff ff       	jmp    101eb2 <__alltraps>

00102860 <vector237>:
.globl vector237
vector237:
  pushl $0
  102860:	6a 00                	push   $0x0
  pushl $237
  102862:	68 ed 00 00 00       	push   $0xed
  jmp __alltraps
  102867:	e9 46 f6 ff ff       	jmp    101eb2 <__alltraps>

0010286c <vector238>:
.globl vector238
vector238:
  pushl $0
  10286c:	6a 00                	push   $0x0
  pushl $238
  10286e:	68 ee 00 00 00       	push   $0xee
  jmp __alltraps
  102873:	e9 3a f6 ff ff       	jmp    101eb2 <__alltraps>

00102878 <vector239>:
.globl vector239
vector239:
  pushl $0
  102878:	6a 00                	push   $0x0
  pushl $239
  10287a:	68 ef 00 00 00       	push   $0xef
  jmp __alltraps
  10287f:	e9 2e f6 ff ff       	jmp    101eb2 <__alltraps>

00102884 <vector240>:
.globl vector240
vector240:
  pushl $0
  102884:	6a 00                	push   $0x0
  pushl $240
  102886:	68 f0 00 00 00       	push   $0xf0
  jmp __alltraps
  10288b:	e9 22 f6 ff ff       	jmp    101eb2 <__alltraps>

00102890 <vector241>:
.globl vector241
vector241:
  pushl $0
  102890:	6a 00                	push   $0x0
  pushl $241
  102892:	68 f1 00 00 00       	push   $0xf1
  jmp __alltraps
  102897:	e9 16 f6 ff ff       	jmp    101eb2 <__alltraps>

0010289c <vector242>:
.globl vector242
vector242:
  pushl $0
  10289c:	6a 00                	push   $0x0
  pushl $242
  10289e:	68 f2 00 00 00       	push   $0xf2
  jmp __alltraps
  1028a3:	e9 0a f6 ff ff       	jmp    101eb2 <__alltraps>

001028a8 <vector243>:
.globl vector243
vector243:
  pushl $0
  1028a8:	6a 00                	push   $0x0
  pushl $243
  1028aa:	68 f3 00 00 00       	push   $0xf3
  jmp __alltraps
  1028af:	e9 fe f5 ff ff       	jmp    101eb2 <__alltraps>

001028b4 <vector244>:
.globl vector244
vector244:
  pushl $0
  1028b4:	6a 00                	push   $0x0
  pushl $244
  1028b6:	68 f4 00 00 00       	push   $0xf4
  jmp __alltraps
  1028bb:	e9 f2 f5 ff ff       	jmp    101eb2 <__alltraps>

001028c0 <vector245>:
.globl vector245
vector245:
  pushl $0
  1028c0:	6a 00                	push   $0x0
  pushl $245
  1028c2:	68 f5 00 00 00       	push   $0xf5
  jmp __alltraps
  1028c7:	e9 e6 f5 ff ff       	jmp    101eb2 <__alltraps>

001028cc <vector246>:
.globl vector246
vector246:
  pushl $0
  1028cc:	6a 00                	push   $0x0
  pushl $246
  1028ce:	68 f6 00 00 00       	push   $0xf6
  jmp __alltraps
  1028d3:	e9 da f5 ff ff       	jmp    101eb2 <__alltraps>

001028d8 <vector247>:
.globl vector247
vector247:
  pushl $0
  1028d8:	6a 00                	push   $0x0
  pushl $247
  1028da:	68 f7 00 00 00       	push   $0xf7
  jmp __alltraps
  1028df:	e9 ce f5 ff ff       	jmp    101eb2 <__alltraps>

001028e4 <vector248>:
.globl vector248
vector248:
  pushl $0
  1028e4:	6a 00                	push   $0x0
  pushl $248
  1028e6:	68 f8 00 00 00       	push   $0xf8
  jmp __alltraps
  1028eb:	e9 c2 f5 ff ff       	jmp    101eb2 <__alltraps>

001028f0 <vector249>:
.globl vector249
vector249:
  pushl $0
  1028f0:	6a 00                	push   $0x0
  pushl $249
  1028f2:	68 f9 00 00 00       	push   $0xf9
  jmp __alltraps
  1028f7:	e9 b6 f5 ff ff       	jmp    101eb2 <__alltraps>

001028fc <vector250>:
.globl vector250
vector250:
  pushl $0
  1028fc:	6a 00                	push   $0x0
  pushl $250
  1028fe:	68 fa 00 00 00       	push   $0xfa
  jmp __alltraps
  102903:	e9 aa f5 ff ff       	jmp    101eb2 <__alltraps>

00102908 <vector251>:
.globl vector251
vector251:
  pushl $0
  102908:	6a 00                	push   $0x0
  pushl $251
  10290a:	68 fb 00 00 00       	push   $0xfb
  jmp __alltraps
  10290f:	e9 9e f5 ff ff       	jmp    101eb2 <__alltraps>

00102914 <vector252>:
.globl vector252
vector252:
  pushl $0
  102914:	6a 00                	push   $0x0
  pushl $252
  102916:	68 fc 00 00 00       	push   $0xfc
  jmp __alltraps
  10291b:	e9 92 f5 ff ff       	jmp    101eb2 <__alltraps>

00102920 <vector253>:
.globl vector253
vector253:
  pushl $0
  102920:	6a 00                	push   $0x0
  pushl $253
  102922:	68 fd 00 00 00       	push   $0xfd
  jmp __alltraps
  102927:	e9 86 f5 ff ff       	jmp    101eb2 <__alltraps>

0010292c <vector254>:
.globl vector254
vector254:
  pushl $0
  10292c:	6a 00                	push   $0x0
  pushl $254
  10292e:	68 fe 00 00 00       	push   $0xfe
  jmp __alltraps
  102933:	e9 7a f5 ff ff       	jmp    101eb2 <__alltraps>

00102938 <vector255>:
.globl vector255
vector255:
  pushl $0
  102938:	6a 00                	push   $0x0
  pushl $255
  10293a:	68 ff 00 00 00       	push   $0xff
  jmp __alltraps
  10293f:	e9 6e f5 ff ff       	jmp    101eb2 <__alltraps>

00102944 <lgdt>:
/* *
 * lgdt - load the global descriptor table register and reset the
 * data/code segement registers for kernel.
 * */
static inline void
lgdt(struct pseudodesc *pd) {
  102944:	55                   	push   %ebp
  102945:	89 e5                	mov    %esp,%ebp
    asm volatile ("lgdt (%0)" :: "r" (pd));
  102947:	8b 45 08             	mov    0x8(%ebp),%eax
  10294a:	0f 01 10             	lgdtl  (%eax)
    asm volatile ("movw %%ax, %%gs" :: "a" (USER_DS));
  10294d:	b8 23 00 00 00       	mov    $0x23,%eax
  102952:	8e e8                	mov    %eax,%gs
    asm volatile ("movw %%ax, %%fs" :: "a" (USER_DS));
  102954:	b8 23 00 00 00       	mov    $0x23,%eax
  102959:	8e e0                	mov    %eax,%fs
    asm volatile ("movw %%ax, %%es" :: "a" (KERNEL_DS));
  10295b:	b8 10 00 00 00       	mov    $0x10,%eax
  102960:	8e c0                	mov    %eax,%es
    asm volatile ("movw %%ax, %%ds" :: "a" (KERNEL_DS));
  102962:	b8 10 00 00 00       	mov    $0x10,%eax
  102967:	8e d8                	mov    %eax,%ds
    asm volatile ("movw %%ax, %%ss" :: "a" (KERNEL_DS));
  102969:	b8 10 00 00 00       	mov    $0x10,%eax
  10296e:	8e d0                	mov    %eax,%ss
    // reload cs
    asm volatile ("ljmp %0, $1f\n 1:\n" :: "i" (KERNEL_CS));
  102970:	ea 77 29 10 00 08 00 	ljmp   $0x8,$0x102977
}
  102977:	5d                   	pop    %ebp
  102978:	c3                   	ret    

00102979 <gdt_init>:
/* temporary kernel stack */
uint8_t stack0[1024];

/* gdt_init - initialize the default GDT and TSS */
static void
gdt_init(void) {
  102979:	55                   	push   %ebp
  10297a:	89 e5                	mov    %esp,%ebp
  10297c:	83 ec 14             	sub    $0x14,%esp
    // Setup a TSS so that we can get the right stack when we trap from
    // user to the kernel. But not safe here, it's only a temporary value,
    // it will be set to KSTACKTOP in lab2.
    ts.ts_esp0 = (uint32_t)&stack0 + sizeof(stack0);
  10297f:	b8 80 f9 10 00       	mov    $0x10f980,%eax
  102984:	05 00 04 00 00       	add    $0x400,%eax
  102989:	a3 a4 f8 10 00       	mov    %eax,0x10f8a4
    ts.ts_ss0 = KERNEL_DS;
  10298e:	66 c7 05 a8 f8 10 00 	movw   $0x10,0x10f8a8
  102995:	10 00 

    // initialize the TSS filed of the gdt
    gdt[SEG_TSS] = SEG16(STS_T32A, (uint32_t)&ts, sizeof(ts), DPL_KERNEL);
  102997:	66 c7 05 08 ea 10 00 	movw   $0x68,0x10ea08
  10299e:	68 00 
  1029a0:	b8 a0 f8 10 00       	mov    $0x10f8a0,%eax
  1029a5:	66 a3 0a ea 10 00    	mov    %ax,0x10ea0a
  1029ab:	b8 a0 f8 10 00       	mov    $0x10f8a0,%eax
  1029b0:	c1 e8 10             	shr    $0x10,%eax
  1029b3:	a2 0c ea 10 00       	mov    %al,0x10ea0c
  1029b8:	0f b6 05 0d ea 10 00 	movzbl 0x10ea0d,%eax
  1029bf:	83 e0 f0             	and    $0xfffffff0,%eax
  1029c2:	83 c8 09             	or     $0x9,%eax
  1029c5:	a2 0d ea 10 00       	mov    %al,0x10ea0d
  1029ca:	0f b6 05 0d ea 10 00 	movzbl 0x10ea0d,%eax
  1029d1:	83 c8 10             	or     $0x10,%eax
  1029d4:	a2 0d ea 10 00       	mov    %al,0x10ea0d
  1029d9:	0f b6 05 0d ea 10 00 	movzbl 0x10ea0d,%eax
  1029e0:	83 e0 9f             	and    $0xffffff9f,%eax
  1029e3:	a2 0d ea 10 00       	mov    %al,0x10ea0d
  1029e8:	0f b6 05 0d ea 10 00 	movzbl 0x10ea0d,%eax
  1029ef:	83 c8 80             	or     $0xffffff80,%eax
  1029f2:	a2 0d ea 10 00       	mov    %al,0x10ea0d
  1029f7:	0f b6 05 0e ea 10 00 	movzbl 0x10ea0e,%eax
  1029fe:	83 e0 f0             	and    $0xfffffff0,%eax
  102a01:	a2 0e ea 10 00       	mov    %al,0x10ea0e
  102a06:	0f b6 05 0e ea 10 00 	movzbl 0x10ea0e,%eax
  102a0d:	83 e0 ef             	and    $0xffffffef,%eax
  102a10:	a2 0e ea 10 00       	mov    %al,0x10ea0e
  102a15:	0f b6 05 0e ea 10 00 	movzbl 0x10ea0e,%eax
  102a1c:	83 e0 df             	and    $0xffffffdf,%eax
  102a1f:	a2 0e ea 10 00       	mov    %al,0x10ea0e
  102a24:	0f b6 05 0e ea 10 00 	movzbl 0x10ea0e,%eax
  102a2b:	83 c8 40             	or     $0x40,%eax
  102a2e:	a2 0e ea 10 00       	mov    %al,0x10ea0e
  102a33:	0f b6 05 0e ea 10 00 	movzbl 0x10ea0e,%eax
  102a3a:	83 e0 7f             	and    $0x7f,%eax
  102a3d:	a2 0e ea 10 00       	mov    %al,0x10ea0e
  102a42:	b8 a0 f8 10 00       	mov    $0x10f8a0,%eax
  102a47:	c1 e8 18             	shr    $0x18,%eax
  102a4a:	a2 0f ea 10 00       	mov    %al,0x10ea0f
    gdt[SEG_TSS].sd_s = 0;
  102a4f:	0f b6 05 0d ea 10 00 	movzbl 0x10ea0d,%eax
  102a56:	83 e0 ef             	and    $0xffffffef,%eax
  102a59:	a2 0d ea 10 00       	mov    %al,0x10ea0d

    // reload all segment registers
    lgdt(&gdt_pd);
  102a5e:	c7 04 24 10 ea 10 00 	movl   $0x10ea10,(%esp)
  102a65:	e8 da fe ff ff       	call   102944 <lgdt>
  102a6a:	66 c7 45 fe 28 00    	movw   $0x28,-0x2(%ebp)
    asm volatile ("cli");
}

static inline void
ltr(uint16_t sel) {
    asm volatile ("ltr %0" :: "r" (sel));
  102a70:	0f b7 45 fe          	movzwl -0x2(%ebp),%eax
  102a74:	0f 00 d8             	ltr    %ax

    // load the TSS
    ltr(GD_TSS);
}
  102a77:	c9                   	leave  
  102a78:	c3                   	ret    

00102a79 <pmm_init>:

/* pmm_init - initialize the physical memory management */
void
pmm_init(void) {
  102a79:	55                   	push   %ebp
  102a7a:	89 e5                	mov    %esp,%ebp
    gdt_init();
  102a7c:	e8 f8 fe ff ff       	call   102979 <gdt_init>
}
  102a81:	5d                   	pop    %ebp
  102a82:	c3                   	ret    

00102a83 <printnum>:
 * @width:         maximum number of digits, if the actual width is less than @width, use @padc instead
 * @padc:        character that padded on the left if the actual width is less than @width
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
  102a83:	55                   	push   %ebp
  102a84:	89 e5                	mov    %esp,%ebp
  102a86:	83 ec 58             	sub    $0x58,%esp
  102a89:	8b 45 10             	mov    0x10(%ebp),%eax
  102a8c:	89 45 d0             	mov    %eax,-0x30(%ebp)
  102a8f:	8b 45 14             	mov    0x14(%ebp),%eax
  102a92:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    unsigned long long result = num;
  102a95:	8b 45 d0             	mov    -0x30(%ebp),%eax
  102a98:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  102a9b:	89 45 e8             	mov    %eax,-0x18(%ebp)
  102a9e:	89 55 ec             	mov    %edx,-0x14(%ebp)
    unsigned mod = do_div(result, base);
  102aa1:	8b 45 18             	mov    0x18(%ebp),%eax
  102aa4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  102aa7:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102aaa:	8b 55 ec             	mov    -0x14(%ebp),%edx
  102aad:	89 45 e0             	mov    %eax,-0x20(%ebp)
  102ab0:	89 55 f0             	mov    %edx,-0x10(%ebp)
  102ab3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102ab6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102ab9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  102abd:	74 1c                	je     102adb <printnum+0x58>
  102abf:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102ac2:	ba 00 00 00 00       	mov    $0x0,%edx
  102ac7:	f7 75 e4             	divl   -0x1c(%ebp)
  102aca:	89 55 f4             	mov    %edx,-0xc(%ebp)
  102acd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102ad0:	ba 00 00 00 00       	mov    $0x0,%edx
  102ad5:	f7 75 e4             	divl   -0x1c(%ebp)
  102ad8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102adb:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102ade:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102ae1:	f7 75 e4             	divl   -0x1c(%ebp)
  102ae4:	89 45 e0             	mov    %eax,-0x20(%ebp)
  102ae7:	89 55 dc             	mov    %edx,-0x24(%ebp)
  102aea:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102aed:	8b 55 f0             	mov    -0x10(%ebp),%edx
  102af0:	89 45 e8             	mov    %eax,-0x18(%ebp)
  102af3:	89 55 ec             	mov    %edx,-0x14(%ebp)
  102af6:	8b 45 dc             	mov    -0x24(%ebp),%eax
  102af9:	89 45 d8             	mov    %eax,-0x28(%ebp)

    // first recursively print all preceding (more significant) digits
    if (num >= base) {
  102afc:	8b 45 18             	mov    0x18(%ebp),%eax
  102aff:	ba 00 00 00 00       	mov    $0x0,%edx
  102b04:	3b 55 d4             	cmp    -0x2c(%ebp),%edx
  102b07:	77 56                	ja     102b5f <printnum+0xdc>
  102b09:	3b 55 d4             	cmp    -0x2c(%ebp),%edx
  102b0c:	72 05                	jb     102b13 <printnum+0x90>
  102b0e:	3b 45 d0             	cmp    -0x30(%ebp),%eax
  102b11:	77 4c                	ja     102b5f <printnum+0xdc>
        printnum(putch, putdat, result, base, width - 1, padc);
  102b13:	8b 45 1c             	mov    0x1c(%ebp),%eax
  102b16:	8d 50 ff             	lea    -0x1(%eax),%edx
  102b19:	8b 45 20             	mov    0x20(%ebp),%eax
  102b1c:	89 44 24 18          	mov    %eax,0x18(%esp)
  102b20:	89 54 24 14          	mov    %edx,0x14(%esp)
  102b24:	8b 45 18             	mov    0x18(%ebp),%eax
  102b27:	89 44 24 10          	mov    %eax,0x10(%esp)
  102b2b:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102b2e:	8b 55 ec             	mov    -0x14(%ebp),%edx
  102b31:	89 44 24 08          	mov    %eax,0x8(%esp)
  102b35:	89 54 24 0c          	mov    %edx,0xc(%esp)
  102b39:	8b 45 0c             	mov    0xc(%ebp),%eax
  102b3c:	89 44 24 04          	mov    %eax,0x4(%esp)
  102b40:	8b 45 08             	mov    0x8(%ebp),%eax
  102b43:	89 04 24             	mov    %eax,(%esp)
  102b46:	e8 38 ff ff ff       	call   102a83 <printnum>
  102b4b:	eb 1c                	jmp    102b69 <printnum+0xe6>
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
            putch(padc, putdat);
  102b4d:	8b 45 0c             	mov    0xc(%ebp),%eax
  102b50:	89 44 24 04          	mov    %eax,0x4(%esp)
  102b54:	8b 45 20             	mov    0x20(%ebp),%eax
  102b57:	89 04 24             	mov    %eax,(%esp)
  102b5a:	8b 45 08             	mov    0x8(%ebp),%eax
  102b5d:	ff d0                	call   *%eax
    // first recursively print all preceding (more significant) digits
    if (num >= base) {
        printnum(putch, putdat, result, base, width - 1, padc);
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
  102b5f:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
  102b63:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  102b67:	7f e4                	jg     102b4d <printnum+0xca>
            putch(padc, putdat);
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
  102b69:	8b 45 d8             	mov    -0x28(%ebp),%eax
  102b6c:	05 70 3d 10 00       	add    $0x103d70,%eax
  102b71:	0f b6 00             	movzbl (%eax),%eax
  102b74:	0f be c0             	movsbl %al,%eax
  102b77:	8b 55 0c             	mov    0xc(%ebp),%edx
  102b7a:	89 54 24 04          	mov    %edx,0x4(%esp)
  102b7e:	89 04 24             	mov    %eax,(%esp)
  102b81:	8b 45 08             	mov    0x8(%ebp),%eax
  102b84:	ff d0                	call   *%eax
}
  102b86:	c9                   	leave  
  102b87:	c3                   	ret    

00102b88 <getuint>:
 * getuint - get an unsigned int of various possible sizes from a varargs list
 * @ap:            a varargs list pointer
 * @lflag:        determines the size of the vararg that @ap points to
 * */
static unsigned long long
getuint(va_list *ap, int lflag) {
  102b88:	55                   	push   %ebp
  102b89:	89 e5                	mov    %esp,%ebp
    if (lflag >= 2) {
  102b8b:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  102b8f:	7e 14                	jle    102ba5 <getuint+0x1d>
        return va_arg(*ap, unsigned long long);
  102b91:	8b 45 08             	mov    0x8(%ebp),%eax
  102b94:	8b 00                	mov    (%eax),%eax
  102b96:	8d 48 08             	lea    0x8(%eax),%ecx
  102b99:	8b 55 08             	mov    0x8(%ebp),%edx
  102b9c:	89 0a                	mov    %ecx,(%edx)
  102b9e:	8b 50 04             	mov    0x4(%eax),%edx
  102ba1:	8b 00                	mov    (%eax),%eax
  102ba3:	eb 30                	jmp    102bd5 <getuint+0x4d>
    }
    else if (lflag) {
  102ba5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  102ba9:	74 16                	je     102bc1 <getuint+0x39>
        return va_arg(*ap, unsigned long);
  102bab:	8b 45 08             	mov    0x8(%ebp),%eax
  102bae:	8b 00                	mov    (%eax),%eax
  102bb0:	8d 48 04             	lea    0x4(%eax),%ecx
  102bb3:	8b 55 08             	mov    0x8(%ebp),%edx
  102bb6:	89 0a                	mov    %ecx,(%edx)
  102bb8:	8b 00                	mov    (%eax),%eax
  102bba:	ba 00 00 00 00       	mov    $0x0,%edx
  102bbf:	eb 14                	jmp    102bd5 <getuint+0x4d>
    }
    else {
        return va_arg(*ap, unsigned int);
  102bc1:	8b 45 08             	mov    0x8(%ebp),%eax
  102bc4:	8b 00                	mov    (%eax),%eax
  102bc6:	8d 48 04             	lea    0x4(%eax),%ecx
  102bc9:	8b 55 08             	mov    0x8(%ebp),%edx
  102bcc:	89 0a                	mov    %ecx,(%edx)
  102bce:	8b 00                	mov    (%eax),%eax
  102bd0:	ba 00 00 00 00       	mov    $0x0,%edx
    }
}
  102bd5:	5d                   	pop    %ebp
  102bd6:	c3                   	ret    

00102bd7 <getint>:
 * getint - same as getuint but signed, we can't use getuint because of sign extension
 * @ap:            a varargs list pointer
 * @lflag:        determines the size of the vararg that @ap points to
 * */
static long long
getint(va_list *ap, int lflag) {
  102bd7:	55                   	push   %ebp
  102bd8:	89 e5                	mov    %esp,%ebp
    if (lflag >= 2) {
  102bda:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  102bde:	7e 14                	jle    102bf4 <getint+0x1d>
        return va_arg(*ap, long long);
  102be0:	8b 45 08             	mov    0x8(%ebp),%eax
  102be3:	8b 00                	mov    (%eax),%eax
  102be5:	8d 48 08             	lea    0x8(%eax),%ecx
  102be8:	8b 55 08             	mov    0x8(%ebp),%edx
  102beb:	89 0a                	mov    %ecx,(%edx)
  102bed:	8b 50 04             	mov    0x4(%eax),%edx
  102bf0:	8b 00                	mov    (%eax),%eax
  102bf2:	eb 28                	jmp    102c1c <getint+0x45>
    }
    else if (lflag) {
  102bf4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  102bf8:	74 12                	je     102c0c <getint+0x35>
        return va_arg(*ap, long);
  102bfa:	8b 45 08             	mov    0x8(%ebp),%eax
  102bfd:	8b 00                	mov    (%eax),%eax
  102bff:	8d 48 04             	lea    0x4(%eax),%ecx
  102c02:	8b 55 08             	mov    0x8(%ebp),%edx
  102c05:	89 0a                	mov    %ecx,(%edx)
  102c07:	8b 00                	mov    (%eax),%eax
  102c09:	99                   	cltd   
  102c0a:	eb 10                	jmp    102c1c <getint+0x45>
    }
    else {
        return va_arg(*ap, int);
  102c0c:	8b 45 08             	mov    0x8(%ebp),%eax
  102c0f:	8b 00                	mov    (%eax),%eax
  102c11:	8d 48 04             	lea    0x4(%eax),%ecx
  102c14:	8b 55 08             	mov    0x8(%ebp),%edx
  102c17:	89 0a                	mov    %ecx,(%edx)
  102c19:	8b 00                	mov    (%eax),%eax
  102c1b:	99                   	cltd   
    }
}
  102c1c:	5d                   	pop    %ebp
  102c1d:	c3                   	ret    

00102c1e <printfmt>:
 * @putch:        specified putch function, print a single character
 * @putdat:        used by @putch function
 * @fmt:        the format string to use
 * */
void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  102c1e:	55                   	push   %ebp
  102c1f:	89 e5                	mov    %esp,%ebp
  102c21:	83 ec 28             	sub    $0x28,%esp
    va_list ap;

    va_start(ap, fmt);
  102c24:	8d 45 14             	lea    0x14(%ebp),%eax
  102c27:	89 45 f4             	mov    %eax,-0xc(%ebp)
    vprintfmt(putch, putdat, fmt, ap);
  102c2a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102c2d:	89 44 24 0c          	mov    %eax,0xc(%esp)
  102c31:	8b 45 10             	mov    0x10(%ebp),%eax
  102c34:	89 44 24 08          	mov    %eax,0x8(%esp)
  102c38:	8b 45 0c             	mov    0xc(%ebp),%eax
  102c3b:	89 44 24 04          	mov    %eax,0x4(%esp)
  102c3f:	8b 45 08             	mov    0x8(%ebp),%eax
  102c42:	89 04 24             	mov    %eax,(%esp)
  102c45:	e8 02 00 00 00       	call   102c4c <vprintfmt>
    va_end(ap);
}
  102c4a:	c9                   	leave  
  102c4b:	c3                   	ret    

00102c4c <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
  102c4c:	55                   	push   %ebp
  102c4d:	89 e5                	mov    %esp,%ebp
  102c4f:	56                   	push   %esi
  102c50:	53                   	push   %ebx
  102c51:	83 ec 40             	sub    $0x40,%esp
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  102c54:	eb 18                	jmp    102c6e <vprintfmt+0x22>
            if (ch == '\0') {
  102c56:	85 db                	test   %ebx,%ebx
  102c58:	75 05                	jne    102c5f <vprintfmt+0x13>
                return;
  102c5a:	e9 d1 03 00 00       	jmp    103030 <vprintfmt+0x3e4>
            }
            putch(ch, putdat);
  102c5f:	8b 45 0c             	mov    0xc(%ebp),%eax
  102c62:	89 44 24 04          	mov    %eax,0x4(%esp)
  102c66:	89 1c 24             	mov    %ebx,(%esp)
  102c69:	8b 45 08             	mov    0x8(%ebp),%eax
  102c6c:	ff d0                	call   *%eax
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  102c6e:	8b 45 10             	mov    0x10(%ebp),%eax
  102c71:	8d 50 01             	lea    0x1(%eax),%edx
  102c74:	89 55 10             	mov    %edx,0x10(%ebp)
  102c77:	0f b6 00             	movzbl (%eax),%eax
  102c7a:	0f b6 d8             	movzbl %al,%ebx
  102c7d:	83 fb 25             	cmp    $0x25,%ebx
  102c80:	75 d4                	jne    102c56 <vprintfmt+0xa>
            }
            putch(ch, putdat);
        }

        // Process a %-escape sequence
        char padc = ' ';
  102c82:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
        width = precision = -1;
  102c86:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
  102c8d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  102c90:	89 45 e8             	mov    %eax,-0x18(%ebp)
        lflag = altflag = 0;
  102c93:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  102c9a:	8b 45 dc             	mov    -0x24(%ebp),%eax
  102c9d:	89 45 e0             	mov    %eax,-0x20(%ebp)

    reswitch:
        switch (ch = *(unsigned char *)fmt ++) {
  102ca0:	8b 45 10             	mov    0x10(%ebp),%eax
  102ca3:	8d 50 01             	lea    0x1(%eax),%edx
  102ca6:	89 55 10             	mov    %edx,0x10(%ebp)
  102ca9:	0f b6 00             	movzbl (%eax),%eax
  102cac:	0f b6 d8             	movzbl %al,%ebx
  102caf:	8d 43 dd             	lea    -0x23(%ebx),%eax
  102cb2:	83 f8 55             	cmp    $0x55,%eax
  102cb5:	0f 87 44 03 00 00    	ja     102fff <vprintfmt+0x3b3>
  102cbb:	8b 04 85 94 3d 10 00 	mov    0x103d94(,%eax,4),%eax
  102cc2:	ff e0                	jmp    *%eax

        // flag to pad on the right
        case '-':
            padc = '-';
  102cc4:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
            goto reswitch;
  102cc8:	eb d6                	jmp    102ca0 <vprintfmt+0x54>

        // flag to pad with 0's instead of spaces
        case '0':
            padc = '0';
  102cca:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
            goto reswitch;
  102cce:	eb d0                	jmp    102ca0 <vprintfmt+0x54>

        // width field
        case '1' ... '9':
            for (precision = 0; ; ++ fmt) {
  102cd0:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
                precision = precision * 10 + ch - '0';
  102cd7:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  102cda:	89 d0                	mov    %edx,%eax
  102cdc:	c1 e0 02             	shl    $0x2,%eax
  102cdf:	01 d0                	add    %edx,%eax
  102ce1:	01 c0                	add    %eax,%eax
  102ce3:	01 d8                	add    %ebx,%eax
  102ce5:	83 e8 30             	sub    $0x30,%eax
  102ce8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
                ch = *fmt;
  102ceb:	8b 45 10             	mov    0x10(%ebp),%eax
  102cee:	0f b6 00             	movzbl (%eax),%eax
  102cf1:	0f be d8             	movsbl %al,%ebx
                if (ch < '0' || ch > '9') {
  102cf4:	83 fb 2f             	cmp    $0x2f,%ebx
  102cf7:	7e 0b                	jle    102d04 <vprintfmt+0xb8>
  102cf9:	83 fb 39             	cmp    $0x39,%ebx
  102cfc:	7f 06                	jg     102d04 <vprintfmt+0xb8>
            padc = '0';
            goto reswitch;

        // width field
        case '1' ... '9':
            for (precision = 0; ; ++ fmt) {
  102cfe:	83 45 10 01          	addl   $0x1,0x10(%ebp)
                precision = precision * 10 + ch - '0';
                ch = *fmt;
                if (ch < '0' || ch > '9') {
                    break;
                }
            }
  102d02:	eb d3                	jmp    102cd7 <vprintfmt+0x8b>
            goto process_precision;
  102d04:	eb 33                	jmp    102d39 <vprintfmt+0xed>

        case '*':
            precision = va_arg(ap, int);
  102d06:	8b 45 14             	mov    0x14(%ebp),%eax
  102d09:	8d 50 04             	lea    0x4(%eax),%edx
  102d0c:	89 55 14             	mov    %edx,0x14(%ebp)
  102d0f:	8b 00                	mov    (%eax),%eax
  102d11:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            goto process_precision;
  102d14:	eb 23                	jmp    102d39 <vprintfmt+0xed>

        case '.':
            if (width < 0)
  102d16:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  102d1a:	79 0c                	jns    102d28 <vprintfmt+0xdc>
                width = 0;
  102d1c:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
            goto reswitch;
  102d23:	e9 78 ff ff ff       	jmp    102ca0 <vprintfmt+0x54>
  102d28:	e9 73 ff ff ff       	jmp    102ca0 <vprintfmt+0x54>

        case '#':
            altflag = 1;
  102d2d:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
            goto reswitch;
  102d34:	e9 67 ff ff ff       	jmp    102ca0 <vprintfmt+0x54>

        process_precision:
            if (width < 0)
  102d39:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  102d3d:	79 12                	jns    102d51 <vprintfmt+0x105>
                width = precision, precision = -1;
  102d3f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  102d42:	89 45 e8             	mov    %eax,-0x18(%ebp)
  102d45:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
            goto reswitch;
  102d4c:	e9 4f ff ff ff       	jmp    102ca0 <vprintfmt+0x54>
  102d51:	e9 4a ff ff ff       	jmp    102ca0 <vprintfmt+0x54>

        // long flag (doubled for long long)
        case 'l':
            lflag ++;
  102d56:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
            goto reswitch;
  102d5a:	e9 41 ff ff ff       	jmp    102ca0 <vprintfmt+0x54>

        // character
        case 'c':
            putch(va_arg(ap, int), putdat);
  102d5f:	8b 45 14             	mov    0x14(%ebp),%eax
  102d62:	8d 50 04             	lea    0x4(%eax),%edx
  102d65:	89 55 14             	mov    %edx,0x14(%ebp)
  102d68:	8b 00                	mov    (%eax),%eax
  102d6a:	8b 55 0c             	mov    0xc(%ebp),%edx
  102d6d:	89 54 24 04          	mov    %edx,0x4(%esp)
  102d71:	89 04 24             	mov    %eax,(%esp)
  102d74:	8b 45 08             	mov    0x8(%ebp),%eax
  102d77:	ff d0                	call   *%eax
            break;
  102d79:	e9 ac 02 00 00       	jmp    10302a <vprintfmt+0x3de>

        // error message
        case 'e':
            err = va_arg(ap, int);
  102d7e:	8b 45 14             	mov    0x14(%ebp),%eax
  102d81:	8d 50 04             	lea    0x4(%eax),%edx
  102d84:	89 55 14             	mov    %edx,0x14(%ebp)
  102d87:	8b 18                	mov    (%eax),%ebx
            if (err < 0) {
  102d89:	85 db                	test   %ebx,%ebx
  102d8b:	79 02                	jns    102d8f <vprintfmt+0x143>
                err = -err;
  102d8d:	f7 db                	neg    %ebx
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  102d8f:	83 fb 06             	cmp    $0x6,%ebx
  102d92:	7f 0b                	jg     102d9f <vprintfmt+0x153>
  102d94:	8b 34 9d 54 3d 10 00 	mov    0x103d54(,%ebx,4),%esi
  102d9b:	85 f6                	test   %esi,%esi
  102d9d:	75 23                	jne    102dc2 <vprintfmt+0x176>
                printfmt(putch, putdat, "error %d", err);
  102d9f:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
  102da3:	c7 44 24 08 81 3d 10 	movl   $0x103d81,0x8(%esp)
  102daa:	00 
  102dab:	8b 45 0c             	mov    0xc(%ebp),%eax
  102dae:	89 44 24 04          	mov    %eax,0x4(%esp)
  102db2:	8b 45 08             	mov    0x8(%ebp),%eax
  102db5:	89 04 24             	mov    %eax,(%esp)
  102db8:	e8 61 fe ff ff       	call   102c1e <printfmt>
            }
            else {
                printfmt(putch, putdat, "%s", p);
            }
            break;
  102dbd:	e9 68 02 00 00       	jmp    10302a <vprintfmt+0x3de>
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
                printfmt(putch, putdat, "error %d", err);
            }
            else {
                printfmt(putch, putdat, "%s", p);
  102dc2:	89 74 24 0c          	mov    %esi,0xc(%esp)
  102dc6:	c7 44 24 08 8a 3d 10 	movl   $0x103d8a,0x8(%esp)
  102dcd:	00 
  102dce:	8b 45 0c             	mov    0xc(%ebp),%eax
  102dd1:	89 44 24 04          	mov    %eax,0x4(%esp)
  102dd5:	8b 45 08             	mov    0x8(%ebp),%eax
  102dd8:	89 04 24             	mov    %eax,(%esp)
  102ddb:	e8 3e fe ff ff       	call   102c1e <printfmt>
            }
            break;
  102de0:	e9 45 02 00 00       	jmp    10302a <vprintfmt+0x3de>

        // string
        case 's':
            if ((p = va_arg(ap, char *)) == NULL) {
  102de5:	8b 45 14             	mov    0x14(%ebp),%eax
  102de8:	8d 50 04             	lea    0x4(%eax),%edx
  102deb:	89 55 14             	mov    %edx,0x14(%ebp)
  102dee:	8b 30                	mov    (%eax),%esi
  102df0:	85 f6                	test   %esi,%esi
  102df2:	75 05                	jne    102df9 <vprintfmt+0x1ad>
                p = "(null)";
  102df4:	be 8d 3d 10 00       	mov    $0x103d8d,%esi
            }
            if (width > 0 && padc != '-') {
  102df9:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  102dfd:	7e 3e                	jle    102e3d <vprintfmt+0x1f1>
  102dff:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  102e03:	74 38                	je     102e3d <vprintfmt+0x1f1>
                for (width -= strnlen(p, precision); width > 0; width --) {
  102e05:	8b 5d e8             	mov    -0x18(%ebp),%ebx
  102e08:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  102e0b:	89 44 24 04          	mov    %eax,0x4(%esp)
  102e0f:	89 34 24             	mov    %esi,(%esp)
  102e12:	e8 15 03 00 00       	call   10312c <strnlen>
  102e17:	29 c3                	sub    %eax,%ebx
  102e19:	89 d8                	mov    %ebx,%eax
  102e1b:	89 45 e8             	mov    %eax,-0x18(%ebp)
  102e1e:	eb 17                	jmp    102e37 <vprintfmt+0x1eb>
                    putch(padc, putdat);
  102e20:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  102e24:	8b 55 0c             	mov    0xc(%ebp),%edx
  102e27:	89 54 24 04          	mov    %edx,0x4(%esp)
  102e2b:	89 04 24             	mov    %eax,(%esp)
  102e2e:	8b 45 08             	mov    0x8(%ebp),%eax
  102e31:	ff d0                	call   *%eax
        case 's':
            if ((p = va_arg(ap, char *)) == NULL) {
                p = "(null)";
            }
            if (width > 0 && padc != '-') {
                for (width -= strnlen(p, precision); width > 0; width --) {
  102e33:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
  102e37:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  102e3b:	7f e3                	jg     102e20 <vprintfmt+0x1d4>
                    putch(padc, putdat);
                }
            }
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  102e3d:	eb 38                	jmp    102e77 <vprintfmt+0x22b>
                if (altflag && (ch < ' ' || ch > '~')) {
  102e3f:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  102e43:	74 1f                	je     102e64 <vprintfmt+0x218>
  102e45:	83 fb 1f             	cmp    $0x1f,%ebx
  102e48:	7e 05                	jle    102e4f <vprintfmt+0x203>
  102e4a:	83 fb 7e             	cmp    $0x7e,%ebx
  102e4d:	7e 15                	jle    102e64 <vprintfmt+0x218>
                    putch('?', putdat);
  102e4f:	8b 45 0c             	mov    0xc(%ebp),%eax
  102e52:	89 44 24 04          	mov    %eax,0x4(%esp)
  102e56:	c7 04 24 3f 00 00 00 	movl   $0x3f,(%esp)
  102e5d:	8b 45 08             	mov    0x8(%ebp),%eax
  102e60:	ff d0                	call   *%eax
  102e62:	eb 0f                	jmp    102e73 <vprintfmt+0x227>
                }
                else {
                    putch(ch, putdat);
  102e64:	8b 45 0c             	mov    0xc(%ebp),%eax
  102e67:	89 44 24 04          	mov    %eax,0x4(%esp)
  102e6b:	89 1c 24             	mov    %ebx,(%esp)
  102e6e:	8b 45 08             	mov    0x8(%ebp),%eax
  102e71:	ff d0                	call   *%eax
            if (width > 0 && padc != '-') {
                for (width -= strnlen(p, precision); width > 0; width --) {
                    putch(padc, putdat);
                }
            }
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  102e73:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
  102e77:	89 f0                	mov    %esi,%eax
  102e79:	8d 70 01             	lea    0x1(%eax),%esi
  102e7c:	0f b6 00             	movzbl (%eax),%eax
  102e7f:	0f be d8             	movsbl %al,%ebx
  102e82:	85 db                	test   %ebx,%ebx
  102e84:	74 10                	je     102e96 <vprintfmt+0x24a>
  102e86:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  102e8a:	78 b3                	js     102e3f <vprintfmt+0x1f3>
  102e8c:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
  102e90:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  102e94:	79 a9                	jns    102e3f <vprintfmt+0x1f3>
                }
                else {
                    putch(ch, putdat);
                }
            }
            for (; width > 0; width --) {
  102e96:	eb 17                	jmp    102eaf <vprintfmt+0x263>
                putch(' ', putdat);
  102e98:	8b 45 0c             	mov    0xc(%ebp),%eax
  102e9b:	89 44 24 04          	mov    %eax,0x4(%esp)
  102e9f:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  102ea6:	8b 45 08             	mov    0x8(%ebp),%eax
  102ea9:	ff d0                	call   *%eax
                }
                else {
                    putch(ch, putdat);
                }
            }
            for (; width > 0; width --) {
  102eab:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
  102eaf:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  102eb3:	7f e3                	jg     102e98 <vprintfmt+0x24c>
                putch(' ', putdat);
            }
            break;
  102eb5:	e9 70 01 00 00       	jmp    10302a <vprintfmt+0x3de>

        // (signed) decimal
        case 'd':
            num = getint(&ap, lflag);
  102eba:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102ebd:	89 44 24 04          	mov    %eax,0x4(%esp)
  102ec1:	8d 45 14             	lea    0x14(%ebp),%eax
  102ec4:	89 04 24             	mov    %eax,(%esp)
  102ec7:	e8 0b fd ff ff       	call   102bd7 <getint>
  102ecc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102ecf:	89 55 f4             	mov    %edx,-0xc(%ebp)
            if ((long long)num < 0) {
  102ed2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102ed5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102ed8:	85 d2                	test   %edx,%edx
  102eda:	79 26                	jns    102f02 <vprintfmt+0x2b6>
                putch('-', putdat);
  102edc:	8b 45 0c             	mov    0xc(%ebp),%eax
  102edf:	89 44 24 04          	mov    %eax,0x4(%esp)
  102ee3:	c7 04 24 2d 00 00 00 	movl   $0x2d,(%esp)
  102eea:	8b 45 08             	mov    0x8(%ebp),%eax
  102eed:	ff d0                	call   *%eax
                num = -(long long)num;
  102eef:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102ef2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102ef5:	f7 d8                	neg    %eax
  102ef7:	83 d2 00             	adc    $0x0,%edx
  102efa:	f7 da                	neg    %edx
  102efc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102eff:	89 55 f4             	mov    %edx,-0xc(%ebp)
            }
            base = 10;
  102f02:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
            goto number;
  102f09:	e9 a8 00 00 00       	jmp    102fb6 <vprintfmt+0x36a>

        // unsigned decimal
        case 'u':
            num = getuint(&ap, lflag);
  102f0e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102f11:	89 44 24 04          	mov    %eax,0x4(%esp)
  102f15:	8d 45 14             	lea    0x14(%ebp),%eax
  102f18:	89 04 24             	mov    %eax,(%esp)
  102f1b:	e8 68 fc ff ff       	call   102b88 <getuint>
  102f20:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102f23:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 10;
  102f26:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
            goto number;
  102f2d:	e9 84 00 00 00       	jmp    102fb6 <vprintfmt+0x36a>

        // (unsigned) octal
        case 'o':
            num = getuint(&ap, lflag);
  102f32:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102f35:	89 44 24 04          	mov    %eax,0x4(%esp)
  102f39:	8d 45 14             	lea    0x14(%ebp),%eax
  102f3c:	89 04 24             	mov    %eax,(%esp)
  102f3f:	e8 44 fc ff ff       	call   102b88 <getuint>
  102f44:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102f47:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 8;
  102f4a:	c7 45 ec 08 00 00 00 	movl   $0x8,-0x14(%ebp)
            goto number;
  102f51:	eb 63                	jmp    102fb6 <vprintfmt+0x36a>

        // pointer
        case 'p':
            putch('0', putdat);
  102f53:	8b 45 0c             	mov    0xc(%ebp),%eax
  102f56:	89 44 24 04          	mov    %eax,0x4(%esp)
  102f5a:	c7 04 24 30 00 00 00 	movl   $0x30,(%esp)
  102f61:	8b 45 08             	mov    0x8(%ebp),%eax
  102f64:	ff d0                	call   *%eax
            putch('x', putdat);
  102f66:	8b 45 0c             	mov    0xc(%ebp),%eax
  102f69:	89 44 24 04          	mov    %eax,0x4(%esp)
  102f6d:	c7 04 24 78 00 00 00 	movl   $0x78,(%esp)
  102f74:	8b 45 08             	mov    0x8(%ebp),%eax
  102f77:	ff d0                	call   *%eax
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
  102f79:	8b 45 14             	mov    0x14(%ebp),%eax
  102f7c:	8d 50 04             	lea    0x4(%eax),%edx
  102f7f:	89 55 14             	mov    %edx,0x14(%ebp)
  102f82:	8b 00                	mov    (%eax),%eax
  102f84:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102f87:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
            base = 16;
  102f8e:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
            goto number;
  102f95:	eb 1f                	jmp    102fb6 <vprintfmt+0x36a>

        // (unsigned) hexadecimal
        case 'x':
            num = getuint(&ap, lflag);
  102f97:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102f9a:	89 44 24 04          	mov    %eax,0x4(%esp)
  102f9e:	8d 45 14             	lea    0x14(%ebp),%eax
  102fa1:	89 04 24             	mov    %eax,(%esp)
  102fa4:	e8 df fb ff ff       	call   102b88 <getuint>
  102fa9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102fac:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 16;
  102faf:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
        number:
            printnum(putch, putdat, num, base, width, padc);
  102fb6:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  102fba:	8b 45 ec             	mov    -0x14(%ebp),%eax
  102fbd:	89 54 24 18          	mov    %edx,0x18(%esp)
  102fc1:	8b 55 e8             	mov    -0x18(%ebp),%edx
  102fc4:	89 54 24 14          	mov    %edx,0x14(%esp)
  102fc8:	89 44 24 10          	mov    %eax,0x10(%esp)
  102fcc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102fcf:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102fd2:	89 44 24 08          	mov    %eax,0x8(%esp)
  102fd6:	89 54 24 0c          	mov    %edx,0xc(%esp)
  102fda:	8b 45 0c             	mov    0xc(%ebp),%eax
  102fdd:	89 44 24 04          	mov    %eax,0x4(%esp)
  102fe1:	8b 45 08             	mov    0x8(%ebp),%eax
  102fe4:	89 04 24             	mov    %eax,(%esp)
  102fe7:	e8 97 fa ff ff       	call   102a83 <printnum>
            break;
  102fec:	eb 3c                	jmp    10302a <vprintfmt+0x3de>

        // escaped '%' character
        case '%':
            putch(ch, putdat);
  102fee:	8b 45 0c             	mov    0xc(%ebp),%eax
  102ff1:	89 44 24 04          	mov    %eax,0x4(%esp)
  102ff5:	89 1c 24             	mov    %ebx,(%esp)
  102ff8:	8b 45 08             	mov    0x8(%ebp),%eax
  102ffb:	ff d0                	call   *%eax
            break;
  102ffd:	eb 2b                	jmp    10302a <vprintfmt+0x3de>

        // unrecognized escape sequence - just print it literally
        default:
            putch('%', putdat);
  102fff:	8b 45 0c             	mov    0xc(%ebp),%eax
  103002:	89 44 24 04          	mov    %eax,0x4(%esp)
  103006:	c7 04 24 25 00 00 00 	movl   $0x25,(%esp)
  10300d:	8b 45 08             	mov    0x8(%ebp),%eax
  103010:	ff d0                	call   *%eax
            for (fmt --; fmt[-1] != '%'; fmt --)
  103012:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  103016:	eb 04                	jmp    10301c <vprintfmt+0x3d0>
  103018:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  10301c:	8b 45 10             	mov    0x10(%ebp),%eax
  10301f:	83 e8 01             	sub    $0x1,%eax
  103022:	0f b6 00             	movzbl (%eax),%eax
  103025:	3c 25                	cmp    $0x25,%al
  103027:	75 ef                	jne    103018 <vprintfmt+0x3cc>
                /* do nothing */;
            break;
  103029:	90                   	nop
        }
    }
  10302a:	90                   	nop
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  10302b:	e9 3e fc ff ff       	jmp    102c6e <vprintfmt+0x22>
            for (fmt --; fmt[-1] != '%'; fmt --)
                /* do nothing */;
            break;
        }
    }
}
  103030:	83 c4 40             	add    $0x40,%esp
  103033:	5b                   	pop    %ebx
  103034:	5e                   	pop    %esi
  103035:	5d                   	pop    %ebp
  103036:	c3                   	ret    

00103037 <sprintputch>:
 * sprintputch - 'print' a single character in a buffer
 * @ch:            the character will be printed
 * @b:            the buffer to place the character @ch
 * */
static void
sprintputch(int ch, struct sprintbuf *b) {
  103037:	55                   	push   %ebp
  103038:	89 e5                	mov    %esp,%ebp
    b->cnt ++;
  10303a:	8b 45 0c             	mov    0xc(%ebp),%eax
  10303d:	8b 40 08             	mov    0x8(%eax),%eax
  103040:	8d 50 01             	lea    0x1(%eax),%edx
  103043:	8b 45 0c             	mov    0xc(%ebp),%eax
  103046:	89 50 08             	mov    %edx,0x8(%eax)
    if (b->buf < b->ebuf) {
  103049:	8b 45 0c             	mov    0xc(%ebp),%eax
  10304c:	8b 10                	mov    (%eax),%edx
  10304e:	8b 45 0c             	mov    0xc(%ebp),%eax
  103051:	8b 40 04             	mov    0x4(%eax),%eax
  103054:	39 c2                	cmp    %eax,%edx
  103056:	73 12                	jae    10306a <sprintputch+0x33>
        *b->buf ++ = ch;
  103058:	8b 45 0c             	mov    0xc(%ebp),%eax
  10305b:	8b 00                	mov    (%eax),%eax
  10305d:	8d 48 01             	lea    0x1(%eax),%ecx
  103060:	8b 55 0c             	mov    0xc(%ebp),%edx
  103063:	89 0a                	mov    %ecx,(%edx)
  103065:	8b 55 08             	mov    0x8(%ebp),%edx
  103068:	88 10                	mov    %dl,(%eax)
    }
}
  10306a:	5d                   	pop    %ebp
  10306b:	c3                   	ret    

0010306c <snprintf>:
 * @str:        the buffer to place the result into
 * @size:        the size of buffer, including the trailing null space
 * @fmt:        the format string to use
 * */
int
snprintf(char *str, size_t size, const char *fmt, ...) {
  10306c:	55                   	push   %ebp
  10306d:	89 e5                	mov    %esp,%ebp
  10306f:	83 ec 28             	sub    $0x28,%esp
    va_list ap;
    int cnt;
    va_start(ap, fmt);
  103072:	8d 45 14             	lea    0x14(%ebp),%eax
  103075:	89 45 f0             	mov    %eax,-0x10(%ebp)
    cnt = vsnprintf(str, size, fmt, ap);
  103078:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10307b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  10307f:	8b 45 10             	mov    0x10(%ebp),%eax
  103082:	89 44 24 08          	mov    %eax,0x8(%esp)
  103086:	8b 45 0c             	mov    0xc(%ebp),%eax
  103089:	89 44 24 04          	mov    %eax,0x4(%esp)
  10308d:	8b 45 08             	mov    0x8(%ebp),%eax
  103090:	89 04 24             	mov    %eax,(%esp)
  103093:	e8 08 00 00 00       	call   1030a0 <vsnprintf>
  103098:	89 45 f4             	mov    %eax,-0xc(%ebp)
    va_end(ap);
    return cnt;
  10309b:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  10309e:	c9                   	leave  
  10309f:	c3                   	ret    

001030a0 <vsnprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want snprintf() instead.
 * */
int
vsnprintf(char *str, size_t size, const char *fmt, va_list ap) {
  1030a0:	55                   	push   %ebp
  1030a1:	89 e5                	mov    %esp,%ebp
  1030a3:	83 ec 28             	sub    $0x28,%esp
    struct sprintbuf b = {str, str + size - 1, 0};
  1030a6:	8b 45 08             	mov    0x8(%ebp),%eax
  1030a9:	89 45 ec             	mov    %eax,-0x14(%ebp)
  1030ac:	8b 45 0c             	mov    0xc(%ebp),%eax
  1030af:	8d 50 ff             	lea    -0x1(%eax),%edx
  1030b2:	8b 45 08             	mov    0x8(%ebp),%eax
  1030b5:	01 d0                	add    %edx,%eax
  1030b7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1030ba:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if (str == NULL || b.buf > b.ebuf) {
  1030c1:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  1030c5:	74 0a                	je     1030d1 <vsnprintf+0x31>
  1030c7:	8b 55 ec             	mov    -0x14(%ebp),%edx
  1030ca:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1030cd:	39 c2                	cmp    %eax,%edx
  1030cf:	76 07                	jbe    1030d8 <vsnprintf+0x38>
        return -E_INVAL;
  1030d1:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  1030d6:	eb 2a                	jmp    103102 <vsnprintf+0x62>
    }
    // print the string to the buffer
    vprintfmt((void*)sprintputch, &b, fmt, ap);
  1030d8:	8b 45 14             	mov    0x14(%ebp),%eax
  1030db:	89 44 24 0c          	mov    %eax,0xc(%esp)
  1030df:	8b 45 10             	mov    0x10(%ebp),%eax
  1030e2:	89 44 24 08          	mov    %eax,0x8(%esp)
  1030e6:	8d 45 ec             	lea    -0x14(%ebp),%eax
  1030e9:	89 44 24 04          	mov    %eax,0x4(%esp)
  1030ed:	c7 04 24 37 30 10 00 	movl   $0x103037,(%esp)
  1030f4:	e8 53 fb ff ff       	call   102c4c <vprintfmt>
    // null terminate the buffer
    *b.buf = '\0';
  1030f9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1030fc:	c6 00 00             	movb   $0x0,(%eax)
    return b.cnt;
  1030ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  103102:	c9                   	leave  
  103103:	c3                   	ret    

00103104 <strlen>:
 * @s:        the input string
 *
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
  103104:	55                   	push   %ebp
  103105:	89 e5                	mov    %esp,%ebp
  103107:	83 ec 10             	sub    $0x10,%esp
    size_t cnt = 0;
  10310a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (*s ++ != '\0') {
  103111:	eb 04                	jmp    103117 <strlen+0x13>
        cnt ++;
  103113:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
    size_t cnt = 0;
    while (*s ++ != '\0') {
  103117:	8b 45 08             	mov    0x8(%ebp),%eax
  10311a:	8d 50 01             	lea    0x1(%eax),%edx
  10311d:	89 55 08             	mov    %edx,0x8(%ebp)
  103120:	0f b6 00             	movzbl (%eax),%eax
  103123:	84 c0                	test   %al,%al
  103125:	75 ec                	jne    103113 <strlen+0xf>
        cnt ++;
    }
    return cnt;
  103127:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  10312a:	c9                   	leave  
  10312b:	c3                   	ret    

0010312c <strnlen>:
 * The return value is strlen(s), if that is less than @len, or
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
  10312c:	55                   	push   %ebp
  10312d:	89 e5                	mov    %esp,%ebp
  10312f:	83 ec 10             	sub    $0x10,%esp
    size_t cnt = 0;
  103132:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (cnt < len && *s ++ != '\0') {
  103139:	eb 04                	jmp    10313f <strnlen+0x13>
        cnt ++;
  10313b:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
    size_t cnt = 0;
    while (cnt < len && *s ++ != '\0') {
  10313f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  103142:	3b 45 0c             	cmp    0xc(%ebp),%eax
  103145:	73 10                	jae    103157 <strnlen+0x2b>
  103147:	8b 45 08             	mov    0x8(%ebp),%eax
  10314a:	8d 50 01             	lea    0x1(%eax),%edx
  10314d:	89 55 08             	mov    %edx,0x8(%ebp)
  103150:	0f b6 00             	movzbl (%eax),%eax
  103153:	84 c0                	test   %al,%al
  103155:	75 e4                	jne    10313b <strnlen+0xf>
        cnt ++;
    }
    return cnt;
  103157:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  10315a:	c9                   	leave  
  10315b:	c3                   	ret    

0010315c <strcpy>:
 * To avoid overflows, the size of array pointed by @dst should be long enough to
 * contain the same string as @src (including the terminating null character), and
 * should not overlap in memory with @src.
 * */
char *
strcpy(char *dst, const char *src) {
  10315c:	55                   	push   %ebp
  10315d:	89 e5                	mov    %esp,%ebp
  10315f:	57                   	push   %edi
  103160:	56                   	push   %esi
  103161:	83 ec 20             	sub    $0x20,%esp
  103164:	8b 45 08             	mov    0x8(%ebp),%eax
  103167:	89 45 f4             	mov    %eax,-0xc(%ebp)
  10316a:	8b 45 0c             	mov    0xc(%ebp),%eax
  10316d:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_STRCPY
#define __HAVE_ARCH_STRCPY
static inline char *
__strcpy(char *dst, const char *src) {
    int d0, d1, d2;
    asm volatile (
  103170:	8b 55 f0             	mov    -0x10(%ebp),%edx
  103173:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103176:	89 d1                	mov    %edx,%ecx
  103178:	89 c2                	mov    %eax,%edx
  10317a:	89 ce                	mov    %ecx,%esi
  10317c:	89 d7                	mov    %edx,%edi
  10317e:	ac                   	lods   %ds:(%esi),%al
  10317f:	aa                   	stos   %al,%es:(%edi)
  103180:	84 c0                	test   %al,%al
  103182:	75 fa                	jne    10317e <strcpy+0x22>
  103184:	89 fa                	mov    %edi,%edx
  103186:	89 f1                	mov    %esi,%ecx
  103188:	89 4d ec             	mov    %ecx,-0x14(%ebp)
  10318b:	89 55 e8             	mov    %edx,-0x18(%ebp)
  10318e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "stosb;"
            "testb %%al, %%al;"
            "jne 1b;"
            : "=&S" (d0), "=&D" (d1), "=&a" (d2)
            : "0" (src), "1" (dst) : "memory");
    return dst;
  103191:	8b 45 f4             	mov    -0xc(%ebp),%eax
    char *p = dst;
    while ((*p ++ = *src ++) != '\0')
        /* nothing */;
    return dst;
#endif /* __HAVE_ARCH_STRCPY */
}
  103194:	83 c4 20             	add    $0x20,%esp
  103197:	5e                   	pop    %esi
  103198:	5f                   	pop    %edi
  103199:	5d                   	pop    %ebp
  10319a:	c3                   	ret    

0010319b <strncpy>:
 * @len:    maximum number of characters to be copied from @src
 *
 * The return value is @dst
 * */
char *
strncpy(char *dst, const char *src, size_t len) {
  10319b:	55                   	push   %ebp
  10319c:	89 e5                	mov    %esp,%ebp
  10319e:	83 ec 10             	sub    $0x10,%esp
    char *p = dst;
  1031a1:	8b 45 08             	mov    0x8(%ebp),%eax
  1031a4:	89 45 fc             	mov    %eax,-0x4(%ebp)
    while (len > 0) {
  1031a7:	eb 21                	jmp    1031ca <strncpy+0x2f>
        if ((*p = *src) != '\0') {
  1031a9:	8b 45 0c             	mov    0xc(%ebp),%eax
  1031ac:	0f b6 10             	movzbl (%eax),%edx
  1031af:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1031b2:	88 10                	mov    %dl,(%eax)
  1031b4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1031b7:	0f b6 00             	movzbl (%eax),%eax
  1031ba:	84 c0                	test   %al,%al
  1031bc:	74 04                	je     1031c2 <strncpy+0x27>
            src ++;
  1031be:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
        }
        p ++, len --;
  1031c2:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  1031c6:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
 * The return value is @dst
 * */
char *
strncpy(char *dst, const char *src, size_t len) {
    char *p = dst;
    while (len > 0) {
  1031ca:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  1031ce:	75 d9                	jne    1031a9 <strncpy+0xe>
        if ((*p = *src) != '\0') {
            src ++;
        }
        p ++, len --;
    }
    return dst;
  1031d0:	8b 45 08             	mov    0x8(%ebp),%eax
}
  1031d3:	c9                   	leave  
  1031d4:	c3                   	ret    

001031d5 <strcmp>:
 * - A value greater than zero indicates that the first character that does
 *   not match has a greater value in @s1 than in @s2;
 * - And a value less than zero indicates the opposite.
 * */
int
strcmp(const char *s1, const char *s2) {
  1031d5:	55                   	push   %ebp
  1031d6:	89 e5                	mov    %esp,%ebp
  1031d8:	57                   	push   %edi
  1031d9:	56                   	push   %esi
  1031da:	83 ec 20             	sub    $0x20,%esp
  1031dd:	8b 45 08             	mov    0x8(%ebp),%eax
  1031e0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1031e3:	8b 45 0c             	mov    0xc(%ebp),%eax
  1031e6:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_STRCMP
#define __HAVE_ARCH_STRCMP
static inline int
__strcmp(const char *s1, const char *s2) {
    int d0, d1, ret;
    asm volatile (
  1031e9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1031ec:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1031ef:	89 d1                	mov    %edx,%ecx
  1031f1:	89 c2                	mov    %eax,%edx
  1031f3:	89 ce                	mov    %ecx,%esi
  1031f5:	89 d7                	mov    %edx,%edi
  1031f7:	ac                   	lods   %ds:(%esi),%al
  1031f8:	ae                   	scas   %es:(%edi),%al
  1031f9:	75 08                	jne    103203 <strcmp+0x2e>
  1031fb:	84 c0                	test   %al,%al
  1031fd:	75 f8                	jne    1031f7 <strcmp+0x22>
  1031ff:	31 c0                	xor    %eax,%eax
  103201:	eb 04                	jmp    103207 <strcmp+0x32>
  103203:	19 c0                	sbb    %eax,%eax
  103205:	0c 01                	or     $0x1,%al
  103207:	89 fa                	mov    %edi,%edx
  103209:	89 f1                	mov    %esi,%ecx
  10320b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  10320e:	89 4d e8             	mov    %ecx,-0x18(%ebp)
  103211:	89 55 e4             	mov    %edx,-0x1c(%ebp)
            "orb $1, %%al;"
            "3:"
            : "=a" (ret), "=&S" (d0), "=&D" (d1)
            : "1" (s1), "2" (s2)
            : "memory");
    return ret;
  103214:	8b 45 ec             	mov    -0x14(%ebp),%eax
    while (*s1 != '\0' && *s1 == *s2) {
        s1 ++, s2 ++;
    }
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
#endif /* __HAVE_ARCH_STRCMP */
}
  103217:	83 c4 20             	add    $0x20,%esp
  10321a:	5e                   	pop    %esi
  10321b:	5f                   	pop    %edi
  10321c:	5d                   	pop    %ebp
  10321d:	c3                   	ret    

0010321e <strncmp>:
 * they are equal to each other, it continues with the following pairs until
 * the characters differ, until a terminating null-character is reached, or
 * until @n characters match in both strings, whichever happens first.
 * */
int
strncmp(const char *s1, const char *s2, size_t n) {
  10321e:	55                   	push   %ebp
  10321f:	89 e5                	mov    %esp,%ebp
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
  103221:	eb 0c                	jmp    10322f <strncmp+0x11>
        n --, s1 ++, s2 ++;
  103223:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  103227:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  10322b:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
 * the characters differ, until a terminating null-character is reached, or
 * until @n characters match in both strings, whichever happens first.
 * */
int
strncmp(const char *s1, const char *s2, size_t n) {
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
  10322f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  103233:	74 1a                	je     10324f <strncmp+0x31>
  103235:	8b 45 08             	mov    0x8(%ebp),%eax
  103238:	0f b6 00             	movzbl (%eax),%eax
  10323b:	84 c0                	test   %al,%al
  10323d:	74 10                	je     10324f <strncmp+0x31>
  10323f:	8b 45 08             	mov    0x8(%ebp),%eax
  103242:	0f b6 10             	movzbl (%eax),%edx
  103245:	8b 45 0c             	mov    0xc(%ebp),%eax
  103248:	0f b6 00             	movzbl (%eax),%eax
  10324b:	38 c2                	cmp    %al,%dl
  10324d:	74 d4                	je     103223 <strncmp+0x5>
        n --, s1 ++, s2 ++;
    }
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
  10324f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  103253:	74 18                	je     10326d <strncmp+0x4f>
  103255:	8b 45 08             	mov    0x8(%ebp),%eax
  103258:	0f b6 00             	movzbl (%eax),%eax
  10325b:	0f b6 d0             	movzbl %al,%edx
  10325e:	8b 45 0c             	mov    0xc(%ebp),%eax
  103261:	0f b6 00             	movzbl (%eax),%eax
  103264:	0f b6 c0             	movzbl %al,%eax
  103267:	29 c2                	sub    %eax,%edx
  103269:	89 d0                	mov    %edx,%eax
  10326b:	eb 05                	jmp    103272 <strncmp+0x54>
  10326d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  103272:	5d                   	pop    %ebp
  103273:	c3                   	ret    

00103274 <strchr>:
 *
 * The strchr() function returns a pointer to the first occurrence of
 * character in @s. If the value is not found, the function returns 'NULL'.
 * */
char *
strchr(const char *s, char c) {
  103274:	55                   	push   %ebp
  103275:	89 e5                	mov    %esp,%ebp
  103277:	83 ec 04             	sub    $0x4,%esp
  10327a:	8b 45 0c             	mov    0xc(%ebp),%eax
  10327d:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
  103280:	eb 14                	jmp    103296 <strchr+0x22>
        if (*s == c) {
  103282:	8b 45 08             	mov    0x8(%ebp),%eax
  103285:	0f b6 00             	movzbl (%eax),%eax
  103288:	3a 45 fc             	cmp    -0x4(%ebp),%al
  10328b:	75 05                	jne    103292 <strchr+0x1e>
            return (char *)s;
  10328d:	8b 45 08             	mov    0x8(%ebp),%eax
  103290:	eb 13                	jmp    1032a5 <strchr+0x31>
        }
        s ++;
  103292:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 * The strchr() function returns a pointer to the first occurrence of
 * character in @s. If the value is not found, the function returns 'NULL'.
 * */
char *
strchr(const char *s, char c) {
    while (*s != '\0') {
  103296:	8b 45 08             	mov    0x8(%ebp),%eax
  103299:	0f b6 00             	movzbl (%eax),%eax
  10329c:	84 c0                	test   %al,%al
  10329e:	75 e2                	jne    103282 <strchr+0xe>
        if (*s == c) {
            return (char *)s;
        }
        s ++;
    }
    return NULL;
  1032a0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  1032a5:	c9                   	leave  
  1032a6:	c3                   	ret    

001032a7 <strfind>:
 * The strfind() function is like strchr() except that if @c is
 * not found in @s, then it returns a pointer to the null byte at the
 * end of @s, rather than 'NULL'.
 * */
char *
strfind(const char *s, char c) {
  1032a7:	55                   	push   %ebp
  1032a8:	89 e5                	mov    %esp,%ebp
  1032aa:	83 ec 04             	sub    $0x4,%esp
  1032ad:	8b 45 0c             	mov    0xc(%ebp),%eax
  1032b0:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
  1032b3:	eb 11                	jmp    1032c6 <strfind+0x1f>
        if (*s == c) {
  1032b5:	8b 45 08             	mov    0x8(%ebp),%eax
  1032b8:	0f b6 00             	movzbl (%eax),%eax
  1032bb:	3a 45 fc             	cmp    -0x4(%ebp),%al
  1032be:	75 02                	jne    1032c2 <strfind+0x1b>
            break;
  1032c0:	eb 0e                	jmp    1032d0 <strfind+0x29>
        }
        s ++;
  1032c2:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 * not found in @s, then it returns a pointer to the null byte at the
 * end of @s, rather than 'NULL'.
 * */
char *
strfind(const char *s, char c) {
    while (*s != '\0') {
  1032c6:	8b 45 08             	mov    0x8(%ebp),%eax
  1032c9:	0f b6 00             	movzbl (%eax),%eax
  1032cc:	84 c0                	test   %al,%al
  1032ce:	75 e5                	jne    1032b5 <strfind+0xe>
        if (*s == c) {
            break;
        }
        s ++;
    }
    return (char *)s;
  1032d0:	8b 45 08             	mov    0x8(%ebp),%eax
}
  1032d3:	c9                   	leave  
  1032d4:	c3                   	ret    

001032d5 <strtol>:
 * an optional "0x" or "0X" prefix.
 *
 * The strtol() function returns the converted integral number as a long int value.
 * */
long
strtol(const char *s, char **endptr, int base) {
  1032d5:	55                   	push   %ebp
  1032d6:	89 e5                	mov    %esp,%ebp
  1032d8:	83 ec 10             	sub    $0x10,%esp
    int neg = 0;
  1032db:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    long val = 0;
  1032e2:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t') {
  1032e9:	eb 04                	jmp    1032ef <strtol+0x1a>
        s ++;
  1032eb:	83 45 08 01          	addl   $0x1,0x8(%ebp)
strtol(const char *s, char **endptr, int base) {
    int neg = 0;
    long val = 0;

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t') {
  1032ef:	8b 45 08             	mov    0x8(%ebp),%eax
  1032f2:	0f b6 00             	movzbl (%eax),%eax
  1032f5:	3c 20                	cmp    $0x20,%al
  1032f7:	74 f2                	je     1032eb <strtol+0x16>
  1032f9:	8b 45 08             	mov    0x8(%ebp),%eax
  1032fc:	0f b6 00             	movzbl (%eax),%eax
  1032ff:	3c 09                	cmp    $0x9,%al
  103301:	74 e8                	je     1032eb <strtol+0x16>
        s ++;
    }

    // plus/minus sign
    if (*s == '+') {
  103303:	8b 45 08             	mov    0x8(%ebp),%eax
  103306:	0f b6 00             	movzbl (%eax),%eax
  103309:	3c 2b                	cmp    $0x2b,%al
  10330b:	75 06                	jne    103313 <strtol+0x3e>
        s ++;
  10330d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  103311:	eb 15                	jmp    103328 <strtol+0x53>
    }
    else if (*s == '-') {
  103313:	8b 45 08             	mov    0x8(%ebp),%eax
  103316:	0f b6 00             	movzbl (%eax),%eax
  103319:	3c 2d                	cmp    $0x2d,%al
  10331b:	75 0b                	jne    103328 <strtol+0x53>
        s ++, neg = 1;
  10331d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  103321:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
    }

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x')) {
  103328:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  10332c:	74 06                	je     103334 <strtol+0x5f>
  10332e:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  103332:	75 24                	jne    103358 <strtol+0x83>
  103334:	8b 45 08             	mov    0x8(%ebp),%eax
  103337:	0f b6 00             	movzbl (%eax),%eax
  10333a:	3c 30                	cmp    $0x30,%al
  10333c:	75 1a                	jne    103358 <strtol+0x83>
  10333e:	8b 45 08             	mov    0x8(%ebp),%eax
  103341:	83 c0 01             	add    $0x1,%eax
  103344:	0f b6 00             	movzbl (%eax),%eax
  103347:	3c 78                	cmp    $0x78,%al
  103349:	75 0d                	jne    103358 <strtol+0x83>
        s += 2, base = 16;
  10334b:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  10334f:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  103356:	eb 2a                	jmp    103382 <strtol+0xad>
    }
    else if (base == 0 && s[0] == '0') {
  103358:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  10335c:	75 17                	jne    103375 <strtol+0xa0>
  10335e:	8b 45 08             	mov    0x8(%ebp),%eax
  103361:	0f b6 00             	movzbl (%eax),%eax
  103364:	3c 30                	cmp    $0x30,%al
  103366:	75 0d                	jne    103375 <strtol+0xa0>
        s ++, base = 8;
  103368:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  10336c:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  103373:	eb 0d                	jmp    103382 <strtol+0xad>
    }
    else if (base == 0) {
  103375:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  103379:	75 07                	jne    103382 <strtol+0xad>
        base = 10;
  10337b:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9') {
  103382:	8b 45 08             	mov    0x8(%ebp),%eax
  103385:	0f b6 00             	movzbl (%eax),%eax
  103388:	3c 2f                	cmp    $0x2f,%al
  10338a:	7e 1b                	jle    1033a7 <strtol+0xd2>
  10338c:	8b 45 08             	mov    0x8(%ebp),%eax
  10338f:	0f b6 00             	movzbl (%eax),%eax
  103392:	3c 39                	cmp    $0x39,%al
  103394:	7f 11                	jg     1033a7 <strtol+0xd2>
            dig = *s - '0';
  103396:	8b 45 08             	mov    0x8(%ebp),%eax
  103399:	0f b6 00             	movzbl (%eax),%eax
  10339c:	0f be c0             	movsbl %al,%eax
  10339f:	83 e8 30             	sub    $0x30,%eax
  1033a2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1033a5:	eb 48                	jmp    1033ef <strtol+0x11a>
        }
        else if (*s >= 'a' && *s <= 'z') {
  1033a7:	8b 45 08             	mov    0x8(%ebp),%eax
  1033aa:	0f b6 00             	movzbl (%eax),%eax
  1033ad:	3c 60                	cmp    $0x60,%al
  1033af:	7e 1b                	jle    1033cc <strtol+0xf7>
  1033b1:	8b 45 08             	mov    0x8(%ebp),%eax
  1033b4:	0f b6 00             	movzbl (%eax),%eax
  1033b7:	3c 7a                	cmp    $0x7a,%al
  1033b9:	7f 11                	jg     1033cc <strtol+0xf7>
            dig = *s - 'a' + 10;
  1033bb:	8b 45 08             	mov    0x8(%ebp),%eax
  1033be:	0f b6 00             	movzbl (%eax),%eax
  1033c1:	0f be c0             	movsbl %al,%eax
  1033c4:	83 e8 57             	sub    $0x57,%eax
  1033c7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1033ca:	eb 23                	jmp    1033ef <strtol+0x11a>
        }
        else if (*s >= 'A' && *s <= 'Z') {
  1033cc:	8b 45 08             	mov    0x8(%ebp),%eax
  1033cf:	0f b6 00             	movzbl (%eax),%eax
  1033d2:	3c 40                	cmp    $0x40,%al
  1033d4:	7e 3d                	jle    103413 <strtol+0x13e>
  1033d6:	8b 45 08             	mov    0x8(%ebp),%eax
  1033d9:	0f b6 00             	movzbl (%eax),%eax
  1033dc:	3c 5a                	cmp    $0x5a,%al
  1033de:	7f 33                	jg     103413 <strtol+0x13e>
            dig = *s - 'A' + 10;
  1033e0:	8b 45 08             	mov    0x8(%ebp),%eax
  1033e3:	0f b6 00             	movzbl (%eax),%eax
  1033e6:	0f be c0             	movsbl %al,%eax
  1033e9:	83 e8 37             	sub    $0x37,%eax
  1033ec:	89 45 f4             	mov    %eax,-0xc(%ebp)
        }
        else {
            break;
        }
        if (dig >= base) {
  1033ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1033f2:	3b 45 10             	cmp    0x10(%ebp),%eax
  1033f5:	7c 02                	jl     1033f9 <strtol+0x124>
            break;
  1033f7:	eb 1a                	jmp    103413 <strtol+0x13e>
        }
        s ++, val = (val * base) + dig;
  1033f9:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  1033fd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  103400:	0f af 45 10          	imul   0x10(%ebp),%eax
  103404:	89 c2                	mov    %eax,%edx
  103406:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103409:	01 d0                	add    %edx,%eax
  10340b:	89 45 f8             	mov    %eax,-0x8(%ebp)
        // we don't properly detect overflow!
    }
  10340e:	e9 6f ff ff ff       	jmp    103382 <strtol+0xad>

    if (endptr) {
  103413:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  103417:	74 08                	je     103421 <strtol+0x14c>
        *endptr = (char *) s;
  103419:	8b 45 0c             	mov    0xc(%ebp),%eax
  10341c:	8b 55 08             	mov    0x8(%ebp),%edx
  10341f:	89 10                	mov    %edx,(%eax)
    }
    return (neg ? -val : val);
  103421:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  103425:	74 07                	je     10342e <strtol+0x159>
  103427:	8b 45 f8             	mov    -0x8(%ebp),%eax
  10342a:	f7 d8                	neg    %eax
  10342c:	eb 03                	jmp    103431 <strtol+0x15c>
  10342e:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  103431:	c9                   	leave  
  103432:	c3                   	ret    

00103433 <memset>:
 * @n:        number of bytes to be set to the value
 *
 * The memset() function returns @s.
 * */
void *
memset(void *s, char c, size_t n) {
  103433:	55                   	push   %ebp
  103434:	89 e5                	mov    %esp,%ebp
  103436:	57                   	push   %edi
  103437:	83 ec 24             	sub    $0x24,%esp
  10343a:	8b 45 0c             	mov    0xc(%ebp),%eax
  10343d:	88 45 d8             	mov    %al,-0x28(%ebp)
#ifdef __HAVE_ARCH_MEMSET
    return __memset(s, c, n);
  103440:	0f be 45 d8          	movsbl -0x28(%ebp),%eax
  103444:	8b 55 08             	mov    0x8(%ebp),%edx
  103447:	89 55 f8             	mov    %edx,-0x8(%ebp)
  10344a:	88 45 f7             	mov    %al,-0x9(%ebp)
  10344d:	8b 45 10             	mov    0x10(%ebp),%eax
  103450:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_MEMSET
#define __HAVE_ARCH_MEMSET
static inline void *
__memset(void *s, char c, size_t n) {
    int d0, d1;
    asm volatile (
  103453:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  103456:	0f b6 45 f7          	movzbl -0x9(%ebp),%eax
  10345a:	8b 55 f8             	mov    -0x8(%ebp),%edx
  10345d:	89 d7                	mov    %edx,%edi
  10345f:	f3 aa                	rep stos %al,%es:(%edi)
  103461:	89 fa                	mov    %edi,%edx
  103463:	89 4d ec             	mov    %ecx,-0x14(%ebp)
  103466:	89 55 e8             	mov    %edx,-0x18(%ebp)
            "rep; stosb;"
            : "=&c" (d0), "=&D" (d1)
            : "0" (n), "a" (c), "1" (s)
            : "memory");
    return s;
  103469:	8b 45 f8             	mov    -0x8(%ebp),%eax
    while (n -- > 0) {
        *p ++ = c;
    }
    return s;
#endif /* __HAVE_ARCH_MEMSET */
}
  10346c:	83 c4 24             	add    $0x24,%esp
  10346f:	5f                   	pop    %edi
  103470:	5d                   	pop    %ebp
  103471:	c3                   	ret    

00103472 <memmove>:
 * @n:        number of bytes to copy
 *
 * The memmove() function returns @dst.
 * */
void *
memmove(void *dst, const void *src, size_t n) {
  103472:	55                   	push   %ebp
  103473:	89 e5                	mov    %esp,%ebp
  103475:	57                   	push   %edi
  103476:	56                   	push   %esi
  103477:	53                   	push   %ebx
  103478:	83 ec 30             	sub    $0x30,%esp
  10347b:	8b 45 08             	mov    0x8(%ebp),%eax
  10347e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103481:	8b 45 0c             	mov    0xc(%ebp),%eax
  103484:	89 45 ec             	mov    %eax,-0x14(%ebp)
  103487:	8b 45 10             	mov    0x10(%ebp),%eax
  10348a:	89 45 e8             	mov    %eax,-0x18(%ebp)

#ifndef __HAVE_ARCH_MEMMOVE
#define __HAVE_ARCH_MEMMOVE
static inline void *
__memmove(void *dst, const void *src, size_t n) {
    if (dst < src) {
  10348d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103490:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  103493:	73 42                	jae    1034d7 <memmove+0x65>
  103495:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103498:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  10349b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10349e:	89 45 e0             	mov    %eax,-0x20(%ebp)
  1034a1:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1034a4:	89 45 dc             	mov    %eax,-0x24(%ebp)
            "andl $3, %%ecx;"
            "jz 1f;"
            "rep; movsb;"
            "1:"
            : "=&c" (d0), "=&D" (d1), "=&S" (d2)
            : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
  1034a7:	8b 45 dc             	mov    -0x24(%ebp),%eax
  1034aa:	c1 e8 02             	shr    $0x2,%eax
  1034ad:	89 c1                	mov    %eax,%ecx
#ifndef __HAVE_ARCH_MEMCPY
#define __HAVE_ARCH_MEMCPY
static inline void *
__memcpy(void *dst, const void *src, size_t n) {
    int d0, d1, d2;
    asm volatile (
  1034af:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  1034b2:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1034b5:	89 d7                	mov    %edx,%edi
  1034b7:	89 c6                	mov    %eax,%esi
  1034b9:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  1034bb:	8b 4d dc             	mov    -0x24(%ebp),%ecx
  1034be:	83 e1 03             	and    $0x3,%ecx
  1034c1:	74 02                	je     1034c5 <memmove+0x53>
  1034c3:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  1034c5:	89 f0                	mov    %esi,%eax
  1034c7:	89 fa                	mov    %edi,%edx
  1034c9:	89 4d d8             	mov    %ecx,-0x28(%ebp)
  1034cc:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  1034cf:	89 45 d0             	mov    %eax,-0x30(%ebp)
            "rep; movsb;"
            "1:"
            : "=&c" (d0), "=&D" (d1), "=&S" (d2)
            : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
            : "memory");
    return dst;
  1034d2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1034d5:	eb 36                	jmp    10350d <memmove+0x9b>
    asm volatile (
            "std;"
            "rep; movsb;"
            "cld;"
            : "=&c" (d0), "=&S" (d1), "=&D" (d2)
            : "0" (n), "1" (n - 1 + src), "2" (n - 1 + dst)
  1034d7:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1034da:	8d 50 ff             	lea    -0x1(%eax),%edx
  1034dd:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1034e0:	01 c2                	add    %eax,%edx
  1034e2:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1034e5:	8d 48 ff             	lea    -0x1(%eax),%ecx
  1034e8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1034eb:	8d 1c 01             	lea    (%ecx,%eax,1),%ebx
__memmove(void *dst, const void *src, size_t n) {
    if (dst < src) {
        return __memcpy(dst, src, n);
    }
    int d0, d1, d2;
    asm volatile (
  1034ee:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1034f1:	89 c1                	mov    %eax,%ecx
  1034f3:	89 d8                	mov    %ebx,%eax
  1034f5:	89 d6                	mov    %edx,%esi
  1034f7:	89 c7                	mov    %eax,%edi
  1034f9:	fd                   	std    
  1034fa:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  1034fc:	fc                   	cld    
  1034fd:	89 f8                	mov    %edi,%eax
  1034ff:	89 f2                	mov    %esi,%edx
  103501:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  103504:	89 55 c8             	mov    %edx,-0x38(%ebp)
  103507:	89 45 c4             	mov    %eax,-0x3c(%ebp)
            "rep; movsb;"
            "cld;"
            : "=&c" (d0), "=&S" (d1), "=&D" (d2)
            : "0" (n), "1" (n - 1 + src), "2" (n - 1 + dst)
            : "memory");
    return dst;
  10350a:	8b 45 f0             	mov    -0x10(%ebp),%eax
            *d ++ = *s ++;
        }
    }
    return dst;
#endif /* __HAVE_ARCH_MEMMOVE */
}
  10350d:	83 c4 30             	add    $0x30,%esp
  103510:	5b                   	pop    %ebx
  103511:	5e                   	pop    %esi
  103512:	5f                   	pop    %edi
  103513:	5d                   	pop    %ebp
  103514:	c3                   	ret    

00103515 <memcpy>:
 * it always copies exactly @n bytes. To avoid overflows, the size of arrays pointed
 * by both @src and @dst, should be at least @n bytes, and should not overlap
 * (for overlapping memory area, memmove is a safer approach).
 * */
void *
memcpy(void *dst, const void *src, size_t n) {
  103515:	55                   	push   %ebp
  103516:	89 e5                	mov    %esp,%ebp
  103518:	57                   	push   %edi
  103519:	56                   	push   %esi
  10351a:	83 ec 20             	sub    $0x20,%esp
  10351d:	8b 45 08             	mov    0x8(%ebp),%eax
  103520:	89 45 f4             	mov    %eax,-0xc(%ebp)
  103523:	8b 45 0c             	mov    0xc(%ebp),%eax
  103526:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103529:	8b 45 10             	mov    0x10(%ebp),%eax
  10352c:	89 45 ec             	mov    %eax,-0x14(%ebp)
            "andl $3, %%ecx;"
            "jz 1f;"
            "rep; movsb;"
            "1:"
            : "=&c" (d0), "=&D" (d1), "=&S" (d2)
            : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
  10352f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  103532:	c1 e8 02             	shr    $0x2,%eax
  103535:	89 c1                	mov    %eax,%ecx
#ifndef __HAVE_ARCH_MEMCPY
#define __HAVE_ARCH_MEMCPY
static inline void *
__memcpy(void *dst, const void *src, size_t n) {
    int d0, d1, d2;
    asm volatile (
  103537:	8b 55 f4             	mov    -0xc(%ebp),%edx
  10353a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10353d:	89 d7                	mov    %edx,%edi
  10353f:	89 c6                	mov    %eax,%esi
  103541:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  103543:	8b 4d ec             	mov    -0x14(%ebp),%ecx
  103546:	83 e1 03             	and    $0x3,%ecx
  103549:	74 02                	je     10354d <memcpy+0x38>
  10354b:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  10354d:	89 f0                	mov    %esi,%eax
  10354f:	89 fa                	mov    %edi,%edx
  103551:	89 4d e8             	mov    %ecx,-0x18(%ebp)
  103554:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  103557:	89 45 e0             	mov    %eax,-0x20(%ebp)
            "rep; movsb;"
            "1:"
            : "=&c" (d0), "=&D" (d1), "=&S" (d2)
            : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
            : "memory");
    return dst;
  10355a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    while (n -- > 0) {
        *d ++ = *s ++;
    }
    return dst;
#endif /* __HAVE_ARCH_MEMCPY */
}
  10355d:	83 c4 20             	add    $0x20,%esp
  103560:	5e                   	pop    %esi
  103561:	5f                   	pop    %edi
  103562:	5d                   	pop    %ebp
  103563:	c3                   	ret    

00103564 <memcmp>:
 *   match in both memory blocks has a greater value in @v1 than in @v2
 *   as if evaluated as unsigned char values;
 * - And a value less than zero indicates the opposite.
 * */
int
memcmp(const void *v1, const void *v2, size_t n) {
  103564:	55                   	push   %ebp
  103565:	89 e5                	mov    %esp,%ebp
  103567:	83 ec 10             	sub    $0x10,%esp
    const char *s1 = (const char *)v1;
  10356a:	8b 45 08             	mov    0x8(%ebp),%eax
  10356d:	89 45 fc             	mov    %eax,-0x4(%ebp)
    const char *s2 = (const char *)v2;
  103570:	8b 45 0c             	mov    0xc(%ebp),%eax
  103573:	89 45 f8             	mov    %eax,-0x8(%ebp)
    while (n -- > 0) {
  103576:	eb 30                	jmp    1035a8 <memcmp+0x44>
        if (*s1 != *s2) {
  103578:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10357b:	0f b6 10             	movzbl (%eax),%edx
  10357e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  103581:	0f b6 00             	movzbl (%eax),%eax
  103584:	38 c2                	cmp    %al,%dl
  103586:	74 18                	je     1035a0 <memcmp+0x3c>
            return (int)((unsigned char)*s1 - (unsigned char)*s2);
  103588:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10358b:	0f b6 00             	movzbl (%eax),%eax
  10358e:	0f b6 d0             	movzbl %al,%edx
  103591:	8b 45 f8             	mov    -0x8(%ebp),%eax
  103594:	0f b6 00             	movzbl (%eax),%eax
  103597:	0f b6 c0             	movzbl %al,%eax
  10359a:	29 c2                	sub    %eax,%edx
  10359c:	89 d0                	mov    %edx,%eax
  10359e:	eb 1a                	jmp    1035ba <memcmp+0x56>
        }
        s1 ++, s2 ++;
  1035a0:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  1035a4:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
 * */
int
memcmp(const void *v1, const void *v2, size_t n) {
    const char *s1 = (const char *)v1;
    const char *s2 = (const char *)v2;
    while (n -- > 0) {
  1035a8:	8b 45 10             	mov    0x10(%ebp),%eax
  1035ab:	8d 50 ff             	lea    -0x1(%eax),%edx
  1035ae:	89 55 10             	mov    %edx,0x10(%ebp)
  1035b1:	85 c0                	test   %eax,%eax
  1035b3:	75 c3                	jne    103578 <memcmp+0x14>
        if (*s1 != *s2) {
            return (int)((unsigned char)*s1 - (unsigned char)*s2);
        }
        s1 ++, s2 ++;
    }
    return 0;
  1035b5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  1035ba:	c9                   	leave  
  1035bb:	c3                   	ret    
