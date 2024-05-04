PASSES=0
FAILS=0
LOG=/dev/null

log_msg() {
    if [ ${2} -eq 0 ]; then
        PASSES=$((PASSES+1))
        if [ $SHOW_ALL_TESTS ]; then
            echo "[PASS] ${3}"
        fi
    else
        FAILS=$((FAILS+1))
        echo "[FAIL] ${1}: ${3}"
    fi
}

output()
{
    case "$1" in

        SV-86845r2_rule) log_msg $1 $2 'A FIPS 140-2 approved cryptographic algorithm must be used for SSH communications.'
                         if [ $2 -ne 0 ];then
                             printf '\n######################\n\nSTIG-ID:SV-86845r2\n\nUnapproved mechanisms that are used for authentication to the cryptographic module are not verified and therefore cannot be relied upon to provide confidentiality or integrity, and LibreServer data may be compromised.\n\nOperating systems utilizing encryption are required to use FIPS-compliant mechanisms for authenticating to cryptographic modules.\n\nFIPS 140-2 is the current standard for validating that mechanisms used to access cryptographic modules utilize authentication that meets LibreServer requirements. This allows for Security Levels 1, 2, 3, or 4 for use on a general purpose computing system.\n\nCheck_content: Verify the operating system uses mechanisms meeting the requirements of applicable federal laws, Executive orders, directives, policies, regulations, standards, and guidance for authentication to a cryptographic module.\n\nNote: If RHEL-07-021350 is a finding, this is automatically a finding as the system cannot implement FIPS 140-2-approved cryptographic algorithms and hashes.\n\nThe location of the "sshd_config" file may vary if a different daemon is in use.\n\nInspect the "Ciphers" configuration with the following command:\n\n# grep -i ciphers /etc/ssh/sshd_config\nCiphers aes128-ctr,aes192-ctr,aes256-ctr\n\nIf any ciphers other than "aes128-ctr", "aes192-ctr", or "aes256-ctr" are listed, the "Ciphers" keyword is missing, or the retuned line is commented out, this is a finding.\n\nFixtext: Configure SSH to use FIPS 140-2 approved cryptographic algorithms.\n\nAdd the following line (or modify the line to have the required value) to the "/etc/ssh/sshd_config" file (this file may be named differently or be in a different location if using a version of SSH that is provided by a third-party vendor).\n\nCiphers aes128-ctr,aes192-ctr,aes256-ctr\n\nThe SSH service must be restarted for changes to take effect.\n\n######################\n\n' >> $LOG
                         fi
                         ;;
        SV-86849r2_rule) log_msg $1 $2 'The Standard Notice must be displayed immediately prior to, or as part of, remote access login prompts.'
                         if [ $2 -ne 0 ];then
                             printf '\n######################\n\n Display of a standardized and approved use notification before granting access to the publicly accessible operating system ensures that you have some clue as to when the last login happened, etc.\n\n.\n\n######################\n\n' >> $LOG
                         fi
                         ;;
        SV-86859r2_rule) log_msg $1 $2 'All networked systems must use SSH for confidentiality and integrity of transmitted and received information as well as information during preparation for transmission.'
                         if [ $2 -ne 0 ];then
                             printf '\n######################\n\nWithout protection of the transmitted information, confidentiality and integrity may be compromised because unprotected communications can be intercepted and either read or altered. \n\nThis requirement applies to both internal and external networks and all types of information system components from which information can be transmitted (e.g., servers, mobile devices, notebook computers, printers, copiers, scanners, and facsimile machines). Communication paths outside the physical protection of a controlled boundary are exposed to the possibility of interception and modification. \n\nProtecting the confidentiality and integrity of organizational information can be accomplished by physical means (e.g., employing physical distribution systems) or by logical means (e.g., employing cryptographic techniques). If physical means of protection are employed, then logical means (cryptography) do not have to be employed, and vice versa.\n\nCheck_content: Verify SSH is loaded and active with the following command:\n\n# systemctl status sshd\n sshd.service - OpenSSH server daemon\n   Loaded: loaded (/usr/lib/systemd/system/sshd.service; enabled)\n   Active: active (running) since Tue 2015-11-17 15:17:22 EST; 4 weeks 0 days ago\n Main PID: 1348 (sshd)\n   CGroup: /system.slice/sshd.service\n           ??1348 /usr/sbin/sshd -D\n\nIf "sshd" does not show a status of "active" and "running", this is a finding.\n\n######################\n\n' >> $LOG
                         fi
                         ;;
        SV-86861r2_rule) log_msg $1 $2 'All network connections associated with SSH traffic must terminate at the end of the session or after 10 minutes of inactivity, except to fulfill documented and validated mission requirements.'
                         if [ $2 -ne 0 ];then
                             printf '\n######################\n\nTerminating an idle SSH session within a short time period reduces the window of opportunity for unauthorized personnel to take control of a management session enabled on the console or console port that has been left unattended. In addition, quickly terminating an idle SSH session will also free up resources committed by the managed network element.\n\nTerminating network connections associated with communications sessions includes, for example, de-allocating associated TCP/IP address/port pairs at the operating system level and de-allocating networking assignments at the application level if multiple application sessions are using a single operating system-level network connection. This does not mean that the operating system terminates all sessions or network access; it only ends the inactive session and releases the resources associated with that session.\n\nCheck_content: Verify the operating system automatically terminates a user session after inactivity time-outs have expired.\n\nCheck for the value of the "ClientAlive" keyword with the following command:\n\n# grep -i clientalive /etc/ssh/sshd_config\n\nClientAliveInterval 600\n\nIf "ClientAliveInterval" is not set to "600" in "/etc/ ssh/sshd_config", and a lower value is not documented with the Information System Security Officer (ISSO) as an operational requirement, this is a finding.\n\nFixtext: Configure the operating system to automatically terminate a user session after inactivity time-outs have expired or at shutdown.\n\nAdd the following line (or modify the line to have the required value) to the "/etc/ssh/sshd_config" file (this file may be named differently or be in a different location if using a version of SSH that is provided by a third-party vendor):\n\nClientAliveInterval 600\n\nThe SSH service must be restarted for changes to take effect.\n\n######################\n\n' >> $LOG
                         fi
                         ;;
        SV-86865r2_rule) log_msg $1 $2 'All network connections associated with SSH traffic must terminate after a period of inactivity.'
                         if [ $2 -ne 0 ];then
                             printf '\n######################\n\nTerminating an idle SSH session within a short time period reduces the window of opportunity for unauthorized personnel to take control of a management session enabled on the console or console port that has been left unattended. In addition, quickly terminating an idle SSH session will also free up resources committed by the managed network element.\n\nTerminating network connections associated with communications sessions includes, for example, de-allocating associated TCP/IP address/port pairs at the operating system level and de-allocating networking assignments at the application level if multiple application sessions are using a single operating system-level network connection. This does not mean that the operating system terminates all sessions or network access; it only ends the inactive session and releases the resources associated with that session.\n\nCheck_content: Verify the operating system automatically terminates a user session after inactivity time-outs have expired.\n\nCheck for the value of the "ClientAliveCountMax" keyword with the following command:\n\n# grep -i clientalivecount /etc/ssh/sshd_config\nClientAliveCountMax 0\n\nIf "ClientAliveCountMax" is not set to "0" in "/etc/ ssh/sshd_config", this is a finding.\n\nFixtext: Configure the operating system to automatically terminate a user session after inactivity time-outs have expired or at shutdown.\n\nAdd the following line (or modify the line to have the required value) to the "/etc/ssh/sshd_config" file (this file may be named differently or be in a different location if using a version of SSH that is provided by a third-party vendor):\n\nClientAliveCountMax 0\n\nThe SSH service must be restarted for changes to take effect.\n\n######################\n\n' >> $LOG
                         fi
                         ;;
        SV-86867r2_rule) log_msg $1 $2 'The SSH daemon must not allow authentication using rhosts authentication.'
                         if [ $2 -ne 0 ];then
                             printf '\n######################\n\nConfiguring this setting for the SSH daemon provides additional assurance that remote login via SSH will require a password, even in the event of misconfiguration elsewhere.\n\nCheck_content: Verify the SSH daemon does not allow authentication using known hosts authentication.\n\nTo determine how the SSH daemons "IgnoreRhosts" option is set, run the following command:\n\n# grep -i IgnoreRhosts /etc/ssh/sshd_config\n\nIgnoreRhosts yes\n\nIf the value is returned as "no", the returned line is commented out, or no output is returned, this is a finding.\n\nFixtext: Configure the SSH daemon to not allow authentication using known hosts authentication.\n\nAdd the following line in "/etc/ssh/sshd_config", or uncomment the line and set the value to "yes":\n\nIgnoreRhosts yes\n\n######################\n\n' >> $LOG
                         fi
                         ;;
        SV-86869r2_rule) log_msg $1 $2 'The system must display the date and time of the last successful account login upon an SSH login.'
                         if [ $2 -ne 0 ];then
                             printf '\n######################\n\nProviding users with feedback on when account accesses via SSH last occurred facilitates user recognition and reporting of unauthorized account use.\n\nCheck_content: Verify SSH provides users with feedback on when account accesses last occurred.\n\nCheck that "PrintLastLog" keyword in the sshd daemon configuration file is used and set to "yes" with the following command:\n\n# grep -i printlastlog /etc/ssh/sshd_config\nPrintLastLog yes\n\nIf the "PrintLastLog" keyword is set to "no", is missing, or is commented out, this is a finding.\n\nFixtext: Configure SSH to provide users with feedback on when account accesses last occurred by setting the required configuration options in "/etc/pam.d/sshd" or in the "sshd_config" file used by the system ("/etc/ssh/sshd_config" will be used in the example) (this file may be named differently or be in a different location if using a version of SSH that is provided by a third-party vendor).\n\nAdd the following line to the top of "/etc/pam.d/sshd":\n\nsession     required      pam_lastlog.so showfailed\n\nOr modify the "PrintLastLog" line in "/etc/ssh/sshd_config" to match the following:\n\nPrintLastLog yes\n\nThe SSH service must be restarted for changes to "sshd_config" to take effect.\n\n######################\n\n' >> $LOG
                         fi
                         ;;
        SV-86871r2_rule) log_msg $1 $2 'The system must not permit direct logins to the root account using remote access via SSH.'
                         if [ $2 -ne 0 ];then
                             printf '\n######################\n\nEven though the communications channel may be encrypted, an additional layer of security is gained by extending the policy of not logging on directly as root. In addition, logging on with a user-specific account provides individual accountability of actions performed on the system.\n\nCheck_content: Verify remote access using SSH prevents users from logging on directly as root.\n\nCheck that SSH prevents users from logging on directly as root with the following command:\n\n# grep -i permitrootlogin /etc/ssh/sshd_config\nPermitRootLogin no\n\nIf the "PermitRootLogin" keyword is set to "yes", is missing, or is commented out, this is a finding.\n\nFixtext: Configure SSH to stop users from logging on remotely as the root user.\n\nEdit the appropriate  "/etc/ssh/sshd_config" file to uncomment or add the line for the "PermitRootLogin" keyword and set its value to "no" (this file may be named differently or be in a different location if using a version of SSH that is provided by a third-party vendor):\n\nPermitRootLogin no\n\nThe SSH service must be restarted for changes to take effect.\n\n######################\n\n' >> $LOG
                         fi
                         ;;
        SV-86873r2_rule) log_msg $1 $2 'The SSH daemon must not allow authentication using known hosts authentication.'
                         if [ $2 -ne 0 ];then
                             printf '\n######################\n\nConfiguring this setting for the SSH daemon provides additional assurance that remote login via SSH will require a password, even in the event of misconfiguration elsewhere.\n\nCheck_content: Verify the SSH daemon does not allow authentication using known hosts authentication.\n\nTo determine how the SSH daemons "IgnoreUserKnownHosts" option is set, run the following command:\n\n# grep -i IgnoreUserKnownHosts /etc/ssh/sshd_config\n\nIgnoreUserKnownHosts yes\n\nIf the value is returned as "no", the returned line is commented out, or no output is returned, this is a finding.\n\nFixtext: Configure the SSH daemon to not allow authentication using known hosts authentication.\n\nAdd the following line in "/etc/ssh/sshd_config", or uncomment the line and set the value to "yes":\n\nIgnoreUserKnownHosts yes\n\nThe SSH service must be restarted for changes to take effect.\n\n######################\n\n' >> $LOG
                         fi
                         ;;
        SV-86875r2_rule) log_msg $1 $2 'The SSH daemon must be configured to only use the SSHv2 protocol.'
                         if [ $2 -ne 0 ];then
                             printf '\n######################\n\nSSHv1 is an insecure implementation of the SSH protocol and has many well-known vulnerability exploits. Exploits of the SSH daemon could provide immediate root access to the system.\n\nCheck_content: Verify the SSH daemon is configured to only use the SSHv2 protocol.\n\nCheck that the SSH daemon is configured to only use the SSHv2 protocol with the following command:\n\n# grep -i protocol /etc/ssh/sshd_config\nProtocol 2\n#Protocol 1,2\n\nIf any protocol line other than "Protocol 2" is uncommented, this is a finding.\n\nFixtext: Remove all Protocol lines that reference version "1" in "/etc/ssh/sshd_config" (this file may be named differently or be in a different location if using a version of SSH that is provided by a third-party vendor). The "Protocol" line must be as follows:\n\nProtocol 2\n\nThe SSH service must be restarted for changes to take effect.\n\n######################\n\n' >> $LOG
                         fi
                         ;;
        SV-86877r2_rule) log_msg $1 $2 'The SSH daemon must be configured to only use Message Authentication Codes (MACs) employing FIPS 140-2 approved cryptographic hash algorithms.'
                         if [ $2 -ne 0 ];then
                             printf '\n######################\n\nLibreServer information systems are required to use FIPS 140-2 approved cryptographic hash functions. The only SSHv2 hash algorithm meeting this requirement is SHA.\n\nCheck_content: Verify the SSH daemon is configured to only use MACs employing FIPS 140-2-approved ciphers.\n\nNote: If RHEL-07-021350 is a finding, this is automatically a finding as the system cannot implement FIPS 140-2-approved cryptographic algorithms and hashes.\n\nCheck that the SSH daemon is configured to only use MACs employing FIPS 140-2-approved ciphers with the following command:\n\n# grep -i macs /etc/ssh/sshd_config\nMACs hmac-sha2-256,hmac-sha2-512\n\nIf any ciphers other than "hmac-sha2-256" or "hmac-sha2-512" are listed or the retuned line is commented out, this is a finding.\n\nFixtext: Edit the "/etc/ssh/sshd_config" file to uncomment or add the line for the "MACs" keyword and set its value to "hmac-sha2-256" and/or "hmac-sha2-512" (this file may be named differently or be in a different location if using a version of SSH that is provided by a third-party vendor):\n\nMACs hmac-sha2-256,hmac-sha2-512\n\nThe SSH service must be restarted for changes to take effect.\n\n######################\n\n' >> $LOG
                         fi
                         ;;
        SV-86879r1_rule) log_msg $1 $2 'The SSH public host key files must have mode 0644 or less permissive.'
                         if [ $2 -ne 0 ];then
                             printf '\n######################\n\nIf a public host key file is modified by an unauthorized user, the SSH service may be compromised.\n\nCheck_content: Verify the SSH public host key files have mode "0644" or less permissive.\n\nNote: SSH public key files may be found in other directories on the system depending on the installation.\n\nThe following command will find all SSH public key files on the system:\n\n# find /etc/ssh -name \"*.pub\" -exec ls -lL {} \\;\n\n-rw-r--r--  1 root  wheel  618 Nov 28 06:43 ssh_host_dsa_key.pub\n-rw-r--r--  1 root  wheel  347 Nov 28 06:43 ssh_host_key.pub\n-rw-r--r--  1 root  wheel  238 Nov 28 06:43 ssh_host_rsa_key.pub\n\nIf any file has a mode more permissive than "0644", this is a finding.\n\nFixtext: Note: SSH public key files may be found in other directories on the system depending on the installation. \n\nChange the mode of public host key files under "/etc/ssh" to "0644" with the following command:\n\n# chmod 0644 /etc/ssh/*.key.pub\n\n######################\n\n' >> $LOG
                         fi
                         ;;
        SV-86881r1_rule) log_msg $1 $2 'The SSH private host key files must have mode 0600 or less permissive.'
                         if [ $2 -ne 0 ];then
                             printf '\n######################\n\nIf an unauthorized user obtains the private SSH host key file, the host could be impersonated.
Check_content: Verify the SSH private host key files have mode "0600" or less permissive.\n\nThe following command will find all SSH private key files on the system:\n\n# find / -name \"*ssh_host*key\"\n\nCheck the mode of the private host key files under "/etc/ssh" file with the following command:\n\n# ls -lL /etc/ssh/*key\n-rw-------  1 root  wheel  668 Nov 28 06:43 ssh_host_dsa_key\n-rw-------  1 root  wheel  582 Nov 28 06:43 ssh_host_key\n-rw-------  1 root  wheel  887 Nov 28 06:43 ssh_host_rsa_key\n\nIf any file has a mode more permissive than "0600", this is a finding.\n\nFixtext: Configure the mode of SSH private host key files under "/etc/ssh" to "0600" with the following command:\n\n# chmod 0600 /etc/ssh/ssh_host*key\n\n######################\n\n' >> $LOG
                         fi
                         ;;
        SV-86883r2_rule) log_msg $1 $2 'The SSH daemon must not permit Generic Security Service Application Program Interface (GSSAPI) authentication unless needed.'
                         if [ $2 -ne 0 ];then
                             printf '\n######################\n\nGSSAPI authentication is used to provide additional authentication mechanisms to applications. Allowing GSSAPI authentication through SSH exposes the system\u2019s GSSAPI to remote hosts, increasing the attack surface of the system. GSSAPI authentication must be disabled unless needed.\n\nCheck_content: Verify the SSH daemon does not permit GSSAPI authentication unless approved.\n\nCheck that the SSH daemon does not permit GSSAPI authentication with the following command:\n\n# grep -i gssapiauth /etc/ssh/sshd_config\nGSSAPIAuthentication no\n\nIf the "GSSAPIAuthentication" keyword is missing, is set to "yes" and is not documented with the Information System Security Officer (ISSO), or the returned line is commented out, this is a finding.\n\nFixtext: Uncomment the "GSSAPIAuthentication" keyword in "/etc/ssh/sshd_config" (this file may be named differently or be in a different location if using a version of SSH that is provided by a third-party vendor) and set the value to "no": \n\nGSSAPIAuthentication no\n\nThe SSH service must be restarted for changes to take effect.\n\nIf GSSAPI authentication is required, it must be documented, to include the location of the configuration file, with the ISSO.\n\n######################\n\n' >> $LOG
                         fi
                         ;;
        SV-86885r2_rule) log_msg $1 $2 'The SSH daemon must not permit Kerberos authentication unless needed.'
                         if [ $2 -ne 0 ];then
                             printf '\n######################\n\nKerberos authentication for SSH is often implemented using Generic Security Service Application Program Interface (GSSAPI). If Kerberos is enabled through SSH, the SSH daemon provides a means of access to the systems Kerberos implementation. Vulnerabilities in the systems Kerberos implementation may then be subject to exploitation. To reduce the attack surface of the system, the Kerberos authentication mechanism within SSH must be disabled for systems not using this capability.\n\nCheck_content: Verify the SSH daemon does not permit Kerberos to authenticate passwords unless approved.\n\nCheck that the SSH daemon does not permit Kerberos to authenticate passwords with the following command:\n\n# grep -i kerberosauth /etc/ssh/sshd_config\nKerberosAuthentication no\n\nIf the "KerberosAuthentication" keyword is missing, or is set to "yes" and is not documented with the Information System Security Officer (ISSO), or the returned line is commented out, this is a finding.\n\nFixtext: Uncomment the "KerberosAuthentication" keyword in "/etc/ssh/sshd_config" (this file may be named differently or be in a different location if using a version of SSH that is provided by a third-party vendor) and set the value to "no":\n\nKerberosAuthentication no\n\nThe SSH service must be restarted for changes to take effect.\n\nIf Kerberos authentication is required, it must be documented, to include the location of the configuration file, with the ISSO.\n\n######################\n\n' >> $LOG
                         fi
                         ;;
        SV-86887r2_rule) log_msg $1 $2 'The SSH daemon must perform strict mode checking of home directory configuration files.'
                         if [ $2 -ne 0 ];then
                             printf '\n######################\n\nIf other users have access to modify user-specific SSH configuration files, they may be able to log on to the system as another user.\n\nCheck_content: Verify the SSH daemon performs strict mode checking of home directory configuration files.\n\nThe location of the "sshd_config" file may vary if a different daemon is in use.\n\nInspect the "sshd_config" file with the following command:\n\n# grep -i strictmodes /etc/ssh/sshd_config\n\nStrictModes yes\n\nIf "StrictModes" is set to "no", is missing, or the returned line is commented out, this is a finding.\n\nFixtext: Uncomment the "StrictModes" keyword in "/etc/ssh/sshd_config" (this file may be named differently or be in a different location if using a version of SSH that is provided by a third-party vendor) and set the value to "yes":\n\nStrictModes yes\n\nThe SSH service must be restarted for changes to take effect.\n\n######################\n\n' >> $LOG
                         fi
                         ;;
        SV-86889r2_rule) log_msg $1 $2 'The SSH daemon must use privilege separation.'
                         if [ $2 -ne 0 ];then
                             printf '\n######################\n\nSSH daemon privilege separation causes the SSH process to drop root privileges when not needed, which would decrease the impact of software vulnerabilities in the unprivileged section.\n\nCheck_content: Verify the SSH daemon performs privilege separation.\n\nCheck that the SSH daemon performs privilege separation with the following command:\n\n# grep -i usepriv /etc/ssh/sshd_config\n\nUsePrivilegeSeparation sandbox\n\nIf the "UsePrivilegeSeparation" keyword is set to "no", is missing, or the retuned line is commented out, this is a finding.\n\nFixtext: Uncomment the "UsePrivilegeSeparation" keyword in "/etc/ssh/sshd_config" (this file may be named differently or be in a different location if using a version of SSH that is provided by a third-party vendor) and set the value to "sandbox" or "yes":\n\nUsePrivilegeSeparation sandbox\n\nThe SSH service must be restarted for changes to take effect.\n\n######################\n\n' >> $LOG
                         fi
                         ;;
        SV-86891r2_rule) log_msg $1 $2 'The SSH daemon must not allow compression or must only allow compression after successful authentication.'
                         if [ $2 -ne 0 ];then
                             printf '\n######################\n\nIf compression is allowed in an SSH connection prior to authentication, vulnerabilities in the compression software could result in compromise of the system from an unauthenticated connection, potentially with root privileges.\n\nCheck_content: Verify the SSH daemon performs compression after a user successfully authenticates.\n\nCheck that the SSH daemon performs compression after a user successfully authenticates with the following command:\n\n# grep -i compression /etc/ssh/sshd_config\nCompression delayed\n\nIf the "Compression" keyword is set to "yes", is missing, or the retuned line is commented out, this is a finding.\n\nFixtext: Uncomment the "Compression" keyword in "/etc/ssh/sshd_config" (this file may be named differently or be in a different location if using a version of SSH that is provided by a third-party vendor) on the system and set the value to "delayed" or "no":\n\nCompression no\n\nThe SSH service must be restarted for changes to take effect.\n\n######################\n\n' >> $LOG
                         fi
                         ;;
        SV-86927r2_rule) log_msg $1 $2 'Dont allow remote X connections.'
                         if [ $2 -ne 0 ];then
                             printf '\n######################\n\nThis system is not intended to support graphical output\n\n######################\n\n' >> $LOG
                         fi
                         ;;
        SV-81723r2_rule) log_msg $1 $2 'Dont allow ssh agent forwarding'
                         if [ $2 -ne 0 ];then
                             printf '\n######################\n\nssh agent forwarding is not regarded as secure and can be hijacked\n\n######################\n\n' >> $LOG
                         fi
                         ;;
        SV-86724r2_rule) log_msg $1 $2 'Dont allow pam_python.'
                         if [ $2 -ne 0 ];then
                             printf '\n######################\n\npam_python within /etc/pam.d/sshd could indicate a possible attack on ssh logins.\n\n######################\n\n' >> $LOG
                         fi
                         ;;
        V-38455)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The system must use a separate file system for /tmp.'
                  else
                      log_msg $1 $2 'tmp目录必须挂载为一个独立的文件系统分区。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000001\n\nVulnerability Discussion: The "/tmp" partition is used as temporary storage by many programs. Placing "/tmp" in its own partition enables the setting of more restrictive mount options, which can help protect programs which use it.\n\nFix Text: The "/tmp" directory is a world-writable directory used for temporary file storage. Ensure it hasits own partition or logical volume at installation time, or migrate it using LVM.\n\n######################\n\n' >> $LOG
                  fi
                  ;;

        V-38456)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The system must use a separate file system for /var.'
                  else
                      log_msg $1 $2 'var目录必须挂载为一个独立的文件系统分区。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000002\n\nVulnerability Discussion: Ensuring that "/var" is mounted on its own partition enables the setting of more restrictive mount options. This helps protect system services such as daemons or other programs which use it. It is not uncommon for the "/var" directory to contain world-writable directories, installed by other software packages.\n\nFix Text: The "/var" directory is used by daemons and other system services to store frequently-changing data. Ensure that "/var" has its own partition or logical volume at installation time, or migrate it using LVM.\n\n######################\n\n' >> $LOG
                  fi
                  ;;

        V-38463)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The system must use a separate file system for /var/log.'
                  else
                      log_msg $1 $2 '/var/log目录必须挂载为一个独立的文件系统分区。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000003\n\nVulnerability Discussion: Placing "/var/log" in its own partition enables better separation between log files and other files in "/var/".\n\nFix text: System logs are stored in the "/var/log" directory. Ensure that it has its own partition or logical volume at installation time, or migrate it using LVM.\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38467)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The system must use a separate file system for the system audit data path.'
                  else
                      log_msg $1 $2 '系统审计数据存放的路径必须为一个独立的文件系统分区。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000004\n\nVulnerability Discussion: Placing "/var/log/audit" in its own partition enables better separation between audit files and other files, and helps ensure that auditing cannot be halted due to the partition running out of space.\n\nFix text: Audit logs are stored in the "/var/log/audit" directory. Ensure that it has its own partition or logical
volume at installation time, or migrate it later using LVM. Make absolutely certain that it is large enough to
store all audit logs that will be created by the auditing daemon.\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38470)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The audit system must alert designated staff members when the audit storage volume approaches capacity.'
                  else
                      log_msg $1 $2 '当审计存储卷空间不足时必须警告指定的工作人员。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000005\n\nVulnerability Discussion: Notifying administrators of an impending disk space problem may allow them to take corrective action prior to any disruption.\n\nFix text: The "auditd" service can be configured to take an action when disk space starts to run low. Edit the file "/etc/audit/auditd.conf". Modify the following line, substituting [ACTION] appropriately:\n\n
space_left_action = [ACTION]\n\nPossible values for [ACTION] are described in the "auditd.conf" man page. These include:\n\n"ignore"\n"syslog"\n"email"\n"exec"\n"suspend"\n"single"\n"halt"\n\nSet this to "email" (instead of the default, which is "suspend") as it is more likely to get prompt attention. The"syslog" option is acceptable, provided the local log management infrastructure notifies an appropriate
administrator in a timely manner.\n\nRHEL-06-000521 ensures that the email generated through the operation "space_left_action" will be sent to
an administrator.\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38473)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The system must use a separate file system for user home directories.'
                  else
                      log_msg $1 $2 '用户的家目录(主目录)必须为一个独立的文件系统分区。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000007\n\nVulnerability Discussion: Ensuring that "/home" is mounted on its own partition enables the setting of more restrictive mount options, and also helps ensure that users cannot trivially fill partitions used for log or audit data storage.\n\nFix text: If user home directories will be stored locally, create a separate partition for "/home" at installation time (or migrate it later using LVM). If "/home" will be mounted from another system such as an NFS server, then creating a separate partition is not necessary at installation time, and the mountpoint can instead be configured later.  \n\n######################\n\n' >> $LOG
                  fi
                  ;;

        V-38476)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'Vendor-provided cryptographic certificates must be installed to verify the integrity of system software.' ##Ported
                  else
                      log_msg $1 $2 '必须安装系统供应商提供的验证系统软件的完整性的加密证书。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000008\n\nVulnerability Discussion: The Debian GPG keys are necessary to cryptographically verify packages are from Debian.\n\nAt this checking script("scripts/check-apt-key.sh"). We check :\n\nDebian8/jessie archive key,security archive signing key,stable release key\nDebian 7/Wheezy archive key,stable key\nDebian 6/Squeeze archive key,stable key.\n\nFor the detial could vist the : https://ftp-master.debian.org/keys.html\n\nFix text: To ensure the system can cryptographically verify base software packages come from Debian,the Red Hat GPG keys must be installed properly. To install the Debian GPG keys, run:\n\napt-key add "KEY"\n\nAnyone could find the key at:https://ftp-master.debian.org/keys.html\n\n######################\n\n' >> $LOG
                  fi
                  ;;

        #wait for porting
        V-38478)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The Red Hat Network Service (rhnsd) service must not be running, unless using RHN or an RHN Satellite.'
                  else
                      log_msg $1 $2 'The Red Hat Network Service (rhnsd) service must not be running, unless using RHN or an RHN Satellite.'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000009\n\nVulnerability Discussion: \n\nFix text: \n\n######################\n\n' >> $LOG
                  fi
                  ;;

        V-38481)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'System security patches and updates must be installed and up-to-date.' ##Ported
                  else
                      log_msg $1 $2 '系统安全补丁及软件更新必须及时安装最新的版本。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000011\n\nVulnerability Discussion: Installing software updates is a fundamental mitigation against the exploitation of publicly-known vulnerabilities.\n\nFix text: If the system can connect to a Debian mirrors, run the following command to install updates:\n\n#apt-get update && apt-get upgrade\n\n######################\n\n' >> $LOG
                  fi
                  ;;

        #wait for porting
        V-38483)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The system package management tool must cryptographically verify the authenticity of system software packages during installation.'
                  else
                      log_msg $1 $2 'The system package management tool must cryptographically verify the authenticity of system software packages during installation.'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000013\n\nVulnerability Discussion: \n\nFix text: \n\n######################\n\n' >> $LOG
                  fi
                  ;;

        #wait for porting
        V-38487)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The system package management tool must cryptographically verify the authenticity of all software packages during installation.'
                  else
                      log_msg $1 $2 '在安装所有软件包时，系统的包管理工具必须对其进行加密验证以保证真实性。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000015\n\nVulnerability Discussion: Ensuring all packages cryptographic signatures are valid prior to installation ensures the provenance of the software and protects against malicious tampering.\n\nFix text: \n\n######################\n\n' >> $LOG
                  fi
                  ;;

        V-38489)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'A file integrity tool must be installed.(tripwire)' ##Ported
                  else
                      log_msg $1 $2 '必须安装文件完整性的工具。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000016\n\nVulnerability Discussion: The tripwire package must be installed if it is to be available for integrity checking.\n\nFix text: Install the tripwire package with the command:\n\n#apt-get install tripwire\n\n######################\n\n' >> $LOG
                  fi
                  ;;

        V-51337)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The system must use a Linux Security Module at boot time.(AppArmor)' ##Ported
                  else
                      log_msg $1 $2 '系统在启动时必须使用Linux安全模块。(AppArmor)。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000017\n\nVulnerability Discussion: Disabling a major host protection feature, such as Apparmor, at boot time prevents it from confining system services at boot time. Further, it increases the chances that it will remain off during system operation.\n\nFix text: Install the Apparmor package with the command:\n\n#apt-get install apparmor apparmor-profiles apparmor-utils\n\nAnd add \n\nGRUB_CMDLINE_LINUX=" apparmor=1 security=apparmor"\n\nTo/etc/default/grub\n\n#update-grub\n\n#reboot\n\nFor detial could visit:https://wiki.debian.org/AppArmor/HowToUse\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-51391)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'A file integrity baseline must be created. Reset the tripwire from the administrator control panel under security settings.'
                  else
                      log_msg $1 $2 '必须创建文件完整性基线。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000018\n\nVulnerability Discussion: For tripwire to be effective, an initial database of "known-good" information about files must be captured and it should be able to be verified against the installed files.\n\nFix text: Run "reset tripwire" from security settings on the administrator control panel.\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38491)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'There must be no .rhosts or hosts.equiv files on the system.'
                  else
                      log_msg $1 $2 '.rhosts文件或hosts.equiv文件在系统必须不存在。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000019\n\nVulnerability Discussion: Trust files are convenient, but when used in conjunction with the R-services, they can allow unauthenticated access to a system.\n\nFix text: The files "/etc/hosts.equiv" and "~/.rhosts" (in each user\047s home directory) list remote hosts and users that are trusted by the local system when using the rshd daemon. To remove these files, run the following command to delete them from any location.\n\n#rm /etc/hosts.equiv\n\n#rm ~/.rhosts\n\n######################\n\n' >> $LOG
                  fi
                  ;;

        #wait for porting
        V-51363)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The system must use a Linux Security Module configured to enforce limits on system services.'
                  else
                      log_msg $1 $2 '系统中必须使用一个Linux安全模块配置对系统服务及资源进行限制。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000020\n\nVulnerability Discussion: Setting the Apparmor state to enforcing ensures Apparmor is able to confine potentially compromised processes to the security policy, which is designed to prevent them from causing damage to the system or further elevating their privileges.\n\nFix text: \n\n######################\n\n' >> $LOG
                  fi
                  ;;

        #wait for porting
        V-51369)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The system must use a Linux Security Module configured to limit the privileges of system services.'
                  else
                      log_msg $1 $2 'The system must use a Linux Security Module configured to limit the privileges of system services.'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000023\n\nVulnerability Discussion: \n\nFix text: \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        #wait for porting
        V-51379)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'All device files must be monitored by the system Linux Security Module.'
                  else
                      log_msg $1 $2 'All device files must be monitored by the system Linux Security Module.'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000025\n\nVulnerability Discussion: \n\nFix text: \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38492)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The system must prevent the root account from logging in from virtual consoles.'
                  else
                      log_msg $1 $2 '必须禁止root帐号从虚拟控制台登录到系统。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000027\n\nVulnerability Discussion: Preventing direct root login to virtual console devices helps ensure accountability for actions taken on the system using the root account.\n\nFix text: To restrict root logins through the (deprecated) virtual console devices, ensure lines of this form do not appear in "/etc/securetty":\n\nvc/1\nvc/2\nvc/3\nvc/4\n\nNote: Virtual console entries are not limited to those listed above. Any lines starting with "vc/" followed by numerals should be removed.\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38494)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The system must prevent the root account from logging in from serial consoles.'
                  else
                      log_msg $1 $2 '必须禁止root帐号从串口控制台登录到系统。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000028\n\nVulnerability Discussion: Preventing direct root login to serial port interfaces helps ensure accountability for actions taken on the systems using the root account.\n\nFix text: To restrict root logins on serial ports, ensure lines of this form do not appear in "/etc/securetty":\n\nttyS0\n\nttyS1\n\nNote: Serial port entries are not limited to those listed above. Any lines starting with "ttyS" followed by numerals should be removed\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38496)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'Default operating system accounts, other than root, must be locked.'
                  else
                      log_msg $1 $2 '除了root以外的默认的帐号，必须进行锁定。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000029\n\nVulnerability Discussion: Disabling authentication for default system accounts makes it more difficult for attackers to make use of them to compromise a system.\n\nFix text: Some accounts are not associated with a human user of the system, and exist to perform some administrative function. An attacker should not be able to log into these accounts.\n\nDisable login access to these accounts with the command:\n\n#passwd -l [SYSACCT]\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38497)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The system must not have accounts configured with blank or null passwords.'  ##Ported
                  else
                      log_msg $1 $2 '禁止帐号的密码配置为空密码。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000030\n\nVulnerability Discussion: If an account has an empty password, anyone could log in and run commands with the privileges of that account. Accounts with empty passwords should never be used in operational environments.\n\nFix text: If an account is configured for password authentication but does not have an assigned password, it may be possible to log onto the account without authentication. Remove any instances of the "nullok" option in "/etc/pam.d/common-password" to prevent logins with empty passwords.\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38499)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The /etc/passwd file must not contain password hashes.'
                  else
                      log_msg $1 $2 '/etc/passwd文件必须不包含密码的哈希值。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000031\n\nVulnerability Discussion: The hashes for all user account passwords should be stored in the file "/etc/shadow" and never in "/etc/passwd", which is readable by all users.\n\nFix text: If any password hashes are stored in "/etc/passwd" (in the second field, instead of an "x"), the cause of this misconfiguration should be investigated. The account should have its password reset and the hash should be properly stored, or the account should be deleted entirely.  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38500)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The root account must be the only account having a UID of 0.'
                  else
                      log_msg $1 $2 'root帐号的UID必须且仅为0。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000032\n\nVulnerability Discussion: An account has root authority if it has a UID of 0. Multiple accounts with a UID of 0 afford more opportunity for potential intruders to guess a password for a privileged account. Proper
configuration of sudo is recommended to afford multiple system administrators access to root privileges in an accountable manner.\n\nFix text: If any account other than root has a UID of 0, this misconfiguration should be investigated and the accounts other than root should be removed or have their UID changed.\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38502)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The /etc/shadow file must be owned by root.'
                  else
                      log_msg $1 $2 '/etc/shadow文件必须所属于root用户。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000033\n\nVulnerability Discussion: The "/etc/shadow" file contains the list of local system accounts and stores password hashes. Protection of this file is critical for system security. Failure to give ownership of this file to root provides the designated owner with access to sensitive information which could weaken the system security posture.\n\nFix text: To properly set the owner of "/etc/shadow", run the command:\n\n#chown root /etc/shadow\n\n##################\n\n' >> $LOG
                  fi
                  ;;
        V-38503)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The /etc/shadow file must be group-owned by root.'
                  else
                      log_msg $1 $2 '/etc/shadow文件的所属组必须为root组。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000034\n\nVulnerability Discussion: The "/etc/shadow" file stores password hashes. Protection of this file is critical for system security.\n\nFix text: To properly set the group owner of "/etc/shadow", run the command:\n\n#chgrp root /etc/shadow\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38504)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The /etc/shadow file must have mode 0000.'
                  else
                      log_msg $1 $2 '/etc/shadow文件的权限必须为不可读写、不可执行。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000035\n\nVulnerability Discussion: The "/etc/shadow" file contains the list of local system accounts and stores password hashes. Protection of this file is critical for system security. Failure to give ownership of this file to root provides the designated owner with access to sensitive information which could weaken the system security posture.\n\nFix text: To properly set the permissions of "/etc/shadow", run the command:\n\n#chmod 0000 /etc/shadow\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38443)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The /etc/gshadow file must be owned by root.'
                  else
                      log_msg $1 $2 '/etc/gshadow文件必须的属于root用户。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000036\n\nVulnerability Discussion: The "/etc/gshadow" file contains group password hashes. Protection of this file is critical for system security.\n\nFix text: To properly set the owner of "/etc/gshadow", run the command:\n\n#chown root /etc/gshadow\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38448)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The /etc/gshadow file must be group-owned by root.'
                  else
                      log_msg $1 $2 '/etc/gshadow文件的组必须属于root组。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000037\n\nVulnerability Discussion: The "/etc/gshadow" file contains group password hashes. Protection of this file is critical for system security.\n\nFix text: To properly set the group owner of "/etc/gshadow", run the command:\n\n#chgrp root /etc/gshadow\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38449)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The /etc/gshadow file must have mode 0000.'
                  else
                      log_msg $1 $2 '/etc/gshadow的权限必须为不可读写、不可执行。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000038\n\nVulnerability Discussion: The /etc/gshadow file contains group password hashes. Protection of this file is critical for system security.\n\nFix text: To properly set the permissions of "/etc/gshadow", run the command:\n\n#chmod 0000 /etc/gshadow\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38450)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The /etc/passwd file must be owned by root.'
                  else
                      log_msg $1 $2 '/etc/passwd必须所属于root用户。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000039\n\nVulnerability Discussion: The "/etc/passwd" file contains information about the users that are configured on the system. Protection of this file is critical for system security.\n\nFix text: To properly set the owner of "/etc/passwd", run the command:\n\n#chown root /etc/passwd\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38451)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The /etc/passwd file must be group-owned by root.'
                  else
                      log_msg $1 $2 '/etc/passwd文件的组属主必须为root组。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000040\n\nVulnerability Discussion: The "/etc/passwd" file contains information about the users that are configured on the system. Protection of this file is critical for system security.\n\nFix text: To properly set the group owner of "/etc/passwd", run the command:\n\n#chgrp root /etc/passwd\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38457)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The /etc/passwd file must have mode 0644 or less permissive.'
                  else
                      log_msg $1 $2 '/etc/passwd文件的权限必须为root用户可读写、root组可读、其它用户可读的权限或更小的权限。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000041\n\nVulnerability Discussion: If the "/etc/passwd" file is writable by a group-owner or the world the risk of its compromise is increased. The file contains the list of accounts on the system and associated information, and protection of this file is critical for system security.\n\nFix text: To properly set the permissions of "/etc/passwd", run the command:\n\n#chmod 0644 /etc/passwd\n\n######################\n\n' >> $LOG
                  fi
                  ;;

        V-38458)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The /etc/group file must be owned by root.'
                  else
                      log_msg $1 $2 '/etc/group文件必须属于root用户。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000042\n\nVulnerability Discussion: The "/etc/group" file contains information regarding groups that are configured on the system. Protection of this file is important for system security.\n\nFix text: To properly set the owner of "/etc/group", run the command:\n\n#chown root /etc/group\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38459)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The /etc/group file must be group-owned by root.'
                  else
                      log_msg $1 $2 '/etc/group文件的组属主必须属于root组。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000043\n\nVulnerability Discussion: The "/etc/group" file contains information regarding groups that are configured on the system. Protection of this file is important for system security.\n\nFix text: To properly set the group owner of "/etc/group", run the command:\n\n#chgrp root /etc/group\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38461)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The /etc/group file must have mode 0644 or less permissive.'
                  else
                      log_msg $1 $2 '/etc/group文件的权限必须为root用户可读写、root组可读、其它用户可读的权限或更小的权限。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000044\n\nVulnerability Discussion: The "/etc/group" file contains information regarding groups that are configured on the system. Protection of this file is important for system security.\n\nFix text: To properly set the permissions of "/etc/group", run the command:\n\n#chmod 0644 /etc/group\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38465)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'Library files must have mode 0755 or less permissive.'
                  else
                      log_msg $1 $2 '库文件的权限必须为root用户可读写可执行、root组可读与执行、其它用户可读可执行的权限或更小的权限。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000045\n\nVulnerability Discussion: Files from shared library directories are loaded into the address space of processes (including privileged ones) or of the kernel itself at runtime. Restrictive permissions are necessary to protect the integrity of the system.\n\nFix text: ystem-wide shared library files, which are linked to executables during process load time or run
time, are stored in the following directories by default:\n\n/lib\n/lib64\n/usr/lib\n/usr/lib64\n\nIf any file in these directories is found to be group-writable or world-writable, correct its permission with the following command:\n\n#chmod go-w [FILE]\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38466)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'Library files must be owned by root.'
                  else
                      log_msg $1 $2 '库文件的属主必须为root用户。'
                  fi
                  if [ $2 -ne 0 ]; then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000046\n\nVulnerability Discussion:  Files from shared library directories are loaded into the address space of processes (including privileged ones) or of the kernel itself at runtime. Proper ownership is necessary to protect the integrity of the system.\n\nFix text: System-wide shared library files, which are linked to executables during process load time or run time, are stored in the following directories by default:\n\n/lib\n/lib64\n/usr/lib\n/usr/lib64\n\nIf any file in these directories is found to be owned by a user other than root, correct its ownership with the following command:\n\n#chown root [FILE]\n\n######################\n\n' >> $LOG
                      find -L /lib  \! -user root  -exec ls -l {} \; | grep -v '> /dev/null'
                      if [ -d /lib64 ]; then
                          find -L /lib64  \! -user root  -exec ls -l {} \;
                      fi
                      find -L /usr/lib -path /usr/lib/prosody -prune -o \! -user root  -exec ls -l {} \;
                      if [ -d /usr/lib64 ]; then
                          find -L /usr/lib64  \! -user root  -exec ls -l {} \;
                      fi
                  fi
                  ;;
        V-7824824) log_msg $1 $2 'Kernel address space layout randomization must be enabled'
                   if [ $2 -ne 0 ];then
                       printf '\n######################\n\nSTIG-ID:V-7824824\n\nVulnerability Discussion:  The kernel address space should be randomized in order to prevent an attacker from being able to poke bits to specific offsets.\n\n######################\n\n' >> $LOG
                   fi
                   echo "2" > /proc/sys/kernel/randomize_va_space
                   ;;
        V-38469)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'All system command files must have mode 755 or less permissive.'
                  else
                      log_msg $1 $2 '所有的系统命令文件的权限必须为root用户可读写可执行、root组可读与执行、其它用户可读可执行的权限或更小的权限。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000047\n\nVulnerability Discussion: System binaries are executed by privileged users, as well as system services, and restrictive permissions are necessary to ensure execution of these programs cannot be co-opted.\n\nFix text: System executables are stored in the following directories by default:\n\n/bin\n/usr/bin\n/usr/local/bin\n/sbin\n/usr/sbin\n/usr/local/sbin\n\nIf any file in these directories is found to be group-writable or world-writable, correct its permission with the following command:\n\n#chmod go-w [FILE]\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38472)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'All system command files must be owned by root.'
                  else
                      log_msg $1 $2 '所有系统命令文件的属主必须为root用户。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000048\n\nVulnerability Discussion: System binaries are executed by privileged users as well as system services, and restrictive permissions are necessary to ensure that their execution of these programs cannot be co-opted.\n\nFix text: System executables are stored in the following directories by default:\n\n/bin\n/usr/bin\n/usr/local/bin\n/sbin\n/usr/sbin\n/usr/local/sbin\n\nIf any file [FILE] in these directories is found to be owned by a user other than root, correct its ownership with the following command:\n\n#chown root [FILE]\n\n######################\n\n' >> $LOG
                      find -L /bin  \! -user root  -exec ls -l {} \;
                      find -L /usr/bin  \! -user root  -exec ls -l {} \;
                      find -L /usr/local/bin  \! -user root  -exec ls -l {} \;
                      find -L /sbin  \! -user root  -exec ls -l {} \;
                      find -L /usr/sbin  \! -user root  -exec ls -l {} \;
                      find -L /usr/local/sbin  \! -user root  -exec ls -l {} \;
                  fi
                  ;;
        V-38475)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The system must require passwords to contain a minimum of 14 characters.'
                  else
                      log_msg $1 $2 "登录系统的密码必须包含一个至少14个字符。"
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000025\n\nVulnerability Discussion: Requiring a minimum password length makes password cracking attacks more difficult by ensuring a larger search space. However, any security benefit from an onerous requirement must be carefully weighed against usability problems, support costs, or counterproductive behavior that may result.\n\nWhile it does not negate the password length requirement, it is preferable to migrate from a password-based authentication scheme to a stronger one based on PKI (public key infrastructure).\n\nFix text: To specify password length requirements for new accounts, edit the file "/etc/login.defs" and add or correct the following lines:\n\nPASS_MIN_LEN 14\n\nThe LibreServer requirement is "14". If a program consults "/etc/login.defs" and also another PAM module (such as"pam_cracklib") during a password change operation, then the most restrictive must be satisfied.\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38477)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'Users must not be able to change passwords more than once every 24 hours.'
                  else
                      log_msg $1 $2 "用户在24小时内不能够再次修改密码。"
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000051\n\nVulnerability Discussion: Setting the minimum password age protects against users cycling back to a favorite password after satisfying the password reuse requirement.\n\nFix text: To specify password minimum age for new accounts, edit the file "/etc/login.defs" and add or correct the following line, replacing [DAYS] appropriately:\n\nPASS_MIN_DAYS [DAYS]\n\nA value of 1 day is considered sufficient for many environments. The LibreServer requirement is 1.\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38479)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'User passwords must be changed at least every 60 days.'
                  else
                      log_msg $1 $2 "用户密码必须至少每60天进行修改。"
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000053\n\nVulnerability Discussion: Setting the password maximum age ensures users are required to periodically change their passwords. This could possibly decrease the utility of a stolen password. Requiring shorter password lifetimes increases the risk of users writing down the password in a convenient location subject to physical compromise.\n\nFix text: To specify password maximum age for new accounts, edit the file "/etc/login.defs" and add or correct the following line, replacing [DAYS] appropriately:\n\nPASS_MAX_DAYS [DAYS]\n\nThe LibreServer requirement is 60.\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38480)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'Users must be warned 7 days in advance of password expiration.'
                  else
                      log_msg $1 $2 "必须在密码无效的7天前对用户进行警告。"
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000054\n\nVulnerability Discussion: Setting the password warning age enables users to make the change at a practical time.\n\nFix text: To specify how many days prior to password expiration that a warning will be issued to users, edit the file "/etc/login.defs" and add or correct the following line, replacing [DAYS] appropriately:\n\nPASS_WARN_AGE [DAYS]\n\nThe LibreServer requirement is 7.\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38482)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The system must require passwords to contain at least one numeric character.'
                  else
                      log_msg $1 $2 "密码必须包含1个数值字符。"
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000056\n\nVulnerability Discussion: Requiring digits makes password guessing attacks more difficult by ensuring a larger search space.\n\nFix text: The pam_cracklib module\047s "dcredit" parameter controls requirements for usage of digits in a password. When set to a negative number, any password will be required to contain that many digits. When set to a positive number, pam_cracklib will grant +1 additional length credit for each digit. Add "dcredit=-1" after pam_cracklib.so to require use of a digit in passwords.  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38569)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The system must require passwords to contain at least one uppercase alphabetic character.'
                  else
                      log_msg $1 $2 "密码必须包含至少1个大写字母字符。"
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000057\n\nVulnerability Discussion: Requiring a minimum number of uppercase characters makes password guessing attacks more difficult by ensuring a larger search space.\n\nFix text: The pam_cracklib module\047s "ucredit=" parameter controls requirements for usage of uppercase letters in a password. When set to a negative number, any password will be required to contain that many uppercase characters. When set to a positive number, pam_cracklib will grant +1 additional length credit for each uppercase character. Add "ucredit=-1" after pam_cracklib.so to require use of an uppercase character in passwords.  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38570)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The system must require passwords to contain at least one special character.'
                  else
                      log_msg $1 $2 "密码必须包含至少1个特殊字符。"
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000058\n\nVulnerability Discussion: Requiring a minimum number of special characters makes password guessing attacks more difficult by ensuring a larger search space.\n\nFix text:  The pam_cracklib module\047s "ocredit=" parameter controls requirements for usage of special (or ``other'') characters in a password. When set to a negative number, any password will be required to contain that many special characters. When set to a positive number, pam_cracklib will grant +1 additional length credit for each special character. Add "ocredit=-1" after pam_cracklib.so to require use of a special character in passwords.\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38571)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The system must require passwords to contain at least one lowercase alphabetic character.'
                  else
                      log_msg $1 $2 "密码必须包含至少1个小写的字母字符。"
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000059\n\nVulnerability Discussion: Requiring a minimum number of lowercase characters makes password guessing attacks more difficult by ensuring a larger search space.\n\nFix text: The pam_cracklib module\047s "lcredit=" parameter controls requirements for usage of lowercase letters in a password. When set to a negative number, any password will be required to contain that many lowercase characters. When set to a positive number, pam_cracklib will grant +1 additional length credit for each lowercase character. Add "lcredit=-1" after pam_cracklib.so to require use of a lowercase character in passwords.  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38572)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The system must require at least four characters be changed between the old and new passwords during a password change.'
                  else
                      log_msg $1 $2 "系统要求在修改密码的时候旧的密码与新的密码之间必须有至少4个字符进行了修改。"
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000060\n\nVulnerability Discussion: Requiring a minimum number of different characters during password changes ensures that newly changed passwords should not resemble previously compromised ones. Note that passwords which are changed on compromised systems will still be compromised, however.\n\nFix text: The pam_cracklib module\047s "difok" parameter controls requirements for usage of different characters during a password change. Add "difok=[NUM]" after pam_cracklib.so to require differing characters when changing passwords, substituting [NUM] appropriately. The LibreServer requirement is 4.  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38573)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The system must disable accounts after ten consecutive unsuccessful login attempts.'
                  else
                      log_msg $1 $2 "系统必须在连续3次失败的登录尝试后禁用帐号。"
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000061\n\nVulnerability Discussion: Locking out user accounts after a number of incorrect attempts prevents direct password guessing attacks.\n\nFix text: To configure the system to lock out accounts after a number of incorrect login attempts using\npam_faillock.so\n\nAdd the following lines immediately below the "pam_unix.so" statement in the AUTH section of"/etc/pam.d/common-auth"\n\nauth required pam_faillock.so even_deny_root deny=3 unlock_time=604800 \n\nNote that any updates made to "/etc/pam.d/common-auth" may be overwritten by the "authconfig" program. The "authconfig" program should not be used.  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38574)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The system must use a FIPS 140-2 approved cryptographic hashing algorithm for generating account password hashes (system-auth).'
                  else
                      log_msg $1 $2 '系统必须使用FIPS 140-2认可的加密哈希算法生成帐号密码哈希值。(system-auth)'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000062\n\nVulnerability Discussion: Using a stronger hashing algorithm makes password cracking attacks more difficult.\n\nFix text: In "/etc/pam.d/common-password", among potentially other files, the "password" section of the files control which PAM modules execute during a password change. Set the "pam_unix.so" module in the "password" section to include the argument "sha512", as shown below: \n\npassword sufficient pam_unix.so sha512 [other arguments...]\n\nThis will help ensure when local users change their passwords, hashes for the new passwords will be generated using the SHA-512 algorithm. This is the default.\n\nNote that any updates made to "/etc/pam.d/common-password" will be overwritten by the "authconfig" program. The "authconfig" program should not be used.  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38576)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The system must use a FIPS 140-2 approved cryptographic hashing algorithm for generating account password hashes (login.defs).'
                  else
                      log_msg $1 $2 '系统必须使用FIPS 140-2认可的加密哈希算法生成帐号密码哈希值。(login.defs)'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000063\n\nVulnerability Discussion: Using a stronger hashing algorithm makes password cracking attacks more difficult.\n\nFix text: In "/etc/login.defs", add or correct the following line to ensure the system will use SHA-512 as the hashing algorithm:\n\nENCRYPT_METHOD SHA512\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38577)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The system must use a FIPS 140-2 approved cryptographic hashing algorithm for generating account password hashes (libuser.conf).'
                  else
                      log_msg $1 $2 '系统必须使用FIPS 140-2认可的加密哈希算法生成帐号密码哈希值。(libuser.conf)'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000064\n\nVulnerability Discussion: Using a stronger hashing algorithm makes password cracking attacks more difficult.\n\nFix text: In "/etc/libuser.conf", add or correct the following line in its "[defaults]" section to ensure the system will use the SHA-512 algorithm for password hashing:\n\ncrypt_style = sha512  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-78252)  log_msg $1 $2 'netcat (nc) should not be installed on this system'
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:WTF-05-000179\n\nHaving netcat present makes life extra convenient for anyone breaking into your system.\nMake them do the work of installing it or downloading it, which increases the defensive possibilities.\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38579)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The system boot loader configuration file(s) must be owned by root.'
                  else
                      log_msg $1 $2 '系统的启动加载器配置文件的属主必须为root用户。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000065\n\nVulnerability Discussion: Only root should be able to modify important boot parameters.\n\nFix text: The file "/boot/grub/grub.cfg" should be owned by the "root" user to prevent destruction or modification of the file. To properly set the owner of "/boot/grub/grub.cfg", run the command:\n\nchown root /boot/grub/grub.cfg\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38581)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The system boot loader configuration file(s) must be group-owned by root.'
                  else
                      log_msg $1 $2 '系统的启动加载器配置文件所属组必须属于root组。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000066\n\nVulnerability Discussion: The "root" group is a highly-privileged group. Furthermore, the group-owner of this file should not have any access privileges anyway.\n\nFix text: The file "/boot/grub/grub.cfg" should be group-owned by the "root" group to prevent destruction or modification of the file. To properly set the group owner of "/boot/grub/grub.cfg", run the command:\n\nchgrp root /boot/grub/grub.cfg\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38583)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The system boot loader configuration file(s) must have mode 0600 or less permissive.'
                  else
                      log_msg $1 $2 '系统启动加载器的配置文件必须为仅使root用户具有读写的权限，其他用户无任何权限或更小的权限控制。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000067\n\nVulnerability Discussion: Proper permissions ensure that only the root user can modify important boot parameters.\n\nFix text: File permissions for "/boot/grub/grub.cfg" should be set to 600, which is the default. To properly set the permissions of "/boot/grub/grub.cfg", run the command:\n\n#chmod 600 /boot/grub/grub.cfg\n\nBoot partitions based on VFAT, NTFS, or other non-standard configurations may require alternative measures.\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38585)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The system boot loader must require authentication.'
                  else
                      log_msg $1 $2 '系统启动加载器必须需要验证。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000068\n\nVulnerability Discussion: Password protection on the boot loader configuration ensures users with physical access cannot trivially alter important bootloader settings. These include which kernel to use, and whether to enter single-user mode.\n\nFix text: The grub boot loader should have password protection enabled to protect boot-time settings. To do
so, select a password and then generate a hash from it by running the following command:\n\n#grub-mkpasswd-pbkdf2\n\nWhen prompted to enter a password, insert the following line into "/etc/default/grub" immediately after the header comments.And run the following command:\n\n#grub-mkconfig\n\nTo generating configuration file(s)\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38590)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The system must allow locking of the console screen in text mode.'
                  else
                      log_msg $1 $2 '系统必须能够在文本模式下对终端屏幕进行锁定。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000071\n\nVulnerability Discussion: Installing "screen" ensures a console locking capability is available for users who may need to suspend console logins.\n\nFix text: To enable console screen locking when in text mode, install the "screen" package:\n\n#apt-get install screen\n\nInstruct users to begin new terminal sessions with the following command:\n\n$ screen\n\nThe console can now be locked with the following key combination:\n\nctrl+a x\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38596)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The system must implement virtual address space randomization.'
                  else
                      log_msg $1 $2 '系统必须使虚拟地址空间随机化功能生效。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000078\n\nVulnerability Discussion: Address space layout randomization (ASLR) makes it more difficult for an attacker to predict the location of attack code he or she has introduced into a process\047s address space during
an attempt at exploitation. Additionally, ASLR also makes it more difficult for an attacker to know the location of existing code in order to repurpose it using return oriented programming (ROP) techniques.\n\nFix text: \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38600)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The system must not send ICMPv4 redirects by default.'
                  else
                      log_msg $1 $2 '系统默认情况下必须不进行ICMPV4重定向消息。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000080\n\nVulnerability Discussion: Sending ICMP redirects permits the system to instruct other systems to update their routing information. The ability to send ICMP redirects is only appropriate for systems acting as routers.\n\nFix text: To set the runtime status of the "net.ipv4.conf.default.send_redirects" kernel parameter, run the following command:\n\n# sysctl -w net.ipv4.conf.default.send_redirects=0\n\nIf this is not the system\047s default value, add the following line to "/etc/sysctl.conf":\n\nnet.ipv4.conf.default.send_redirects = 0  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38601)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The system must not send ICMPv4 redirects from any interface.'
                  else
                      log_msg $1 $2 '系统必须从任何接口都不能发送ICMPv4重定向消息。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000081\n\nVulnerability Discussion: Sending ICMP redirects permits the system to instruct other systems to update their routing information. The ability to send ICMP redirects is only appropriate for systems acting as routers.\n\nFix text: \n\nTo set the runtime status of the "net.ipv4.conf.all.send_redirects" kernel parameter, run the following command:\n\n# sysctl -w net.ipv4.conf.all.send_redirects=0\n\nIf this is not the system\047s default value, add the following line to "/etc/sysctl.conf":\n\nnet.ipv4.conf.all.send_redirects = 0\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38511)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'IP forwarding for IPv4 must not be enabled, unless the system is a router.'
                  else
                      log_msg $1 $2 'IPv4的IP转发功能必须没有开启，除非此系统本身是作为路由器进行使用。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000082\n\nVulnerability Discussion: IP forwarding permits the kernel to forward packets from one network interface to another. The ability to forward packets between two networks is only appropriate for systems acting as routers.\n\nFix text: To set the runtime status of the "net.ipv4.ip_forward" kernel parameter, run the following command:\n\n# sysctl -w net.ipv4.ip_forward=0\n\nIf this is not the system\047s default value, add the following line to "/etc/sysctl.conf":\n\nnet.ipv4.ip_forward = 0\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38523)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The system must not accept IPv4 source-routed packets on any interface.'
                  else
                      log_msg $1 $2 '系统必须不接受来自任何接口的IPv4的源路径包。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000083\n\nVulnerability Discussion: Accepting source-routed packets in the IPv4 protocol has few legitimate uses. It should be disabled unless it is absolutely required.\n\nFix text: To set the runtime status of the "net.ipv4.conf.all.accept_source_route" kernel parameter, run the following command: \n\n# sysctl -w net.ipv4.conf.all.accept_source_route=0\n\nIf this is not the system\047s default value, add the following line to "/etc/sysctl.conf":\n\nnet.ipv4.conf.all.accept_source_route = 0  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38524)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The system must not accept ICMPv4 redirect packets on any interface.'
                  else
                      log_msg $1 $2 '系统必须不接受任意接口的ICMPv4重定向包。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000084\n\nVulnerability Discussion: Accepting ICMP redirects has few legitimate uses. It should be disabled unless it is absolutely required.\n\nFix text: To set the runtime status of the "net.ipv4.conf.all.accept_redirects" kernel parameter, run the following command:\n\n# sysctl -w net.ipv4.conf.all.accept_redirects=0\n\nIf this is not the system\047s default value, add the following line to "/etc/sysctl.conf":\n\nnet.ipv4.conf.all.accept_redirects = 0  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38526)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The system must not accept ICMPv4 secure redirect packets on any interface.'
                  else
                      log_msg $1 $2 '系统必须不接受任意接口的ICMPv4安全重定向包。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000086\n\nVulnerability Discussion: Accepting "secure" ICMP redirects (from those gateways listed as default gateways) has few legitimate uses. It should be disabled unless it is absolutely required.\n\nFix text: To set the runtime status of the "net.ipv4.conf.all.secure_redirects" kernel parameter, run the following command:\n\n# sysctl -w  net.ipv4.conf.all.secure_redirects=0\n\nIf this is not the system\047s default value, add the following line to "/etc/sysctl.conf":\n\nnet.ipv4.conf.all.secure_redirects = 0  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38528)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The system must log Martian packets.'
                  else
                      log_msg $1 $2 '系统必须记录具有不可能地址的包。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000088\n\nVulnerability Discussion: The presence of "martian" packets (which have impossible addresses) as well asspoofed packets, source-routed packets, and redirects could be a sign of nefarious network activity. Logging these packets enables this activity to be detected.\n\nFix text: To set the runtime status of the "net.ipv4.conf.all.log_martians" kernel parameter, run the following command:\n\n# sysctl -w net.ipv4.conf.all.log_martians=1\n\nIf this is not the system\047s default value, add the following line to "/etc/sysctl.conf":\n\nnet.ipv4.conf.all.log_martians = 1\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38529)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The system must not accept IPv4 source-routed packets by default.'
                  else
                      log_msg $1 $2 '系统必须不接受默认的IPv4的源路由包。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000089\n\nVulnerability Discussion: Accepting source-routed packets in the IPv4 protocol has few legitimate uses. It should be disabled unless it is absolutely required.\n\nFix text: To set the runtime status of the "net.ipv4.conf.default.accept_source_route" kernel parameter, run the following command:\n\n# sysctl -w net.ipv4.conf.default.accept_source_route=0\n\nIf this is not the system\047s default value, add the following line to "/etc/sysctl.conf":\n\nnet.ipv4.conf.default.accept_source_route = 0  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38532)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The system must not accept ICMPv4 secure redirect packets by default.'
                  else
                      log_msg $1 $2 '系统必须不接受ICMPv4默认的安全重定向包。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000090\n\nVulnerability Discussion: Accepting "secure" ICMP redirects (from those gateways listed as default gateways) has few legitimate uses. It should be disabled unless it is absolutely required.\n\nFix text: To set the runtime status of the "net.ipv4.conf.default.secure_redirects" kernel parameter, run the following command:\n\n# sysctl -w net.ipv4.conf.default.secure_redirects=0\n\nIf this is not the system\047s default value, add the following line to "/etc/sysctl.conf":\n\nnet.ipv4.conf.default.secure_redirects = 0\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38533)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The system must ignore ICMPv4 redirect messages by default.'
                  else
                      log_msg $1 $2 '系统必须忽略默认的ICMPv4的重定向消息。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000091\n\nVulnerability Discussion: This feature of the IPv4 protocol has few legitimate uses. It should be disabled unless it is absolutely required.\n\nFix text: To set the runtime status of the "net.ipv4.conf.default.accept_redirects" kernel parameter, run the following command:\n\n# sysctl -w net.ipv4.conf.default.accept_redirects=0\n\nIf this is not the system\047s default value, add the following line to "/etc/sysctl.conf":\n\nnet.ipv4.conf.default.accept_redirects = 0  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38535)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The system must not respond to ICMPv4 sent to a broadcast address.'
                  else
                      log_msg $1 $2 '系统必须不响应ICMPv4发送的一个广播地址。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000092\n\nVulnerability Discussion: The system must not respond to ICMPv4 sent to a broadcast address.\n\nFix text: Ignoring ICMP echo requests (pings) sent to broadcast or multicast addresses makes the system slightly more difficult to enumerate on the network.\n\nTo set the runtime status of the "net.ipv4.icmp_echo_ignore_broadcasts" kernel parameter, run the following command:\n\n# sysctl -w net.ipv4.icmp_echo_ignore_broadcasts=1\n\nIf this is not the system\047s default value, add the following line to "/etc/sysctl.conf":\n\nnet.ipv4.icmp_echo_ignore_broadcasts = 1  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38537)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The system must ignore ICMPv4 bogus error responses.'
                  else
                      log_msg $1 $2 '系统必须忽略ICMPv4伪造的错误的回应。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000093\n\nVulnerability Discussion: Ignoring bogus ICMP error responses reduces log size, although some activity would not be logged.\n\nFix text: To set the runtime status of the "net.ipv4.icmp_ignore_bogus_error_responses" kernel parameter, run the following command:\n\n# sysctl -w net.ipv4.icmp_ignore_bogus_error_responses=1\n\nIf this is not the system\047s default value, add the following line to "/etc/sysctl.conf":\n\nnet.ipv4.icmp_ignore_bogus_error_responses = 1  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38539)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The system must be configured to use TCP syncookies when experiencing a TCP SYN flood.'
                  else
                      log_msg $1 $2 '系统必须配置synccookies防止TCP SYN洪水攻击。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000095\n\nVulnerability Discussion: A TCP SYN flood attack can cause a denial of service by filling a system\047s TCP connection table with connections in the SYN_RCVD state. Syncookies can be used to track a connection when a subsequent ACK is received, verifying the initiator is attempting a valid connection and is not a flood source. This feature is activated when a flood condition is detected, and enables the system to continue servicing valid connection requests.\n\nFix text: To set the runtime status of the "net.ipv4.tcp_syncookies" kernel parameter, run the following command:\n\n# sysctl -w net.ipv4.tcp_syncookies=1\n\nIf this is not the system\047s default value, add the following line to "/etc/sysctl.conf":\n\nnet.ipv4.tcp_syncookies = 1  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38542)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The system must use a reverse-path filter for IPv4 network traffic when possible on all interfaces.'
                  else
                      log_msg $1 $2 '系统必须使用一个反向路径过滤器对IPv4网络流量进行过滤。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000096\n\nVulnerability Discussion: Enabling reverse path filtering drops packets with source addresses that should not have been able to be received on the interface they were received on. It should not be used on systems which are routers for complicated networks, but is helpful for end hosts and routers serving small networks.\n\nFix text: To set the runtime status of the "net.ipv4.conf.all.rp_filter" kernel parameter, run the following command:\n\n# sysctl -w net.ipv4.conf.all.rp_filter=1\n\nIf this is not the system\047s default value, add the following line to "/etc/sysctl.conf":\n\nnet.ipv4.conf.all.rp_filter = 1\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38544)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The system must use a reverse-path filter for IPv4 network traffic when possible by default.'
                  else
                      log_msg $1 $2 '系统默认情况下必须使用一个反向路径过滤器对IPv4网络传输流量进行过滤。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000097\n\nVulnerability Discussion: Enabling reverse path filtering drops packets with source addresses that should not have been able to be received on the interface they were received on. It should not be used on systems which are routers for complicated networks, but is helpful for end hosts and routers serving small networks.\n\nFix text: To set the runtime status of the "net.ipv4.conf.default.rp_filter" kernel parameter, run the following command:\n\n# sysctl -w net.ipv4.conf.default.rp_filter=1\n\nIf this is not the system\047s default value, add the following line to "/etc/sysctl.conf":\n\nnet.ipv4.conf.default.rp_filter = 1\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38546)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The IPv6 protocol handler must not be bound to the network stack unless needed.'
                  else
                      log_msg $1 $2 'IPv6协议处理器必须没有参与网络协议栈的处理，除非需要对IPv6进行处理。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000098\n\nVulnerability Discussion: Any unnecessary network stacks - including IPv6 - should be disabled, to reduce the vulnerability to exploitation.\n\nFix text: To disable IPv6 networking stack ,add the following line to "/etc/default/grub"\n\nFind the line that contain "GRUB_CMDLINE_LINUX_DEFAULT":\n\nGRUB_CMDLINE_LINUX_DEFAULT="quiet splash"
\n\nAdd "ipv6.disable=1" to the boot option, then save your grub file:\n\nGRUB_CMDLINE_LINUX_DEFAULT="ipv6.disable=1 quiet splash"\n\nsudo update-grub\n\nFor more details You could visit:http://askubuntu.com/questions/309461/how-to-disable-ipv6-permanently\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38548)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The system must ignore ICMPv6 redirects by default.'
                  else
                      log_msg $1 $2 '系统必须忽略默认的ICMPv6重定向包。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000099\n\nVulnerability Discussion: An illicit ICMP redirect message could result in a man-in-the-middle attack.\n\nFix text: To set the runtime status of the "net.ipv6.conf.default.accept_redirects" kernel parameter, run the following command:\n\n# sysctl -w net.ipv6.conf.default.accept_redirects=0\n\nIf this is not the system\047s default value, add the following line to "/etc/sysctl.conf":\n\nnet.ipv6.conf.default.accept_redirects = 0\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38513)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The systems local IPv4 firewall must implement a deny-all, allow-by-exception policy for inbound packets.'
                  else
                      log_msg $1 $2 '系统本地IPv4防火墙必须实现拒绝全部数据包，允许对于例外包按例外策略进行接收。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000120\n\nVulnerability Discussion: In "iptables" the default policy is applied only after all the applicable rules in the table are examined for a match. Setting the default policy to "DROP" implements proper design for a firewall, i.e., any packets which are not explicitly permitted should not be accepted.\n\nFix text: To set the default policy to DROP (instead of ACCEPT) for the built-in INPUT chain which processes incoming packets, you could use following command:\n\n#iptables -P INPUT DROP\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38514)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The Datagram Congestion Control Protocol (DCCP) must be disabled unless required.'
                  else
                      log_msg $1 $2 '数据报拥塞控制协议必须设置为失效，除非需要。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000124\n\nVulnerability Discussion: Disabling DCCP protects the system against exploitation of any flaws in its implementation.\n\nFix text: The Datagram Congestion Control Protocol (DCCP) is a relatively new transport layer protocol, designed to support streaming media and telephony. To configure the system to prevent the "dccp" kernel module from being loaded, add the following line to a file in the directory "/etc/modprobe.d":\n\ninstall dccp /bin/true\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38515)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The Stream Control Transmission Protocol (SCTP) must be disabled unless required.'
                  else
                      log_msg $1 $2 '流控制传输协议必须设置为失效，除非需要。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000125\n\nVulnerability Discussion: Disabling SCTP protects the system against exploitation of any flaws in its implementation.\n\nFix text: The Stream Control Transmission Protocol (SCTP) is a transport layer protocol, designed to support the idea of message-oriented communication, with several streams of messages within one connection. To configure the system to prevent the "sctp" kernel module from being loaded, add the following line to a file in the directory "/etc/modprobe.d":\n\ninstall sctp /bin/true  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38516)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The Reliable Datagram Sockets (RDS) protocol must be disabled unless required.'
                  else
                      log_msg $1 $2 '可靠数据报套接字协议必须设置为失效，除非需要。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000126\n\nVulnerability Discussion: \n\nFix text: Disabling RDS protects the system against exploitation of any flaws in its implementation.\n\nThe Reliable Datagram Sockets (RDS) protocol is a transport layer protocol designed to provide reliable high-bandwidth, low-latency communications between nodes in a cluster. To configure the system to prevent the "rds" kernel module from being loaded, add the following line to a file in the directory "/etc/modprobe.d":\n\ninstall rds /bin/true  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38517)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The Transparent Inter-Process Communication (TIPC) protocol must be disabled unless required.'
                  else
                      log_msg $1 $2 '除非所要求的透明進程間通信（TIPC）协议必须被禁止。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000127\n\nVulnerability Discussion: Disabling TIPC protects the system against exploitation of any flaws in its implementation.\n\nFix text: The Transparent Inter-Process Communication (TIPC) protocol is designed to provide communications between nodes in a cluster. To configure the system to prevent the "tipc" kernel module from being loaded, add the following line to a file in the directory "/etc/modprobe.d":\n\ninstall tipc /bin/true  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38518)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'All rsyslog-generated log files must be owned by root.'
                  else
                      log_msg $1 $2 '系统生成的所有日志文件的属主必须为root用户。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000133\n\nVulnerability Discussion: The log files generated by rsyslog contain valuable information regarding system configuration, user authentication, and other such information. Log files should be protected from unauthorized access.\n\nFix text: The owner of all log files written by "rsyslog" should be root. These log files are determined by the second part of each Rule line in "/etc/rsyslog.conf" typically all appear in "/var/log". For each log file [LOGFILE] referenced in "/etc/rsyslog.conf", run the following command to inspect the file\047s owner:\n\n$ ls -l [LOGFILE]\n\nIf the owner is not "root", run the following command to correct this:\n\n# chown root [LOGFILE]\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38519)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'All rsyslog-generated log files must be group-owned by root.'
                  else
                      log_msg $1 $2 '系统生成的所有日志文件的属组必须为root组。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000134\n\nVulnerability Discussion: The log files generated by rsyslog contain valuable information regarding system configuration, user authentication, and other such information. Log files should be protected from unauthorized access.\n\nFix text: The group-owner of all log files written by "rsyslog" should be root. These log files are determined by the second part of each Rule line in "/etc/rsyslog.conf" and typically all appear in "/var/log". For each log file [LOGFILE] referenced in "/etc/rsyslog.conf", run the following command to inspect the file\047s group owner:\n\n$ ls -l [LOGFILE]\n\nIf the owner is not "root", run the following command to correct this:\n\n# chgrp root [LOGFILE]\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38623)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'All rsyslog-generated log files must have mode 0600 or less permissive.'
                  else
                      log_msg $1 $2 '系统生成的所有日志文件的权限必须为仅为root用户可读写或更小的权限。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000135\n\nVulnerability Discussion: Log files can contain valuable information regarding system configuration. If the system log files are not protected, unauthorized users could change the logged data, eliminating their forensic value.\n\nFix text: The file permissions for all log files written by rsyslog should be set to 600, or more restrictive. These log files are determined by the second part of each Rule line in "/etc/rsyslog.conf" and typically all appear in "/var/log". For each log file [LOGFILE] referenced in "/etc/rsyslog.conf", run the following command to inspect the file\047s permissions:\n\n$ ls -l [LOGFILE]\n\nIf the permissions are not 600 or more restrictive, run the following command to correct this:\n\n# chmod 0600 [LOGFILE]  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38520)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The operating system must back up audit records on an organization defined frequency onto a different system or media than the system being audited.'
                  else
                      log_msg $1 $2 '操作系统必须按周期备份审计记录到不同的系统。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000136\n\nVulnerability Discussion: A log server (loghost) receives syslog messages from one or more systems. This data can be used as an additional log source in the event a system is compromised and its local logs are suspect. Forwarding log messages to a remote loghost also provides system administrators with a centralized place to view the status of multiple hosts within the enterprise.\n\nFix text: To configure rsyslog to send logs to a remote log server, open "/etc/rsyslog.conf" and read and understand the last section of the file, which describes the multiple directives necessary to activate remote logging. Along with these other directives, the system can be configured to forward its logs to a particular log server by adding or correcting one of the following lines, substituting "[loghost.example.com]" appropriately. The choice of protocol depends on the environment of the system; although TCP and RELP provide more reliable message delivery, they may not be supported in all environments.\nTo use UDP for log message delivery:\n\n*.* @[loghost.example.com]\n\nTo use TCP for log message delivery:\n\n*.* @@[loghost.example.com]\n\nTo use RELP for log message delivery:\n\n*.* :omrelp:[loghost.example.com]  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38521)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The operating system must support the requirement to centrally manage the content of audit records generated by organization defined information system components.'
                  else
                      log_msg $1 $2 '操作系统必须支持集中管理的组织所定义的信息系统组件生成的审计记录的内容的要求。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000137\n\nVulnerability Discussion: A log server (loghost) receives syslog messages from one or more systems. This data can be used as an additional log source in the event a system is compromised and its local logs are suspect. Forwarding log messages to a remote loghost also provides system administrators with a centralized place to view the status of multiple hosts within the enterprise.\n\nFix text: To configure rsyslog to send logs to a remote log server, open "/etc/rsyslog.conf" and read and understand the last section of the file, which describes the multiple directives necessary to activate remote logging. Along with these other directives, the system can be configured to forward its logs to a particular log server by adding or correcting one of the following lines, substituting "[loghost.example.com]" appropriately. The choice of protocol depends on the environment of the system; although TCP and RELP provide more reliable message delivery, they may not be supported in all environments.\nTo use UDP for log message delivery:\n\n*.* @[loghost.example.com]\n\nTo use TCP for log message delivery:\n\n*.* @@[loghost.example.com]\n\nTo use RELP for log message delivery:\n\n*.* :omrelp:[loghost.example.com]  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38624)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'System logs must be rotated daily.'
                  else
                      log_msg $1 $2 '系统日志必须进行日常的滚动记录。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000138\n\nVulnerability Discussion: Log files that are not properly rotated run the risk of growing so large that they fill up the /var/log partition. Valuable logging information could be lost if the /var/log  partition becomes full.\n\nFix text: The "logrotate" service should be installed or reinstalled if it is not installed and operating properly, by running the following command:\n\n#apt-get install logrotate\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38628)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The operating system must produce audit records containing sufficient information to establish the identity of any user/subject associated with the event.'
                  else
                      log_msg $1 $2 '操作系统必须产生含有足够的信息来建立与该事件相关联的任何用户/主体的身份审核记录。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000145\n\nVulnerability Discussion: Ensuring the "auditd" service is active ensures audit records generated by the kernel can be written to disk, or that appropriate actions will be taken if other obstacles exist.\n\nFix text: The "auditd" service is an essential userspace component of the Linux Auditing System, as it is responsible for writing audit records to disk. The "auditd" service can be enabled with the following commands:\n\n#update-rc.d auditd defaults\n# service auditd start  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38631)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The operating system must employ automated mechanisms to facilitate the monitoring and control of remote access methods.'
                  else
                      log_msg $1 $2 '操作系统必须采用自动化的机制来促进远程接入方式监视和控制。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000148\n\nVulnerability Discussion: The operating system must employ automated mechanisms to facilitate the monitoring and control of remote access methods.\n\nFix text: The "auditd" service is an essential userspace component of the Linux Auditing System, as it is responsible for writing audit records to disk. The "auditd" service can be enabled with the following commands:\n\n#update-rc.d auditd defaults\n# service auditd start  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38632)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The operating system must produce audit records containing sufficient information to establish what type of events occurred.'
                  else
                      log_msg $1 $2 '操作系统必须生产含有足够的信息来确定发生了什么类型的事件的审计记录。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000154\n\nVulnerability Discussion: Ensuring the "auditd" service is active ensures audit records generated by the kernel can be written to disk, or that appropriate actions will be taken if other obstacles exist.\n\nFix text: The "auditd" service is an essential userspace component of the Linux Auditing System, as it is responsible for writing audit records to disk. The "auditd" service can be enabled with the following commands:\n\n#update-rc.d auditd defaults\n# service auditd start  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38636)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The system must retain enough rotated audit logs to cover the required log retention period.'
                  else
                      log_msg $1 $2 '该系统必须保留足够的轮转审计日志覆盖所需的日志保留期限。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000159\n\nVulnerability Discussion: The total storage for audit log files must be large enough to retain log information over the period required. This is a function of the maximum log file size and the number of logs retained.\n\nFix text: Determine how many log files "auditd" should retain when it rotates logs. Edit the file "/etc/audit/auditd.conf". Add or modify the following line, substituting [NUMLOGS] with the correct value:\n\nnum_logs = [NUMLOGS]\n\nSet the value to 5 for general-purpose systems. Note that values less than 2 result in no log rotation.\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38633)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The system must set a maximum audit log file size.'
                  else
                      log_msg $1 $2 '系统必须设置最大的审计日志文件的大小。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000160\n\nVulnerability Discussion: The total storage for audit log files must be large enough to retain log information over the period required. This is a function of the maximum log file size and the number of logs retained.\n\nFix text: Determine the amount of audit data (in megabytes) which should be retained in each log file. Edit the file "/etc/audit/auditd.conf". Add or modify the following line, substituting the correct value for [STOREMB]:\n\nmax_log_file = [STOREMB]Set the value to "6" (MB) or higher for general-purpose systems. Larger values, of course, support retention of even more audit data.  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38634)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The system must rotate audit log files that reach the maximum file size.'
                  else
                      log_msg $1 $2 '该系统必须有转动，达到最大文件大小审核日志文件。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000161\n\nVulnerability Discussion: Automatically rotating logs (by setting this to "rotate") minimizes the chances of the system unexpectedly running out of disk space by being overwhelmed with log data. However, for systems that must never discard log data, or which use external processes to transfer it and reclaim space, "keep_logs" can be employed.\n\nFix text: The default action to take when the logs reach their maximum size is to rotate the log files, discarding the oldest one. To configure the action taken by "auditd", add or correct the line in "/etc/audit/auditd.conf":\n\nmax_log_file_action = [ACTION]\n\nPossible values for [ACTION] are described in the "auditd.conf" man page. These include:\n\n"ignore"\n"syslog"\n"suspend"\n"rotate"\n"keep_logs"\n\nSet the "[ACTION]" to "rotate" to ensure log rotation occurs. This is the default. The setting is case-insensitive.  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-54381)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The audit system must switch the system to single-user mode when available audit storage volume becomes dangerously low.'
                  else
                      log_msg $1 $2 '当可用的审计存储体积变得严重不足时审计系统必须切换至单用户模式。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000163\n\nVulnerability Discussion: Administrators should be made aware of an inability to record audit records. If a separate partition or logical volume of adequate size is used, running low on space for audit records should never occur.\n\nFix text: The "auditd" service can be configured to take an action when disk space is running low but prior to running out of space completely. Edit the file "/etc/audit/auditd.conf". Add or modify the following line, substituting [ACTION] appropriately:\n\nadmin_space_left_action = [ACTION]\n\nSet this value to "single" to cause the system to switch to single-user mode for corrective action. Acceptable values also include "suspend" and "halt". For certain systems, the need for availability outweighs the need to log all actions, and a different setting should be determined. Details regarding all possible values for [ACTION] are described in the "auditd.conf" man page.  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38635)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The audit system must be configured to audit all attempts to alter system time through adjtimex.'
                  else
                      log_msg $1 $2 '审计系统必须配置审核所有试图通过adjtimex修改系统时间。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000165\n\nVulnerability Discussion: Arbitrary changes to the system time can be used to obfuscate nefarious activities in log files, as well as to confuse network services that are highly dependent upon an accurate system time (such as sshd). All changes to the system time should be audited.\n\nFix text: On a 32-bit system, add the following to \"/etc/audit/audit.rules\": \n\n# audit_time_rules\n-a always,exit -F arch=b32 -S adjtimex -k audit_time_rules\n\nOn a 64-bit system, add the following to \"/etc/audit/audit.rules\": \n\n# audit_time_rules\n-a always,exit -F arch=b64 -S adjtimex -k audit_time_rules\n\nThe -k option allows for the specification of a key in string form that can be used for better reporting capability through ausearch and aureport. Multiple system calls can be defined on the same line to save space if desired, but is not required. See an example of multiple combined syscalls: \n\n-a always,exit -F arch=b64 -S adjtimex -S settimeofday -S clock_settime -k audit_time_rules\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38522)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The audit system must be configured to audit all attempts to alter system time through settimeofday.'
                  else
                      log_msg $1 $2 '审计系统必须配置审核所有试图通过settimeofday修改系统时间。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000167\n\nVulnerability Discussion: Arbitrary changes to the system time can be used to obfuscate nefarious activities in log files, as well as to confuse network services that are highly dependent upon an accurate system time (such as sshd). All changes to the system time should be audited.\n\nFix text: On a 32-bit system, add the following to \"/etc/audit/audit.rules\": \n\n# audit_time_rules\n-a always,exit -F arch=b32 -S settimeofday -k audit_time_rules\n\nOn a 64-bit system, add the following to \"/etc/audit/audit.rules\": \n\n# audit_time_rules\n-a always,exit -F arch=b64 -S settimeofday -k audit_time_rules\n\nThe -k option allows for the specification of a key in string form that can be used for better reporting capability through ausearch and aureport. Multiple system calls can be defined on the same line to save space if desired, but is not required. See an example of multiple combined syscalls: \n\n-a always,exit -F arch=b64 -S adjtimex -S settimeofday -S clock_settime -k audit_time_rules\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38525)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The audit system must be configured to audit all attempts to alter system time through stime.'
                  else
                      log_msg $1 $2 '审计系统必须配置审核所有试图通过STIME修改系统时间。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000169\n\nVulnerability Discussion: Arbitrary changes to the system time can be used to obfuscate nefarious activities in log files, as well as to confuse network services that are highly dependent upon an accurate system time (such as sshd). All changes to the system time should be audited.\n\nFix text: On a 32-bit system, add the following to \"/etc/audit/audit.rules\": \n\n# audit_time_rules\n-a always,exit -F arch=b32 -S stime -k audit_time_rules\n\nOn a 64-bit system, the \"-S stime\" is not necessary. The -k option allows for the specification of a key in string form that can be used for better reporting capability through ausearch and aureport. Multiple system calls can be defined on the same line to save space if desired, but is not required. See an example of multiple combined syscalls: \n\n-a always,exit -F arch=b64 -S adjtimex -S settimeofday -S clock_settime -k audit_time_rules\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38527)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The audit system must be configured to audit all attempts to alter system time through clock_settime.'
                  else
                      log_msg $1 $2 '审计系统必须配置审核所有试图通过clock_gettime修改系统时间。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000171\n\nVulnerability Discussion: Arbitrary changes to the system time can be used to obfuscate nefarious activities in log files, as well as to confuse network services that are highly dependent upon an  accurate system time (such as sshd). All changes to the system time should be audited.\n\nFix text: On a 32-bit system, add the following to "/etc/audit/audit.rules":\n\n# audit_time_rules\n-a always,exit -F arch=b32 -S clock_settime -k audit_time_rules\n\nOn a 64-bit system, add the following to "/etc/audit/audit.rules":\n\n# audit_time_rules\n\n-a always,exit -F arch=b64 -S clock_settime -k audit_time_rules\n\nThe -k option allows for the specification of a key in string form that can be used for better reporting capability through ausearch and aureport. Multiple system calls can be defined on the same line to save space if desired, but is not required. See an example of multiple combined syscalls:\n\n-a always,exit -F arch=b64 -S adjtimex -S settimeofday -S clock_settime -k audit_time_rules  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38530)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The audit system must be configured to audit all attempts to alter system time through /etc/localtime.'
                  else
                      log_msg $1 $2 '审计系统必须配置审核所有试图通过/etc/localtime对系统时间进行改变的行为。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000173\n\nVulnerability Discussion: Arbitrary changes to the system time can be used to obfuscate nefarious activities in log files, as well as to confuse network services that are highly dependent upon an accurate system time (such as sshd). All changes to the system time should be audited.\n\nFix text: Add the following to "/etc/audit/audit.rules":\n\n-w /etc/localtime -p wa -k audit_time_rules\n\nThe -k option allows for the specification of a key in string form that can be used for better reporting capability through ausearch and aureport and should always be used.\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38531)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The operating system must automatically audit account creation.'
                  else
                      log_msg $1 $2 '操作系统必须自动审核帐户创建。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000174\n\nVulnerability Discussion: In addition to auditing new user and group accounts, these watches will alert the
system administrator(s) to any modifications. Any unexpected users, groups, or modifications should be investigated for legitimacy.\n\nFix text: Add the following to "/etc/audit/audit.rules", in order to capture events that modify account changes:\n\n# audit_account_changes\n-w /etc/group -p wa -k audit_account_changes\n-w /etc/passwd -p wa -k audit_account_changes\n-w /etc/gshadow -p wa -k audit_account_changes\n-w /etc/shadow -p wa -k audit_account_changes\n-w /etc/security/opasswd -p wa -k audit_account_changes\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38534)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The operating system must automatically audit account modification.'
                  else
                      log_msg $1 $2 '操作系统必须自动审核帐户的修改。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000175\n\nVulnerability Discussion: In addition to auditing new user and group accounts, these watches will alert the system administrator(s) to any modifications. Any unexpected users, groups, or modifications should be investigated for legitimacy.\n\nFix text: Add the following to "/etc/audit/audit.rules", in order to capture events that modify account changes:\n\n# audit_account_changes\n-w /etc/group -p wa -k audit_account_changes\n-w /etc/passwd -p wa -k audit_account_changes\n-w /etc/gshadow -p wa -k audit_account_changes\n-w /etc/shadow -p wa -k audit_account_changes-w /etc/security/opasswd -p wa -k audit_account_changes\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38536)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The operating system must automatically audit account disabling actions.'
                  else
                      log_msg $1 $2 '操作系统必须自动审核帐号禁用的行为。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000176\n\nVulnerability Discussion:  In addition to auditing new user and group accounts, these watches will alert the system administrator(s) to any modifications. Any unexpected users, groups, or modifications should be investigated for legitimacy.\n\nFix text: Add the following to "/etc/audit/audit.rules", in order to capture events that modify account changes:\n\n#audit_account_changes\n-w /etc/group -p wa -k audit_account_changes\n-w /etc/passwd -p wa -k audit_account_changes\n-w /etc/gshadow -p wa -k audit_account_changes\n-w /etc/shadow -p wa -k audit_account_changes\n-w /etc/security/opasswd -p wa -k audit_account_changes\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38538)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The operating system must automatically audit account termination.'
                  else
                      log_msg $1 $2 '操作系统必须自动审核帐号的终止行为'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000177\n\nVulnerability Discussion: In addition to auditing new user and group accounts, these watches will alert the system administrator(s) to any modifications. Any unexpected users, groups, or modifications should be investigated for legitimacy.\n\nFix text: Add the following to "/etc/audit/audit.rules", in order to capture events that modify account changes:\n\n#audit_account_changes\n-w /etc/group -p wa -k audit_account_changes\n-w /etc/passwd -p wa -k audit_account_changes\n-w /etc/gshadow -p wa -k audit_account_changes\n-w /etc/shadow -p wa -k audit_account_changes\n-w /etc/security/opasswd -p wa -k audit_account_changes\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38540)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The audit system must be configured to audit modifications to the systems network configuration.'
                  else
                      log_msg $1 $2 '审核系统必须配置对系统网络配置的自动审核。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000182\n\nVulnerability Discussion: The network environment should not be modified by anything other than administrator action. Any change to network parameters should be audited.\n\nFix text: Add the following to "/etc/audit/audit.rules", setting ARCH to either b32 or b64 as appropriate for your system:\n\n# audit_network_modifications\n-a always,exit -F arch=ARCH -S sethostname -S setdomainname -k audit_network_modifications\n-w /etc/issue -p wa -k audit_network_modifications\n-w /etc/issue.net -p wa -k audit_network_modifications\n-w /etc/hosts -p wa -k audit_network_modifications\n-w /etc/sysconfig/network -p wa -k audit_network_modifications  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38541)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The audit system must be configured audit modifications to the systems Mandatory Access Control (MAC) configuration (Apparmor).'
                  else
                      log_msg $1 $2 '审核系统必须配置对强制访问控制（Apparmor）配置的修改的审核。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000183\n\nVulnerability Discussion: The system\047s mandatory access policy (Apparmor) should not be arbitrarily changed by anything other than administrator action. All changes to MAC policy should be audited.\n\nFix text: Add the following to "/etc/audit/audit.rules":\n\n-w /etc/apparmor/ -p wa -k apparmor\n-w /etc/apparmor.d/ -p wa -k apparmor\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38543)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The audit system must be configured to audit all discretionary access control permission modifications using chmod.'
                  else
                      log_msg $1 $2 '审核系统必须配置对通过chmod命令进行访问控制权限的修改行为进行审核。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000184\n\nVulnerability Discussion: The changing of file permissions could indicate that a user is attempting to gain access to information that would otherwise be disallowed. Auditing DAC modifications can facilitate the identification of patterns of abuse among both authorized and unauthorized users.\n\nFix text: At a minimum, the audit system should collect file permission changes for all users and root. Add the following to "/etc/audit/audit.rules":\n\n-a always,exit -F arch=b32 -S chmod -F auid>=500 -F auid!=4294967295 -k perm_mod\n-a always,exit -F arch=b32 -S chmod -F auid=0 -k perm_mod\n\nIf the system is 64-bit, then also add the following:-a always,exit -F arch=b64 -S chmod -F auid>=500 -F auid!=4294967295 -k perm_mod \n-a always,exit -F arch=b64 -S chmod -F auid=0 -k perm_mod  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38545)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The audit system must be configured to audit all discretionary access control permission modifications using chown.'
                  else
                      log_msg $1 $2 '审核系统必须配置对通过chown命令修改属主关系的所有行为进行审核。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000185\n\nVulnerability Discussion: The changing of file permissions could indicate that a user is attempting to gain access to information that would otherwise be disallowed. Auditing DAC modifications can facilitate the identification of patterns of abuse among both authorized and unauthorized users.\n\nFix text: At a minimum, the audit system should collect file permission changes for all users and root. Add the following to "/etc/audit/audit.rules":\n\n-a always,exit -F arch=b32 -S chown -F auid>=500 -F auid!=4294967295 -k perm_mod\n\n-a always,exit -F arch=b32 -S chown -F auid=0 -k perm_mod\n\nIf the system is 64-bit, then also add the following:\n\n-a always,exit -F arch=b64 -S chown -F auid>=500 -F auid!=4294967295 -k perm_mod\n-a always,exit -F arch=b64 -S chown -F auid=0 -k perm_mod \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38547)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The audit system must be configured to audit all discretionary access control permission modifications using fchmod.'
                  else
                      log_msg $1 $2 '审核系统必须配置对通过fchmod修改访问控制权限的所有行为进行审核。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000186\n\nVulnerability Discussion: The changing of file permissions could indicate that a user is attempting to gain access to information that would otherwise be disallowed. Auditing DAC modifications can facilitate the identification of patterns of abuse among both authorized and unauthorized users.\n\nFix text: At a minimum, the audit system should collect file permission changes for all users and root. Add the following to "/etc/audit/audit.rules":\n\n-a always,exit -F arch=b32 -S fchmod -F auid>=500 -F auid!=4294967295 -k perm_mod\n-a always,exit -F arch=b32 -S fchmod -F auid=0 -k perm_mod\n\nIf the system is 64-bit, then also add the following:\n\n-a always,exit -F arch=b64 -S fchmod -F auid>=500 -F auid!=4294967295 -k perm_mod\n-a always,exit -F arch=b64 -S fchmod -F auid=0 -k perm_mod\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38550)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The audit system must be configured to audit all discretionary access control permission modifications using fchmodat.'
                  else
                      log_msg $1 $2 '审核系统必须配置对使用fchmodat进行访问控制权限的修改的所有行为进行审核。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000187\n\nVulnerability Discussion: The changing of file permissions could indicate that a user is attempting to gain access to information that would otherwise be disallowed. Auditing DAC modifications can facilitate the identification of patterns of abuse among both authorized and unauthorized users.\n\nFix text: At a minimum, the audit system should collect file permission changes for all users and root. Add the following to "/etc/audit/audit.rules":\n\n-a always,exit -F arch=b32 -S fchmodat -F auid>=500 -F auid!=4294967295 -k perm_mod\n-a always,exit -F arch=b32 -S fchmodat -F auid=0 -k perm_mod\n\nIf the system is 64-bit, then also add the following:\n\n-a always,exit -F arch=b64 -S fchmodat -F auid>=500 -F auid!=4294967295 -k perm_mod\n-a always,exit -F arch=b64 -S fchmodat -F auid=0 -k perm_mod  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38552)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The audit system must be configured to audit all discretionary access control permission modifications using fchown.'
                  else
                      log_msg $1 $2 '审核系统必须配置对使用fchown进行访问控制权限的修改的所有行为进行审核。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000188\n\nVulnerability Discussion: The changing of file permissions could indicate that a user is attempting to gain access to information that would otherwise be disallowed. Auditing DAC modifications can facilitate the identification of patterns of abuse among both authorized and unauthorized users.\n\nFix text: At a minimum, the audit system should collect file permission changes for all users and root. Add the following to "/etc/audit/audit.rules":\n\n-a always,exit -F arch=b32 -S fchown -F auid>=500 -F auid!=4294967295 -k perm_mod\n-a always,exit -F arch=b32 -S fchown -F auid=0 -k perm_mod\n\nIf the system is 64-bit, then also add the following:-a always,exit -F arch=b64 -S fchown -F auid>=500 -F auid!=4294967295 -k perm_mod\n-a always,exit -F arch=b64 -S fchown -F auid=0 -k perm_mod  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38554)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The audit system must be configured to audit all discretionary access control permission modifications using fchownat.'
                  else
                      log_msg $1 $2 '审计系统必须配置对使用fchownat修改访问控制权限的所有行为进行审计。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000189\n\nVulnerability Discussion: The changing of file permissions could indicate that a user is attempting to gain access to information that would otherwise be disallowed. Auditing DAC modifications can facilitate the identification of patterns of abuse among both authorized and unauthorized users\n\nFix text: At a minimum, the audit system should collect file permission changes for all users and root. Add the following to "/etc/audit/audit.rules":\n\n-a always,exit -F arch=b32 -S fchownat -F auid>=500 -F auid!=4294967295 -k perm_mod\n-a always,exit -F arch=b32 -S fchownat -F auid=0 -k perm_mod\n\nIf the system is 64-bit, then also add the following:\n\n-a always,exit -F arch=b64 -S fchownat -F auid>=500 -F auid!=4294967295 -k perm_mod\n-a always,exit -F arch=b64 -S fchownat -F auid=0 -k perm_mod\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38556)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The audit system must be configured to audit all discretionary access control permission modifications using fremovexattr.'
                  else
                      log_msg $1 $2 '审计系统必须配置对使用fremovexattr修改访问控制权限的所有行为进行审计。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID: RHEL-06-000190\n\nVulnerability Discussion: The changing of file permissions could indicate that a user is attempting to gain access to information that would otherwise be disallowed. Auditing DAC modifications can facilitate the identification of patterns of abuse among both authorized and unauthorized users.\n\nFix text: At a minimum, the audit system should collect file permission changes for all users and root. Add the following to "/etc/audit/audit.rules":\n\n-a always,exit -F arch=b32 -S fremovexattr -F auid>=500 -F auid!=4294967295 -k perm_mod \n-a always,exit -F arch=b32 -S fremovexattr -F auid=0 -k perm_mod\n\nIf the system is 64-bit, then also add the following:\n\n-a always,exit -F arch=b64 -S fremovexattr -F auid>=500 -F auid!=4294967295 -k perm_mod\n-a always,exit -F arch=b64 -S fremovexattr -F auid=0 -k perm_mod\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38557)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The audit system must be configured to audit all discretionary access control permission modifications using fsetxattr.'
                  else
                      log_msg $1 $2 '审计系统必须配置对使用fsetxattr进行修改访问控制权限的所有行为进行审计。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000191\n\nVulnerability Discussion: The changing of file permissions could indicate that a user is attempting to gain access to information that would otherwise be disallowed. Auditing DAC modifications can facilitate the identification of patterns of abuse among both authorized and unauthorized users.\n\nFix text: At a minimum, the audit system should collect file permission changes for all users and root. Add the following to "/etc/audit/audit.rules":\n\n-a always,exit -F arch=b32 -S fsetxattr -F auid>=500 -F auid!=4294967295 -k perm_mod\n-a always,exit -F arch=b32 -S fsetxattr -F auid=0 -k perm_mod\n\nIf the system is 64-bit, then also add the following:\n\n-a always,exit -F arch=b64 -S fsetxattr -F auid>=500 -F auid!=4294967295 -k perm_mod\n-a always,exit -F arch=b64 -S fsetxattr -F auid=0 -k perm_mod\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38558)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The audit system must be configured to audit all discretionary access control permission modifications using lchown.'
                  else
                      log_msg $1 $2 '审计系统必须配置对使用lchown进行访问控制权限的修改的所有行为进行审计。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-0001920\n\nVulnerability Discussion: The changing of file permissions could indicate that a user is attempting to gain access to information that would otherwise be disallowed. Auditing DAC modifications can facilitate the identification of patterns of abuse among both authorized and unauthorized users.\n\nFix text: At a minimum, the audit system should collect file permission changes for all users and root. Add the following to "/etc/audit/audit.rules":\n\n-a always,exit -F arch=b32 -S lchown -F auid>=500 -F auid!=4294967295 -k perm_mod\n-a always,exit -F arch=b32 -S lchown -F auid=0 -k perm_mod\n\nIf the system is 64-bit, then also add the following:\n\n-a always,exit -F arch=b64 -S lchown -F auid>=500 -F auid!=4294967295 -k perm_mod\n-a always,exit -F arch=b64 -S lchown -F auid=0 -k perm_mod\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38559)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The audit system must be configured to audit all discretionary access control permission modifications using lremovexattr.'
                  else
                      log_msg $1 $2 '审计系统必须配置对使用lremovexattr进行访问控制权限的修改的所有行为进行审计。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000193\n\nVulnerability Discussion: The changing of file permissions could indicate that a user is attempting to gain access to information that would otherwise be disallowed. Auditing DAC modifications can facilitate the identification of patterns of abuse among both authorized and unauthorized users.\n\nFix text: At a minimum, the audit system should collect file permission changes for all users and root. Add the following to "/etc/audit/audit.rules":\n\n-a always,exit -F arch=b32 -S lremovexattr -F auid>=500 -F auid!=4294967295 -k perm_mod\n-a always,exit -F arch=b32 -S lremovexattr -F auid=0 -k perm_mod\n\nIf the system is 64-bit, then also add the following:\n\n-a always,exit -F arch=b64 -S lremovexattr -F auid>=500 -F auid!=4294967295 -k perm_mod\n-a always,exit -F arch=b64 -S lremovexattr -F auid=0 -k perm_mod\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38561)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The audit system must be configured to audit all discretionary access control permission modifications using lsetxattr.'
                  else
                      log_msg $1 $2 '审计系统必须配置对使用lsetxattr进行访问控制权限的修改的所有行为进行审计。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000194\n\nVulnerability Discussion: The changing of file permissions could indicate that a user is attempting to gain access to information that would otherwise be disallowed. Auditing DAC modifications can facilitate the identification of patterns of abuse among both authorized and unauthorized users.\n\nFix text: At a minimum, the audit system should collect file permission changes for all users and root. Add the following to "/etc/audit/audit.rules":\n\n-a always,exit -F arch=b32 -S lsetxattr -F auid>=500 -F auid!=4294967295 -k perm_mod \n-a always,exit -F arch=b32 -S lsetxattr -F auid=0 -k perm_mod\n\nIf the system is 64-bit, then also add the following:\n\n-a always,exit -F arch=b64 -S lsetxattr -F auid>=500 -F auid!=4294967295 -k perm_mod\n-a always,exit -F arch=b64 -S lsetxattr -F auid=0 -k perm_mod\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38563)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The audit system must be configured to audit all discretionary access control permission modifications using removexattr.'
                  else
                      log_msg $1 $2 '审计系统必须配置对使用removexattr进行访问控制权限的修改的所有行为进行审计。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000195\n\nVulnerability Discussion: The changing of file permissions could indicate that a user is attempting to gain access to information that would otherwise be disallowed. Auditing DAC modifications can facilitate the identification of patterns of abuse among both authorized and unauthorized users.\n\nFix text: At a minimum, the audit system should collect file permission changes for all users and root. Add the following to "/etc/audit/audit.rules":\n\n-a always,exit -F arch=b32 -S removexattr -F auid>=500 -F auid!=4294967295 -k perm_mod\n-a always,exit -F arch=b32 -S removexattr -F auid=0 -k perm_mod\n\nIf the system is 64-bit, then also add the following:\n\n-a always,exit -F arch=b64 -S removexattr -F auid>=500 -F auid!=4294967295 -k perm_mod\n-a always,exit -F arch=b64 -S removexattr -F auid=0 -k perm_mod\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38565)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The audit system must be configured to audit all discretionary access control permission modifications using setxattr.'
                  else
                      log_msg $1 $2 '审计系统必须配置对使用setxattr进行访问控制权限的修改的所有行为进行审计。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000196\n\nVulnerability Discussion: The changing of file permissions could indicate that a user is attempting to gain access to information that would otherwise be disallowed. Auditing DAC modifications can facilitate theidentification of patterns of abuse among both authorized and unauthorized users.\n\nFix text: At a minimum, the audit system should collect file permission changes for all users and root. Add the following to "/etc/audit/audit.rules":\n\n-a always,exit -F arch=b32 -S setxattr -F auid>=500 -F auid!=4294967295 -k perm_mod\n-a always,exit -F arch=b32 -S setxattr -F auid=0 -k perm_mod\n\nIf the system is 64-bit, then also add the following:\n\n-a always,exit -F arch=b64 -S setxattr -F auid>=500 -F auid!=4294967295 -k perm_mod \n-a always,exit -F arch=b64 -S setxattr -F auid=0 -k perm_mod\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38566)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The audit system must be configured to audit failed attempts to access files and programs.'
                  else
                      log_msg $1 $2 '审计系统必须配置失败的尝试访问文件或程序的行为进行审计。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000197\n\nVulnerability Discussion: Unsuccessful attempts to access files could be an indicator of malicious activity on a system. Auditing these events could serve as evidence of potential system compromise.\n\nFix text: At a minimum, the audit system should collect unauthorized file accesses for all users and root. Add the following to "/etc/audit/audit.rules", setting ARCH to either b32 or b64 as appropriate for your system:\n\n-a always,exit -F arch=ARCH -S creat -S open -S openat -S truncate \\\n-S ftruncate -F exit=-EACCES -F auid>=500 -F auid!=4294967295 -k access\n-a always,exit -F arch=ARCH -S creat -S open -S openat -S truncate \\\n-S ftruncate -F exit=-EPERM -F auid>=500 -F auid!=4294967295 -k access\n-a always,exit -F arch=ARCH -S creat -S open -S openat -S truncate \\\n-S ftruncate -F exit=-EACCES -F auid=0 -k access\n-a always,exit -F arch=ARCH -S creat -S open -S openat -S truncate \\\n -S ftruncate -F exit=-EPERM -F auid=0 -k access  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38567)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The audit system must be configured to audit all use of setuid and setgid programs.'
                  else
                      log_msg $1 $2 '审计系统必须配置对所有的setuid和setgid的程序进行审计。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000198\n\nVulnerability Discussion: Privileged programs are subject to escalation-of-privilege attacks, which attempt to subvert their normal role of providing some necessary but limited capability. As such, motivation exists to monitor these programs for unusual activity.\n\nFix text: At a minimum, the audit system should collect the execution of privileged commands for all users and root. To find the relevant setuid / setgid programs, run the following command for each local partition [PART]:\n\n$ sudo find [PART] -xdev -type f -perm /6000 2>/dev/null\n\nThen, for each setuid / setgid program on the system, add a line of the following form to "/etc/audit/audit.rules", where [SETUID_PROG_PATH] is the full path to each setuid / setgid program in the list:\n\n-a always,exit -F path=[SETUID_PROG_PATH] -F perm=x -F auid>=500 -F auid!=4294967295 -k privileged\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38568)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The audit system must be configured to audit successful file system mounts.'
                  else
                      log_msg $1 $2 '审计系统必须配置对成功进行文件系统的挂载进行审计。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000199\n\nVulnerability Discussion: The unauthorized exportation of data to external media could result in an information leak where classified information, Privacy Act information, and intellectual property could be lost. An audit trail should be created each time a filesystem is mounted to help identify and guard against information loss.\n\nFix text: At a minimum, the audit system should collect media exportation events for all users and root. Add the following to "/etc/audit/audit.rules", setting ARCH to either b32 or b64 as appropriate for your system:\n\n-a always,exit -F arch=ARCH -S mount -F auid>=500 -F auid!=4294967295 -k export\n-a always,exit -F arch=ARCH -S mount -F auid=0 -k export  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38575)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The audit system must be configured to audit user deletions of files and programs.'
                  else
                      log_msg $1 $2 '审计系统必须配置对用户删除文件或程序的行为进行审计。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000200\n\nVulnerability Discussion: Auditing file deletions will create an audit trail for files that are removed from the system. The audit trail could aid in system troubleshooting, as well as detecting malicious processes that attempt to delete log files to conceal their presence.\n\nFix text: \n\nAt a minimum, the audit system should collect file deletion events for all users and root. Add the following (or equivalent) to "/etc/audit/audit.rules", setting ARCH to either b32 or b64 as appropriate for your system:\n\n-a always,exit -F arch=ARCH -S rmdir -S unlink -S unlinkat -S rename -S renameat -F auid>=500 -F auid!=4294967295 -k delete\n-a always,exit -F arch=ARCH -S rmdir -S unlink -S unlinkat -S rename -S renameat -F auid=0 -k delete\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38578)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The audit system must be configured to audit changes to the /etc/sudoers file.'
                  else
                      log_msg $1 $2 '审计系统必须配置对文件/etc/sudoers文件的修改的审计。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000201\n\nVulnerability Discussion: The actions taken by system administrators should be audited to keep a record of what was executed on the system, as well as, for accountability purposes.\n\nFix text: At a minimum, the audit system should collect administrator actions for all users and root. Add the following to "/etc/audit/audit.rules":\n-w /etc/sudoers -p wa -k actions\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38580)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The audit system must be configured to audit the loading and unloading of dynamic kernel modules.'
                  else
                      log_msg $1 $2 '审计系统必须配置对装载与卸载动态内核模块的审计。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000202\n\nVulnerability Discussion: The addition/removal of kernel modules can be used to alter the behavior of the kernel and potentially introduce malicious code into kernel space. It is important to have an audit trail of modules that have been introduced into the kernel.\n\nFix text: Add the following to "/etc/audit/audit.rules" in order to capture kernel module loading and unloading events, setting ARCH to either b32 or b64 as appropriate for your system:\n\n-w /sbin/insmod -p x -k modules\n-w /sbin/rmmod -p x -k modules\n-w /sbin/modprobe -p x -k modules\n-a always,exit -F arch=[ARCH] -S init_module -S delete_module -k modules  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38582)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The xinetd service must be disabled if no network services utilizing it are enabled.'
                  else
                      log_msg $1 $2 '如果没有网络服务已启用xinetd服务，则此服务必须被禁止。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000203\n\nVulnerability Discussion: The xinetd service provides a dedicated listener service for some programs, which is no longer necessary for commonly-used network services. Disabling it ensures that these uncommonservices are not running, and also prevents attacks against xinetd itself.\n\nFix text: The "xinetd" service can be disabled with the following commands:\n\n#update-rc.d xinetd remove\nservice xinetd stop\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38584)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The xinetd service must be uninstalled if no network services utilizing it are enabled.'
                  else
                      log_msg $1 $2 '如果没有网络服务已启用xinetd服务，则xinetd服务必须未安装。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000204\n\nVulnerability Discussion: Removing the "xinetd" package decreases the risk of the xinetd service\047s accidental (or intentional) activation.\n\nFix text: The "xinetd" package can be uninstalled with the following command:\n\n#apt-get purge xinetd\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38587)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The telnet-server package must not be installed.'
                  else
                      log_msg $1 $2 'telnet服务软件包必须没有进行安装。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000206\n\nVulnerability Discussion: Removing the "telnetd" package decreases the risk of the unencrypted telnet service\047s accidental (or intentional) activation.\n\nFix text: The "telnetd" package can be uninstalled with the following command:\n\n#apt-get purge telnetd\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38589)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The telnet daemon must not be running.'
                  else
                      log_msg $1 $2 'telnet守护程序必须没有运行。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000211\n\nVulnerability Discussion: The telnet protocol uses unencrypted network communication, which means that data from the login session, including passwords and all other information transmitted during the session, can be stolen by eavesdroppers on the network. The telnet protocol is also subject to man-in-the-middle attacks.\n\nMitigation: If an enabled telnet daemon is configured to only allow encrypted sessions, such as with Kerberos or the use of encrypted network tunnels, the risk of exposing sensitive information is mitigated.\n\nFix text: In Debian telnet server using inetd\n\nCheck following line in the "/etc/inetd.conf":\n\ntelnet      stream  tcp nowait  telnetd /usr/sbin/tcpd  /usr/sbin/in.telnetd\n\nYou can disable telnet server by comment above line.\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38591)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The rsh-server package must not be installed.'
                  else
                      log_msg $1 $2 'rsh服务软件包必须没有进行安装。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000213\n\nVulnerability Discussion: The "rsh-server" package provides several obsolete and insecure network services.Removing it decreases the risk of those services\047 accidental (or intentional) activation.\n\nFix text: The "rsh-server" package can be uninstalled with the following command:\n\n#apt-get purge rsh-server\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38594)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The rshd service must not be running.'
                  else
                      log_msg $1 $2 'rshd服务必须没有运行。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000214\n\nVulnerability Discussion: The rsh service uses unencrypted network communications, which means that data from the login session, including passwords and all other information transmitted during the session, can be stolen by eavesdroppers on the network.\n\nFix text: The "rshd" service, which is available with the "rsh-server" package and runs as a service through inetd, should be disabled.You could disabled rshd in "/etc/inetd.conf" by comment or remove following line:\n\nshell      stream  tcp nowait  root    /usr/sbin/tcpd  /usr/sbin/in.rshd\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38598)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The rexecd service must not be running.'
                  else
                      log_msg $1 $2 'rexecd服务必须没有运行。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000216\n\nVulnerability Discussion: The rexec service uses unencrypted network communications, which means that data from the login session, including passwords and all other information transmitted during the session, can be stolen by eavesdroppers on the network.\n\nFix text: The "rexecd" service, which is available with the "rsh-server" package and runs as a service through inetd, should be disabled.You could disabled rexecd in "/etc/inetd.conf" by comment or remove following line:\n\nexec     stream  tcp nowait  root    /usr/sbin/tcpd  /usr/sbin/in.rexecd\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38602)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The rlogind service must not be running.'
                  else
                      log_msg $1 $2 'rlogind服务必须没有进行运行。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000218\n\nVulnerability Discussion: The rlogin service uses unencrypted network communications, which means that data from the login session, including passwords and all other information transmitted during the session, can be stolen by eavesdroppers on the network.\n\nFix text: The "rlogind" service, which is available with the "rsh-server" package and runs as a service through inetd, should be disabled.You could disabled rlogind in "/etc/inetd.conf" by comment or remove following line:\n\nlogin     stream  tcp nowait  root    /usr/sbin/tcpd  /usr/sbin/in.rlogind\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38603)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The nis(ypserv) package must not be installed.'
                  else
                      log_msg $1 $2 'nis(ypserv)安装包必须没有安装。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000220\n\nVulnerability Discussion: Removing the "nis" package decreases the risk of the accidental (or intentional) activation of NIS or NIS+ services.\n\nFix text: The "nis" package can be uninstalled with the following command:\n\n#apt-get purge nis\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38604)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The nis(ypbind) service must not be running.'
                  else
                      log_msg $1 $2 'nis(ypserv)服务必须没有运行。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000221\n\nVulnerability Discussion: Disabling the "nis" service ensures the system is not acting as a client in a NIS or NIS+ domain.\n\nFix text: The "nis" service, which allows the system to act as a client in a NIS or NIS+ domain, should be
disabled. The "nis" service can be disabled with the following commands:\n\n#update-rc.d nis remove\nservice nis stop\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38606)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The tftp-server package must not be installed unless required.'
                  else
                      log_msg $1 $2 'tftp服务软件包必须没有安装，除非必需。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000222\n\nVulnerability Discussion: Removing the "tftp-server" package decreases the risk of the accidental (or intentional) activation of tftp services.\n\nFix text: The "tftp-server" package can be removed with the following command:\n\n#apt-get purge tftpd\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38609)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The tftp service must not be running.'
                  else
                      log_msg $1 $2 'tftp服务必须没有运行。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000223\n\nVulnerability Discussion: Disabling the "tftp" service ensures the system is not acting as a tftp server, which does not provide encryption or authentication.\n\nFix text: The "tftp" service, which is available with the "tftpd" package and runs as a service through inetd, should be disabled.You could disabled tftp in "/etc/inetd.conf" by comment or remove following line:\n\ntftp       dgram   udp wait    nobody  /usr/sbin/tcpd  /usr/sbin/in.tftpd /srv/tftp\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38605)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The cron service must be running.'
                  else
                      log_msg $1 $2 'cron服务必须正常运行。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000224\n\nVulnerability Discussion: Due to its usage for maintenance and security-supporting tasks, enabling the cron daemon is essential.\n\nFix text: The "crond" service is used to execute commands at preconfigured times. It is required by almost all systems to perform necessary maintenance tasks, such as notifying root of system activity. The "crond" service can be enabled with the following commands:\n\n#update-rc.d cron defaults\nservice cron start\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        SV-86857r1_rule) if [ "$3" = "en" ]; then
                             log_msg $1 $2 'OpenSSH server and client must be installed.'
                         else
                             log_msg $1 $2 '必须安装OpenSSH服务器和客户端'
                         fi
                         if [ $2 -ne 0 ];then
                             printf '\n######################\n\nWithout protection of the transmitted information, confidentiality and integrity may be compromised because unprotected communications can be intercepted and either read or altered. \n\nThis requirement applies to both internal and external networks and all types of information system components from which information can be transmitted (e.g., servers, mobile devices, notebook computers, printers, copiers, scanners, and facsimile machines). Communication paths outside the physical protection of a controlled boundary are exposed to the possibility of interception and modification. \n\nProtecting the confidentiality and integrity of organizational information can be accomplished by physical means (e.g., employing physical distribution systems) or by logical means (e.g., employing cryptographic techniques). If physical means of protection are employed, logical means (cryptography) do not have to be employed, and vice versa.\n\n######################\n\n' >> $LOG
                         fi
                         ;;
        V-38607)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The SSH daemon must be configured to use only the SSHv2 protocol.'
                  else
                      log_msg $1 $2 'SSH守护进程必须配置为仅支持SSHv2协议。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000227\n\nVulnerability Discussion: SSH protocol version 1 suffers from design flaws that result in security vulnerabilities and should not be used.\n\nFix text: Only SSH protocol version 2 connections should be permitted. The default setting in "/etc/ssh/sshd_config" is correct, and can be verified by ensuring that the following line appears:\n\nProtocol 2\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38608)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The SSH daemon must set a timeout interval on idle sessions.'
                  else
                      log_msg $1 $2 'SSH守护进程必须设置空闲会话的超时间隔时间。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000230\n\nVulnerability Discussion: Causing idle users to be automatically logged out guards against compromises one system leading trivially to compromises on another.\n\nFix text: SSH allows administrators to set an idle timeout interval. After this interval has passed, the idle user will be automatically logged out.\n\nTo set an idle timeout interval, edit the following line in "/etc/ssh/sshd_config" as follows:\n\nClientAliveInterval [interval]\n\nThe timeout [interval] is given in seconds. To have a timeout of 15 minutes, set [interval] to 900.\n\nIf a shorter timeout has already been set for the login shell, that value will preempt any SSH setting made here.Keep in mind that some processes may stop SSH from correctly detecting that the user is idle.  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38610)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The SSH daemon must set a timeout count on idle sessions.'
                  else
                      log_msg $1 $2 'SSH守护进程必须设置空闲会话的超时数。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000231\n\nVulnerability Discussion: This ensures a user login will be terminated as soon as the "ClientAliveCountMax" is reached.\n\nFix text: To ensure the SSH idle timeout occurs precisely when the "ClientAliveCountMax" is set, edit "/etc/ssh/sshd_config" as follows:\n\nClientAliveCountMax 0\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38611)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The SSH daemon must ignore .rhosts files.'
                  else
                      log_msg $1 $2 'SSH守护进程必须忽略.rhosts文件。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000234\n\nVulnerability Discussion: SSH trust relationships mean a compromise on one host can allow an attacker to move trivially to other hosts.\n\nFix text:  SSH can emulate the behavior of the obsolete rsh command in allowing users to enable insecure access to their accounts via ".rhosts" files.\n\nTo ensure this behavior is disabled, add or correct the following line in "/etc/ssh/sshd_config":\n\nIgnoreRhosts yes  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38612)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The SSH daemon must not allow host-based authentication.'
                  else
                      log_msg $1 $2 'SSH守护进程必须不允许基于主机的认证。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000236\n\nVulnerability Discussion: SSH trust relationships mean a compromise on one host can allow an attacker to move trivially to other hosts.\n\nFix text: SSH\047s cryptographic host-based authentication is more secure than ".rhosts" authentication, since hosts are cryptographically authenticated. However, it is not recommended that hosts unilaterally trust one another, even within an organization.\n\nTo disable host-based authentication, add or correct the following line in "/etc/ssh/sshd_config":\n\nHostbasedAuthentication no  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38613)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The system must not permit root logins using remote access programs such as ssh.'
                  else
                      log_msg $1 $2 '必须不允许类似ssh的远程登录程序使用root帐号进行远程登录。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000237\n\nVulnerability Discussion: Permitting direct root login reduces auditable information about who ran privileged commands on the system and also allows direct attack attempts on root\047s password.\n\nFix text: The root user should never be allowed to log in to a system directly over a network. To disable root login via SSH, add or correct the following line in "/etc/ssh/sshd_config":\n\nPermitRootLogin no\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-21736)  log_msg $1 $2 'A grace time must be set for ssh logins.'
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:C-LoginGraceTime\n\nAdding a grace time makes it more difficult for a remote attacker to try to perform brute force login attempts, tieing up server resources.\n\nFix text: add or correct the following line in "/etc/ssh/sshd_config":\n\nLoginGraceTime 1m\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-25716)  log_msg $1 $2 'A maximum authentication attempts value must be set for ssh logins.'
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:C-MaxAuthTries\n\nSetting a maximum number of ssh authentication retries disrupts attackers who are attempting to gain brute force access.\n\nFix text: add or correct the following line in "/etc/ssh/sshd_config":\n\nMaxAuthTries 6\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-29152)  log_msg $1 $2 'A maximum ssh sessions value must be set.'
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:C-MaxSessions\n\nOnly a few ssh logins are expected at any point in time.\n\nFix text: add or correct the following line in "/etc/ssh/sshd_config":\n\nMaxSessions 5\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-22717)  log_msg $1 $2 'TCP forwarding via ssh should not be permitted.'
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:C-AllowTcpForwarding\n\nTurning off forwarding via ssh ensures that an attacker who has gained access cannot then forward their traffic to some other target.\n\nFix text: add or correct the following line in "/etc/ssh/sshd_config":\n\nAllowTcpForwarding no\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38614)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The SSH daemon must not allow authentication using an empty password.'
                  else
                      log_msg $1 $2 'SSH守护进程必须不允许通过一个空密码进行认证。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000239\n\nVulnerability Discussion: Configuring this setting for the SSH daemon provides additional assurance that remote login via SSH will require a password, even in the event of misconfiguration elsewhere.\n\nFix text: To explicitly disallow remote login from accounts with empty passwords, add or correct the following line in "/etc/ssh/sshd_config":\n\nPermitEmptyPasswords no\n\nAny accounts with empty passwords should be disabled immediately, and PAM configuration should prevent users from being able to assign themselves empty passwords.  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38616)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The SSH daemon must not permit user environment settings.'
                  else
                      log_msg $1 $2 'SSH守护进程必须不允许进行用户环境的设置。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000241\n\nVulnerability Discussion: SSH environment options potentially allow users to bypass access restriction in some configurations.\n\nFix text: To ensure users are not able to present environment options to the SSH daemon, add or correct the following line in "/etc/ssh/sshd_config":\n\nPermitUserEnvironment no\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38617) if [ "$3" = "en" ]; then
                     log_msg $1 $2 'The SSH daemon must be configured to use only FIPS 140-2 approved ciphers.'
                 else
                     log_msg $1 $2 'SSH守护进程必须配置为使用满足FIPS 140-2标准认可的密码。'
                 fi
                 if [ $2 -ne 0 ];then
                     printf '\n######################\n\nSTIG-ID:RHEL-06-000243\n\nVulnerability Discussion: Approved algorithms should impart some level of confidence in their implementation. These are also required for compliance.\n\nFix text: Limit the ciphers to those algorithms which are FIPS-approved. Counter (CTR) mode is also preferred over cipher-block chaining (CBC) mode. The following line in "/etc/ssh/sshd_config" demonstrates use of FIPS-approved ciphers:\n\nCiphers aes128-ctr,aes192-ctr,aes256-ctr,aes128-cbc,3des-cbc,aes192-cbc,aes256-cbc\n\nThe man page "sshd_config(5)" contains a list of supported ciphers.  \n\n######################\n\n' >> $LOG
                 fi
                 ;;
        V-38618)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The avahi service must be disabled.'
                  else
                      log_msg $1 $2 'avahi服务必须设置为失效。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000246\n\nVulnerability Discussion: Because the Avahi daemon service keeps an open network port, it is subject to network attacks. Its functionality is convenient but is only appropriate if the local network can be trusted.\n\nFix text: The "avahi-daemon" service can be disabled with the following commands:\n\n#update-rc.d avahi-daemon remove\nservice avahi-daemon stop\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38620)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The system clock must be synchronized continuously, or at least daily.'
                  else
                      log_msg $1 $2 '系统时钟必须至少每天同步。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000247\n\nVulnerability Discussion: Enabling the "ntp" service ensures that the "ntp" service will be running and that the system will synchronize its time to any servers specified. This is important whether the system is configured to be a client (and synchronize only its own clock) or it is also acting as an NTP server to other systems. Synchronizing time is essential for authentication services such as Kerberos, but it is also important for maintaining accurate logs and auditing possible security breaches.\n\nFix text: The "ntp" service can be enabled with the following command:\n\nupdate-rc.d ntp defaults\nservice ntp start\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38621)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The system clock must be synchronized to an authoritative trusted time source.'
                  else
                      log_msg $1 $2 '系统时钟必须同步权威可信时间源。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000248\n\nVulnerability Discussion: Synchronizing with an NTP server makes it possible to collate system logs from multiple sources or correlate computer events with real time events. Using a trusted NTP server provided by your organization is recommended.\n\nFix text: To specify a remote NTP server for time synchronization, edit the file "/etc/ntpsec/ntp.conf". Add or correct the following lines, substituting the IP or hostname of a remote NTP server for ntpserver.\n\nserver [ntpserver]\n\nThis instructs the NTP software to contact that remote server to obtain time data. \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38622)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'Mail relaying must be restricted.'
                  else
                      log_msg $1 $2 '邮件中继必须加以限制。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000249\n\nVulnerability Discussion: This ensures "postfix" accepts mail messages (such as cron job reports) from the local system only, and not from the network, which protects it from network attack.\n\nFix text: Edit the file "/etc/postfix/main.cf" to ensure that only the following "inet_interfaces" line appears:\n\ninet_interfaces = localhost  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38625)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'If the system is using LDAP for authentication or account information, the system must use a TLS connection using FIPS 140-2 approved cryptographic algorithms.'
                  else
                      log_msg $1 $2 '如果系统使用了LDAP认证或帐号信息，系统必须使用满足140-2的密码算法的TLS进行连接。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000252\n\nVulnerability Discussion: The ssl directive specifies whether to use ssl or not. If not specified it will default to "no". It should be set to "start_tls" rather than doing LDAP over SSL.\n\nFix text: Configure LDAP to enforce TLS use. First, edit the file "/etc/pam_ldap.conf", and add or correct the following lines:\n\nssl start_tls\n\nThen review the LDAP server and ensure TLS has been configured.  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38626)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The LDAP client must use a TLS connection using trust certificates signed by the site CA.'
                  else
                      log_msg $1 $2 'LDAP客户端必须使用由CA签发的认证证书进行TLS连接。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000253\n\nVulnerability Discussion: The tls_cacertdir or tls_cacertfile directives are required when tls_checkpeer is configured (which is the default for openldap versions 2.1 and up). These directives define the path to the trust certificates signed by the site CA.\n\nFix text: Ensure a copy of the site\047s CA certificate has been placed in the file "/etc/pki/tls/CA/cacert.pem". Configure LDAP to enforce TLS use and to trust certificates signed by the site\047s CA. First, edit the file "/etc/pam_ldap.conf", and add or correct either of the following lines:\n\ntls_cacertdir /etc/pki/tls/CA\n\nor\n\ntls_cacertfile /etc/pki/tls/CA/cacert.pem\n\nThen review the LDAP server and ensure TLS has been configured.\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38627)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The openldap-servers package must not be installed unless required.'
                  else
                      log_msg $1 $2 'Openldap服务软件包必须没有进行安装，除非必需。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000256\n\nVulnerability Discussion: Unnecessary packages should not be installed to decrease the attack surface of the
system.\n\nFix text: The "sldap" package should be removed if not in use. Is this machine the OpenLDAP server? If not, remove the package.\n\n#apt-get purge sldap\n\nThe openldap-servers RPM is not installed by default on RHEL6 machines. It is needed only by the OpenLDAP server, not by the clients which use LDAP for authentication. If the system is not intended for use as an LDAP Server it should be removed.  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38629)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The graphical desktop environment must set the idle timeout to no more than 15 minutes.'
                  else
                      log_msg $1 $2 '图形桌面环境必须设置空闲超时时间不大于15分钟。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000257\n\nVulnerability Discussion: Setting the idle delay controls when the screensaver will start, and can be combined with screen locking to prevent access from passersby.\n\nFix text: Run the following command to set the idle time-out value for inactivity in the GNOME desktop to 15 minutes:\n\n# gconftool-2 \\\n--direct \\\n--config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory \\\n--type int \\\n--set /apps/gnome-screensaver/idle_delay 15  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38630)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The graphical desktop environment must automatically lock after 15 minutes of inactivity and the system must require user reauthentication to unlock the environment.'
                  else
                      log_msg $1 $2 '图形化桌面环境必须闲置15分钟后自动锁定，系统必须要求用户重新认证解锁环境。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000258\n\nVulnerability Discussion: Enabling idle activation of the screen saver ensures the screensaver will be activated after the idle delay. Applications requiring continuous, real-time screen display (such as network management products) require the login session does not have administrator rights and the display station is located in a controlled-access area.\n\nFix text: Run the following command to activate the screensaver in the GNOME desktop after a period of inactivity:\n\n# gconftool-2 --direct \\\n--config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory \\\n--type bool \\\n--set /apps/gnome-screensaver/idle_activation_enabled true\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38638)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The graphical desktop environment must have automatic lock enabled.'
                  else
                      log_msg $1 $2 '图形化桌面环境必须自动锁定已经开启。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000259\n\nVulnerability Discussion: Enabling the activation of the screen lock after an idle period ensures password entry will be required in order to access the system, preventing access by passersby.\n\nFix text: Run the following command to activate locking of the screensaver in the GNOME desktop when it is activated:\n\n# gconftool-2 --direct \\\n--config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory \\\n--type bool \\\n--set /apps/gnome-screensaver/lock_enabled true  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38639)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The system must display a publicly-viewable pattern during a graphical desktop environment session lock.'
                  else
                      log_msg $1 $2 '系统必须图形桌面环境会话锁定时显示一个公开展示的模式。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000260\n\nVulnerability Discussion: Setting the screensaver mode to blank-only conceals the contents of the display from passersby.\n\nFix text: Run the following command to set the screensaver mode in the GNOME desktop to a blank screen:\n\n# gconftool-2 \\\n--direct \--config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory \\\n--type string \\\n--set /apps/gnome-screensaver/mode blank-only\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38641)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The atd service must be disabled.'
                  else
                      log_msg $1 $2 'atd服务必须设置为失效。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000262\n\nVulnerability Discussion: The "atd" service could be used by an unsophisticated insider to carry out activities outside of a normal login session, which could complicate accountability. Furthermore, the need to schedule tasks with "at" or "batch" is not common.\n\nFix text: The "at" and "batch" commands can be used to schedule tasks that are meant to be executed only once. This allows delayed execution in a manner similar to cron, except that it is not recurring. The daemon "atd" keeps track of tasks scheduled via "at" and "batch", and executes them at the specified time. The "atd" service can be disabled with the following commands:\n\nupdate-rc.d atd remove\nservice atd stop\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38652)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'Remote file systems must be mounted with the nodev option.'
                  else
                      log_msg $1 $2 '远程文件系统必须使用nodev选项进行挂载。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000266\n\nVulnerability Discussion: Legitimate device files should only exist in the /dev directory. NFS mounts should not present device files to users.\n\nFix text: Add the "nodev" option to the fourth column of "/etc/fstab" for the line which controls mounting of any NFS mounts.  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38654)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'Remote file systems must be mounted with the nosuid option.'
                  else
                      log_msg $1 $2 '远程文件系统必须使用nosuid选项进行挂载。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000270\n\nVulnerability Discussion: NFS mounts should not present suid binaries to users. Only vendor-supplied suid executables should be installed to their default location on the local filesystem.\n\nFix text: Add the "nosuid" option to the fourth column of "/etc/fstab" for the line which controls mounting of any NFS mounts.  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38655)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The noexec option must be added to removable media partitions.'
                  else
                      log_msg $1 $2 'noexec选项必须在挂载可移动分区时使用。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000271\n\nVulnerability Discussion: Allowing users to execute binaries from removable media such as USB keys exposes the system to potential compromise.\n\nFix text: The "noexec" mount option prevents the direct execution of binaries on the mounted filesystem. Users should not be allowed to execute binaries that exist on partitions mounted from removable media (such as a USB key). The "noexec" option prevents code from being executed directly from the media itself, and may therefore provide a line of defense against certain types of worms or malicious code. Add the "noexec" ption to the fourth column of "/etc/fstab" for the line which controls mounting of any removable media partitions.  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38656)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The system must use SMB client signing for connecting to samba servers using smbclient'
                  else
                      log_msg $1 $2 '系统必须使用SMB客户端签名，用于连接使用smbclient的samba服务器。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000272\n\nVulnerability Discussion: Packet signing can prevent man-in-the-middle attacks which modify SMB packets in transit.\n\nFix text: To require samba clients running "smbclient" to use packet signing, add the following to the "[global]" section of the Samba configuration file in "/etc/samba/smb.conf":\n\nclient signing = mandatory\n\nRequiring samba clients such as "smbclient" to use packet signing ensures they can only communicate with servers that support packet signing.  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38657)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The system must use SMB client signing for connecting to samba servers using mount.cifs.'
                  else
                      log_msg $1 $2 '系统必须使用SMB客户端签名使用mount.cifs配置去连接samba服务器。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000273\n\nVulnerability Discussion: Packet signing can prevent man-in-the-middle attacks which modify SMB packets in transit.\n\nFix text: Require packet signing of clients who mount Samba shares using the "mount.cifs" program (e.g., those who specify shares in "/etc/fstab"). To do so, ensure signing options (either "sec=krb5i" or "sec=ntlmv2i") are used.\n\nSee the "mount.cifs(8)" man page for more information. A Samba client should only communicate with servers who can support SMB packet signing.\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38658)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The system must prohibit the reuse of passwords within twenty-four iterations.'
                  else
                      log_msg $1 $2 "系统必须禁止重用最近24次的密码。"
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000274\n\nVulnerability Discussion: Preventing reuse of previous passwords helps ensure that a compromised password is not reused by a user.\n\nFix text: Do not allow users to reuse recent passwords. This can be accomplished by using the "remember" option for the "pam_unix" PAM module. In the file "/etc/pam.d/common-auth", append "remember=24" to the line which refers to the "pam_unix.so" module, as shown:\n\npassword sufficient pam_unix.so [existing_options] remember=24\n\nThe LibreServer requirement is 24 passwords.  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38659)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The operating system must employ cryptographic mechanisms to protect information in storage.'
                  else
                      log_msg $1 $2 '操作系统必须采用加密机制来保护信息存储。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000275\n\nVulnerability Discussion: The risk of a system\047s physical compromise, particularly mobile systems such as laptops, places its data at risk of compromise. Encrypting this data mitigates the risk of its loss if the system is lost.\n\nFix text: Debian 8 natively supports partition encryption through the Linux Unified Key Setup-on-disk-format (LUKS) technology. The easiest way to encrypt a partition is during installation time. \n\nFor manual installations, select the "Encrypt" checkbox during partition creation to encrypt the partition. When this option is selected the system will prompt for a passphrase to use in decrypting the partition. The passphrase will subsequently need to be entered manually every time the system boots.\n\nFor automated/unattended installations, it is possible to use Kickstart by adding the "--encrypted" and "-- passphrase=" options to the definition of each partition to be encrypted. For example, the following line would encrypt the root partition:\n\npart / --fstype=ext3 --size=100 --onpart=hda1 --encrypted --passphrase=[PASSPHRASE]\n\nAny [PASSPHRASE] is stored in the Kickstart in plaintext, and the Kickstart must then be protected accordingly. Omitting the "--passphrase=" option from the partition definition will cause the installer to pause and interactively ask for the passphrase during installation.\n\nDetailed information on encrypting partitions using LUKS can be found on the Red Had Documentation web
site:\nhttps://docs.redhat.com/docs/en-US/Red_Hat_Enterprise_Linux/6/html/Security_Guide/sect-Security_Guide-LUKS_Disk_Encryption.html  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38661)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The operating system must protect the confidentiality and integrity of data at rest.'
                  else
                      log_msg $1 $2 '操作系统必须保护静态数据的机密性和完整性。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000276\n\nVulnerability Discussion: The risk of a system\047s physical compromise, particularly mobile systems such as laptops, places its data at risk of compromise. Encrypting this data mitigates the risk of its loss if the system is lost.\n\nFix text: Debian 8 natively supports partition encryption through the Linux Unified Key Setup-on-disk-format (LUKS) technology. The easiest way to encrypt a partition is during installation time. \n\nFor manual installations, select the "Encrypt" checkbox during partition creation to encrypt the partition. When this option is selected the system will prompt for a passphrase to use in decrypting the partition. The passphrase will subsequently need to be entered manually every time the system boots.\n\nFor automated/unattended installations, it is possible to use Kickstart by adding the "--encrypted" and "-- passphrase=" options to the definition of each partition to be encrypted. For example, the following line would encrypt the root partition:\n\npart / --fstype=ext3 --size=100 --onpart=hda1 --encrypted --passphrase=[PASSPHRASE]\n\nAny [PASSPHRASE] is stored in the Kickstart in plaintext, and the Kickstart must then be protected accordingly. Omitting the "--passphrase=" option from the partition definition will cause the installer to pause and interactively ask for the passphrase during installation.\n\nDetailed information on encrypting partitions using LUKS can be found on the Red Had Documentation web
site:\nhttps://docs.redhat.com/docs/en-US/Red_Hat_Enterprise_Linux/6/html/Security_Guide/sect-Security_Guide-LUKS_Disk_Encryption.html  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38662)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The operating system must employ cryptographic mechanisms to prevent unauthorized disclosure of data at rest unless otherwise protected by alternative physical measures.'
                  else
                      log_msg $1 $2 '操作系统必须采用加密机制，以防止数据的未经授权的数据泄漏，除非通过其他物理措施进行保护。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000277\n\nVulnerability Discussion: The risk of a system\047s physical compromise, particularly mobile systems such as laptops, places its data at risk of compromise. Encrypting this data mitigates the risk of its loss if the system is lost.\n\nFix text: Debian 8 natively supports partition encryption through the Linux Unified Key Setup-on-disk-format (LUKS) technology. The easiest way to encrypt a partition is during installation time. \n\nFor manual installations, select the "Encrypt" checkbox during partition creation to encrypt the partition. When this option is selected the system will prompt for a passphrase to use in decrypting the partition. The passphrase will subsequently need to be entered manually every time the system boots.\n\nFor automated/unattended installations, it is possible to use Kickstart by adding the "--encrypted" and "-- passphrase=" options to the definition of each partition to be encrypted. For example, the following line would encrypt the root partition:\n\npart / --fstype=ext3 --size=100 --onpart=hda1 --encrypted --passphrase=[PASSPHRASE]\n\nAny [PASSPHRASE] is stored in the Kickstart in plaintext, and the Kickstart must then be protected accordingly. Omitting the "--passphrase=" option from the partition definition will cause the installer to pause and interactively ask for the passphrase during installation.\n\nDetailed information on encrypting partitions using LUKS can be found on the Red Had Documentation web
site:\nhttps://docs.redhat.com/docs/en-US/Red_Hat_Enterprise_Linux/6/html/Security_Guide/sect-Security_Guide-LUKS_Disk_Encryption.html  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38663)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The system package management tool must verify permissions on all files and directories associated with the audit package.'
                  else
                      log_msg $1 $2 '系统软件包管理工具必须验证与审核包相关的所有文件和目录的权限。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000278\n\nVulnerability Discussion: Permissions on audit binaries and configuration files that are too generous could allow an unauthorized user to gain privileges that they should not have. The permissions set by the vendor should be maintained. Any deviations from this baseline should be investigated.\n\nFix text: In Debian there is directly way to get the package\047s permission and change it.\n\nThere\047s one way to use :\n\n#aptitude download auditd\n\nTo dowanload the package\047s file and use dpkg -c <package.deb> to extract it and get the permission and change it manually\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38664)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The system package management tool must verify ownership on all files and directories associated with the audit package.'
                  else
                      log_msg $1 $2 '该系统软件包管理工具必须验证与审核包关联的所有文件和目录的所有权。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000279\n\nVulnerability Discussion: Ownership of audit binaries and configuration files that is incorrect could allow an unauthorized user to gain privileges that they should not have. The ownership set by the vendor should be maintained. Any deviations from this baseline should be investigated.\n\nFix text: In Debian there is directly way to get the package\047s ownership and change it.\n\nThere\047s one way to use :\n\n#aptitude download auditd\n\nTo dowanload the package\047s file and use dpkg -c <package.deb> to extract it and get the ownership and change it manually\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38665)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The system package management tool must verify group-ownership on all files and directories associated with the audit package.'
                  else
                      log_msg $1 $2 '系统软件包管理工具必须验证与审核包关联的所有文件和目录的组所有权。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000280\n\nVulnerability Discussion: Group-ownership of audit binaries and configuration files that is incorrect could allow an unauthorized user to gain privileges that they should not have. The group-ownership set by the vendor should be maintained. Any deviations from this baseline should be investigated.\n\nFix text: In Debian there is directly way to get the package\047s group-ownership and change it.\n\nThere\047s one way to use :\n\n#aptitude download auditd\n\nTo dowanload the package\047s file and use dpkg -c <package.deb> to extract it and get the group-ownership and change it manually\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38637)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The system package management tool must verify contents of all files associated with the audit package.'
                  else
                      log_msg $1 $2 '系统软件包管理工具必须验证与审核程序包关联的所有文件的内容。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000281\n\nVulnerability Discussion: The hash on important files like audit system executables should match the information given by the packages. Audit executables with erroneous hashes could be a sign of nefarious activity on the system.\n\nFix text: In Debian there is directly way to get the package\047s hash and change it.\n\nThere\047s one way to use :\n\n#aptitude download auditd\n\nTo dowanload the package\047s file and use dpkg -c <package.deb> to extract it and use sha512sum to get the origin hash and compare with the current hash and change it manually\n\n' >> $LOG
                  fi
                  ;;
        V-38643)  find / -xdev -type f -perm -002
                  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'There must be no world-writable files on the system.'
                  else
                      log_msg $1 $2 '系统上必须没有允许任意用户都可以进行修改的文件。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000282\n\nVulnerability Discussion: Data in world-writable files can be modified by any user on the system. In almost all circumstances, files can be configured using a combination of user and group permissions to support whatever legitimate access is needed without the risk caused by world-writable files.\n\nFix text: It is generally a good idea to remove global (other) write access to a file when it is discovered. However, check with documentation for specific applications before making changes. Also, monitor for recurring world-writable files, as these may be symptoms of a misconfigured application or user account.  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38668)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The x86 Ctrl-Alt-Delete key sequence must be disabled.'
                  else
                      log_msg $1 $2 'X86的组合快捷键Ctrl-Alt-Delete必须使其失效。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000286\n\nVulnerability Discussion: A locally logged-in user who presses Ctrl-Alt-Delete, when at the console, can reboot the system. If accidentally pressed, as could happen in the case of mixed OS environment, this can create the risk of short-term loss of availability of systems due to unintentional reboot. In the GNOME graphical environment, risk of unintentional reboot from the Ctrl-Alt-Delete sequence is reduced because the user will be prompted before any action is taken.\n\nFix text: By default, Debian 8 using systemd. You could use following command to disable Ctrl+Alt+Delete\n\nsystemctl mask ctrl-alt-del.target\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38669)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The postfix service must be enabled for mail delivery.'
                  else
                      log_msg $1 $2 'postfix邮件服务必须是开启的。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000287\n\nVulnerability Discussion: Local mail delivery is essential to some system maintenance and notification tasks.\n\nFix text: The Postfix mail transfer agent is used for local mail delivery within the system. The default configuration only listens for connections to the default SMTP port (port 25) on the loopback interface (127.0.0.1). It is recommended to leave this service enabled for local mail delivery. The "postfix" service can be enabled with the following command:\n\n#update-rc.d postfix defaults\n#service postfix start\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38671)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The sendmail package must be removed.'
                  else
                      log_msg $1 $2 'sendmail软件包必须删除。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000288\n\nVulnerability Discussion: The sendmail software was not developed with security in mind and its design prevents it from being effectively contained by SELinux. Postfix should be used instead.\n\nFix text: Sendmail is not the default mail transfer agent and is not installed by default. The "sendmail" package can be removed with the following command:\n\n#apt-get purge sendmail\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38674)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'X Windows must not be enabled unless required.'
                  else
                      log_msg $1 $2 'X窗口程序必须处于未开启状态，除非必需。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000290\n\nVulnerability Discussion: Unnecessary services should be disabled to decrease the attack surface of the system.\n\nFix text: Look in /etc/rc2.d/. There are probably links to /etc/init.d/xdm and /etc/init.d/kdm which you haven\047t removed yet.\n\nYou can also edit the file /etc/X11/default-display-manager, which includes the full path to the default display manager Debian is using. If you replace the content of that file with /bin/true, you are probably disabling the start of any login-manager as well.\n\nFor more detials:\http://unix.stackexchange.com/questions/86740/disabling-graphical-login-in-debian-wheezyn\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38676)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The xorg-x11-server-common (X Windows) package must not be installed, unless required.'
                  else
                      log_msg $1 $2 'xorg-x11-server-common软件包必须没有进行安装，除非必需。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000291\n\nVulnerability Discussion: Unnecessary packages should not be installed to decrease the attack surface of the system.\n\nFix text: You could visit the: http://pc-freak.net/blog/debian-linux-remove-xorg-gnome-gdm-graphical-environment-packages-serverr/\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38681)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'All GIDs referenced in /etc/passwd must be defined in /etc/group'
                  else
                      log_msg $1 $2 '在/etc/passwd中的所有GID引用的定义必须在/etc/group文件中。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000294\n\nVulnerability Discussion: Inconsistency in GIDs between /etc/passwd and /etc/group could lead to a user having unintended rights.\n\nFix text: Add a group to the system for each GID referenced without a corresponding group.  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38683)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'All accounts on the system must have unique user or account names'
                  else
                      log_msg $1 $2 '系统中的所有帐号必须具有独一无二的用户名或帐户名。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000296\n\nVulnerability Discussion: Unique usernames allow for accountability on the system.\n\nFix text: Change usernames, or delete accounts, so each has a unique name.  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38693)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The system must require passwords to contain no more than three consecutive repeating characters.'
                  else
                      log_msg $1 $2 "系统必须要求密码包含不超过3个连续重复的字符。"
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000299\n\nVulnerability Discussion: Passwords with excessive repeating characters may be more vulnerable to password-guessing attacks.\n\nFix text: The pam_cracklib module\047s "maxrepeat" parameter controls requirements for consecutive repeating characters. When set to a positive number, it will reject passwords which contain more than that number of consecutive characters. Add "maxrepeat=3" after pam_cracklib.so to prevent a run of (3 + 1) or more identical characters.\n\npassword required pam_cracklib.so maxrepeat=3\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38695)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'A file integrity tool must be used at least weekly to check for unauthorized file changes, particularly the addition of unauthorized system libraries or binaries, or for unauthorized modification to authorized system libraries or binaries.'
                  else
                      log_msg $1 $2 '一个文件完整性工具必须至少每周用于检查未经授权的文件的变化，特别是除了未经授权的系统库或二进制文件，或未经授权的修改授权的系统库或二进制文件。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000302\n\nVulnerability Discussion: By default, AIDE does not install itself for periodic execution. Periodically running AIDE may reveal unexpected changes in installed files.\n\nFix text:  AIDE should be executed on a periodic basis to check for changes. To implement a daily execution of AIDE at 4:05am using cron, add the following line to /etc/crontab:\n\n05 4 * * * root /usr/sbin/aide --check\n\nAIDE can be executed periodically through other means; this is merely one example.  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38696)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The operating system must employ automated mechanisms, per organization defined frequency, to detect the addition of unauthorized components/devices into the operating system.'
                  else
                      log_msg $1 $2 '操作系统必须采用自动化机制，每个组织定义的频率，以检测除了未授权的组件/装置的运作系统。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000303\n\nVulnerability Discussion: By default, AIDE does not install itself for periodic execution. Periodically running AIDE may reveal unexpected changes in installed files.\n\nFix text:  AIDE should be executed on a periodic basis to check for changes. To implement a daily execution of AIDE at 4:05am using cron, add the following line to /etc/crontab:\n\n05 4 * * * root /usr/sbin/aide --check\n\nAIDE can be executed periodically through other means; this is merely one example.  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38698)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The operating system must employ automated mechanisms to detect the presence of unauthorized software on organizational information systems and notify designated organizational officials in accordance with the organization defined frequency.'
                  else
                      log_msg $1 $2 '操作系统必须采用自动化的机制来检测未经授权的软件对组织信息系统的存在，并根据组织定义的频率通知指定的组织的官员。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000304\n\nVulnerability Discussion: \n\nFix text:  AIDE should be executed on a periodic basis to check for changes. To implement a daily execution of AIDE at 4:05am using cron, add the following line to /etc/crontab:\n\n05 4 * * * root /usr/sbin/aide --check\n\nAIDE can be executed periodically through other means; this is merely one example.  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38675)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'Process core dumps must be disabled unless needed.'
                  else
                      log_msg $1 $2 '处理核心转储必须被禁止，除非需要。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000308\n\nVulnerability Discussion: A core dump includes a memory image taken at the time the operating system terminates an application. The memory image could contain sensitive data and is generally useful only for developers trying to debug problems.\n\nFix text: To disable core dumps for all users, add the following line to "/etc/security/limits.conf": \n\n* hard core 0  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38677)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The NFS server must not have the insecure file locking option enabled.'
                  else
                      log_msg $1 $2 'NFS服务器必须尚未启用不安全的文件锁定选项。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000309\n\nVulnerability Discussion: Allowing insecure file locking could allow for sensitive data to be viewed or edited by an unauthorized user.\n\nFix text: By default the NFS server requires secure file-lock requests, which require credentials from the client in order to lock a file. Most NFS clients send credentials with file lock requests, however, there are a few clients that do not send credentials when requesting a file-lock, allowing the client to only be able to lock world-readable files. To get around this, the "insecure_locks" option can be used so these clients can access the desired export. This poses a security risk by potentially allowing the client access to data for which it does not have authorization. Remove any instances of the "insecure_locks" option from the file "/etc/exports".  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38680)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The audit system must identify staff members to receive notifications of audit log storage volume capacity issues.'
                  else
                      log_msg $1 $2 '审计系统必须查明工作人员收到的审计日志存储卷容量问题的通知。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000313\n\nVulnerability Discussion: Email sent to the root account is typically aliased to the administrators of the system, who can take appropriate action.\n\nFix text: The "auditd" service can be configured to send email to a designated account in certain situations. Add or correct the following line in "/etc/audit/auditd.conf" to ensure that administrators are notified via email for those situations:\n\naction_mail_acct = root  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38682)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The Bluetooth kernel module must be disabled.'
                  else
                      log_msg $1 $2 '蓝牙内核模块必须设置为失效。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000315\n\nVulnerability Discussion: If Bluetooth functionality must be disabled, preventing the kernel from loading the kernel module provides an additional safeguard against its activation.\n\nFix text: The kernel\047s module loading system can be configured to prevent loading of the Bluetooth module. Add the following to the appropriate "/etc/modprobe.d" configuration file to prevent the loading of the Bluetooth module:\n\ninstall net-pf-31 /bin/true\ninstall bluetooth /bin/true\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-86575r1_rule) log_msg $1 $2 'The delay between login prompts following a failed console login attempt must be at least 3 seconds.'
                        if [ $2 -ne 0 ];then
                            printf '\nConfiguring the operating system to implement organization-wide security implementation guides and security checklists verifies a common security baseline that reflects the most restrictive security posture consistent with operational requirements.\n\nConfiguration settings are the set of parameters that can be changed in hardware, software, or firmware components of the system that affect the security posture and/or functionality of the system. Security-related parameters are those parameters impacting the security state of the system, including the parameters required to satisfy other security control requirements. Security-related parameters include, for example, registry settings; account, file, and directory permission settings; and settings for functions, ports, protocols, services, and remote connections.\n\nCheck_content: Verify the operating system enforces a delay of at least 3 seconds between console login prompts following a failed login attempt.\n\nCheck the value of the "fail_delay" parameter in the "/etc/login.defs" file with the following command:\n\n# grep -i fail_delay /etc/login.defs\nFAIL_DELAY 4\n\nIf the value of "FAIL_DELAY" is not set to "3" or greater, this is a finding.\n\n' >> $LOG
                        fi
                        ;;
        V-86479r2_rule) log_msg $1 $2 'The cryptographic hash of system files and commands must match vendor values.'
                        if [ $2 -ne 0 ];then
                            printf '\nWithout cryptographic integrity protections, system command and files can be altered by unauthorized users without detection.\n\nCryptographic mechanisms used for protecting the integrity of information include, for example, signed hash functions using asymmetric cryptography enabling distribution of the public key to verify the hash information while maintaining the confidentiality of the key used to generate the hash.\n\n
Check_content: Verify the cryptographic hash of system files and commands match the vendor values.\n\nCheck the cryptographic hash of system files and commands with the following command:\n\nNote: System configuration files (indicated by a "c" in the second column) are expected to change over time. Unusual modifications should be investigated through the system audit log.\n\n# dpkg -V | grep "^..5"\n\nIf there is any output from the command for system binaries, this is a finding.\n\n' >> $LOG
                        fi
                        ;;
        prelink) log_msg $1 $2 'Ensure prelink is disabled'
                 if [ $2 -ne 0 ];then
                     printf '\nDisable prelink to prevent libraries compromise.\n\n' >> $LOG
                 fi
                 ;;
        talk) log_msg $1 $2 'Ensure talk is disabled'
              if [ $2 -ne 0 ];then
                  printf '\nDisable talk utility.\n\n' >> $LOG
              fi
              ;;
        nis) log_msg $1 $2 'Ensure that Network Information Service is not installed'
             if [ $2 -ne 0 ];then
                 printf '\nEnsure that Network Information Service is not installed.\n\n' >> $LOG
             fi
             ;;
        legacy_groups) log_msg $1 $2 'Verify no legacy + entries exist in /etc/group file'
             if [ $2 -ne 0 ];then
                 printf '\nVerify no legacy + entries exist in /etc/group file.\n\n' >> $LOG
             fi
             ;;
        password_crypt) log_msg $1 $2 'Check that any password that may exist in /etc/shadow is yescrypt hashed and salted'
                        if [ $2 -ne 0 ];then
                            printf '\nCheck that any password that may exist in /etc/shadow is yescrypt hashed and salted.\n\n' >> $LOG
                        fi
                        ;;
        V-38684)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The system must limit users to 2 simultaneous system logins, or a site-defined number, in accordance with operational requirements.'
                  else
                      log_msg $1 $2 '系统必须禁止多个用户共用一个帐号。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000319\n\nVulnerability Discussion: Limiting simultaneous user logins can insulate the system from denial of service problems caused by excessive logins. Automated login processes operating improperly or maliciously may result in an exceptional number of simultaneous login sessions.\n\nFix text: Limiting the number of allowed users and sessions per user can limit risks related to denial of service attacks. This addresses concurrent sessions for a single account and does not address concurrent sessions by a single user via multiple accounts. To set the number of concurrent sessions per user add the following line in "/etc/security/limits.conf":\n* hard maxlogins 10 A documented site-defined number may be substituted for 10 in the above.  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38686)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The systems local firewall must implement a deny-all, allow-by-exception policy for forwarded packets.'
                  else
                      log_msg $1 $2 '系统本地防火墙必须实现转发的数据包一个全部拒绝，允许按例外策略。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000320\n\nVulnerability Discussion: In "iptables" the default policy is applied only after all the applicable rules in the table are examined for a match. Setting the default policy to "DROP" implements proper design for a firewall, i.e., any packets which are not explicitly permitted should not be accepted.\n\nFix text: To set the default policy to DROP (instead of ACCEPT) for the built-in FORWARD chain which processes packets that will be forwarded from one interface to another, could use following command:\n\n#iptables -P INPUT DROP\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38691)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The Bluetooth service must be disabled.'
                  else
                      log_msg $1 $2 '蓝牙服务必须设置为失效。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000331\n\nVulnerability Discussion: Disabling the "bluetooth" service prevents the system from attempting connections to Bluetooth devices, which entails some security risk. Nevertheless, variation in this risk decision may be expected due to the utility of Bluetooth connectivity and its limited range.\n\nFix text: The "bluetooth" service can be disabled with the following command:\n\nupdate-rc.d bluetooth remove\n#service bluetooth stop\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38692)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'Accounts must be locked upon 35 days of inactivity.'
                  else
                      log_msg $1 $2 "帐户必须在35天不使用后被锁定。"
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000334\n\nVulnerability Discussion: Disabling inactive accounts ensures that accounts which may not have been responsibly removed are not available to attackers who may have compromised their credentials.\n\nFix text:  To specify the number of days after a password expires (which signifies inactivity) until an account is permanently disabled, add or correct the following lines in "/etc/default/useradd", substituting " [NUM_DAYS]" appropriately: INACTIVE=[NUM_DAYS]A value of 35 is recommended. If a password is currently on the verge of expiration, then 35 days remain until the account is automatically disabled. However, if the password will not expire for another 60 days, then 95 days could elapse until the account would be automatically disabled. See the "useradd" man page for more information. Determining the inactivity timeout must be done with careful consideration of the length of a "normal" period of inactivity for users in the particular environment. Setting the timeout too low incurs support costs and also has the potential to impact availability of the system to legitimate users.  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38694)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The operating system must manage information system identifiers for users and devices by disabling the user identifier after an organization defined time period of inactivity.'
                  else
                      log_msg $1 $2 '操作系统必须通过禁止不活动的组织定义的时间段之后的用户标识符管理用户和设备的信息系统标识符。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000335\n\nVulnerability Discussion: Disabling inactive accounts ensures that accounts which may not have been responsibly removed are not available to attackers who may have compromised their credentials.\n\nFix text:  To specify the number of days after a password expires (which signifies inactivity) until an account is permanently disabled, add or correct the following lines in "/etc/default/useradd", substituting " [NUM_DAYS]" appropriately: INACTIVE=[NUM_DAYS]A value of 35 is recommended. If a password is currently on the verge of expiration, then 35 days remain until the account is automatically disabled. However, if the password will not expire for another 60 days, then 95 days could elapse until the account would be automatically disabled. See the "useradd" man page for more information. Determining the inactivity timeout must be done with careful consideration of the length of a "normal" period of inactivity for users in the particular environment. Setting the timeout too low incurs support costs and also has the potential to impact availability of the system to legitimate users.  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38697)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The sticky bit must be set on all public directories.'
                  else
                      log_msg $1 $2 'sticky位必须为所有的公共目录进行设置。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000336\n\nVulnerability Discussion: Failing to set the sticky bit on public directories allows unauthorized users to delete files in the directory structure.\n\nThe only authorized public directories are those temporary directories supplied with the system, or those designed to be temporary file repositories. The setting is normally reserved for directories used by the system, and by users for temporary file storage - such as /tmp - and for directories requiring global read/write access.\n\nFix text: When the so-called \047sticky bit\047 is set on a directory, only the owner of a given file may remove that file from the directory. Without the sticky bit, any user with write access to a directory may remove any file in the directory. Setting the sticky bit prevents users from removing each other\047s files. In cases where there is no reason for a directory to be world-writable, a better solution is to remove that permission rather than to set the sticky bit. However, if a directory is used by a particular application, consult that application\047s documentation instead of blindly changing modes. \nTo set the sticky bit on a world-writable directory [DIR], run the following command:\n\n# chmod +t [DIR]  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38699)  if [ "$3" = "en" ]; then
                      find / -xdev -type d -perm -0002 -uid +499 -print
                      log_msg $1 $2 'All public directories must be owned by a system account.'
                  else
                      log_msg $1 $2 '所有的公共目录必须属于一个系统帐号。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000337\n\nVulnerability Discussion: Allowing a user account to own a world-writable directory is undesirable because it allows the owner of that directory to remove or replace any files that may be placed in the directory by other users.\n\nFix text: All directories in local partitions which are world-writable should be owned by root or another system account. If any world-writable directories are not owned by a system account, this should beinvestigated. Following this, the files should be deleted or assigned to an appropriate group.  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38701)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The TFTP daemon must operate in secure mode which provides access only to a single directory on the host file system.'
                  else
                      log_msg $1 $2 '在TFTP守护程序必须在其中只对主机文件系统上的单个目录提供了访问的安全模式下运行。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000338\n\nVulnerability Discussion: Using the "-s" option causes the TFTP service to only serve files from the given directory. Serving files from an intentionally specified directory reduces the risk of sharing files which should remain private.\n\nFix text: If running the "tftp" service is necessary, it should be configured to change its root directory at startup. To do so, ensure "/etc/inetd.conf" includes "-s" as a command line argument, as shown in the following example (which is also the default):\n\ntftp  dgram   udp   wait   root   /etc/tftpd   tftpd -s /tftpboot\n\nAnd manually create the directory /tftpboot\n\nFor more detials could visit:http://osr507doc.sco.com/en/man/html.ADMN/tftpd.ADMN.html\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38702)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The FTP daemon must be configured for logging or verbose mode.'
                  else
                      log_msg $1 $2 '该FTP守护进程必须配置为记录或详细模式。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000339\n\nVulnerability Discussion: To trace malicious activity facilitated by the FTP service, it must be configured to ensure that all commands sent to the ftp server are logged using the verbose vsftpd log format. The default vsftpd log file is /var/log/vsftpd.log.\n\nFix text: Add or correct the following configuration options within the "vsftpd" configuration file, located at"/etc/vsftpd/vsftpd.conf".\n\nxferlog_enable=YES\nxferlog_std_format=NO\nlog_ftp_protocol=YES\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38645)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The system default umask in /etc/login.defs must be 077.'
                  else
                      log_msg $1 $2 '在/etc/login.defs中系统默认的umask必须是077。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000345\n\nVulnerability Discussion: The umask value influences the permissions assigned to files when they are created. A misconfigured umask value could result in files with excessive permissions that can be read and/or written to by unauthorized users.\n\nFix text: To ensure the default umask controlled by "/etc/login.defs" is set properly, add or correct the "umask" setting in "/etc/login.defs" to read as follows: \n\nUMASK 077\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38642)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The system default umask for daemons must be 027 or 022.'
                  else
                      log_msg $1 $2 '系统默认的umask必须设置为027或022。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000346\n\nVulnerability Discussion: The umask influences the permissions assigned to files created by a process at run time. An unnecessarily permissive umask could result in files being created with insecure permissions.\n\nFix text: In Debian the file "/etc/init.d/rc" includes initialization parameters for most or all daemons started at boot time. The default umask of 022 prevents creation of group- or world-writable files. To set the default umask for daemons, edit the following line, inserting 022 or 027 for [UMASK] appropriately: \n\numask [UMASK]\n\nSetting the umask to too restrictive a setting can cause serious errors at runtime. Many daemons on the system already individually restrict themselves to a umask of 077 in their own init scripts.  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38619)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'There must be no .netrc files on the system.'
                  else
                      log_msg $1 $2 '在系统中必须不存在.netrc文件。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000347\n\nVulnerability Discussion: Unencrypted passwords for remote FTP servers may be stored in ".netrc" files. LibreServer policy requires passwords be encrypted in storage and not used in access scripts.\n\nFix text: The ".netrc" files contain login information used to auto-login into FTP servers and reside in the user\047s home directory. These files may contain unencrypted passwords to remote FTP servers making them susceptible to access by unauthorized users and should not be used. Any ".netrc" files should be removed.  \ n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38592)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The system must require administrator action to unlock an account locked by excessive failed login attempts.'
                  else
                      log_msg $1 $2 "系统必须要求系统管理员在多次登录尝试失败时对账号进行锁定。"
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000356\n\nVulnerability Discussion: Locking out user accounts after a number of incorrect attempts prevents direct password guessing attacks. Ensuring that an administrator is involved in unlocking locked accounts draws appropriate attention to such situations.\n\nFix text: To configure the system to lock out accounts after a number of incorrect login attempts and require an administrator to unlock the account using "pam_faillock.so":\n\nAdd the following lines immediately below the "pam_unix.so" statement in the AUTH section of\n"/etc/pam.d/common-auth" and "/etc/pam.d/common-auth":\n\nauth [default=die] pam_faillock.so authfail deny=3 unlock_time=604800 fail_interval=900\n\nauth required pam_faillock.so authsucc deny=3 unlock_time=604800 fail_interval=900\n\nNote that any updates made to "/etc/pam.d/common-auth" and "/etc/pam.d/common-auth" may be overwritten by the "authconfig" program. The "authconfig" program should not be used.  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-51875)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The operating system, upon successful login/access, must display to the user the number of unsuccessful login/access attempts since the last successful login/access.'
                  else
                      log_msg $1 $2 '操作系统，在成功登录/访问，必须自上次成功登录/接入向用户显示失败的登录/访问尝试的次数。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000372\n\nVulnerability Discussion: Users need to be aware of activity that occurs regarding their account. Providing users with information regarding the number of unsuccessful attempts that were made to login to their account allows the user to determine if any unauthorized activity has occurred and gives them an opportunity to notify administrators.\n\nFix text: To configure the system to notify users of last login/access using "pam_lastlog", add the following line immediately after "session required pam_limits.so":\n\nsession required pam_lastlog.so showfailed  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38498)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'Audit log files must have mode 0640 or less permissive.'
                  else
                      log_msg $1 $2 '审计日志文件的访问权限必须设置为root用户可读写、同组用户可读的权限或更小的权限。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000383\n\nVulnerability Discussion: If users can write to audit logs, audit trails can be modified or destroyed.\n\nFix text: Change the mode of the audit log files with the following command: \n\n# chmod 0640 [audit_file]  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-86671r1_rule) log_msg $1 $2 'The only authorized public directories are those temporary directories supplied with the system or those designed to be temporary file repositories.'
                        if [ $2 -ne 0 ];then
                            printf '\nThe only authorized public directories are those temporary directories supplied with the system or those designed to be temporary file repositories.\n\nVerify all world-writable directories are group-owned by root, sys, bin, or an application group.\n\n' >> $LOG
                        fi
                        ;;
        V-38495)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'Audit log files must be owned by root.'
                  else
                      log_msg $1 $2 '审计日志文件的属主必须为root用户。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000384\n\nVulnerability Discussion: If non-privileged users can write to audit logs, audit trails can be modified or destroyed.\n\nFix text: Change the owner of the audit log files with the following command:\n\n# chown root [audit_file]  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38493)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'Audit log directories must have mode 0755 or less permissive.'
                  else
                      log_msg $1 $2 '审计日志的存放目录的权限设置必须为root用户具有读写执行的权限、同组用户可读可执行、其他用户具有可读可执行的权限或更小的权限。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000385\n\nVulnerability Discussion: If users can delete audit logs, audit trails can be modified or destroyed.\n\nFix text: Change the mode of the audit log directories with the following command:\n\n# chmod go-w [audit_directory]  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38490)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The operating system must enforce requirements for the connection of mobile devices to operating systems.'
                  else
                      log_msg $1 $2 '操作系统必须执行用于移动设备的对操作系统的连接要求。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000503\n\nVulnerability Discussion: USB storage devices such as thumb drives can be used to introduce unauthorized software and other vulnerabilities. Support for these devices should be disabled and the devices themselves should be tightly controlled.\n\nFix text: To prevent USB storage devices from being used, configure the kernel module loading system to prevent automatic loading of the USB storage driver. To configure the system to prevent the "usb-storage"kernel module from being loaded, add the following line to a file in the directory "/etc/modprobe.d": \n\ninstall usb-storage /bin/true\n\nThis will prevent the "modprobe" program from loading the "usb-storage" module, but will not prevent an administrator (or another program) from using the "insmod" program to load the module manually.\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38484)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The operating system, upon successful login, must display to the user the date and time of the last login or access via ssh.'
                  else
                      log_msg $1 $2 '操作系统，在成功登录，必须向用户显示通过SSH上次登录或访问的日期和时间。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000507\n\nVulnerability Discussion: Users need to be aware of activity that occurs regarding their account. Providing users with information regarding the date and time of their last successful login allows the user to determine if any unauthorized activity has occurred and gives them an opportunity to notify administrators.\n\nAt ssh login, a user must be presented with the last successful login date and time.\n\nFix text: Update the "PrintLastLog" keyword to "yes" in /etc/ssh/sshd_config: \n\nPrintLastLog yes\n\nWhile it is acceptable to remove the keyword entirely since the default action for the SSH daemon is to print the last login date and time, it is preferred to have the value explicitly documented.  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38471)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The system must forward audit records to the syslog service.'
                  else
                      log_msg $1 $2 '系统必须能将审核记录转发给syslog服务。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000509\n\nVulnerability Discussion: The auditd service does not include the ability to send audit records to a centralized server for  management directly. It does, however, include an audit event multiplexor plugin (audispd) to pass audit records to the local syslog server.\n\nFix text: Set the "active" line in "/etc/audisp/plugins.d/syslog.conf" to "yes". Restart the auditd process.\n\n# service auditd restart  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38468)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The audit system must take appropriate action when the audit storage volume is full.'
                  else
                      log_msg $1 $2 '当审计存储容量已满审计系统必须采取适当的行动。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000510\n\nVulnerability Discussion: Taking appropriate action in case of a filled audit storage volume will minimize the possibility of losing audit records.\n\nFix text: The "auditd" service can be configured to take an action when disk space starts to run low. Edit the file "/etc/audit/auditd.conf". Modify the following line, substituting [ACTION] appropriately:\n\ndisk_full_action = [ACTION]\n\nPossible values for [ACTION] are described in the "auditd.conf" man page. These include:\n\n"ignore"\n"syslog"\n"exec"\n"suspend"\n"single"\n"halt"\n\nSet this to "syslog", "exec", "single", or "halt".\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38464)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The audit system must take appropriate action when there are disk errors on the audit storage volume.'
                  else
                      log_msg $1 $2 '当审计存储卷发生硬盘错误时，审计系统必须采取适当的行动。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000511\n\nVulnerability Discussion: Taking appropriate action in case of disk errors will minimize the possibility of losing audit records\n\nFix text: Edit the file "/etc/audit/auditd.conf". Modify the following line, substituting [ACTION] appropriately:\n\ndisk_error_action = [ACTION]\n\nPossible values for [ACTION] are described in the "auditd.conf" man page. These include:\n\n\"ignore\"\n\"syslog\"\n\"exec\"\n"suspend\"\n\"single\"\n\"halt\"Set this to \"syslog\", \"exec", \"single\", or \"halt\".  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38462)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The package management tool must cryptographically verify the authenticity of all software packages during installation.'
                  else
                      log_msg $1 $2 '在安装所有软件包时必须使用包管理工具加密验证软件包的真实性。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000514\n\nVulnerability Discussion: Ensuring all packages\047 cryptographic signatures are valid prior to installation ensures the provenance of the software and protects against malicious tampering.\n\nFix text: Check the file in /etc/apt/apt.conf.d/ and find the "GPG::Check false" option and remove it\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38460)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The NFS server must not have the all_squash option enabled.'
                  else
                      log_msg $1 $2 'NFS服务中必须没有all_squash选项的开启。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000515\n\nVulnerability Discussion: The "all_squash" option maps all client requests to a single anonymous uid/gid on the NFS server, negating the ability to track file access by user ID.\n\nFix text: Remove any instances of the "all_squash" option from the file "/etc/exports". Restart the NFS daemon for the changes to take effect.\n\n# service nfs restart  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38446)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The mail system must forward all mail for root to one or more system administrators.'
                  else
                      log_msg $1 $2 '邮件系统必须转发所有的邮件到root或多个系统管理。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000521\n\nVulnerability Discussion: A number of system services utilize email messages sent to the root user to notify system administrators of active or impending issues. These messages must be forwarded to at least one monitored email address.\n\nFix text: Set up an alias for root that forwards to a monitored email address:\n\n# echo "root: <system.administrator>@mail.mil" >> /etc/aliases\n# newaliases  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38445)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'Audit log files must be group-owned by root.'
                  else
                      log_msg $1 $2 '审计日志文件的组属主必须为root组。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000522\n\nVulnerability Discussion: If non-privileged users can write to audit logs, audit trails can be modified or destroyed.\n\nFix text: Change the group owner of the audit log files with the following command:\n\n# chgrp root [audit_file]\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38444)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The systems local IPv6 firewall must implement a deny-all, allow-by-exception policy for inboundpackets.'
                  else
                      log_msg $1 $2 '系统的本地IPv6防火墙必须实现入站数据包的全部拒绝，允许按例外策略。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000523\n\nVulnerability Discussion: In "ip6tables" the default policy is applied only after all the applicable rules in the table are examined for a match. Setting the default policy to "DROP" implements proper design for a firewall, i.e., any packets which are not explicitly permitted should not be accepted.\n\nFix text: To set the default policy to DROP (instead of ACCEPT) for the built-in INPUT chain which processes incoming packets, using following command:\n\n#ip6tables -P INPUT DROP\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38438)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'Auditing must be enabled at boot by setting a kernel parameter.'
                  else
                      log_msg $1 $2 '审计必须在启动通过设置内核参数启用。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000525\n\nVulnerability Discussion: Each process on the system carries an "auditable" flag which indicates whether its activities can be audited. Although "auditd" takes care of enabling this for all processes which launch after it does, adding the kernel argument ensures it is set for every process during boot.\n\nFix text: To ensure all processes can be audited, even those which start prior to the audit daemon, add the argument "audit=1" to the kernel line in "/etc/grub.conf", in the manner below:\n\nkernel /vmlinuz-version ro vga=ext root=/dev/VolGroup00/LogVol00 rhgb quiet audit=1\n\nUEFI systems may prepend "/boot" to the "/vmlinuz-version" argument.  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-38437)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'Automated file system mounting tools must not be enabled unless needed.'
                  else
                      log_msg $1 $2 '文件系统的自动挂载工具必须没有开启，除非必需。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000526\n\nVulnerability Discussion: All filesystems that are required for the successful operation of the system should be explicitly listed in "/etc/fstab" by an administrator. New filesystems should not be arbitrarily introduced via the automounter.\n\nThe "autofs" daemon mounts and unmounts filesystems, such as user home directories shared via NFS, on demand. In addition, autofs can be used to handle removable media, and the default configuration provides the cdrom device as "/misc/cd". However, this method of providing access to removable media is not common, so autofs can almost always be disabled if NFS is not in use. Even if NFS is required, it is almost always possible to configure filesystem mounts statically by editing "/etc fstab" rather than relying on the automounter.\n\nFix text: If the "autofs" service is not needed to dynamically mount NFS filesystems or removable media,disable the service by using\n\n#update-rc.d autofs remove\n#service autofs stop\n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-57569)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The noexec option must be added to the /tmp partition.'
                  else
                      log_msg $1 $2 '不可执行(noexec)的选项必须添加到/tmp分区的挂载参数中。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000528\n\nVulnerability Discussion: Allowing users to execute binaries from world-writable directories such as "/tmp" should never be necessary in normal operation and can expose the system to potential compromise.\n\nFix text: The "noexec" mount option can be used to prevent binaries from being executed out of "/tmp". Add the "noexec" option to the fourth column of "/etc/fstab" for the line which controls mounting of "/tmp".  \n\n######################\n\n' >> $LOG
                  fi
                  ;;
        V-58901)  if [ "$3" = "en" ]; then
                      log_msg $1 $2 'The sudo command must require authentication.'
                  else
                      log_msg $1 $2 '使用sudo命令必须进行验证。'
                  fi
                  if [ $2 -ne 0 ];then
                      printf '\n######################\n\nSTIG-ID:RHEL-06-000529\n\nVulnerability Discussion: The "sudo" command allows authorized users to run programs (including shells) as other users, system users, and root. The "/etc/sudoers" file is used to configure authorized "sudo" users as well as the programs they are allowed to run. Some configuration options in the "/etc/sudoers" file allow configured users to run programs without re-authenticating. Use of these configuration options makes it easier for one compromised account to be used to compromise other accounts.\n\nFix text: Update the "/etc/sudoers" or other sudo configuration files to remove or comment out lines utilizing the "NOPASSWD" and "!authenticate" options. \n\n# visudo\n# visudo -f [other sudo configuration file]  \n\n######################\n\n' >> $LOG
                  fi
                  ;;

    esac
}
