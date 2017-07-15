# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools

DESCRIPTION="A simple RADIUS client library"
HOMEPAGE="http://radcli.github.io/radcli/"
SRC_URI="https://github.com/radcli/radcli/releases/download/${PV}/${P}.tar.gz"

LICENSE="radcli"
SLOT="0"
KEYWORDS="~x86"
IUSE="+nettle"

CDEPEND="
	net-libs/gnutls
	nettle? ( dev-libs/nettle )
"
DEPEND="${CDEPEND}
	dev-util/abi-compliance-checker
	sys-devel/autoconf
	sys-devel/automake
	sys-devel/libtool
"
RDEPEND="${CEPEND}"

src_prepare() {
	eautoreconf
	default
}

src_configure() {
	econf \
		$(use_with nettle ) \
		--with-tls
}
