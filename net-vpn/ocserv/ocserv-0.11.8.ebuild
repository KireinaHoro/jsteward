# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools systemd

DESCRIPTION="OpenConnect SSL VPN server."
HOMEPAGE="http://ocserv.gitlab.io/www/index.html"
#SRC_URI="https://gitlab.com/ocserv/ocserv/repository/archive.tar.gz?ref=ocserv_${PV//./_} -> ${P}.tar.gz"
SRC_URI="ftp://ftp.infradead.org/pub/${PN}/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="tcpd pam +lz4 seccomp gssapi radius oath systemd geoip +anyconnect-compat"

CDEPEND="
	dev-libs/libev
	dev-libs/libevdev
	dev-libs/libnl:=
	dev-libs/nettle
	dev-libs/pcl
	dev-libs/protobuf-c
	net-libs/gnutls
	net-libs/http-parser
	net-libs/socket_wrapper
	sys-devel/autogen
	sys-libs/readline:0=
	sys-libs/talloc
	sys-libs/uid_wrapper
	oath? ( sys-auth/oath-toolkit )
	gssapi? ( app-crypt/mit-krb5 )
	seccomp? ( sys-libs/libseccomp )
	lz4? ( app-arch/lz4 )
	pam? ( sys-libs/pam )
	tcpd? ( sys-apps/tcp-wrappers )
	systemd? ( sys-apps/systemd )
	geoip? ( dev-libs/geoip )
	radius? ( || ( net-dialup/freeradius-client net-dialup/radcli ) )
"
DEPEND="${CDEPEND}
	dev-util/gperf
"
RDEPEND="${CDEPEND}
	app-misc/lockfile-progs
"

src_prepare() {
	eautoreconf
	default
}

src_configure() {
	econf \
		$(use_with geoip ) \
		$(use_with oath liboath ) \
		$(use_with pam ) \
		$(use_with radius ) \
		$(use_with lz4 ) \
		$(use_with gssapi ) \
		$(use_enable seccomp ) \
		$(use_enable systemd ) \
		$(use_enable anyconnect-compat )
}

src_install() {
	default
	doinitd "${FILESDIR}"/ocserv
	if use systemd ; then
		systemd_dounit doc/systemd/standalone/ocserv.service
	fi

	insinto /usr/share/doc/"${PF}"/examples
	doins doc/sample.{config,passwd}
	if use oath ; then
		doins doc/sample.otp
	fi
}

pkg_postinst() {
	elog "You will need to set up your /etc/ocserv/ocserv.conf file"
	elog "before starting the service for the first time. For details,"
	elog "refer to /usr/share/doc/${PF}/examples and ocserv(8)"
	elog "manual page."
}
