# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools

DESCRIPTION="A simple RADIUS client library"
HOMEPAGE="http://radcli.github.io/radcli/"
SRC_URI="https://github.com/radcli/radcli/releases/download/${PV}/${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~x86"
IUSE="+nettle"

DEPEND="
	dev-util/abi-compliance-checker
	net-libs/gnutls
	sys-devel/autoconf
	sys-devel/automake
	sys-devel/libtool
	nettle? ( dev-libs/nettle )
"
RDEPEND="${DEPEND}"

src_prepare() {
	eautoreconf	
	default
}

src_configure() {
	econf \
		$(use_with nettle ) \
		--with-tls
}
