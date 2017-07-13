# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_4 )
inherit distutils-r1

DESCRIPTION="asyncio (PEP 3156) support for ZeroMQ"
HOMEPAGE="http://aiozmq.readthedocs.org/"
#SRC_URI="https://pypi.python.org/packages/e2/8b/319fc94958c387c8ed8ad03b7f235df58a0aef484d74959d10c4e72a750c/${P}.tar.gz"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="
	>=dev-python/pyzmq-13.1[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}"
