#!/usr/bin/env bash
# Run on the EC2 proxy instance (Amazon Linux 2023) after SSH login.
# Usage: sudo bash setup_etg_squid_proxy.sh <proxy_username> <proxy_password>
set -euo pipefail

PROXY_USER="${1:-etgproxy}"
PROXY_PASS="${2:-}"

if [[ -z "$PROXY_PASS" ]]; then
  echo "Usage: sudo bash $0 <proxy_username> <proxy_password>" >&2
  exit 1
fi

dnf install -y squid httpd-tools

cat > /etc/squid/squid.conf <<'EOF'
acl SSL_ports port 443
acl Safe_ports port 443
acl CONNECT method CONNECT
http_access deny !Safe_ports
http_access deny CONNECT !SSL_ports
auth_param basic program /usr/lib64/squid/basic_ncsa_auth /etc/squid/passwd
auth_param basic realm ETG Proxy
acl authenticated proxy_auth REQUIRED
http_access allow authenticated
http_access deny all
http_port 3128
EOF

htpasswd -cb /etc/squid/passwd "$PROXY_USER" "$PROXY_PASS"
chmod 640 /etc/squid/passwd
chown squid:squid /etc/squid/passwd

systemctl enable --now squid
systemctl status squid --no-pager

PUBLIC_IP="$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4 || true)"
echo ""
echo "Squid is running on port 3128."
echo "Elastic/public IP for ETG whitelist: ${PUBLIC_IP:-<associate Elastic IP and re-check>}"
echo "Lambda env:"
echo "  RATEHAWK_HTTPS_PROXY=http://${PROXY_USER}:<password>@<ELASTIC_IP>:3128"
