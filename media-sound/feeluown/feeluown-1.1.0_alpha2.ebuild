# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{4,5,6} )
inherit distutils-r1 eutils

DESCRIPTION="A hackable music player for Netease Cloud Music"
HOMEPAGE="https://pypi.python.org/pypi/feeluown"

MY_PV="1.1.0a2"
#SRC_URI="https://pypi.python.org/packages/ba/f2/73404bf814b8235770c5663604dc51290cd78a81154296e8583917cc93a7/${PN}-${MY_PV}.tar.gz"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${PN}-${MY_PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86"
IUSE="vlc"

DEPEND="
	dev-python/beautifulsoup:4[${PYTHON_USEDEP}]
	dev-python/PyQt5[multimedia,${PYTHON_USEDEP}]
	dev-python/pycrypto[${PYTHON_USEDEP}]
	>=dev-python/fuocore-0.0.5_alpha2[${PYTHON_USEDEP}]
	>=dev-python/quamash-0.5.5[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-qt/qtmultimedia:5[alsa,gstreamer,pulseaudio]
	dev-qt/qtwebkit:5
"
RDEPEND="${DEPEND}
	vlc? ( media-video/vlc )
"

S="${WORKDIR}/${PN}-${MY_PV}"

src_install() {
	distutils-r1_python_install
	rm -f ${ED}/usr/bin/feeluown-{install-dev,genicon,update} || die "failed to remove arbitrary scripts!"

	domenu ${FILESDIR}/${MY_P}.desktop
	newicon ${S}/feeluown/feeluown.png ${MY_P}.png
}
