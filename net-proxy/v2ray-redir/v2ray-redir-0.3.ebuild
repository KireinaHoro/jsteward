# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit linux-info eutils systemd

DESCRIPTION="Automatic script to start v2ray-redir and configure routing table "
HOMEPAGE="https://github.com/KireinaHoro/v2ray-redir"

SRC_URI="https://github.com/KireinaHoro/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

CDEPEND=""
DEPEND="${CDEPEND}"
RDEPEND="${CDEPEND}
	app-misc/jq
	net-firewall/iptables
	|| (
		net-proxy/v2ray
		net-proxy/v2ray-bin
	)
"

pkg_setup() {
	get_version
	CONFIG_CHECK="${CONFIG_CHECK} NETFILTER_XT_TARGET_REDIRECT"
	ERROR_NETFILTER_XT_TARGET_REDIRECT="v2ray-redir requires config NETFILTER_XT_TARGET_REDIRECT"
	CONFIG_CHECK="${CONFIG_CHECK} IP_NF_NAT"
	ERROR_NETFILTER_XT_TARGET_REDIRECT="v2ray-redir requires config IP_NF_NAT"
	CONFIG_CHECK="${CONFIG_CHECK} IP6_NF_NAT"
	ERROR_NETFILTER_XT_TARGET_REDIRECT="v2ray-redir requires config IP6_NF_NAT"
	CONFIG_CHECK="${CONFIG_CHECK} IP6_NF_IPTABLES"
	ERROR_IP6_NF_TABLES="v2ray-redir requires config IP6_NF_IPTABLES"
}

src_install() {
	insinto /usr/lib/${PN}
	doins routing
	fperms 0755 /usr/lib/${PN}/routing

	doinitd openrc/${PN}

	systemd_dounit "systemd/v2ray-redir.service"
	systemd_dounit -r "systemd/v2ray.service.d"

	DOCS=(README.md)
	einstalldocs
}

pkg_postinst() {
	ewarn "Make sure you don't start the original v2ray service.  Use the v2ray-redir"
	ewarn "service to start v2ray and configure routing."
}
