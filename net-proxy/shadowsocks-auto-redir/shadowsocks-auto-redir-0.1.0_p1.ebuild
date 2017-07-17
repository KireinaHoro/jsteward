# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit linux-info eutils systemd

DESCRIPTION="Automatic script to start shadowsocks-redir and configure routing table "
HOMEPAGE="https://github.com/KireinaHoro/shadowsocks-auto-redir.sh"

MY_PN="${PN}.sh"
MY_PV="0.1.0_p1"
SRC_URI="https://github.com/KireinaHoro/${MY_PN}/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

CDEPEND=""
DEPEND="${CDEPEND}"
RDEPEND="${CDEPEND}
	app-misc/jq
	net-firewall/ipset
	net-firewall/iptables
	net-proxy/shadowsocks-libev
"
S="${WORKDIR}/${MY_PN}-${MY_PV}"

pkg_setup() {
	get_version
	CONFIG_CHECK="${CONFIG_CHECK} IP_SET_HASH_NET"
	ERROR_IP_SET_HASH_NET="shadowsocks-auto-redir requires IP_SET_HASH_NET support in your kernel."
	CONFIG_CHECK="${CONFIG_CHECK} NETFILTER_XT_TARGET_REDIRECT"
	ERROR_NETFILTER_XT_TARGET_REDIRECT="shadowsocks-auto-redir requires NETFILTER_XT_TARGET_REDIRECT support in your kernel."
	CONFIG_CHECK="${CONFIG_CHECK} NETFILTER_XT_SET"
	ERROR_NETFILTER_XT_SET="shadowsocks-auto-redir requires NETFILTER_XT_SET support in your kernel."
	CONFIG_CHECK="${CONFIG_CHECK} IP6_NF_IPTABLES"
	ERROR_IP6_NF_TABLES="shadowsocks-auto-redir requires IP6_NF_IPTABLES support in your kernel."
}

src_install() {
	dodir /opt/"${PN}"
	insinto /opt/"${PN}"
	doins -r "${S}"/{routing.v{4,6},routes/,shadowsocks-auto-redir}
	fperms 0755 /opt/"${PN}"/{routing.v{4,6},shadowsocks-auto-redir}

	doinitd "${S}"/openrc/shadowsocks-auto-redir
	dosym /etc/init.d/shadowsocks-auto-redir /etc/init.d/shadowsocks-auto-redir.v4
	dosym /etc/init.d/shadowsocks-auto-redir /etc/init.d/shadowsocks-auto-redir.v6

	systemd_dounit "systemd/shadowsocks-auto-redir@.service"

	insinto /etc/shadowsocks-libev
	doins "${S}"/examples/redir{,.v{4,6}}.json

	DOCS="README.md examples"
	einstalldocs
}

pkg_postinst() {
	elog "Remember to fill in correct server address, port and password in"
	elog "/etc/shadowsocks-libev/routing{,.v{4,6}}.json. Refer to"
	elog "/usr/share/doc/${PF} for more information."
}
