# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit autotools-utils

DESCRIPTION="Widgets and other objects used for indicators"
HOMEPAGE="https://launchpad.net/ido"
SRC_URI="http://launchpad.net/ido/12.10/${PV}/+download/ido-${PV}.tar.gz"

LICENSE="LGPL-3"
SLOT="3"
KEYWORDS="~amd64 ~x86"
IUSE="doc static-libs"

RDEPEND="
	>=x11-libs/gtk+-3.1:3"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? ( dev-util/gtk-doc )"

pkg_setup() {
	DOCS=( AUTHORS COPYING ChangeLog NEWS README TODO )
	S="${WORKDIR}/ido-${PV}"
}

src_prepare() {
	# Remove reference to ubuntu gtk+ patch
	sed -i 's/ubuntu_//' src/idoscalemenuitem.c

	# Remove GTK_DOC_CHECK if documentation is not enabled
	use doc || sed -i 's/GTK_DOC_CHECK(\[1.8\])//' configure.ac

	eautoreconf
	#NOCONFIGURE=1 ./autogen.sh
}